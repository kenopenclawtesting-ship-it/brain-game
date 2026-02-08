// Main Menu Screen
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { Button } from '../ui/Button';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES } from '../../lib/constants';
import { MinigameId } from '../../types';
import { useEffect, useState } from 'react';

export function MainMenu() {
  const startFullTest = useGameStore((state) => state.startFullTest);
  const startPractice = useGameStore((state) => state.startPractice);
  const { play, stop } = useSound();
  const [showPractice, setShowPractice] = useState(false);

  useEffect(() => {
    play('theme');
    return () => stop('theme');
  }, [play, stop]);

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="flex flex-col items-center justify-center h-full p-8">
          {/* Logo/Title */}
          <motion.div
            initial={{ y: -50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ duration: 0.5 }}
            className="text-center mb-8"
          >
            <h1 className="text-4xl font-bold text-gray-800 mb-2">
              Who Has The
            </h1>
            <h1 className="text-5xl font-extrabold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
              BIGGEST BRAIN?
            </h1>
            <p className="text-gray-600 mt-2">Train your brain in 4 categories</p>
          </motion.div>

          {/* Brain icon */}
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.3, type: 'spring' }}
            className="text-8xl mb-8"
          >
            🧠
          </motion.div>

          {/* Menu buttons */}
          {!showPractice ? (
            <motion.div
              initial={{ y: 50, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.5 }}
              className="flex flex-col gap-4 w-64"
            >
              <Button variant="menu" size="large" onClick={startFullTest}>
                🎮 PLAY
              </Button>
              <Button variant="secondary" size="medium" onClick={() => setShowPractice(true)}>
                📝 Practice
              </Button>
            </motion.div>
          ) : (
            <PracticeMenu onBack={() => setShowPractice(false)} onSelect={startPractice} />
          )}
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}

function PracticeMenu({ onBack, onSelect }: { onBack: () => void; onSelect: (id: MinigameId) => void }) {
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="w-full max-w-md"
    >
      <div className="flex items-center justify-between mb-4">
        <button onClick={onBack} className="text-gray-600 hover:text-gray-800">
          ← Back
        </button>
        <h2 className="text-xl font-bold">Practice Mode</h2>
        <div className="w-12" />
      </div>
      
      <div className="grid grid-cols-2 gap-2 max-h-64 overflow-y-auto">
        {MINIGAMES.filter(g => !g.isPro).map((game) => (
          <button
            key={game.id}
            onClick={() => onSelect(game.id)}
            className="p-3 text-left bg-white rounded-lg border-2 border-gray-200 hover:border-blue-500 transition-colors"
          >
            <div className="font-medium text-sm">{game.name}</div>
            <div className="text-xs text-gray-500">
              +{game.correctPoints} / {game.incorrectPoints}
            </div>
          </button>
        ))}
      </div>
      
      <div className="mt-4 text-center text-sm text-gray-500">
        PRO games coming soon!
      </div>
    </motion.div>
  );
}
