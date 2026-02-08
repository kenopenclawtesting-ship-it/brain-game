// Results Screen - DARK TV Game Show Theme
import { motion } from 'framer-motion';
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

export function Results() {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const currentScore = useGameStore((state) => state.currentScore);
  const currentCorrect = useGameStore((state) => state.currentCorrect);
  const currentIncorrect = useGameStore((state) => state.currentIncorrect);
  const gameMode = useGameStore((state) => state.gameMode);
  const startNextCategory = useGameStore((state) => state.startNextCategory);
  const setScreen = useGameStore((state) => state.setScreen);
  const { play, playClick } = useSound();
  
  const [displayScore, setDisplayScore] = useState(0);
  
  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];
  const categoryColor = CATEGORY_COLORS[currentCategory as Category];
  const accuracy = currentCorrect + currentIncorrect > 0 
    ? Math.round((currentCorrect / (currentCorrect + currentIncorrect)) * 100)
    : 0;

  useEffect(() => {
    play('applause');
    
    // Animate score counting
    const duration = 1500;
    const steps = 30;
    const increment = currentScore / steps;
    let current = 0;
    
    const timer = setInterval(() => {
      current += increment;
      if (current >= currentScore) {
        setDisplayScore(currentScore);
        clearInterval(timer);
      } else {
        setDisplayScore(Math.floor(current));
      }
    }, duration / steps);
    
    return () => clearInterval(timer);
  }, [currentScore, play]);

  const handleContinue = () => {
    playClick();
    if (gameMode === 'practice') {
      setScreen('menu');
    } else {
      startNextCategory();
    }
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="relative w-full h-full overflow-hidden">
          {/* Radial glow */}
          <div 
            className="absolute inset-0"
            style={{
              background: `radial-gradient(circle at center top, ${categoryColor}22 0%, transparent 60%)`
            }}
          />

          {/* Category badge */}
          <motion.div
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-4 left-1/2 transform -translate-x-1/2"
          >
            <span 
              className="px-6 py-2 text-white rounded-full text-sm font-bold shadow-lg"
              style={{ 
                background: `linear-gradient(180deg, ${categoryColor} 0%, ${categoryColor}cc 100%)`,
              }}
            >
              {categoryName}
            </span>
          </motion.div>

          {/* Game name */}
          <motion.h2
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            className="absolute top-16 left-0 right-0 text-center text-2xl text-white"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {game.name}
          </motion.h2>

          {/* Score display */}
          <motion.div
            initial={{ scale: 0.5, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.2, type: 'spring' }}
            className="absolute top-28 left-0 right-0 text-center"
          >
            <div className="text-sm text-gray-400 mb-1">YOUR SCORE</div>
            <div 
              className="text-7xl font-bold gold-glow"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              {displayScore}
            </div>
          </motion.div>

          {/* Stats boxes */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="absolute top-56 left-8 right-8 flex justify-center gap-6"
          >
            <div 
              className="rounded-xl p-4 text-center min-w-[90px] shadow-lg"
              style={{ background: 'linear-gradient(180deg, #27ae60 0%, #1e8449 100%)' }}
            >
              <div 
                className="text-4xl font-bold text-white"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                {currentCorrect}
              </div>
              <div className="text-xs text-white/80">Correct</div>
            </div>
            <div 
              className="rounded-xl p-4 text-center min-w-[90px] shadow-lg"
              style={{ background: 'linear-gradient(180deg, #e74c3c 0%, #c0392b 100%)' }}
            >
              <div 
                className="text-4xl font-bold text-white"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                {currentIncorrect}
              </div>
              <div className="text-xs text-white/80">Wrong</div>
            </div>
            <div 
              className="rounded-xl p-4 text-center min-w-[90px] shadow-lg"
              style={{ background: 'linear-gradient(180deg, #9b59b6 0%, #6c3483 100%)' }}
            >
              <div 
                className="text-4xl font-bold text-white"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                {accuracy}%
              </div>
              <div className="text-xs text-white/80">Accuracy</div>
            </div>
          </motion.div>

          {/* Performance message */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.6 }}
            className="absolute top-[320px] left-8 right-8 text-center"
          >
            <p className="text-lg text-gray-300" style={{ fontFamily: 'Baveuse, cursive' }}>
              {getPerformanceMessage(currentScore)}
            </p>
          </motion.div>

          {/* Progress dots for full test */}
          {gameMode === 'fullTest' && (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.7 }}
              className="absolute bottom-28 left-0 right-0 flex justify-center gap-3"
            >
              {[0, 1, 2, 3].map((i) => (
                <div
                  key={i}
                  className="w-4 h-4 rounded-full transition-colors"
                  style={{
                    background: i < currentCategory ? '#27ae60' :
                      i === currentCategory ? categoryColor : 
                      '#444',
                    boxShadow: i === currentCategory ? `0 0 10px ${categoryColor}` : 'none'
                  }}
                />
              ))}
            </motion.div>
          )}

          {/* Continue button */}
          <motion.button
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.8, type: 'spring' }}
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleContinue}
            className="absolute bottom-6 left-1/2 transform -translate-x-1/2 px-12 py-4 text-white text-xl rounded-xl shadow-lg"
            style={{ 
              fontFamily: 'Baveuse, cursive',
              background: `linear-gradient(180deg, ${categoryColor} 0%, ${categoryColor}bb 100%)`,
              boxShadow: `0 4px 20px ${categoryColor}66`,
              border: '2px solid rgba(255,255,255,0.2)'
            }}
          >
            {gameMode === 'practice' ? 'BACK TO MENU' : 
             currentCategory >= 3 ? 'SEE RESULTS' : 'CONTINUE'}
          </motion.button>
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}

function getPerformanceMessage(score: number): string {
  if (score >= 700) return 'Outstanding! You\'re a natural!';
  if (score >= 500) return 'Excellent work! Keep it up!';
  if (score >= 300) return 'Good job! Practice makes perfect!';
  if (score >= 100) return 'Nice try! You\'re improving!';
  return 'Keep practicing! You\'ll get better!';
}
