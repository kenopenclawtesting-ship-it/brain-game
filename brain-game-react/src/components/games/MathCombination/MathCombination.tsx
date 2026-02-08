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
        <div className="text-center mb-6">
          <div className="text-sm text-gray-500">Find numbers that add up to</div>
          <div className="text-5xl font-bold text-blue-600">{puzzle.target}</div>
        </div>

        {/* Current sum */}
        <div className="mb-6 flex items-center gap-2">
          <span className="text-gray-500">Current sum:</span>
          <span className={`text-2xl font-bold ${
            currentSum === puzzle.target ? 'text-green-600' :
            currentSum > puzzle.target ? 'text-red-600' : 'text-gray-800'
          }`}>
            {currentSum}
          </span>
          {selected.length > 0 && (
            <span className="text-sm text-gray-400">
              ({selected.map((i) => puzzle.numbers[i]).join(' + ')})
            </span>
          )}
        </div>

        {/* Number buttons */}
        <div className="flex gap-3 flex-wrap justify-center max-w-md mb-6">
          {puzzle.numbers.map((num, idx) => (
            <motion.button
              key={idx}
              onClick={() => handleNumberClick(idx)}
              className={`
                w-16 h-16 rounded-xl text-2xl font-bold transition-all
                ${selected.includes(idx)
                  ? 'bg-blue-500 text-white border-4 border-blue-700'
                  : 'bg-white border-4 border-gray-300 hover:border-blue-400 text-gray-800'
                }
              `}
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.9 }}
            >
              {num}
            </motion.button>
          ))}
        </div>

        {/* Clear button */}
        {selected.length > 0 && (
          <button
            onClick={handleClear}
            className="px-6 py-2 bg-gray-200 hover:bg-gray-300 rounded-lg font-medium text-gray-700"
          >
            Clear Selection
          </button>
        )}

        <div className="mt-4 text-gray-500 text-sm">
          Select numbers that add up to {puzzle.target}
        </div>
      </div>
    </GameContainer>
  );
}
