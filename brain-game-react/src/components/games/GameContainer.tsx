// Game Container - DARK TV Game Show Theme
import { ReactNode, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useGameTimer } from '../../hooks/useGameTimer';
import { useSound } from '../../hooks/useSound';
import { GameCanvas } from '../layout/GameCanvas';
import { Timer, TimerCompact } from '../layout/Timer';
import { ScoreDisplay, FeedbackFlash } from '../layout/ScoreDisplay';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category } from '../../types';

// Category colors
const CATEGORY_COLORS: Record<Category, string> = {
  0: '#e74c3c',
  1: '#f1c40f',
  2: '#2ecc71',
  3: '#3498db',
};

// Category AI backgrounds
const CATEGORY_BGS: Record<Category, string> = {
  0: '/assets/generated/cat-bg-analyse.png',
  1: '/assets/generated/cat-bg-calculate.png',
  2: '/assets/generated/cat-bg-memory.png',
  3: '/assets/generated/cat-bg-identify.png',
};

interface GameContainerProps {
  children: ReactNode;
}

export function GameContainer({ children }: GameContainerProps) {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const currentScreen = useGameStore((state) => state.currentScreen);
  const { start: startTimer, reset: resetTimer } = useGameTimer();
  const { play, stop } = useSound();

  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];
  const categoryColor = CATEGORY_COLORS[currentCategory as Category];
  const categoryBg = CATEGORY_BGS[currentCategory as Category];

  useEffect(() => {
    if (currentScreen === 'game') {
      play('ingame');
      resetTimer();
      startTimer();
    }
    
    return () => {
      stop('ingame');
    };
  }, [currentScreen, play, stop, resetTimer, startTimer]);

  return (
    <div className="game-page" style={{ justifyContent: 'center' }}>
     <div className="flex flex-col items-center" style={{ position: 'relative', zIndex: 1 }}>
      {/* Header with category and game name */}
      <div className="w-full max-w-[640px]">
        <div 
          className="flex justify-between items-center px-4 py-2 text-white rounded-t-xl shadow-lg"
          style={{ 
            background: `linear-gradient(180deg, ${categoryColor} 0%, ${categoryColor}cc 100%)`,
          }}
        >
          <div className="text-sm font-medium text-white/80">{categoryName}</div>
          <div 
            className="text-lg font-bold"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {game.name}
          </div>
          <div className="text-sm font-medium text-white/80">
            +{game.correctPoints} / {game.incorrectPoints}
          </div>
        </div>
      </div>

      {/* Game area */}
      <GameCanvas className="rounded-t-none">
        {/* Top bar with timer and score */}
        <div 
          className="absolute top-0 left-0 right-0 z-10 flex justify-between items-center p-4"
          style={{
            background: 'linear-gradient(180deg, rgba(26,26,74,0.95) 0%, transparent 100%)'
          }}
        >
          <Timer />
          <ScoreDisplay />
        </div>

        {/* Timer bar at bottom */}
        <div className="absolute bottom-0 left-0 right-0 z-10 px-4 pb-4">
          <TimerCompact categoryColor={categoryColor} />
        </div>

        {/* Game content - category-themed background */}
        <div className="absolute inset-0">
          {/* AI category background */}
          <img
            src={categoryBg}
            alt=""
            style={{
              position: 'absolute',
              inset: 0,
              width: '100%',
              height: '100%',
              objectFit: 'cover',
              opacity: 0.2,
            }}
            draggable={false}
          />
          {/* Dark overlay for gameplay readability */}
          <div
            style={{
              position: 'absolute',
              inset: 0,
              background: 'linear-gradient(180deg, #1a1a4a 0%, #2a1a3a 100%)',
              opacity: 0.85,
            }}
          />
          {/* Game content */}
          <div className="relative h-full pt-20 pb-16 px-4">
            {children}
          </div>
        </div>

        {/* Feedback flash overlay */}
        <FeedbackFlash />
      </GameCanvas>
     </div>
    </div>
  );
}

// Time's Up overlay
export function TimeUpOverlay() {
  return (
    <motion.div
      className="absolute inset-0 flex items-center justify-center bg-black/80 z-50"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.3 }}
    >
      <motion.div
        className="text-center"
        initial={{ scale: 0.5, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ delay: 0.2, type: 'spring' }}
      >
        <div 
          className="text-6xl font-bold gold-glow"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          TIME'S UP!
        </div>
      </motion.div>
    </motion.div>
  );
}
