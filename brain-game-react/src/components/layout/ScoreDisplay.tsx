// Score display component
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useState, useEffect } from 'react';

export function ScoreDisplay() {
  const currentScore = useGameStore((state) => state.currentScore);
  const currentCorrect = useGameStore((state) => state.currentCorrect);
  const currentIncorrect = useGameStore((state) => state.currentIncorrect);

  return (
    <div className="flex items-center gap-6">
      <div className="text-center">
        <div className="text-sm font-medium text-gray-600">SCORE</div>
        <AnimatedNumber value={currentScore} className="text-3xl font-bold text-gray-800" />
      </div>
      <div className="text-center">
        <div className="text-sm font-medium text-green-600">✓</div>
        <div className="text-xl font-bold text-green-600">{currentCorrect}</div>
      </div>
      <div className="text-center">
        <div className="text-sm font-medium text-red-600">✗</div>
        <div className="text-xl font-bold text-red-600">{currentIncorrect}</div>
      </div>
    </div>
  );
}

// Animated number display for score counting
function AnimatedNumber({ value, className = '' }: { value: number; className?: string }) {
  const [displayValue, setDisplayValue] = useState(value);

  useEffect(() => {
    if (displayValue === value) return;
    
    const diff = value - displayValue;
    const step = diff > 0 ? Math.ceil(diff / 10) : Math.floor(diff / 10);
    const duration = 50; // ms per step

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

    return () => clearInterval(timer);
  }, [value, displayValue]);

  return (
    <motion.div
      className={className}
      key={value}
      initial={{ scale: 1 }}
      animate={{ scale: [1, 1.2, 1] }}
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
  const prevCorrect = useState(currentCorrect)[0];
  const prevIncorrect = useState(currentIncorrect)[0];

  useEffect(() => {
    if (currentCorrect > prevCorrect) {
      setFeedback('correct');
      setTimeout(() => setFeedback(null), 500);
    }
  }, [currentCorrect, prevCorrect]);

  useEffect(() => {
    if (currentIncorrect > prevIncorrect) {
      setFeedback('incorrect');
      setTimeout(() => setFeedback(null), 500);
    }
  }, [currentIncorrect, prevIncorrect]);

  return (
    <AnimatePresence>
      {feedback && (
        <motion.div
          className={`
            fixed inset-0 pointer-events-none z-50
            ${feedback === 'correct' ? 'bg-green-500' : 'bg-red-500'}
          `}
          initial={{ opacity: 0.3 }}
          animate={{ opacity: 0 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.5 }}
        />
      )}
    </AnimatePresence>
  );
}
