// WeightGame (Balance Scale) - FROM SOURCE.md
// Determine which object is heaviest from scale comparisons
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const SHAPES = ['🔴', '🔵', '🟢', '🟡', '🟣', '🟠'];

interface Scale {
  left: number[];
  right: number[];
  result: 'left' | 'right' | 'equal';
}

interface Puzzle {
  numItems: number;
  scales: Scale[];
  heaviest: number;
}

export function WeightGameGame() {
  const [puzzle, setPuzzle] = useState<Puzzle | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): Puzzle => {
    // From SOURCE.md: numScales = Math.min(1 + Math.floor(totalCorrect / 8), 4)
    const numScales = Math.min(1 + Math.floor(totalCorrect / 8), 3);
    const numItems = numScales + 2;
    
    // Assign random weights (the heaviest will be the answer)
    const weights = Array.from({ length: numItems }, (_, i) => i + 1);
    // Shuffle weights
    for (let i = weights.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [weights[i], weights[j]] = [weights[j], weights[i]];
    }
    
    const heaviest = weights.indexOf(Math.max(...weights));
    
    // Generate scales that help determine the heaviest
    const scales: Scale[] = [];
    const usedItems = new Set<number>();
    
    for (let i = 0; i < numScales; i++) {
      const availableItems = Array.from({ length: numItems }, (_, i) => i)
        .filter(item => !usedItems.has(item) || Math.random() > 0.5);
      
      if (availableItems.length < 2) break;
      
      const left = [availableItems[Math.floor(Math.random() * availableItems.length)]];
      let right: number;
      do {
        right = availableItems[Math.floor(Math.random() * availableItems.length)];
      } while (right === left[0]);
      
      const leftWeight = weights[left[0]];
      const rightWeight = weights[right];
      
      scales.push({
        left,
        right: [right],
        result: leftWeight > rightWeight ? 'left' : leftWeight < rightWeight ? 'right' : 'equal',
      });
      
      usedItems.add(left[0]);
      usedItems.add(right);
    }
    
    return { numItems, scales, heaviest };
  }, [totalCorrect]);

  useEffect(() => {
    setPuzzle(generatePuzzle());
  }, []);

  const handleItemClick = (itemIndex: number) => {
    if (!puzzle) return;
    
    if (itemIndex === puzzle.heaviest) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
    } else {
      playIncorrect();
      addIncorrect();
    }
    
    setPuzzle(generatePuzzle());
  };

  if (!puzzle || timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        <div className="text-sm text-gray-500 mb-4">
          Which object is the HEAVIEST?
        </div>

        {/* Scales display */}
        <div className="flex flex-wrap justify-center gap-4 mb-6">
          {puzzle.scales.map((scale, i) => (
            <div key={i} className="bg-gray-100 rounded-lg p-4">
              <div className="flex items-center gap-2">
                {/* Left side */}
                <div className="flex gap-1">
                  {scale.left.map((item) => (
                    <span key={item} className="text-3xl">{SHAPES[item]}</span>
                  ))}
                </div>
                
                {/* Scale indicator */}
                <div className="flex flex-col items-center">
                  <div className={`w-20 h-1 bg-gray-800 transform ${
                    scale.result === 'left' ? '-rotate-12' :
                    scale.result === 'right' ? 'rotate-12' : ''
                  }`} />
                  <div className="text-xs text-gray-500 mt-1">
                    {scale.result === 'left' ? '⬅️ heavier' :
                     scale.result === 'right' ? 'heavier ➡️' : '= equal'}
                  </div>
                </div>
                
                {/* Right side */}
                <div className="flex gap-1">
                  {scale.right.map((item) => (
                    <span key={item} className="text-3xl">{SHAPES[item]}</span>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Item selection */}
        <div className="flex gap-4 flex-wrap justify-center">
          {Array.from({ length: puzzle.numItems }).map((_, i) => (
            <motion.button
              key={i}
              onClick={() => handleItemClick(i)}
              className="w-20 h-20 bg-white border-4 border-gray-300 hover:border-blue-500 rounded-xl flex items-center justify-center text-4xl transition-colors"
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.9 }}
            >
              {SHAPES[i]}
            </motion.button>
          ))}
        </div>
        
        <div className="mt-4 text-gray-500 text-sm">
          Use the scale comparisons to find the heaviest object
        </div>
      </div>
    </GameContainer>
  );
}
