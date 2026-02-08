// ShapeOrder Game - FROM SOURCE.md
// Watch the sequence of shapes, then repeat it in the correct order
import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const SHAPES = [
  { icon: '●', color: '#ef4444', name: 'red circle' },
  { icon: '■', color: '#3b82f6', name: 'blue square' },
  { icon: '▲', color: '#22c55e', name: 'green triangle' },
  { icon: '★', color: '#eab308', name: 'yellow star' },
  { icon: '◆', color: '#8b5cf6', name: 'purple diamond' },
  { icon: '♥', color: '#ec4899', name: 'pink heart' },
];

type Phase = 'showing' | 'input' | 'feedback';

export function ShapeOrderGame() {
  const [sequence, setSequence] = useState<number[]>([]);
  const [userSequence, setUserSequence] = useState<number[]>([]);
  const [phase, setPhase] = useState<Phase>('showing');
  const [showingIndex, setShowingIndex] = useState(0);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [availableShapes, setAvailableShapes] = useState<number[]>([]);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateSequence = useCallback(() => {
    // From SOURCE.md: DIFFICULTY_LEVEL_PARAMS
    const difficulty = Math.min(totalCorrect, 14);
    const numIcons = Math.min(3 + Math.floor(difficulty / 2), 8);
    const extraChoices = Math.min(1 + Math.floor(difficulty / 3), 3);
    
    // Generate random sequence
    const seq: number[] = [];
    for (let i = 0; i < numIcons; i++) {
      seq.push(Math.floor(Math.random() * SHAPES.length));
    }
    
    // Available shapes for selection (sequence + extras)
    const available = new Set(seq);
    while (available.size < Math.min(seq.length + extraChoices, SHAPES.length)) {
      available.add(Math.floor(Math.random() * SHAPES.length));
    }
    
    setSequence(seq);
    setAvailableShapes(Array.from(available).sort(() => Math.random() - 0.5));
    setUserSequence([]);
    setPhase('showing');
    setShowingIndex(0);
  }, [totalCorrect]);

  useEffect(() => {
    generateSequence();
  }, []);

  // Show sequence animation
  useEffect(() => {
    if (phase !== 'showing') return;
    
    const speed = Math.max(800 - totalCorrect * 30, 400);
    
    const timer = setInterval(() => {
      setShowingIndex((prev) => {
        if (prev >= sequence.length - 1) {
          clearInterval(timer);
          setTimeout(() => setPhase('input'), 500);
          return prev;
        }
        return prev + 1;
      });
    }, speed);
    
    return () => clearInterval(timer);
  }, [phase, sequence.length, totalCorrect]);

  const handleShapeClick = (shapeIndex: number) => {
    if (phase !== 'input') return;
    
    const newUserSequence = [...userSequence, shapeIndex];
    setUserSequence(newUserSequence);
    
    // Check if correct so far
    const expectedIndex = userSequence.length;
    if (shapeIndex !== sequence[expectedIndex]) {
      playIncorrect();
      addIncorrect();
      generateSequence();
      return;
    }
    
    // Check if complete
    if (newUserSequence.length === sequence.length) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
      setTimeout(() => generateSequence(), 500);
    }
  };

  if (timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        {/* Status */}
        <div className="text-sm text-gray-500 mb-4">
          {phase === 'showing' 
            ? 'Watch the sequence...' 
            : `Repeat the sequence (${userSequence.length}/${sequence.length})`
          }
        </div>

        {/* Display area */}
        <div className="h-24 mb-6 flex items-center justify-center">
          {phase === 'showing' ? (
            <AnimatePresence mode="wait">
              <motion.div
                key={showingIndex}
                initial={{ scale: 0, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                exit={{ scale: 0, opacity: 0 }}
                className="text-8xl"
                style={{ color: SHAPES[sequence[showingIndex]]?.color }}
              >
                {SHAPES[sequence[showingIndex]]?.icon}
              </motion.div>
            </AnimatePresence>
          ) : (
            <div className="flex gap-2">
              {userSequence.map((shapeIdx, i) => (
                <motion.span
                  key={i}
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  className="text-4xl"
                  style={{ color: SHAPES[shapeIdx].color }}
                >
                  {SHAPES[shapeIdx].icon}
                </motion.span>
              ))}
              {userSequence.length < sequence.length && (
                <span className="text-4xl text-gray-300">?</span>
              )}
            </div>
          )}
        </div>

        {/* Shape selection */}
        <div className="flex gap-3 flex-wrap justify-center">
          {availableShapes.map((shapeIdx) => (
            <motion.button
              key={shapeIdx}
              onClick={() => handleShapeClick(shapeIdx)}
              className={`
                w-16 h-16 rounded-xl flex items-center justify-center text-4xl
                transition-all border-4
                ${phase === 'input' 
                  ? 'bg-white border-gray-300 hover:border-blue-500 cursor-pointer' 
                  : 'bg-gray-100 border-gray-200 cursor-not-allowed'
                }
              `}
              style={{ color: SHAPES[shapeIdx].color }}
              whileHover={phase === 'input' ? { scale: 1.1 } : {}}
              whileTap={phase === 'input' ? { scale: 0.9 } : {}}
              disabled={phase !== 'input'}
            >
              {SHAPES[shapeIdx].icon}
            </motion.button>
          ))}
        </div>

        {/* Progress indicator */}
        <div className="mt-4 flex gap-1">
          {sequence.map((_, i) => (
            <div
              key={i}
              className={`w-2 h-2 rounded-full ${
                i < userSequence.length ? 'bg-green-500' :
                i === userSequence.length ? 'bg-blue-500' : 'bg-gray-300'
              }`}
            />
          ))}
        </div>
      </div>
    </GameContainer>
  );
}
