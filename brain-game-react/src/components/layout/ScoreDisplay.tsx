// Score display component - DARK theme
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useState, useEffect, useRef } from 'react';

export function ScoreDisplay() {
  const currentScore = useGameStore((state) => state.currentScore);
  const currentCorrect = useGameStore((state) => state.currentCorrect);
  const currentIncorrect = useGameStore((state) => state.currentIncorrect);

  return (
    <div className="flex items-center gap-4">
      <div className="text-center">
        <div className="text-xs font-medium text-gray-400">SCORE</div>
        <AnimatedNumber 
          value={currentScore} 
          className="text-2xl font-bold gold-glow" 
          style={{ fontFamily: 'Baveuse, cursive' }}
        />
      </div>
      <div className="flex gap-2">
        <div 
          className="rounded-lg px-3 py-1 text-center min-w-[45px]"
          style={{ background: 'rgba(39,174,96,0.3)', border: '1px solid rgba(39,174,96,0.5)' }}
        >
          <div 
            className="text-lg font-bold text-green-400"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {currentCorrect}
          </div>
        </div>
        <div 
          className="rounded-lg px-3 py-1 text-center min-w-[45px]"
          style={{ background: 'rgba(231,76,60,0.3)', border: '1px solid rgba(231,76,60,0.5)' }}
        >
          <div 
            className="text-lg font-bold text-red-400"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {currentIncorrect}
          </div>
        </div>
      </div>
    </div>
  );
}

// Animated number display for score counting
function AnimatedNumber({ 
  value, 
  className = '',
  style = {}
}: { 
  value: number; 
  className?: string;
  style?: React.CSSProperties;
}) {
  const [displayValue, setDisplayValue] = useState(value);
  const prevValue = useRef(value);

  useEffect(() => {
    if (prevValue.current === value) return;
    
    const diff = value - displayValue;
    const step = diff > 0 ? Math.ceil(diff / 10) : Math.floor(diff / 10);
    const duration = 50;

    const timer = setInterval(() => {
      setDisplayValue((prev) => {
        const next = prev + step;
        if ((step > 0 && next >= value) || (step < 0 && next <= value)) {
          clearInterval(timer);
          return value;
        }
        return next;
      });
    }, duration);

    prevValue.current = value;
    return () => clearInterval(timer);
  }, [value, displayValue]);

  return (
    <motion.div
      className={className}
      style={style}
      key={value}
      initial={{ scale: 1 }}
      animate={{ scale: [1, 1.15, 1] }}
      transition={{ duration: 0.2 }}
    >
      {displayValue}
    </motion.div>
  );
}

// Feedback flash for correct/incorrect answers
export function FeedbackFlash() {
  const [feedback, setFeedback] = useState<'correct' | 'incorrect' | null>(null);
  const currentCorrect = useGameStore((state) => state.currentCorrect);
  const currentIncorrect = useGameStore((state) => state.currentIncorrect);
  const prevCorrect = useRef(currentCorrect);
  const prevIncorrect = useRef(currentIncorrect);

  useEffect(() => {
    if (currentCorrect > prevCorrect.current) {
      setFeedback('correct');
      setTimeout(() => setFeedback(null), 300);
    }
    prevCorrect.current = currentCorrect;
  }, [currentCorrect]);

  useEffect(() => {
    if (currentIncorrect > prevIncorrect.current) {
      setFeedback('incorrect');
      setTimeout(() => setFeedback(null), 300);
    }
    prevIncorrect.current = currentIncorrect;
  }, [currentIncorrect]);

  return (
    <AnimatePresence>
      {feedback && (
        <motion.div
          className={`
            absolute inset-0 pointer-events-none z-40
            ${feedback === 'correct' ? 'bg-green-500' : 'bg-red-500'}
          `}
          initial={{ opacity: 0.4 }}
          animate={{ opacity: 0 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.3 }}
        />
      )}
    </AnimatePresence>
  );
}
