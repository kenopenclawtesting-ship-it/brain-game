// MatchCard (Card Pairs) Game - FROM SOURCE.md
// Memory matching game with increasing pairs and card swaps
import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const CARD_COLORS = ['#ef4444', '#3b82f6', '#22c55e', '#eab308', '#6b7280', '#8b5cf6', '#ec4899', '#f97316'];
const CARD_SHAPES = ['●', '■', '★', '▲', '◆', '♠', '♥', '♣'];

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
        <div className="text-sm text-gray-500 mb-4">
          {isRevealing ? 'Memorize the cards!' : 'Find the matching pairs!'}
        </div>
        
        <div 
          className="grid gap-2"
          style={{ gridTemplateColumns: `repeat(${gridCols}, minmax(0, 1fr))` }}
        >
          {cards.map((card) => (
            <motion.button
              key={card.id}
              onClick={() => handleCardClick(card.id)}
              className={`
                w-16 h-20 rounded-lg font-bold text-2xl transition-all
                ${card.isMatched ? 'opacity-30' : ''}
                ${card.isFlipped ? 'bg-white border-2 border-gray-300' : 'bg-blue-500 hover:bg-blue-600'}
              `}
              whileHover={!card.isFlipped && !card.isMatched ? { scale: 1.05 } : {}}
              whileTap={!card.isFlipped && !card.isMatched ? { scale: 0.95 } : {}}
              disabled={card.isFlipped || card.isMatched || !canClick}
            >
              <AnimatePresence mode="wait">
                {card.isFlipped ? (
                  <motion.span
                    initial={{ rotateY: 90 }}
                    animate={{ rotateY: 0 }}
                    exit={{ rotateY: 90 }}
                    style={{ color: CARD_COLORS[card.value % CARD_COLORS.length] }}
                  >
                    {CARD_SHAPES[card.value % CARD_SHAPES.length]}
                  </motion.span>
                ) : (
                  <motion.span
                    initial={{ rotateY: -90 }}
                    animate={{ rotateY: 0 }}
                    exit={{ rotateY: -90 }}
                    className="text-white"
                  >
                    ?
                  </motion.span>
                )}
              </AnimatePresence>
            </motion.button>
          ))}
        </div>
        
        <div className="mt-4 text-sm text-gray-500">
          Round {round + 1} • {cards.filter((c) => !c.isMatched).length / 2} pairs left
        </div>
      </div>
    </GameContainer>
  );
}
