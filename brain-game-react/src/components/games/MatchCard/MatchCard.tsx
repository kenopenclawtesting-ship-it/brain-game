// MatchCard (Card Pairs) Game - Rewritten from MatchCard.as + CardObject.as
// Memory matching with card swaps, easy/hard types, timer pause during reveal
// CORRECT_SCORE: 26, INCORRECT_SCORE: -18
import { useState, useEffect, useCallback, useRef } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

// Card images — first 5 are "easy" (distinct symbols), last 3 are "hard" (similar)
// Original AS: CARD_TYPE_EASY=[0..4], CARD_TYPE_HARD=[5..9]
const CARD_FRONTS = [
  '/assets/generated/card-front-star.png',      // 0 easy
  '/assets/generated/card-front-moon.png',       // 1 easy
  '/assets/generated/card-front-sun.png',        // 2 easy
  '/assets/generated/card-front-lightning.png',   // 3 easy
  '/assets/generated/card-front-diamond.png',     // 4 easy
  '/assets/generated/card-front-heart.png',       // 5 hard
  '/assets/generated/card-front-crown.png',       // 6 hard
  '/assets/generated/card-front-flame.png',       // 7 hard
];

const EASY_TYPES = [0, 1, 2, 3, 4];
const HARD_TYPES = [5, 6, 7, 0, 1]; // pad with easy types since we only have 8 images
const MAX_PAIRS = 5;
const GRID_COLS = 4;
const GRID_ROWS = 3;
const CARD_W = 68;
const CARD_H = 84;
const GAP = 10;

interface Card {
  id: number;
  cardType: number;
  isRevealed: boolean;
  isCorrect: boolean;
  gridSlot: number; // position index in 4×3 grid
}

type Phase =
  | 'dealing'       // cards flying in
  | 'revealing'     // cards flipping face-up
  | 'waitSkip'      // revealed, waiting for timeout or click
  | 'hiding'        // cards flipping face-down
  | 'playing'       // player matching
  | 'wrongPause'    // showing wrong pair briefly
  | 'swapping'      // cards swapping positions
  | 'roundEnd';     // all matched, brief pause

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

function rnd(min: number, max: number) {
  return min + Math.floor(Math.random() * (max - min));
}

export function MatchCardGame() {
  const [cards, setCards] = useState<Card[]>([]);
  const [flippedIds, setFlippedIds] = useState<number[]>([]);
  const [round, setRound] = useState(0);
  const [phase, setPhase] = useState<Phase>('dealing');
  const [swapsLeft, setSwapsLeft] = useState(0);
  const timerRef = useRef<ReturnType<typeof setTimeout>>();

  const addCorrect = useGameStore((s) => s.addCorrect);
  const addIncorrect = useGameStore((s) => s.addIncorrect);
  const timeRemaining = useGameStore((s) => s.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  // Timer pause/resume — called directly on store to avoid re-render deps
  const pauseGameTimer = useCallback(() => {
    useGameStore.getState().stopTimer();
  }, []);
  const resumeGameTimer = useCallback(() => {
    useGameStore.getState().startTimer();
  }, []);

  const startRound = useCallback(
    (roundNum: number) => {
      // From MatchCard.as restart()
      let numPairs = Math.min(2 + Math.floor(roundNum / 2), MAX_PAIRS);

      // Choose card type pool (hard types when maxed)
      let typePool: number[];
      if (numPairs >= MAX_PAIRS) {
        typePool = [...HARD_TYPES];
      } else {
        typePool = [...EASY_TYPES];
      }

      // Pick random types for pairs
      const chosen = shuffle(typePool).slice(0, numPairs);

      // Create card pairs
      const rawCards: { cardType: number }[] = [];
      for (const t of chosen) {
        rawCards.push({ cardType: t }, { cardType: t });
      }

      // Assign random grid slots (from 12 positions, skip slot 0 per original)
      const slots = shuffle(
        Array.from({ length: GRID_COLS * GRID_ROWS - 1 }, (_, i) => i + 1)
      ).slice(0, rawCards.length);

      const newCards: Card[] = rawCards.map((c, i) => ({
        id: i,
        cardType: c.cardType,
        isRevealed: false,
        isCorrect: false,
        gridSlot: slots[i],
      }));

      setCards(newCards);
      setFlippedIds([]);
      setSwapsLeft(Math.floor(roundNum / 3));

      // Pause timer during reveal phase (from original: gameTimerEnabled = false)
      pauseGameTimer();

      // Deal → Reveal → Wait → Hide → Play
      setPhase('dealing');
      clearTimeout(timerRef.current);

      timerRef.current = setTimeout(() => {
        // Reveal all cards
        setCards((prev) => prev.map((c) => ({ ...c, isRevealed: true })));
        setPhase('revealing');

        timerRef.current = setTimeout(() => {
          setPhase('waitSkip');

          // Auto-hide after 2s (or click to skip)
          timerRef.current = setTimeout(() => {
            hideCardsAndPlay();
          }, 2000);
        }, 600);
      }, 400);
    },
    [pauseGameTimer]
  );

  const hideCardsAndPlay = useCallback(() => {
    clearTimeout(timerRef.current);
    setCards((prev) =>
      prev.map((c) => (c.isCorrect ? c : { ...c, isRevealed: false }))
    );
    setPhase('hiding');

    // Brief delay for flip animation, then enable play
    timerRef.current = setTimeout(() => {
      setPhase('playing');
      resumeGameTimer(); // Resume game timer
    }, 400);
  }, [resumeGameTimer]);

  // Click anywhere to skip reveal wait
  const handleBoardClick = useCallback(() => {
    if (phase === 'waitSkip') {
      hideCardsAndPlay();
    }
  }, [phase, hideCardsAndPlay]);

  // Start first round
  useEffect(() => {
    startRound(0);
    return () => clearTimeout(timerRef.current);
  }, []);

  // Swap mechanic — swap 2 random unmatched cards' positions
  const performSwap = useCallback((currentCards: Card[]) => {
    const unmatched = currentCards.filter((c) => !c.isCorrect);
    if (unmatched.length < 4) return; // need at least 2 pairs

    const picked = shuffle(unmatched).slice(0, 2);
    const [a, b] = [picked[0], picked[1]];

    setPhase('swapping');
    setCards((prev) =>
      prev.map((c) => {
        if (c.id === a.id) return { ...c, gridSlot: b.gridSlot };
        if (c.id === b.id) return { ...c, gridSlot: a.gridSlot };
        return c;
      })
    );

    timerRef.current = setTimeout(() => {
      setPhase('playing');
    }, 550);
  }, []);

  const handleCardClick = (cardId: number) => {
    if (phase !== 'playing') return;

    const card = cards.find((c) => c.id === cardId);
    if (!card || card.isRevealed || card.isCorrect) return;

    // Flip this card
    setCards((prev) =>
      prev.map((c) => (c.id === cardId ? { ...c, isRevealed: true } : c))
    );

    const newFlipped = [...flippedIds, cardId];
    setFlippedIds(newFlipped);

    if (newFlipped.length === 2) {
      const card1 = cards.find((c) => c.id === newFlipped[0])!;
      const card2 = cards.find((c) => c.id === newFlipped[1])!;

      if (card1.cardType === card2.cardType) {
        // Match!
        playCorrect();
        addCorrect();

        const updated = cards.map((c) =>
          c.id === card1.id || c.id === card2.id
            ? { ...c, isRevealed: true, isCorrect: true }
            : c
        );

        // Auto-reveal last pair (from original: if cardsLeft <= 2)
        const remaining = updated.filter(
          (c) => !c.isCorrect && c.id !== card1.id && c.id !== card2.id
        );
        if (remaining.length === 2) {
          updated.forEach((c) => {
            if (!c.isCorrect) {
              c.isRevealed = true;
              c.isCorrect = true;
            }
          });
        }

        setCards(updated);
        setFlippedIds([]);

        const allDone = updated.every((c) => c.isCorrect);

        if (allDone) {
          // Round complete
          setPhase('roundEnd');
          timerRef.current = setTimeout(() => {
            const next = round + 1;
            setRound(next);
            startRound(next);
          }, 700);
        } else {
          // Maybe swap cards (from original MatchCard.as)
          if (swapsLeft > 0) {
            const pairsRemaining = remaining.length / 2;
            if (
              rnd(0, 2) === 0 ||
              pairsRemaining - 1 <= swapsLeft
            ) {
              setSwapsLeft((s) => s - 1);
              performSwap(updated);
            }
          }
        }
      } else {
        // No match
        playIncorrect();
        addIncorrect();
        setPhase('wrongPause');

        timerRef.current = setTimeout(() => {
          setCards((prev) =>
            prev.map((c) =>
              c.id === card1.id || c.id === card2.id
                ? { ...c, isRevealed: false }
                : c
            )
          );
          setFlippedIds([]);
          setPhase('playing');
        }, 800);
      }
    }
  };

  if (timeRemaining <= 0) return null;

  // Grid layout — absolute positioning based on gridSlot
  const gridW = GRID_COLS * (CARD_W + GAP) - GAP;
  const gridH = GRID_ROWS * (CARD_H + GAP) - GAP;

  return (
    <GameContainer>
      <div
        className="flex flex-col items-center justify-center h-full"
        onClick={handleBoardClick}
      >
        {phase === 'waitSkip' && (
          <motion.div
            className="text-sm text-yellow-300 mb-2"
            style={{ fontFamily: 'Baveuse, cursive' }}
            initial={{ opacity: 0 }}
            animate={{ opacity: [0, 1, 0.6, 1] }}
            transition={{ duration: 1.5, repeat: Infinity }}
          >
            Memorize the cards! (click to start)
          </motion.div>
        )}
        {(phase === 'revealing' || phase === 'dealing' || phase === 'hiding') && (
          <div
            className="text-sm text-gray-300 mb-2"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            Memorize the cards!
          </div>
        )}
        {(phase === 'playing' || phase === 'swapping' || phase === 'wrongPause') && (
          <div
            className="text-sm text-gray-300 mb-2"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            Find the matching pairs!
          </div>
        )}

        <div className="relative" style={{ width: gridW, height: gridH }}>
          {cards.map((card) => {
            const col = card.gridSlot % GRID_COLS;
            const row = Math.floor(card.gridSlot / GRID_COLS);
            const x = col * (CARD_W + GAP);
            const y = row * (CARD_H + GAP);
            const canInteract =
              phase === 'playing' &&
              !card.isRevealed &&
              !card.isCorrect;

            return (
              <motion.button
                key={card.id}
                onClick={(e) => {
                  e.stopPropagation();
                  handleCardClick(card.id);
                }}
                className="absolute rounded-xl overflow-hidden"
                initial={{ left: gridW / 2 - CARD_W / 2, top: gridH / 2 - CARD_H / 2, opacity: 0, scale: 0.5 }}
                animate={{
                  left: x,
                  top: y,
                  opacity: card.isCorrect && phase === 'roundEnd' ? 0.3 : 1,
                  scale: 1,
                }}
                transition={{
                  left: { duration: 0.4, ease: 'easeOut' },
                  top: { duration: 0.4, ease: 'easeOut' },
                  opacity: { duration: 0.3 },
                  scale: { duration: 0.3 },
                }}
                style={{
                  width: CARD_W,
                  height: CARD_H,
                  filter: card.isCorrect ? 'grayscale(0.5)' : 'none',
                  boxShadow:
                    card.isRevealed && !card.isCorrect
                      ? '0 0 12px rgba(255,215,0,0.4)'
                      : '0 4px 8px rgba(0,0,0,0.3)',
                }}
                whileHover={
                  canInteract
                    ? {
                        scale: 1.08,
                        boxShadow: '0 0 18px rgba(255,215,0,0.6)',
                      }
                    : {}
                }
                whileTap={canInteract ? { scale: 0.93 } : {}}
                disabled={!canInteract}
              >
                <AnimatePresence mode="wait">
                  {card.isRevealed ? (
                    <motion.img
                      key="front"
                      src={CARD_FRONTS[card.cardType % CARD_FRONTS.length]}
                      initial={{ rotateY: 90 }}
                      animate={{ rotateY: 0 }}
                      exit={{ rotateY: 90 }}
                      className="w-full h-full object-cover"
                      draggable={false}
                      alt=""
                    />
                  ) : (
                    <motion.img
                      key="back"
                      src="/assets/generated/card-back.png"
                      initial={{ rotateY: -90 }}
                      animate={{ rotateY: 0 }}
                      exit={{ rotateY: -90 }}
                      className="w-full h-full object-cover"
                      draggable={false}
                      alt=""
                    />
                  )}
                </AnimatePresence>
              </motion.button>
            );
          })}
        </div>

        <div
          className="mt-3 text-sm text-gray-400"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Round {round + 1} •{' '}
          {Math.ceil(cards.filter((c) => !c.isCorrect).length / 2)} pairs left
        </div>
      </div>
    </GameContainer>
  );
}
