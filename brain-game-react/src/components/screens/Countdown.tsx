// Countdown Screen - 3-2-1-GO before each minigame
import { motion, AnimatePresence } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category } from '../../types';

// Category colors
const CATEGORY_COLORS: Record<Category, string> = {
  0: 'from-red-400 to-red-600',
  1: 'from-yellow-400 to-yellow-600',
  2: 'from-green-400 to-green-600',
  3: 'from-blue-400 to-blue-600',
};

const CATEGORY_RING: Record<Category, string> = {
  0: 'border-red-300',
  1: 'border-yellow-300',
  2: 'border-green-300',
  3: 'border-blue-300',
};

export function CountdownScreen() {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const setScreen = useGameStore((state) => state.setScreen);
  const { play } = useSound();
  
  const [count, setCount] = useState(3);
  
  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];
  const categoryColor = CATEGORY_COLORS[currentCategory as Category];
  const ringColor = CATEGORY_RING[currentCategory as Category];

  useEffect(() => {
    play('start');
    
    const timer = setInterval(() => {
      setCount((prev) => {
        if (prev <= 0) {
          clearInterval(timer);
          setScreen('game');
          return prev;
        }
        return prev - 1;
      });
    }, 1000);
    
    return () => clearInterval(timer);
  }, [play, setScreen]);

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className={`relative w-full h-full bg-gradient-to-b ${categoryColor} overflow-hidden`}>
          {/* Decorative circles */}
          <div className="absolute inset-0 overflow-hidden">
            <div className="absolute -top-20 -left-20 w-64 h-64 bg-white/10 rounded-full" />
            <div className="absolute -bottom-32 -right-32 w-96 h-96 bg-white/10 rounded-full" />
          </div>

          {/* Category & Game name */}
          <motion.div
            initial={{ y: -50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-8 left-0 right-0 text-center"
          >
            <div className="text-white/70 text-sm mb-1">{categoryName}</div>
            <h1 
              className="text-3xl font-bold text-white"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              {game.name}
            </h1>
          </motion.div>

          {/* Countdown number */}
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="relative">
              {/* Pulsing ring */}
              <motion.div
                className={`absolute inset-0 -m-8 rounded-full border-8 ${ringColor}`}
                animate={{ scale: [1, 1.3, 1], opacity: [0.6, 0.2, 0.6] }}
                transition={{ duration: 1, repeat: Infinity }}
              />
              
              <AnimatePresence mode="wait">
                <motion.div
                  key={count}
                  initial={{ scale: 2, opacity: 0 }}
                  animate={{ scale: 1, opacity: 1 }}
                  exit={{ scale: 0.5, opacity: 0 }}
                  transition={{ duration: 0.3 }}
                  className="w-40 h-40 bg-white rounded-full flex items-center justify-center shadow-2xl"
                >
                  <span 
                    className={`text-7xl font-bold bg-gradient-to-b ${categoryColor} bg-clip-text text-transparent`}
                    style={{ fontFamily: 'Baveuse, cursive' }}
                  >
                    {count > 0 ? count : 'GO!'}
                  </span>
                </motion.div>
              </AnimatePresence>
            </div>
          </div>

          {/* Instructions reminder */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.5 }}
            className="absolute bottom-8 left-0 right-0 text-center text-white/80"
          >
            <p className="text-lg" style={{ fontFamily: 'Baveuse, cursive' }}>
              Get ready! You have 60 seconds.
            </p>
            <p className="text-sm mt-1">
              +{game.correctPoints} correct / {game.incorrectPoints} wrong
            </p>
          </motion.div>
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
