// MissingSign Game - FROM SOURCE.md
// Find the missing operator (+, -, ×, ÷) that makes the equation true
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

type Operator = '+' | '-' | '×' | '÷';

interface Question {
  num1: number;
  num2: number;
  result: number;
  correctOperator: Operator;
}

const OPERATORS: Operator[] = ['+', '-', '×', '÷'];

export function MissingSignGame() {
  const [question, setQuestion] = useState<Question | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateQuestion = useCallback((): Question => {
    const difficulty = Math.floor(totalCorrect / 3);
    const maxNum = Math.min(10 + difficulty * 2, 20);
    
    // Pick a random operator
    const availableOps: Operator[] = difficulty < 2 ? ['+', '-'] : OPERATORS;
    const correctOperator = availableOps[Math.floor(Math.random() * availableOps.length)];
    
    let num1: number, num2: number, result: number;
    
    switch (correctOperator) {
      case '+':
        num1 = Math.floor(Math.random() * maxNum) + 1;
        num2 = Math.floor(Math.random() * maxNum) + 1;
        result = num1 + num2;
        break;
      case '-':
        num2 = Math.floor(Math.random() * maxNum) + 1;
        result = Math.floor(Math.random() * maxNum) + 1;
        num1 = num2 + result;
        break;
      case '×':
        num1 = Math.floor(Math.random() * 12) + 1;
        num2 = Math.floor(Math.random() * 12) + 1;
        result = num1 * num2;
        break;
      case '÷':
        num2 = Math.floor(Math.random() * 10) + 1;
        result = Math.floor(Math.random() * 10) + 1;
        num1 = num2 * result;
        break;
    }
    
    return { num1, num2, result, correctOperator };
  }, [totalCorrect]);

  useEffect(() => {
    setQuestion(generateQuestion());
  }, []);

  const handleOperatorClick = (operator: Operator) => {
    if (!question) return;
    
    if (operator === question.correctOperator) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
    } else {
      playIncorrect();
      addIncorrect();
    }
    
    setQuestion(generateQuestion());
  };

  if (!question || timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        {/* Equation display */}
        <motion.div
          key={`${question.num1}-${question.num2}-${question.result}`}
          initial={{ scale: 0.8, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          className="text-5xl font-bold mb-12 flex items-center gap-4"
        >
          <span>{question.num1}</span>
          <span className="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center text-3xl">
            ?
          </span>
          <span>{question.num2}</span>
          <span className="text-gray-600">=</span>
          <span>{question.result}</span>
        </motion.div>

        {/* Operator buttons */}
        <div className="grid grid-cols-4 gap-4">
          {OPERATORS.map((op) => (
            <motion.button
              key={op}
              onClick={() => handleOperatorClick(op)}
              className="w-20 h-20 bg-blue-500 hover:bg-blue-600 text-white text-4xl font-bold rounded-xl transition-colors"
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.9 }}
            >
              {op}
            </motion.button>
          ))}
        </div>

        <div className="mt-8 text-gray-500 text-sm">
          Which operator makes this equation true?
        </div>
      </div>
    </GameContainer>
  );
}
