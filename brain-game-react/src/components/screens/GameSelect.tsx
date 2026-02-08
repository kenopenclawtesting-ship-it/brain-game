// Game Select Screen - DARK TV Game Show Theme
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES } from '../../lib/constants';
import { MinigameId } from '../../types';
import { useState } from 'react';

// Category colors
const CATEGORY_COLORS = ['#e74c3c', '#f1c40f', '#2ecc71', '#3498db'];
const CATEGORY_NAMES = ['Analyse', 'Calculate', 'Memory', 'Identify'];

export function GameSelect() {
  const setScreen = useGameStore((state) => state.setScreen);
  const startFullTest = useGameStore((state) => state.startFullTest);
  const startPractice = useGameStore((state) => state.startPractice);
  const { playClick } = useSound();
  const [showPractice, setShowPractice] = useState(false);

  const handleBack = () => {
    playClick();
    if (showPractice) {
      setShowPractice(false);
    } else {
      setScreen('menu');
    }
  };

  const handleClassicTest = () => {
    playClick();
    startFullTest();
  };

  const handlePractice = () => {
    playClick();
    setShowPractice(true);
  };

  const handleSelectGame = (id: MinigameId) => {
    playClick();
    startPractice(id);
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="relative w-full h-full overflow-hidden">
          {/* Back button */}
          <motion.img
            src="/assets/sprites/button-back.png"
            alt="Back"
            initial={{ x: -20, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            className="absolute top-4 left-4 w-16 h-auto sprite-button z-20"
            whileHover={{ scale: 1.08 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleBack}
            draggable={false}
          />

          {/* Title */}
          <motion.h1
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="text-center pt-6 text-2xl gold-glow"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {showPractice ? 'Practice Mode' : 'Select Game Mode'}
          </motion.h1>

          {!showPractice ? (
            /* Game mode selection */
            <motion.div
              initial={{ y: 30, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.2 }}
              className="flex flex-col items-center justify-center gap-5 mt-12"
            >
              {/* Category preview strip */}
              <div className="flex gap-2 mb-4">
                {CATEGORY_COLORS.map((color, i) => (
                  <div 
                    key={i}
                    className="w-14 h-14 rounded-lg flex items-center justify-center text-white font-bold shadow-lg"
                    style={{ 
                      background: `linear-gradient(180deg, ${color} 0%, ${color}99 100%)`,
                      boxShadow: `0 4px 15px ${color}66`
                    }}
                  >
                    <span style={{ fontFamily: 'Baveuse, cursive' }}>
                      {CATEGORY_NAMES[i][0]}
                    </span>
                  </div>
                ))}
              </div>

              {/* Classic Test button */}
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={handleClassicTest}
                className="w-64 py-4 text-white text-xl rounded-xl shadow-lg border-2 border-green-400/30"
                style={{ 
                  fontFamily: 'Baveuse, cursive',
                  background: 'linear-gradient(180deg, #27ae60 0%, #1e8449 100%)',
                  boxShadow: '0 4px 20px rgba(39, 174, 96, 0.4)'
                }}
              >
                Classic Test
                <div className="text-sm font-normal opacity-80">4 categories • 60s each</div>
              </motion.button>

              {/* Pro Test button */}
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className="w-64 py-4 text-white text-xl rounded-xl shadow-lg border-2 border-purple-400/30"
                style={{ 
                  fontFamily: 'Baveuse, cursive',
                  background: 'linear-gradient(180deg, #9b59b6 0%, #6c3483 100%)',
                  boxShadow: '0 4px 20px rgba(155, 89, 182, 0.4)'
                }}
              >
                Pro Test
                <div className="text-sm font-normal opacity-80">Coming soon!</div>
              </motion.button>

              {/* Practice button */}
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={handlePractice}
                className="w-64 py-4 text-white text-xl rounded-xl shadow-lg border-2 border-blue-400/30"
                style={{ 
                  fontFamily: 'Baveuse, cursive',
                  background: 'linear-gradient(180deg, #3498db 0%, #2471a3 100%)',
                  boxShadow: '0 4px 20px rgba(52, 152, 219, 0.4)'
                }}
              >
                Practice
                <div className="text-sm font-normal opacity-80">Pick any game</div>
              </motion.button>
            </motion.div>
          ) : (
            /* Practice game selection */
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              className="px-6 mt-8"
            >
              <div className="grid grid-cols-4 gap-3">
                {MINIGAMES.filter(g => !g.isPro).map((game, index) => (
                  <motion.button
                    key={game.id}
                    initial={{ scale: 0, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    transition={{ delay: index * 0.05 }}
                    whileHover={{ scale: 1.1, y: -5 }}
                    whileTap={{ scale: 0.9 }}
                    onClick={() => handleSelectGame(game.id)}
                    className="flex flex-col items-center p-3 rounded-xl shadow-lg transition-colors"
                    style={{
                      background: 'linear-gradient(180deg, #2a2a5a 0%, #1a1a3a 100%)',
                      border: `2px solid ${CATEGORY_COLORS[game.category]}44`,
                      boxShadow: `0 4px 15px ${CATEGORY_COLORS[game.category]}33`
                    }}
                  >
                    <img
                      src={`/assets/icons/game-${game.id + 1}.png`}
                      alt={game.name}
                      className="w-14 h-14 object-contain"
                      draggable={false}
                    />
                    <span 
                      className="text-xs mt-2 text-white text-center leading-tight"
                      style={{ fontFamily: 'Baveuse, cursive' }}
                    >
                      {game.name}
                    </span>
                  </motion.button>
                ))}
              </div>

              {/* Category legend */}
              <div className="flex justify-center gap-4 mt-5 text-xs">
                {CATEGORY_NAMES.map((name, i) => (
                  <div key={i} className="flex items-center gap-1">
                    <div 
                      className="w-3 h-3 rounded"
                      style={{ background: CATEGORY_COLORS[i] }}
                    />
                    <span className="text-gray-400">{name}</span>
                  </div>
                ))}
              </div>
            </motion.div>
          )}
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
