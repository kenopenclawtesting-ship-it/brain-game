// WeightGame (Balance Scale) - FROM SOURCE.md
// Determine which object is heaviest from scale comparisons
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const WEIGHT_IMAGES = [
  '/assets/generated/weight-anvil.png',
  '/assets/generated/weight-feather.png',
  '/assets/generated/weight-brick.png',
  '/assets/generated/weight-ball.png',
  '/assets/generated/weight-balloon.png',
  '/assets/generated/weight-rock.png',
  '/assets/generated/weight-cloud.png',
  '/assets/generated/weight-gold-bar.png',
];

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
        <div
          className="text-sm text-gray-300 mb-4"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Which object is the HEAVIEST?
        </div>

        {/* Scales display */}
        <div className="flex flex-wrap justify-center gap-4 mb-6">
          {puzzle.scales.map((scale, i) => (
            <div
              key={i}
              className="rounded-xl p-4 relative"
              style={{
                background: 'linear-gradient(180deg, rgba(40,40,80,0.8) 0%, rgba(20,20,50,0.9) 100%)',
                border: '2px solid rgba(255,255,255,0.1)',
              }}
            >
              <div className="flex items-center gap-3">
                {/* Left side */}
                <div className="flex gap-1">
                  {scale.left.map((item) => (
                    <img
                      key={item}
                      src={WEIGHT_IMAGES[item % WEIGHT_IMAGES.length]}
                      className="w-10 h-10 object-contain"
                      alt=""
                    />
                  ))}
                </div>

                {/* Scale indicator with AI image */}
                <div className="flex flex-col items-center">
                  <div className="relative w-20 h-12">
                    <img
                      src="/assets/generated/scale-balance.png"
                      className="w-full h-full object-contain"
                      style={{
                        transform: scale.result === 'left' ? 'rotate(-12deg)' :
                          scale.result === 'right' ? 'rotate(12deg)' : 'rotate(0deg)',
                      }}
                      alt=""
                    />
                  </div>
                  <div
                    className="text-xs text-gray-400 mt-1"
                    style={{ fontFamily: 'Baveuse, cursive' }}
                  >
                    {scale.result === 'left' ? '← heavier' :
                     scale.result === 'right' ? 'heavier →' : '= equal'}
                  </div>
                </div>

                {/* Right side */}
                <div className="flex gap-1">
                  {scale.right.map((item) => (
                    <img
                      key={item}
                      src={WEIGHT_IMAGES[item % WEIGHT_IMAGES.length]}
                      className="w-10 h-10 object-contain"
                      alt=""
                    />
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
              className="w-20 h-20 rounded-xl flex items-center justify-center overflow-hidden"
              style={{
                background: 'linear-gradient(180deg, #3a3a6a 0%, #2a2a4a 100%)',
                border: '3px solid rgba(255,255,255,0.15)',
              }}
              whileHover={{ scale: 1.1, boxShadow: '0 0 20px rgba(255,215,0,0.5)' }}
              whileTap={{ scale: 0.9 }}
            >
              <img
                src={WEIGHT_IMAGES[i % WEIGHT_IMAGES.length]}
                className="w-14 h-14 object-contain"
                alt=""
              />
            </motion.button>
          ))}
        </div>

        <div
          className="mt-4 text-gray-400 text-sm"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Use the scale comparisons to find the heaviest object
        </div>
      </div>
    </GameContainer>
  );
}
