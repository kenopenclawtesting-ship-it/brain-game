// Game Select Screen — v2 redesign: clean mode selection + practice grid
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { MINIGAMES } from '../../lib/constants';
import { MinigameId } from '../../types';
import { useState } from 'react';

const CATEGORY_COLORS = ['#e74c3c', '#f1c40f', '#2ecc71', '#3498db'];
const CATEGORY_NAMES_SHORT = ['ANL', 'CALC', 'MEM', 'VIS'];

const MODES = [
  {
    id: 'classic',
    title: 'CLASSIC',
    subtitle: 'Full Brain Test',
    desc: '4 categories · 60s each',
    icon: '🧠',
    gradient: 'linear-gradient(135deg, #7C3AED, #5B21B6)',
    glow: 'rgba(124, 58, 237, 0.5)',
  },
  {
    id: 'practice',
    title: 'PRACTICE',
    subtitle: 'Free Play',
    desc: 'Pick any game · no pressure',
    icon: '🎯',
    gradient: 'linear-gradient(135deg, #06B6D4, #0891B2)',
    glow: 'rgba(6, 182, 212, 0.5)',
  },
  {
    id: 'pro',
    title: 'PRO',
    subtitle: 'Coming Soon',
    desc: 'Challenge mode · leaderboards',
    icon: '⚡',
    gradient: 'linear-gradient(135deg, #F59E0B, #D97706)',
    glow: 'rgba(245, 158, 11, 0.5)',
  },
];

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

  const handleMode = (id: string) => {
    playClick();
    if (id === 'classic') startFullTest();
    else if (id === 'practice') setShowPractice(true);
  };

  const handleSelectGame = (id: MinigameId) => {
    playClick();
    startPractice(id);
  };

  return (
    <div className="game-page">
      <div className="game-stage">
        <img
          src="/assets/generated/gameselect-bg.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        <div className="stage-overlay">
          <AnimatePresence mode="wait">
            {!showPractice ? (
              <motion.div
                key="modes"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                transition={{ duration: 0.25 }}
                style={{ position: 'absolute', inset: 0 }}
              >
                {/* Back button */}
                <motion.button
                  className="gs-back-btn"
                  whileHover={{ scale: 1.1 }}
                  whileTap={{ scale: 0.9 }}
                  onClick={handleBack}
                >
                  ←
                </motion.button>

                {/* Title */}
                <motion.div
                  className="gs-title"
                  initial={{ opacity: 0, y: -20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: 0.2, duration: 0.5 }}
                >
                  CHOOSE YOUR MODE
                </motion.div>

                {/* Three mode cards — centered, full width */}
                <div className="gs-modes-row">
                  {MODES.map((mode, i) => (
                    <motion.button
                      key={mode.id}
                      className={`gs-mode-card ${mode.id === 'pro' ? 'gs-mode-disabled' : ''}`}
                      initial={{ opacity: 0, y: 40 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: 0.3 + i * 0.12, duration: 0.5 }}
                      whileHover={mode.id !== 'pro' ? { y: -8, scale: 1.04 } : {}}
                      whileTap={mode.id !== 'pro' ? { scale: 0.95 } : {}}
                      onClick={() => handleMode(mode.id)}
                    >
                      <div
                        className="gs-mode-icon"
                        style={{ background: mode.gradient, boxShadow: `0 4px 20px ${mode.glow}` }}
                      >
                        <span>{mode.icon}</span>
                      </div>
                      <div className="gs-mode-title">{mode.title}</div>
                      <div className="gs-mode-subtitle">{mode.subtitle}</div>
                      <div className="gs-mode-desc">{mode.desc}</div>
                    </motion.button>
                  ))}
                </div>
              </motion.div>
            ) : (
              /* Practice game picker grid */
              <motion.div
                key="practice"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                transition={{ duration: 0.25 }}
                style={{ position: 'absolute', inset: 0 }}
              >
                {/* Back button */}
                <motion.button
                  className="gs-back-btn"
                  whileHover={{ scale: 1.1 }}
                  whileTap={{ scale: 0.9 }}
                  onClick={handleBack}
                >
                  ←
                </motion.button>

                {/* Dark overlay */}
                <div className="gs-practice-overlay" />

                {/* Title */}
                <div className="gs-practice-title">CHOOSE A GAME</div>

                {/* Game grid — 4x3 */}
                <div className="gs-practice-grid">
                  {MINIGAMES.map((game, index) => (
                    <motion.div
                      key={game.id}
                      className="gs-game-card"
                      initial={{ scale: 0, opacity: 0 }}
                      animate={{ scale: 1, opacity: 1 }}
                      transition={{ delay: index * 0.04 }}
                      whileHover={{ scale: 1.1, y: -4 }}
                      whileTap={{ scale: 0.9 }}
                      onClick={() => handleSelectGame(game.id)}
                      style={{ borderColor: CATEGORY_COLORS[game.category] + '66' }}
                    >
                      <img
                        src={`/assets/generated/icon-game-${game.id + 1}.png`}
                        alt={game.name}
                        className="gs-game-icon"
                        draggable={false}
                      />
                      <span className="gs-game-name">{game.name}</span>
                      <span
                        className="gs-game-cat"
                        style={{ color: CATEGORY_COLORS[game.category] }}
                      >
                        {CATEGORY_NAMES_SHORT[game.category]}
                      </span>
                    </motion.div>
                  ))}
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </div>
      </div>
    </div>
  );
}
