// Summary Screen - Shows brain type after completing full test
import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { Button } from '../ui/Button';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { CATEGORY_NAMES, getBrainType } from '../../lib/constants';
import { Category } from '../../types';

// Brain emojis by tier (roughly mapping to categories)
const BRAIN_EMOJIS: Record<number, string> = {
  0: '🦠', // Amoeba
  1: '🪱', // Earthworm
  2: '🐌', // Snail
  3: '🐀', // Rat
  4: '🐱', // Cat
  5: '🐕', // Dog
  6: '🐐', // Goat
  7: '🐵', // Chimp
  8: '🦍', // Gorilla
  9: '🧑‍🦲', // Missing Link
  10: '🧔', // Neanderthal
  11: '🧑', // Average Joe
  12: '🤓', // Geek
  13: '👨‍💻', // Nerd
  14: '🎓', // Scholar
  15: '👨‍🔬', // Scientist
  16: '🧠', // Genius
  17: '🚀', // Space Ace
  18: '🤖', // Cyborg
  19: '👽', // Alien
  20: '🦑', // Squidlian
  21: '💻', // Bitbot
  22: '🛸', // Spacebot
  23: '🔢', // Calcubot
  24: '🧬', // Encephalobot
  25: '🤖', // Brainbot
  26: '⚡', // Neurobot
  27: '💾', // Computron
  28: '✨', // Xenos
  29: '🌟', // Neuronian
  30: '🌌', // Aeonian
  31: '🌠', // Galaxian
};

export function Summary() {
  const categoryScores = useGameStore((state) => state.categoryScores);
  const setScreen = useGameStore((state) => state.setScreen);
  const resetGame = useGameStore((state) => state.resetGame);
  const { play } = useSound();
  
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
    resetGame();
    setScreen('menu');
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="flex flex-col items-center justify-center h-full p-6">
          <motion.h1
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="text-2xl font-bold text-gray-800 mb-4"
          >
            Your Brain Size
          </motion.h1>

          {/* Category breakdown */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="grid grid-cols-2 gap-3 mb-6 w-full max-w-sm"
          >
            {categoryScores.map((score, i) => (
              <div key={i} className="bg-gray-100 rounded-lg p-3 text-center">
                <div className="text-xs text-gray-500">{CATEGORY_NAMES[i as Category]}</div>
                <div className="text-xl font-bold text-gray-800">{score}</div>
              </div>
            ))}
          </motion.div>

          {/* Total score */}
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="text-center mb-6"
          >
            <div className="text-sm text-gray-500">TOTAL SCORE</div>
            <div className="text-5xl font-bold text-blue-600">{displayTotal}</div>
          </motion.div>

          {/* Brain type reveal */}
          {revealBrain && (
            <motion.div
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ type: 'spring', bounce: 0.5 }}
              className="text-center mb-6"
            >
              <div className="text-6xl mb-2">{BRAIN_EMOJIS[brainType.index] || '🧠'}</div>
              <div className="text-2xl font-bold text-purple-600 mb-1">
                {brainType.name}
              </div>
              <div className="text-sm text-gray-600 max-w-xs">
                {brainType.description}
              </div>
            </motion.div>
          )}

          {/* Play again button */}
          {revealBrain && (
            <motion.div
              initial={{ y: 20, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.3 }}
              className="flex gap-4"
            >
              <Button variant="primary" size="large" onClick={handlePlayAgain}>
                PLAY AGAIN
              </Button>
            </motion.div>
          )}
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
