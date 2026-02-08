// Results Screen - Shows after each minigame
import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { Button } from '../ui/Button';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category } from '../../types';

export function Results() {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const currentScore = useGameStore((state) => state.currentScore);
  const currentCorrect = useGameStore((state) => state.currentCorrect);
  const currentIncorrect = useGameStore((state) => state.currentIncorrect);
  const gameMode = useGameStore((state) => state.gameMode);
  const startNextCategory = useGameStore((state) => state.startNextCategory);
  const setScreen = useGameStore((state) => state.setScreen);
  const { play } = useSound();
  
  const [displayScore, setDisplayScore] = useState(0);
  
  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];
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
    if (gameMode === 'practice') {
      setScreen('menu');
    } else {
      startNextCategory();
    }
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="flex flex-col items-center justify-center h-full p-8">
          {/* Category & Game */}
          <motion.div
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="text-center mb-6"
          >
            <span className="px-4 py-1 bg-purple-100 text-purple-700 rounded-full text-sm font-medium">
              {categoryName}
            </span>
            <h2 className="text-2xl font-bold text-gray-800 mt-2">{game.name}</h2>
          </motion.div>

          {/* Score */}
          <motion.div
            initial={{ scale: 0.5, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.2, type: 'spring' }}
            className="text-center mb-8"
          >
            <div className="text-sm text-gray-500 mb-1">YOUR SCORE</div>
            <div className="text-6xl font-bold text-blue-600">{displayScore}</div>
          </motion.div>

          {/* Stats */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="flex gap-8 mb-8"
          >
            <div className="text-center">
              <div className="text-3xl font-bold text-green-600">{currentCorrect}</div>
              <div className="text-sm text-gray-500">Correct</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-red-600">{currentIncorrect}</div>
              <div className="text-sm text-gray-500">Wrong</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-purple-600">{accuracy}%</div>
              <div className="text-sm text-gray-500">Accuracy</div>
            </div>
          </motion.div>

          {/* Performance message */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.6 }}
            className="text-center mb-8"
          >
            <p className="text-lg text-gray-600">
              {getPerformanceMessage(currentScore, game.correctPoints)}
            </p>
          </motion.div>

          {/* Continue button */}
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.8, type: 'spring' }}
          >
            <Button variant="primary" size="large" onClick={handleContinue}>
              {gameMode === 'practice' ? 'BACK TO MENU' : 'CONTINUE'}
            </Button>
          </motion.div>
          
          {/* Progress indicator for full test */}
          {gameMode === 'fullTest' && (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 1 }}
              className="mt-6 flex gap-2"
            >
              {[0, 1, 2, 3].map((i) => (
                <div
                  key={i}
                  className={`w-3 h-3 rounded-full ${
                    i <= currentCategory ? 'bg-blue-500' : 'bg-gray-300'
                  }`}
                />
              ))}
            </motion.div>
          )}
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}

function getPerformanceMessage(score: number, pointsPerCorrect: number): string {
  const estimated = Math.floor(score / pointsPerCorrect);
  
  if (score >= 700) return '🏆 Outstanding! You\'re a natural!';
  if (score >= 500) return '🌟 Excellent work! Keep it up!';
  if (score >= 300) return '👍 Good job! Practice makes perfect!';
  if (score >= 100) return '💪 Nice try! You\'re improving!';
  return '🎯 Keep practicing! You\'ll get better!';
}
