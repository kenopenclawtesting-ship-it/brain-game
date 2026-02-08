// Game Select Screen - Choose game mode
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES } from '../../lib/constants';
import { MinigameId } from '../../types';
import { useState } from 'react';

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
        <div className="relative w-full h-full bg-gradient-to-b from-sky-100 to-white overflow-hidden">
          {/* Back button */}
          <motion.img
            src="/assets/sprites/button-back.png"
            alt="Back"
            initial={{ x: -20, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            className="absolute top-4 left-4 w-20 h-auto sprite-button"
            whileHover={{ scale: 1.08 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleBack}
            draggable={false}
          />

          {/* Title */}
          <motion.h1
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="text-center pt-6 text-3xl text-amber-600"
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
              className="flex flex-col items-center justify-center gap-6 mt-16"
            >
              {/* Category preview strip */}
              <div className="flex gap-2 mb-4">
                <div className="w-16 h-16 bg-red-500 rounded-lg flex items-center justify-center text-white font-bold shadow-md">
                  <span style={{ fontFamily: 'Baveuse, cursive' }}>A</span>
                </div>
                <div className="w-16 h-16 bg-yellow-500 rounded-lg flex items-center justify-center text-white font-bold shadow-md">
                  <span style={{ fontFamily: 'Baveuse, cursive' }}>C</span>
                </div>
                <div className="w-16 h-16 bg-green-500 rounded-lg flex items-center justify-center text-white font-bold shadow-md">
                  <span style={{ fontFamily: 'Baveuse, cursive' }}>M</span>
                </div>
                <div className="w-16 h-16 bg-blue-500 rounded-lg flex items-center justify-center text-white font-bold shadow-md">
                  <span style={{ fontFamily: 'Baveuse, cursive' }}>I</span>
                </div>
              </div>

              {/* Classic Test button */}
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={handleClassicTest}
                className="w-64 py-4 bg-gradient-to-b from-green-400 to-green-600 text-white text-xl rounded-xl shadow-lg border-4 border-green-300"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                Classic Test
                <div className="text-sm font-normal opacity-80">4 categories • 60s each</div>
              </motion.button>

              {/* Pro Test button */}
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className="w-64 py-4 bg-gradient-to-b from-purple-400 to-purple-600 text-white text-xl rounded-xl shadow-lg border-4 border-purple-300"
                style={{ fontFamily: 'Baveuse, cursive' }}
              >
                Pro Test
                <div className="text-sm font-normal opacity-80">Coming soon!</div>
              </motion.button>

              {/* Practice button */}
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={handlePractice}
                className="w-64 py-4 bg-gradient-to-b from-blue-400 to-blue-600 text-white text-xl rounded-xl shadow-lg border-4 border-blue-300"
                style={{ fontFamily: 'Baveuse, cursive' }}
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
              className="px-8 mt-8"
            >
              <div className="grid grid-cols-4 gap-4">
                {MINIGAMES.filter(g => !g.isPro).map((game, index) => (
                  <motion.button
                    key={game.id}
                    initial={{ scale: 0, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    transition={{ delay: index * 0.05 }}
                    whileHover={{ scale: 1.1, y: -5 }}
                    whileTap={{ scale: 0.9 }}
                    onClick={() => handleSelectGame(game.id)}
                    className="flex flex-col items-center p-3 bg-white rounded-xl shadow-md hover:shadow-lg border-2 border-gray-200 hover:border-blue-400 transition-colors"
                  >
                    <img
                      src={`/assets/icons/game-${game.id + 1}.png`}
                      alt={game.name}
                      className="w-16 h-16 object-contain"
                      draggable={false}
                    />
                    <span 
                      className="text-xs mt-2 text-gray-700 text-center leading-tight"
                      style={{ fontFamily: 'Baveuse, cursive' }}
                    >
                      {game.name}
                    </span>
                  </motion.button>
                ))}
              </div>

              {/* Category legend */}
              <div className="flex justify-center gap-4 mt-6 text-xs">
                <div className="flex items-center gap-1">
                  <div className="w-3 h-3 bg-red-500 rounded" />
                  <span>Analyse</span>
                </div>
                <div className="flex items-center gap-1">
                  <div className="w-3 h-3 bg-yellow-500 rounded" />
                  <span>Calculate</span>
                </div>
                <div className="flex items-center gap-1">
                  <div className="w-3 h-3 bg-green-500 rounded" />
                  <span>Memory</span>
                </div>
                <div className="flex items-center gap-1">
                  <div className="w-3 h-3 bg-blue-500 rounded" />
                  <span>Identify</span>
                </div>
              </div>
            </motion.div>
          )}
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
