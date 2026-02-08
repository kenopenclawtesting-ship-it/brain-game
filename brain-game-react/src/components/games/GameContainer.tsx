// Game Container - wraps minigames with common UI (timer, score, header)
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

// Category header colors
const CATEGORY_HEADER_BG: Record<Category, string> = {
  0: 'from-red-500 to-red-600',
  1: 'from-yellow-500 to-yellow-600',
  2: 'from-green-500 to-green-600',
  3: 'from-blue-500 to-blue-600',
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
  const headerBg = CATEGORY_HEADER_BG[currentCategory as Category];

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
    <div className="flex flex-col items-center">
      {/* Header with category and game name */}
      <div className="w-full max-w-[640px]">
        <div className={`flex justify-between items-center px-4 py-2 bg-gradient-to-r ${headerBg} text-white rounded-t-xl shadow-md`}>
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
        <div className="absolute top-0 left-0 right-0 z-10 flex justify-between items-center p-4 bg-gradient-to-b from-white via-white/90 to-transparent">
          <Timer />
          <ScoreDisplay />
        </div>

        {/* Timer bar at bottom */}
        <div className="absolute bottom-0 left-0 right-0 z-10 px-4 pb-4">
          <TimerCompact />
        </div>

        {/* Game content */}
        <div className="absolute inset-0 pt-20 pb-16 px-4 bg-gradient-to-b from-sky-50 to-white">
          {children}
        </div>

        {/* Feedback flash overlay */}
        <FeedbackFlash />
      </GameCanvas>
    </div>
  );
}

// Countdown screen (3-2-1-GO)
export function Countdown({ onComplete }: { onComplete: () => void }) {
  const { play } = useSound();
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const game = MINIGAMES[currentMinigame];

  useEffect(() => {
    play('start');
    const timer = setTimeout(onComplete, 3000);
    return () => clearTimeout(timer);
  }, [onComplete, play]);

  return (
    <GameCanvas className="flex items-center justify-center bg-gradient-to-b from-sky-100 to-white">
      <div className="text-center">
        <h2 
          className="text-2xl font-bold mb-4 text-gray-800"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {game.name}
        </h2>
        <CountdownAnimation />
      </div>
    </GameCanvas>
  );
}

function CountdownAnimation() {
  return (
    <div className="relative w-32 h-32 mx-auto">
      <AnimatePresence mode="wait">
        {[3, 2, 1, 'GO!'].map((num, i) => (
          <motion.div
            key={num}
            className="absolute inset-0 flex items-center justify-center text-6xl font-bold text-blue-600"
            style={{ fontFamily: 'Baveuse, cursive' }}
            initial={{ scale: 2, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0.5, opacity: 0 }}
            transition={{ 
              duration: 0.3,
              delay: i * 0.75,
            }}
          >
            {num}
          </motion.div>
        ))}
      </AnimatePresence>
    </div>
  );
}

// Time's Up overlay
export function TimeUpOverlay() {
  return (
    <motion.div
      className="absolute inset-0 flex items-center justify-center bg-black/70 z-50"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.3 }}
    >
      <motion.div
        className="text-white text-center"
        initial={{ scale: 0.5, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ delay: 0.2, type: 'spring' }}
      >
        <div 
          className="text-6xl font-bold mb-4"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          TIME'S UP!
        </div>
      </motion.div>
    </motion.div>
  );
}
