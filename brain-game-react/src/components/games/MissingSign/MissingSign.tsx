// MissingSign Game - FROM SOURCE.md
// Find the missing operator (+, -, ×, ÷) that makes the equation true
// CORRECT_SCORE = 20, INCORRECT_SCORE = -12
import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
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

// Exact scoring from SOURCE.md
const CORRECT_SCORE = 20;
const INCORRECT_SCORE = -12;

export function MissingSignGame() {
  const [question, setQuestion] = useState<Question | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [feedback, setFeedback] = useState<'correct' | 'incorrect' | null>(null);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateQuestion = useCallback((): Question => {
    const difficulty = Math.floor(totalCorrect / 3.5);
    const maxNum = Math.min(10 + difficulty * 2, 50);
    
    // All operators available from the start (like original)
    const correctOperator = OPERATORS[Math.floor(Math.random() * OPERATORS.length)];
    
    let num1: number, num2: number, result: number;
    let attempts = 0;
    
    // Generate equation ensuring no ambiguous solutions
    do {
      switch (correctOperator) {
        case '+':
          num1 = Math.floor(Math.random() * maxNum) + 1;
          num2 = Math.floor(Math.random() * maxNum) + 1;
          result = num1 + num2;
          break;
        case '-':
          num1 = Math.floor(Math.random() * maxNum) + 5;
          num2 = Math.floor(Math.random() * Math.min(num1 - 1, maxNum)) + 1;
          result = num1 - num2;
          break;
        case '×':
          num1 = Math.floor(Math.random() * 12) + 2;
          num2 = Math.floor(Math.random() * 12) + 2;
          result = num1 * num2;
          break;
        case '÷':
          num2 = Math.floor(Math.random() * 10) + 2;
          result = Math.floor(Math.random() * 10) + 2;
          num1 = num2 * result;
          break;
      }
      attempts++;
    } while (hasAmbiguousSolution(num1, num2, result, correctOperator) && attempts < 10);
    
    return { num1, num2, result, correctOperator };
  }, [totalCorrect]);

  // Check if multiple operators produce the same result (ambiguous)
  const hasAmbiguousSolution = (n1: number, n2: number, result: number, correct: Operator): boolean => {
    const results: number[] = [];
    OPERATORS.forEach((op) => {
      let r: number;
      switch (op) {
        case '+': r = n1 + n2; break;
        case '-': r = n1 - n2; break;
        case '×': r = n1 * n2; break;
        case '÷': r = n2 !== 0 ? n1 / n2 : -999; break;
        default: r = -999;
      }
      if (r === result && op !== correct) {
        results.push(r);
      }
    });
    return results.length > 0;
  };

  useEffect(() => {
    setQuestion(generateQuestion());
  }, []);

  const handleOperatorClick = (operator: Operator) => {
    if (!question || feedback) return;
    
    if (operator === question.correctOperator) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
      setFeedback('correct');
    } else {
      playIncorrect();
      addIncorrect();
      setFeedback('incorrect');
    }
    
    setTimeout(() => {
      setFeedback(null);
      setQuestion(generateQuestion());
    }, 300);
  };

  if (!question || timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full relative">
        {/* Feedback overlay */}
        <AnimatePresence>
          {feedback && (
            <motion.div
              initial={{ scale: 0.5, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.5, opacity: 0 }}
              className="absolute inset-0 flex items-center justify-center z-10 pointer-events-none"
            >
              <span className={`text-8xl ${feedback === 'correct' ? 'text-green-500' : 'text-red-500'}`}>
                {feedback === 'correct' ? '✓' : '✗'}
              </span>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Equation display */}
        <motion.div
          key={`${question.num1}-${question.num2}-${question.result}`}
          initial={{ scale: 0.8, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          className="text-5xl md:text-6xl font-bold mb-12 flex items-center gap-4 text-white"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          <span>{question.num1}</span>
          <motion.span 
            className="w-16 h-16 bg-gradient-to-b from-yellow-400 to-yellow-600 rounded-2xl flex items-center justify-center text-4xl text-gray-900 shadow-lg border-4 border-yellow-300"
            animate={{ rotate: [0, 5, -5, 0] }}
            transition={{ repeat: Infinity, duration: 2 }}
          >
            ?
          </motion.span>
          <span>{question.num2}</span>
          <span className="text-gray-400">=</span>
          <span>{question.result}</span>
        </motion.div>

        {/* Operator buttons */}
        <div className="grid grid-cols-4 gap-4">
          {OPERATORS.map((op) => (
            <motion.button
              key={op}
              onClick={() => handleOperatorClick(op)}
              className="w-20 h-20 bg-gradient-to-b from-blue-500 to-blue-700 hover:from-blue-400 hover:to-blue-600 text-white text-4xl font-bold rounded-2xl shadow-lg border-2 border-blue-400"
              whileHover={{ scale: 1.1, y: -2 }}
              whileTap={{ scale: 0.95 }}
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              {op}
            </motion.button>
          ))}
        </div>

        <div 
          className="mt-8 text-gray-400 text-lg"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Which sign makes this true?
        </div>
      </div>
    </GameContainer>
  );
}
