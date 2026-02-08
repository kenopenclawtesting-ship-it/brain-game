// Calculate (Missing Number) Game - FROM SOURCE.md
// Solve arithmetic equations (e.g., "5 + ? = 12")
// Complex equations at higher difficulty: (3 + 2) × ? = 20
import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

type Operator = '+' | '-' | '×' | '÷';

interface SimpleQuestion {
  type: 'simple';
  num1: number;
  num2: number;
  operator: Operator;
  answer: number;
  missingPosition: 'first' | 'second' | 'result';
  missingValue: number;
}

interface ComplexQuestion {
  type: 'complex';
  a: number;
  b: number;
  op1: Operator;
  op2: Operator;
  missingValue: number;
  result: number;
  display: string;
}

type Question = SimpleQuestion | ComplexQuestion;

// Exact scoring from SOURCE.md
const CORRECT_SCORE = 27;
const INCORRECT_SCORE = -18;

export function CalculateGame() {
  const [question, setQuestion] = useState<Question | null>(null);
  const [input, setInput] = useState('');
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [feedback, setFeedback] = useState<'correct' | 'incorrect' | null>(null);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateQuestion = useCallback((): Question => {
    // Difficulty scaling from SOURCE.md: difficulty = Math.floor(totalCorrect / 3.5)
    const difficulty = Math.floor(totalCorrect / 3.5);
    const maxNum = Math.min(10 + difficulty * 3, 99);
    
    // Complex equations at difficulty >= 3 AND odd total correct (from ActionScript)
    const useComplex = difficulty >= 3 && totalCorrect % 2 === 1;
    
    if (useComplex) {
      // Complex equation: (a op1 b) op2 ? = result
      const ops1: Operator[] = ['+', '-'];
      const ops2: Operator[] = ['+', '-', '×', '÷'];
      const op1 = ops1[Math.floor(Math.random() * ops1.length)];
      const op2 = ops2[Math.floor(Math.random() * ops2.length)];
      
      let a: number, b: number, innerResult: number, c: number, finalResult: number;
      
      // Generate inner operation
      a = Math.floor(Math.random() * 15) + 1;
      b = Math.floor(Math.random() * 10) + 1;
      
      if (op1 === '+') {
        innerResult = a + b;
      } else {
        if (a < b) [a, b] = [b, a];
        innerResult = a - b;
      }
      
      // Generate outer operation
      switch (op2) {
        case '+':
          c = Math.floor(Math.random() * 20) + 1;
          finalResult = innerResult + c;
          break;
        case '-':
          c = Math.floor(Math.random() * Math.max(innerResult - 1, 1)) + 1;
          finalResult = innerResult - c;
          break;
        case '×':
          c = Math.floor(Math.random() * 8) + 2;
          finalResult = innerResult * c;
          break;
        case '÷':
          // Ensure clean division
          c = Math.floor(Math.random() * 5) + 2;
          finalResult = innerResult; 
          innerResult = c * finalResult;
          // Recalculate a, b
          if (op1 === '+') {
            a = Math.floor(innerResult / 2);
            b = innerResult - a;
          } else {
            b = Math.floor(Math.random() * 10) + 1;
            a = innerResult + b;
          }
          break;
        default:
          c = 1; finalResult = innerResult;
      }
      
      return {
        type: 'complex',
        a, b, op1, op2,
        missingValue: c,
        result: finalResult,
        display: `(${a} ${op1} ${b}) ${op2} ? = ${finalResult}`
      };
    }
    
    // Simple equation
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
        num1 = Math.floor(Math.random() * maxNum) + 5;
        num2 = Math.floor(Math.random() * Math.min(num1 - 1, maxNum)) + 1;
        answer = num1 - num2;
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
    
    const positions: ('first' | 'second' | 'result')[] = ['first', 'second', 'result'];
    const missingPosition = positions[Math.floor(Math.random() * positions.length)];
    const missingValue = missingPosition === 'first' ? num1 
      : missingPosition === 'second' ? num2 : answer;
    
    return { 
      type: 'simple',
      num1, num2, operator, answer, missingPosition, missingValue 
    };
  }, [totalCorrect]);

  useEffect(() => {
    setQuestion(generateQuestion());
  }, []);

  const checkAnswer = useCallback(() => {
    if (!question || !input) return;
    
    const userAnswer = parseInt(input, 10);
    const correctAnswer = question.missingValue;
    
    if (userAnswer === correctAnswer) {
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
      setInput('');
      setQuestion(generateQuestion());
    }, 300);
  }, [question, input, addCorrect, addIncorrect, playCorrect, playIncorrect, generateQuestion]);

  const handleKeyPress = (key: string) => {
    if (key === 'enter') {
      checkAnswer();
    } else if (key === 'backspace' || key === 'C') {
      setInput((prev) => prev.slice(0, -1));
    } else if (key === '-' && input === '') {
      setInput('-');
    } else if (/^\d$/.test(key) && input.length < 4) {
      setInput((prev) => prev + key);
    }
  };

  // Keyboard support
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key >= '0' && e.key <= '9') {
        handleKeyPress(e.key);
      } else if (e.key === 'Enter') {
        handleKeyPress('enter');
      } else if (e.key === 'Backspace') {
        handleKeyPress('backspace');
      } else if (e.key === '-' && input === '') {
        handleKeyPress('-');
      }
    };
    
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [input]);

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
          key={JSON.stringify(question)}
          initial={{ scale: 0.8, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          className="text-4xl md:text-5xl font-bold mb-8 text-white"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {question.type === 'complex' ? (
            <span>
              ({question.a} {question.op1} {question.b}) {question.op2}{' '}
              <span className="text-yellow-400">?</span> = {question.result}
            </span>
          ) : (
            <span className="flex items-center gap-3">
              <span className={question.missingPosition === 'first' ? 'text-yellow-400' : ''}>
                {question.missingPosition === 'first' ? '?' : question.num1}
              </span>
              <span className="text-blue-400">{question.operator}</span>
              <span className={question.missingPosition === 'second' ? 'text-yellow-400' : ''}>
                {question.missingPosition === 'second' ? '?' : question.num2}
              </span>
              <span>=</span>
              <span className={question.missingPosition === 'result' ? 'text-yellow-400' : ''}>
                {question.missingPosition === 'result' ? '?' : question.answer}
              </span>
            </span>
          )}
        </motion.div>

        {/* Input display */}
        <div 
          className="w-36 h-16 bg-gradient-to-b from-gray-800 to-gray-900 border-4 border-yellow-500 rounded-xl flex items-center justify-center mb-6 shadow-lg"
        >
          <span 
            className="text-4xl font-bold text-yellow-400"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {input || '_'}
          </span>
        </div>

        {/* Number pad */}
        <div className="grid grid-cols-3 gap-3">
          {[1, 2, 3, 4, 5, 6, 7, 8, 9, 'C', 0, '⏎'].map((key) => (
            <motion.button
              key={key}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => handleKeyPress(key === '⏎' ? 'enter' : String(key))}
              className={`w-16 h-16 rounded-xl text-2xl font-bold transition-all shadow-md ${
                key === '⏎'
                  ? 'bg-gradient-to-b from-green-500 to-green-700 text-white'
                  : key === 'C'
                  ? 'bg-gradient-to-b from-red-500 to-red-700 text-white'
                  : 'bg-gradient-to-b from-gray-600 to-gray-800 text-white hover:from-gray-500 hover:to-gray-700'
              }`}
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              {key}
            </motion.button>
          ))}
        </div>
      </div>
    </GameContainer>
  );
}
