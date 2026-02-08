// Game Select Screen - Sprite-based matching original Flash PlayMenu
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { MINIGAMES } from '../../lib/constants';
import { MinigameId } from '../../types';
import { useState } from 'react';

const CATEGORY_COLORS = ['#e74c3c', '#f1c40f', '#2ecc71', '#3498db'];

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
    <div className="game-page">
      <div className="page-header">
        <h1 className="page-title">WHO HAS THE BIGGEST BRAIN?</h1>
        <p className="page-subtitle">Pro Player Club</p>
      </div>

      <div className="game-stage">
        {/* Same stage background as MainMenu */}
        <img
          src="/assets/sprites/stage-bg.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        <div className="stage-overlay">
          {/* Back button */}
          <motion.img
            src="/assets/sprites/button-back.png"
            alt="Back"
            className="gs-back-btn"
            draggable={false}
            whileHover={{ scale: 1.1, filter: 'brightness(1.15)' }}
            whileTap={{ scale: 0.95 }}
            onClick={handleBack}
          />

          {/* Title overlay */}
          <div className="gs-title">
            {showPractice ? 'CHOOSE A GAME' : 'SELECT GAME MODE'}
          </div>

          <AnimatePresence mode="wait">
            {!showPractice ? (
              /* Mode selection - PlayMenu sprite with click zones */
              <motion.div
                key="modes"
                className="play-menu-container"
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.9 }}
                transition={{ duration: 0.25 }}
              >
                <img
                  src="/assets/sprites/play-menu-full.png"
                  alt=""
                  className="play-menu-img"
                  draggable={false}
                />
                {/* Classic Test click zone - over the 4 circles */}
                <motion.div
                  className="click-zone classic-zone"
                  whileHover={{ backgroundColor: 'rgba(255,255,255,0.15)' }}
                  whileTap={{ scale: 0.95 }}
                  onClick={handleClassicTest}
                  title="Classic Test - 4 categories, 60 seconds each"
                />
                {/* Practice click zone - over the dumbbell */}
                <motion.div
                  className="click-zone practice-zone"
                  whileHover={{ backgroundColor: 'rgba(255,255,255,0.15)' }}
                  whileTap={{ scale: 0.95 }}
                  onClick={handlePractice}
                  title="Practice - Pick any game"
                />
                {/* Pro Test click zone - over the items burst */}
                <motion.div
                  className="click-zone pro-zone"
                  whileHover={{ backgroundColor: 'rgba(255,255,255,0.15)' }}
                  whileTap={{ scale: 0.95 }}
                  onClick={() => playClick()}
                  title="Pro Test - Coming Soon"
                />
              </motion.div>
            ) : (
              /* Practice game grid - show all 12 game icons */
              <motion.div
                key="practice"
                className="practice-grid"
                initial={{ opacity: 0, x: 50 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -50 }}
                transition={{ duration: 0.25 }}
              >
                {MINIGAMES.map((game, index) => (
                  <motion.div
                    key={game.id}
                    className="practice-game-btn"
                    initial={{ scale: 0, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    transition={{ delay: index * 0.04 }}
                    whileHover={{ scale: 1.12, y: -4 }}
                    whileTap={{ scale: 0.9 }}
                    onClick={() => handleSelectGame(game.id)}
                    style={{
                      borderColor: CATEGORY_COLORS[game.category] + '66',
                    }}
                  >
                    <img
                      src={`/assets/icons/game-${game.id + 1}.png`}
                      alt={game.name}
                      className="practice-game-icon"
                      draggable={false}
                    />
                    <span className="practice-game-name">{game.name}</span>
                    {game.isPro && <span className="pro-badge">PRO</span>}
                  </motion.div>
                ))}
              </motion.div>
            )}
          </AnimatePresence>
        </div>
      </div>

      <div className="page-footer">
        © 2007-2009 Playfish Ltd. All Rights Reserved.
      </div>
    </div>
  );
}
