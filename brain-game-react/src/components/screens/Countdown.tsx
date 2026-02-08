// Countdown Screen - DARK TV Game Show Theme
import { motion, AnimatePresence } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category } from '../../types';

// Category colors
const CATEGORY_COLORS: Record<Category, string> = {
  0: '#e74c3c',
  1: '#f1c40f',
  2: '#2ecc71',
  3: '#3498db',
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
        <div className="relative w-full h-full overflow-hidden">
          {/* Radial glow background */}
          <div 
            className="absolute inset-0"
            style={{
              background: `radial-gradient(circle at center, ${categoryColor}33 0%, transparent 70%)`
            }}
          />

          {/* Category & Game name */}
          <motion.div
            initial={{ y: -50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-8 left-0 right-0 text-center"
          >
            <div className="text-gray-400 text-sm mb-1">{categoryName}</div>
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
                className="absolute inset-0 -m-12 rounded-full"
                style={{ border: `4px solid ${categoryColor}` }}
                animate={{ scale: [1, 1.3, 1], opacity: [0.6, 0.1, 0.6] }}
                transition={{ duration: 1, repeat: Infinity }}
              />
              <motion.div
                className="absolute inset-0 -m-8 rounded-full"
                style={{ border: `2px solid ${categoryColor}88` }}
                animate={{ scale: [1, 1.2, 1], opacity: [0.4, 0.1, 0.4] }}
                transition={{ duration: 1, repeat: Infinity, delay: 0.2 }}
              />
              
              <AnimatePresence mode="wait">
                <motion.div
                  key={count}
                  initial={{ scale: 2, opacity: 0 }}
                  animate={{ scale: 1, opacity: 1 }}
                  exit={{ scale: 0.5, opacity: 0 }}
                  transition={{ duration: 0.3 }}
                  className="w-40 h-40 rounded-full flex items-center justify-center"
                  style={{
                    background: `linear-gradient(180deg, ${categoryColor} 0%, ${categoryColor}99 100%)`,
                    boxShadow: `0 0 40px ${categoryColor}88, inset 0 2px 0 rgba(255,255,255,0.3)`
                  }}
                >
                  <span 
                    className="text-7xl font-bold text-white"
                    style={{ 
                      fontFamily: 'Baveuse, cursive',
                      textShadow: '2px 2px 4px rgba(0,0,0,0.3)'
                    }}
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
            className="absolute bottom-8 left-0 right-0 text-center text-gray-400"
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
