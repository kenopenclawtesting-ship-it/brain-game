// MatchCard (Card Pairs) Game - FROM SOURCE.md
// Memory matching game with increasing pairs and card swaps
import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const CARD_FRONTS = [
  '/assets/generated/card-front-star.png',
  '/assets/generated/card-front-moon.png',
  '/assets/generated/card-front-sun.png',
  '/assets/generated/card-front-lightning.png',
  '/assets/generated/card-front-diamond.png',
  '/assets/generated/card-front-heart.png',
  '/assets/generated/card-front-crown.png',
  '/assets/generated/card-front-flame.png',
];

interface Card {
  id: number;
  value: number;
  isFlipped: boolean;
  isMatched: boolean;
  position: number;
}

export function MatchCardGame() {
  const [cards, setCards] = useState<Card[]>([]);
  const [flippedCards, setFlippedCards] = useState<number[]>([]);
  const [round, setRound] = useState(0);
  const [isRevealing, setIsRevealing] = useState(true);
  const [canClick, setCanClick] = useState(false);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateCards = useCallback((roundNum: number) => {
    // From SOURCE.md: numPairs = 2 + Math.floor(round / 2), max 5 pairs
    const numPairs = Math.min(2 + Math.floor(roundNum / 2), 5);
    const totalCards = numPairs * 2;
    
    const values: number[] = [];
    for (let i = 0; i < numPairs; i++) {
      values.push(i, i); // Each value appears twice
    }
    
    // Shuffle
    for (let i = values.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [values[i], values[j]] = [values[j], values[i]];
    }
    
    return values.map((value, index) => ({
      id: index,
      value,
      isFlipped: true, // Start revealed
      isMatched: false,
      position: index,
    }));
  }, []);

  const startNewRound = useCallback(() => {
    const newCards = generateCards(round);
    setCards(newCards);
    setFlippedCards([]);
    setIsRevealing(true);
    setCanClick(false);
    
    // Reveal cards for 2 seconds, then hide
    setTimeout(() => {
      setCards((prev) => prev.map((c) => ({ ...c, isFlipped: false })));
      setIsRevealing(false);
      setCanClick(true);
    }, 2000);
  }, [round, generateCards]);

  useEffect(() => {
    startNewRound();
  }, []);

  const handleCardClick = (cardId: number) => {
    if (!canClick || isRevealing) return;
    
    const card = cards.find((c) => c.id === cardId);
    if (!card || card.isFlipped || card.isMatched) return;
    
    // Flip the card
    setCards((prev) => prev.map((c) => 
      c.id === cardId ? { ...c, isFlipped: true } : c
    ));
    
    const newFlipped = [...flippedCards, cardId];
    setFlippedCards(newFlipped);
    
    if (newFlipped.length === 2) {
      setCanClick(false);
      
      const [first, second] = newFlipped;
      const card1 = cards.find((c) => c.id === first)!;
      const card2 = cards.find((c) => c.id === second)!;
      
      if (card1.value === card2.value) {
        // Match!
        playCorrect();
        addCorrect();
        setCards((prev) => prev.map((c) => 
          c.id === first || c.id === second ? { ...c, isMatched: true } : c
        ));
        setFlippedCards([]);
        
        // Check if all matched
        setTimeout(() => {
          const allMatched = cards.every((c) => c.isMatched || c.id === first || c.id === second);
          if (allMatched) {
            setRound((r) => r + 1);
            startNewRound();
          } else {
            setCanClick(true);
          }
        }, 300);
      } else {
        // No match
        playIncorrect();
        addIncorrect();
        setTimeout(() => {
          setCards((prev) => prev.map((c) => 
            c.id === first || c.id === second ? { ...c, isFlipped: false } : c
          ));
          setFlippedCards([]);
          setCanClick(true);
        }, 800);
      }
    }
  };

  if (timeRemaining <= 0) return null;

  const gridCols = cards.length <= 6 ? 3 : cards.length <= 8 ? 4 : 5;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        <div
          className="text-sm text-gray-300 mb-4"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {isRevealing ? 'Memorize the cards!' : 'Find the matching pairs!'}
        </div>

        <div
          className="grid gap-3"
          style={{ gridTemplateColumns: `repeat(${gridCols}, minmax(0, 1fr))` }}
        >
          {cards.map((card) => (
            <motion.button
              key={card.id}
              onClick={() => handleCardClick(card.id)}
              className="relative w-[68px] h-[84px] rounded-xl overflow-hidden"
              style={{
                opacity: card.isMatched ? 0.35 : 1,
                filter: card.isMatched ? 'grayscale(0.5)' : 'none',
                boxShadow: card.isFlipped && !card.isMatched
                  ? '0 0 12px rgba(255,215,0,0.4)'
                  : '0 4px 8px rgba(0,0,0,0.3)',
              }}
              whileHover={!card.isFlipped && !card.isMatched ? { scale: 1.08, boxShadow: '0 0 18px rgba(255,215,0,0.6)' } : {}}
              whileTap={!card.isFlipped && !card.isMatched ? { scale: 0.93 } : {}}
              disabled={card.isFlipped || card.isMatched || !canClick}
            >
              <AnimatePresence mode="wait">
                {card.isFlipped ? (
                  <motion.img
                    key="front"
                    src={CARD_FRONTS[card.value % CARD_FRONTS.length]}
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
              {card.isMatched && (
                <img
                  src="/assets/generated/card-match-effect.png"
                  className="absolute inset-0 w-full h-full object-cover pointer-events-none opacity-70"
                  alt=""
                />
              )}
            </motion.button>
          ))}
        </div>

        <div
          className="mt-4 text-sm text-gray-400"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Round {round + 1} • {cards.filter((c) => !c.isMatched).length / 2} pairs left
        </div>
      </div>
    </GameContainer>
  );
}
