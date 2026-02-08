// Summary Screen - Shows brain type after completing full test
import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { CATEGORY_NAMES, getBrainType } from '../../lib/constants';
import { Category } from '../../types';

// Category colors for score boxes
const CATEGORY_BG: Record<Category, string> = {
  0: 'bg-red-100 border-red-300',
  1: 'bg-yellow-100 border-yellow-300',
  2: 'bg-green-100 border-green-300',
  3: 'bg-blue-100 border-blue-300',
};

const CATEGORY_TEXT: Record<Category, string> = {
  0: 'text-red-700',
  1: 'text-yellow-700',
  2: 'text-green-700',
  3: 'text-blue-700',
};

export function Summary() {
  const categoryScores = useGameStore((state) => state.categoryScores);
  const setScreen = useGameStore((state) => state.setScreen);
  const resetGame = useGameStore((state) => state.resetGame);
  const { play, playClick } = useSound();
  
  const [displayTotal, setDisplayTotal] = useState(0);
  const [revealBrain, setRevealBrain] = useState(false);
  
  const totalScore = categoryScores.reduce((sum, score) => sum + score, 0);
  const brainType = getBrainType(totalScore);

  useEffect(() => {
    play('applause');
    
    // Animate total score counting
    const duration = 2000;
    const steps = 50;
    const increment = totalScore / steps;
    let current = 0;
    
    const timer = setInterval(() => {
      current += increment;
      if (current >= totalScore) {
        setDisplayTotal(totalScore);
        clearInterval(timer);
        setTimeout(() => setRevealBrain(true), 500);
      } else {
        setDisplayTotal(Math.floor(current));
      }
    }, duration / steps);
    
    return () => clearInterval(timer);
  }, [totalScore, play]);

  const handlePlayAgain = () => {
    playClick();
    resetGame();
    setScreen('menu');
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="relative w-full h-full bg-gradient-to-b from-amber-50 to-white overflow-hidden">
          {/* Title */}
          <motion.h1
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-4 left-0 right-0 text-center text-2xl text-amber-700"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            Your Brain Size
          </motion.h1>

          {/* Category breakdown */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="absolute top-14 left-4 right-4 grid grid-cols-4 gap-2"
          >
            {categoryScores.map((score, i) => (
              <div 
                key={i} 
                className={`${CATEGORY_BG[i as Category]} rounded-lg p-2 text-center border-2 shadow-sm`}
              >
                <div className="text-xs text-gray-600">{CATEGORY_NAMES[i as Category]}</div>
                <div 
                  className={`text-xl font-bold ${CATEGORY_TEXT[i as Category]}`}
                  style={{ fontFamily: 'Baveuse, cursive' }}
                >
                  {score}
                </div>
              </div>
            ))}
          </motion.div>

          {/* Total score */}
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="absolute top-36 left-0 right-0 text-center"
          >
            <div 
              className="text-sm text-gray-500"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              TOTAL SCORE
            </div>
            <div 
              className="text-6xl font-bold text-amber-600"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              {displayTotal}
            </div>
          </motion.div>

          {/* Brain type reveal */}
          {revealBrain && (
            <motion.div
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ type: 'spring', bounce: 0.5 }}
              className="absolute top-56 left-0 right-0 flex flex-col items-center"
            >
              {/* Brain sprite */}
              <img
                src={`/assets/sprites/brain-type-${brainType.index + 1}.png`}
                alt={brainType.name}
                className="w-32 h-32 object-contain mb-2"
              />
              
              {/* Brain type name */}
              <div 
                className="text-3xl font-bold text-purple-600 mb-1"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                {brainType.name}
              </div>
              
              {/* Description */}
              <div className="text-sm text-gray-600 max-w-xs text-center px-4">
                {brainType.description}
              </div>
            </motion.div>
          )}

          {/* Play again button */}
          {revealBrain && (
            <motion.button
              initial={{ y: 20, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.3 }}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={handlePlayAgain}
              className="absolute bottom-6 left-1/2 transform -translate-x-1/2 px-12 py-4 bg-gradient-to-b from-green-400 to-green-600 text-white text-xl rounded-xl shadow-lg border-4 border-white/30"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              PLAY AGAIN
            </motion.button>
          )}
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
