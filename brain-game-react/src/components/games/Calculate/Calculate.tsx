// Calculate (Missing Number) Game - FROM SOURCE.md
// Solve arithmetic equations (e.g., "5 + ? = 12")
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

type Operator = '+' | '-' | '×' | '÷';

interface Question {
  num1: number;
  num2: number;
  operator: Operator;
  answer: number;
  missingPosition: 'first' | 'second' | 'result';
}

export function CalculateGame() {
  const [question, setQuestion] = useState<Question | null>(null);
  const [input, setInput] = useState('');
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateQuestion = useCallback((): Question => {
    // Difficulty scaling from SOURCE.md: difficulty = Math.floor(totalCorrect / 3.5)
    const difficulty = Math.floor(totalCorrect / 3.5);
    const maxNum = Math.min(10 + difficulty * 3, 99);
    
    // Available operators based on difficulty
    const operators: Operator[] = ['+', '-'];
    if (difficulty >= 2) operators.push('×');
    if (difficulty >= 4) operators.push('÷');
    
    const operator = operators[Math.floor(Math.random() * operators.length)];
    
    let num1: number, num2: number, answer: number;
    
    switch (operator) {
      case '+':
        num1 = Math.floor(Math.random() * maxNum) + 1;
        num2 = Math.floor(Math.random() * maxNum) + 1;
        answer = num1 + num2;
        break;
      case '-':
        answer = Math.floor(Math.random() * maxNum) + 1;
        num2 = Math.floor(Math.random() * Math.min(answer, maxNum)) + 1;
        num1 = answer + num2;
        [num1, answer] = [answer + num2, answer]; // Ensure positive result
        break;
      case '×':
        num1 = Math.floor(Math.random() * 12) + 1;
        num2 = Math.floor(Math.random() * 12) + 1;
        answer = num1 * num2;
        break;
      case '÷':
        num2 = Math.floor(Math.random() * 12) + 1;
        answer = Math.floor(Math.random() * 12) + 1;
        num1 = num2 * answer;
        break;
      default:
        num1 = 1; num2 = 1; answer = 2;
    }
    
    // Randomly choose which position is missing
    const positions: ('first' | 'second' | 'result')[] = ['first', 'second', 'result'];
    const missingPosition = positions[Math.floor(Math.random() * positions.length)];
    
    return { num1, num2, operator, answer, missingPosition };
  }, [totalCorrect]);

  useEffect(() => {
    setQuestion(generateQuestion());
  }, []);

  const checkAnswer = useCallback(() => {
    if (!question || !input) return;
    
    const userAnswer = parseInt(input, 10);
    let correctAnswer: number;
    
    switch (question.missingPosition) {
      case 'first':
        correctAnswer = question.num1;
        break;
      case 'second':
        correctAnswer = question.num2;
        break;
      case 'result':
        correctAnswer = question.answer;
        break;
    }
    
    if (userAnswer === correctAnswer) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
    } else {
      playIncorrect();
      addIncorrect();
    }
    
    setInput('');
    setQuestion(generateQuestion());
  }, [question, input, addCorrect, addIncorrect, playCorrect, playIncorrect, generateQuestion]);

  const handleKeyPress = (key: string) => {
    if (key === 'enter') {
      checkAnswer();
    } else if (key === 'backspace') {
      setInput((prev) => prev.slice(0, -1));
    } else if (key === '-' && input === '') {
      setInput('-');
    } else if (/^\d$/.test(key) && input.length < 4) {
      setInput((prev) => prev + key);
    }
  };

  if (!question || timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        {/* Equation display */}
        <motion.div
          key={`${question.num1}-${question.operator}-${question.num2}`}
          initial={{ scale: 0.8, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          className="text-4xl font-bold mb-8 flex items-center gap-4"
        >
          <span className={question.missingPosition === 'first' ? 'text-blue-500' : ''}>
            {question.missingPosition === 'first' ? '?' : question.num1}
          </span>
          <span className="text-gray-600">{question.operator}</span>
          <span className={question.missingPosition === 'second' ? 'text-blue-500' : ''}>
            {question.missingPosition === 'second' ? '?' : question.num2}
          </span>
          <span className="text-gray-600">=</span>
          <span className={question.missingPosition === 'result' ? 'text-blue-500' : ''}>
            {question.missingPosition === 'result' ? '?' : question.answer}
          </span>
        </motion.div>

        {/* Input display */}
        <div className="w-32 h-16 bg-white border-4 border-blue-500 rounded-lg flex items-center justify-center mb-6">
          <span className="text-3xl font-bold">{input || '_'}</span>
        </div>

        {/* Number pad */}
        <div className="grid grid-cols-3 gap-2">
          {[1, 2, 3, 4, 5, 6, 7, 8, 9, '-', 0, '←'].map((key) => (
            <button
              key={key}
              onClick={() => handleKeyPress(key === '←' ? 'backspace' : String(key))}
              className="w-14 h-14 bg-gray-200 hover:bg-gray-300 rounded-lg text-xl font-bold transition-colors"
            >
              {key}
            </button>
          ))}
        </div>
        
        {/* Submit button */}
        <button
          onClick={checkAnswer}
          disabled={!input}
          className="mt-4 px-8 py-3 bg-green-500 hover:bg-green-600 disabled:bg-gray-300 text-white font-bold rounded-lg transition-colors"
        >
          SUBMIT
        </button>
      </div>
    </GameContainer>
  );
}
