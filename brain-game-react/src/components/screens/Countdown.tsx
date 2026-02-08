// Countdown Screen - 3-2-1-GO before each minigame
import { motion, AnimatePresence } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category } from '../../types';

export function CountdownScreen() {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const setScreen = useGameStore((state) => state.setScreen);
  const { play } = useSound();
  
  const [count, setCount] = useState(3);
  
  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];

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
        <div className="flex flex-col items-center justify-center h-full p-8 bg-gradient-to-b from-blue-500 to-purple-600">
          {/* Category & Game name */}
          <motion.div
            initial={{ y: -50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="text-center mb-12"
          >
            <div className="text-white/70 text-sm mb-1">{categoryName}</div>
            <h1 className="text-3xl font-bold text-white">{game.name}</h1>
          </motion.div>

          {/* Countdown number */}
          <div className="relative w-40 h-40 flex items-center justify-center">
            <AnimatePresence mode="wait">
              <motion.div
                key={count}
                initial={{ scale: 2, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                exit={{ scale: 0.5, opacity: 0 }}
                transition={{ duration: 0.3 }}
                className="text-8xl font-bold text-white"
              >
                {count > 0 ? count : 'GO!'}
              </motion.div>
            </AnimatePresence>
          </div>

          {/* Pulsing ring */}
          <motion.div
            className="absolute w-48 h-48 rounded-full border-4 border-white/30"
            animate={{ scale: [1, 1.2, 1], opacity: [0.5, 0.2, 0.5] }}
            transition={{ duration: 1, repeat: Infinity }}
          />

          {/* Instructions reminder */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.5 }}
            className="mt-12 text-white/60 text-sm text-center"
          >
            <p>Get ready! You have 60 seconds.</p>
            <p>+{game.correctPoints} for correct, {game.incorrectPoints} for wrong</p>
          </motion.div>
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
