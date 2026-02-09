// MathCombination (PRO) - FROM SOURCE.md
// Select numbers that sum to target
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

interface Puzzle {
  numbers: number[];
  target: number;
  solution: number[]; // Indices of correct numbers
}

export function MathCombinationGame() {
  const [puzzle, setPuzzle] = useState<Puzzle | null>(null);
  const [selected, setSelected] = useState<number[]>([]);
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): Puzzle => {
    const difficulty = Math.min(totalCorrect, 10);
    const numNumbers = Math.min(4 + Math.floor(difficulty / 2), 7);
    const solutionSize = Math.min(2 + Math.floor(difficulty / 3), 4);
    const maxNum = 10 + difficulty * 2;
    
    // Generate solution numbers first
    const solutionNums: number[] = [];
    for (let i = 0; i < solutionSize; i++) {
      solutionNums.push(Math.floor(Math.random() * maxNum) + 1);
    }
    const target = solutionNums.reduce((a, b) => a + b, 0);
    
    // Add distractor numbers
    const numbers = [...solutionNums];
    while (numbers.length < numNumbers) {
      const num = Math.floor(Math.random() * maxNum) + 1;
      // Avoid duplicates and numbers that would form alternative solutions
      if (!numbers.includes(num)) {
        numbers.push(num);
      }
    }
    
    // Shuffle and track solution indices
    const shuffled = numbers.sort(() => Math.random() - 0.5);
    const solution = solutionNums.map((n) => shuffled.indexOf(n));
    
    return { numbers: shuffled, target, solution };
  }, [totalCorrect]);

  useEffect(() => {
    setPuzzle(generatePuzzle());
    setSelected([]);
  }, []);

  const currentSum = selected.reduce((sum, idx) => sum + (puzzle?.numbers[idx] || 0), 0);

  const handleNumberClick = (index: number) => {
    if (!puzzle) return;
    
    if (selected.includes(index)) {
      setSelected(selected.filter((i) => i !== index));
    } else {
      const newSelected = [...selected, index];
      const newSum = newSelected.reduce((sum, idx) => sum + puzzle.numbers[idx], 0);
      
      if (newSum === puzzle.target) {
        playCorrect();
        addCorrect();
        setTotalCorrect((prev) => prev + 1);
        setTimeout(() => {
          setPuzzle(generatePuzzle());
          setSelected([]);
        }, 500);
      } else if (newSum > puzzle.target) {
        playIncorrect();
        addIncorrect();
        setSelected([]);
      } else {
        setSelected(newSelected);
      }
    }
  };

  const handleClear = () => {
    setSelected([]);
  };

  if (!puzzle || timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        {/* Target */}
        <div className="text-center mb-5 relative">
          <div className="relative inline-block px-8 py-3 rounded-xl" style={{ background: 'linear-gradient(180deg, #2a2a5a 0%, #1a1a3a 100%)', border: '2px solid rgba(255,215,0,0.3)' }}>
            <img
              src="/assets/generated/number-target-display.png"
              className="absolute inset-0 w-full h-full object-cover rounded-xl opacity-30"
              alt=""
            />
            <div className="relative z-10">
              <div className="text-sm text-gray-400" style={{ fontFamily: 'Baveuse, cursive' }}>Find numbers that add up to</div>
              <div className="text-5xl font-bold text-yellow-400" style={{ fontFamily: 'Baveuse, cursive', textShadow: '0 0 15px rgba(255,215,0,0.4)' }}>{puzzle.target}</div>
            </div>
          </div>
        </div>

        {/* Current sum */}
        <div className="mb-5 flex items-center gap-2">
          <span className="text-gray-400" style={{ fontFamily: 'Baveuse, cursive' }}>Sum:</span>
          <span className={`text-2xl font-bold ${
            currentSum === puzzle.target ? 'text-green-400' :
            currentSum > puzzle.target ? 'text-red-400' : 'text-white'
          }`} style={{ fontFamily: 'Baveuse, cursive' }}>
            {currentSum}
          </span>
          {selected.length > 0 && (
            <span className="text-sm text-gray-500">
              ({selected.map((i) => puzzle.numbers[i]).join(' + ')})
            </span>
          )}
        </div>

        {/* Number buttons */}
        <div className="flex gap-3 flex-wrap justify-center max-w-md mb-5">
          {puzzle.numbers.map((num, idx) => {
            const isSelected = selected.includes(idx);
            const bubbleNum = Math.abs(num % 9) + 1;
            return (
              <motion.button
                key={idx}
                onClick={() => handleNumberClick(idx)}
                className="relative w-16 h-16 rounded-xl flex items-center justify-center overflow-hidden"
                style={{
                  border: isSelected ? '3px solid #ffd700' : '3px solid rgba(255,255,255,0.1)',
                  boxShadow: isSelected ? '0 0 15px rgba(255,215,0,0.5)' : '0 4px 8px rgba(0,0,0,0.3)',
                }}
                whileHover={{ scale: 1.1, boxShadow: '0 0 15px rgba(255,215,0,0.4)' }}
                whileTap={{ scale: 0.9 }}
              >
                <img
                  src={`/assets/generated/number-bubble-${bubbleNum}.png`}
                  className="absolute inset-0 w-full h-full object-cover"
                  style={{ filter: isSelected ? 'brightness(1.3)' : 'brightness(0.9)' }}
                  alt=""
                />
                <span
                  className="relative z-10 text-2xl font-bold text-white"
                  style={{ fontFamily: 'Baveuse, cursive', textShadow: '1px 1px 3px rgba(0,0,0,0.8)' }}
                >
                  {num}
                </span>
              </motion.button>
            );
          })}
        </div>

        {/* Clear button */}
        {selected.length > 0 && (
          <motion.button
            onClick={handleClear}
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            className="px-6 py-2 rounded-lg font-bold text-white"
            style={{
              fontFamily: 'Baveuse, cursive',
              background: 'linear-gradient(180deg, #e74c3c 0%, #c0392b 100%)',
            }}
          >
            Clear Selection
          </motion.button>
        )}

        <div className="mt-4 text-gray-400 text-sm" style={{ fontFamily: 'Baveuse, cursive' }}>
          Select numbers that add up to {puzzle.target}
        </div>
      </div>
    </GameContainer>
  );
}
