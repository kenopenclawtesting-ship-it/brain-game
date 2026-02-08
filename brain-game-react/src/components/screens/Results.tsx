// Results Screen - Shows after each minigame
import { motion } from 'framer-motion';
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

const CATEGORY_BG_COLORS: Record<Category, string> = {
  0: 'bg-red-500',
  1: 'bg-yellow-500',
  2: 'bg-green-500',
  3: 'bg-blue-500',
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
  const categoryBgColor = CATEGORY_BG_COLORS[currentCategory as Category];
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
        <div className="relative w-full h-full bg-gradient-to-b from-sky-50 to-white overflow-hidden">
          {/* Category badge */}
          <motion.div
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-4 left-1/2 transform -translate-x-1/2"
          >
            <span className={`px-6 py-2 ${categoryBgColor} text-white rounded-full text-sm font-bold shadow-md`}>
              {categoryName}
            </span>
          </motion.div>

          {/* Game name */}
          <motion.h2
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            className="absolute top-16 left-0 right-0 text-center text-2xl text-gray-800"
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
            <div 
              className="text-sm text-gray-500 mb-1"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              YOUR SCORE
            </div>
            <div 
              className={`text-7xl font-bold bg-gradient-to-b ${categoryColor} bg-clip-text text-transparent`}
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
            className="absolute top-60 left-8 right-8 flex justify-center gap-6"
          >
            <div className="bg-green-100 rounded-xl p-4 text-center min-w-[80px] shadow-md">
              <div 
                className="text-4xl font-bold text-green-600"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                {currentCorrect}
              </div>
              <div className="text-xs text-green-700 font-medium">Correct</div>
            </div>
            <div className="bg-red-100 rounded-xl p-4 text-center min-w-[80px] shadow-md">
              <div 
                className="text-4xl font-bold text-red-600"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                {currentIncorrect}
              </div>
              <div className="text-xs text-red-700 font-medium">Wrong</div>
            </div>
            <div className="bg-purple-100 rounded-xl p-4 text-center min-w-[80px] shadow-md">
              <div 
                className="text-4xl font-bold text-purple-600"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                {accuracy}%
              </div>
              <div className="text-xs text-purple-700 font-medium">Accuracy</div>
            </div>
          </motion.div>

          {/* Performance message */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.6 }}
            className="absolute top-[340px] left-8 right-8 text-center"
          >
            <p className="text-lg text-gray-600" style={{ fontFamily: 'Baveuse, cursive' }}>
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
                  className={`w-4 h-4 rounded-full transition-colors ${
                    i < currentCategory ? 'bg-green-500' :
                    i === currentCategory ? 'bg-blue-500 ring-2 ring-blue-300' : 
                    'bg-gray-300'
                  }`}
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
            className={`absolute bottom-6 left-1/2 transform -translate-x-1/2 px-12 py-4 bg-gradient-to-b ${categoryColor} text-white text-xl rounded-xl shadow-lg border-4 border-white/30`}
            style={{ fontFamily: 'Baveuse, cursive' }}
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
