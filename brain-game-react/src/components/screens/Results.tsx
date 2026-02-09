// Results Screen — v2 redesign: centered layout, no professor, clean score display
import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category } from '../../types';

const CATEGORY_COLORS: Record<Category, string> = {
  0: '#e74c3c',
  1: '#f1c40f',
  2: '#2ecc71',
  3: '#3498db',
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

  useEffect(() => {
    play('applause');

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
    <div className="game-page">
      <div className="game-stage">
        <img
          src="/assets/generated/results-bg-v2.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        {/* Dark overlay for readability */}
        <div style={{
          position: 'absolute', inset: 0,
          background: 'rgba(0,0,0,0.4)',
          pointerEvents: 'none',
        }} />

        <div className="stage-overlay">
          <div className="res-container">
            {/* Category badge */}
            <motion.div
              initial={{ y: -15, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              className="res-cat-badge"
              style={{
                background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}cc)`,
                boxShadow: `0 3px 12px ${categoryColor}66`,
              }}
            >
              {categoryName} — {game.name}
            </motion.div>

            {/* YOUR SCORE label */}
            <motion.div
              className="res-label"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.2 }}
            >
              YOUR SCORE
            </motion.div>

            {/* Big score number */}
            <motion.div
              initial={{ scale: 0.5, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 0.3, type: 'spring' }}
            >
              <div className="results-score-big">{displayScore}</div>
            </motion.div>

            {/* Stats row */}
            <motion.div
              className="res-stats-row"
              initial={{ y: 15, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.5 }}
            >
              <div className="results-stat-box" style={{ background: 'rgba(39,174,96,0.25)', border: '1px solid rgba(39,174,96,0.4)' }}>
                <div className="results-stat-number" style={{ color: '#2ecc71' }}>{currentCorrect}</div>
                <div className="results-stat-label">Correct</div>
              </div>
              <div className="results-stat-box" style={{ background: 'rgba(231,76,60,0.25)', border: '1px solid rgba(231,76,60,0.4)' }}>
                <div className="results-stat-number" style={{ color: '#e74c3c' }}>{currentIncorrect}</div>
                <div className="results-stat-label">Wrong</div>
              </div>
            </motion.div>

            {/* Progress dots (full test mode) */}
            {gameMode === 'fullTest' && (
              <motion.div
                className="res-progress-dots"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.6 }}
              >
                {[0, 1, 2, 3].map((i) => (
                  <div
                    key={i}
                    className="res-dot"
                    style={{
                      background: i < currentCategory ? '#27ae60' :
                        i === currentCategory ? categoryColor : 'rgba(255,255,255,0.2)',
                      boxShadow: i === currentCategory ? `0 0 10px ${categoryColor}` : 'none',
                    }}
                  />
                ))}
              </motion.div>
            )}

            {/* Continue button */}
            <motion.button
              className="res-continue-btn"
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ delay: 0.7, type: 'spring' }}
              whileHover={{ scale: 1.08, filter: 'brightness(1.2)' }}
              whileTap={{ scale: 0.95 }}
              onClick={handleContinue}
              style={{
                background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}bb)`,
                boxShadow: `0 4px 16px ${categoryColor}66`,
              }}
            >
              {gameMode === 'practice' ? 'BACK TO MENU' :
                currentCategory >= 3 ? 'SEE RESULTS' : 'CONTINUE'}
            </motion.button>
          </div>
        </div>
      </div>
    </div>
  );
}
