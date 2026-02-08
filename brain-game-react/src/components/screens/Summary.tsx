// Summary Screen - DARK TV Game Show Theme
import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { CATEGORY_NAMES, getBrainType } from '../../lib/constants';
import { Category } from '../../types';

// Category colors
const CATEGORY_COLORS: Record<Category, string> = {
  0: '#e74c3c',
  1: '#f1c40f',
  2: '#2ecc71',
  3: '#3498db',
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
        <div className="relative w-full h-full overflow-hidden">
          {/* Radial glow */}
          <div 
            className="absolute inset-0"
            style={{
              background: 'radial-gradient(circle at center, rgba(255,215,0,0.15) 0%, transparent 60%)'
            }}
          />

          {/* Title */}
          <motion.h1
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-4 left-0 right-0 text-center text-2xl gold-glow"
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
                className="rounded-lg p-2 text-center shadow-lg"
                style={{ 
                  background: `linear-gradient(180deg, ${CATEGORY_COLORS[i as Category]} 0%, ${CATEGORY_COLORS[i as Category]}99 100%)`,
                }}
              >
                <div className="text-xs text-white/80">{CATEGORY_NAMES[i as Category]}</div>
                <div 
                  className="text-xl font-bold text-white"
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
            className="absolute top-32 left-0 right-0 text-center"
          >
            <div className="text-sm text-gray-400">TOTAL SCORE</div>
            <div 
              className="text-6xl font-bold gold-glow"
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
              className="absolute top-52 left-0 right-0 flex flex-col items-center"
            >
              {/* Brain sprite */}
              <div 
                className="rounded-full p-2 mb-2"
                style={{
                  background: 'linear-gradient(180deg, #4a4a8a 0%, #2a2a5a 100%)',
                  boxShadow: '0 0 30px rgba(100,100,255,0.4)'
                }}
              >
                <img
                  src={`/assets/sprites/brain-type-${brainType.index + 1}.png`}
                  alt={brainType.name}
                  className="w-28 h-28 object-contain"
                />
              </div>
              
              {/* Brain type name */}
              <div 
                className="text-3xl font-bold text-purple-400 mb-1"
                style={{ 
                  fontFamily: 'Baveuse, cursive',
                  textShadow: '0 0 15px rgba(155,89,182,0.6)'
                }}
              >
                {brainType.name}
              </div>
              
              {/* Description */}
              <div className="text-sm text-gray-400 max-w-xs text-center px-4">
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
              className="absolute bottom-6 left-1/2 transform -translate-x-1/2 px-12 py-4 text-white text-xl rounded-xl shadow-lg"
              style={{ 
                fontFamily: 'Baveuse, cursive',
                background: 'linear-gradient(180deg, #27ae60 0%, #1e8449 100%)',
                boxShadow: '0 4px 20px rgba(39,174,96,0.5)',
                border: '2px solid rgba(255,255,255,0.2)'
              }}
            >
              PLAY AGAIN
            </motion.button>
          )}
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
