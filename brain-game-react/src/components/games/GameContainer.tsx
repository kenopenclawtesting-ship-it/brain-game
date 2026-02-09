// Game Container - Light category-themed backgrounds
import { ReactNode, useEffect } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useGameTimer } from '../../hooks/useGameTimer';
import { useSound } from '../../hooks/useSound';
import { GameCanvas } from '../layout/GameCanvas';
import { Timer } from '../layout/Timer';
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

// Light category backgrounds
const CATEGORY_LIGHT_BGS: Record<Category, string> = {
  0: '#fde8e4', // light coral (Analyse/Red)
  1: '#fdf4e0', // light gold (Calculate/Yellow)
  2: '#e4f8ee', // light mint (Memory/Green)
  3: '#e4f0fd', // light sky (Identify/Blue)
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
  const categoryLightBg = CATEGORY_LIGHT_BGS[currentCategory as Category];

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
            background: `linear-gradient(180deg, ${categoryLightBg} 0%, transparent 100%)`
          }}
        >
          <Timer />
          <ScoreDisplay />
        </div>

        {/* Game content - light category-themed background */}
        <div className="absolute inset-0" style={{ background: categoryLightBg }}>
          {/* Game content */}
          <div className="relative h-full pt-20 pb-4 px-4">
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
