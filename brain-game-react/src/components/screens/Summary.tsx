// Summary Screen — v2 with AI-generated background + brain type reveal
import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { CATEGORY_NAMES, getBrainType } from '../../lib/constants';
import { Category } from '../../types';

const CATEGORY_COLORS: Record<Category, string> = {
  0: '#e74c3c',
  1: '#f1c40f',
  2: '#2ecc71',
  3: '#3498db',
};

export function Summary() {
  const categoryScores = useGameStore((state) => state.categoryScores);
  const setScreen = useGameStore((state) => state.setScreen);
  const resetGame = useGameStore((state) => state.resetGame);
  const { play, playClick } = useSound();

  const [displayTotal, setDisplayTotal] = useState(0);
  const [revealBrain, setRevealBrain] = useState(false);

  const totalScore = categoryScores.reduce((sum, score) => sum + score, 0);
  const brainType = getBrainType(totalScore);

  useEffect(() => {
    play('applause');

    const duration = 2000;
    const steps = 50;
    const increment = totalScore / steps;
    let current = 0;

    const timer = setInterval(() => {
      current += increment;
      if (current >= totalScore) {
        setDisplayTotal(totalScore);
        clearInterval(timer);
        setTimeout(() => setRevealBrain(true), 500);
      } else {
        setDisplayTotal(Math.floor(current));
      }
    }, duration / steps);

    return () => clearInterval(timer);
  }, [totalScore, play]);

  const handlePlayAgain = () => {
    playClick();
    resetGame();
    setScreen('menu');
  };

  return (
    <div className="game-page">
      <div className="page-header">
        <h1 className="page-title-rainbow">WHO HAS THE BIGGEST BRAIN?</h1>
      </div>

      <div className="game-stage">
        <img
          src="/assets/generated/summary-bg.png"
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
          <div className="sum-container">
            {/* Title */}
            <motion.div
              className="sum-title"
              initial={{ y: -15, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
            >
              YOUR BRAIN SIZE
            </motion.div>

            {/* Category scores bar */}
            <motion.div
              className="sum-category-bar"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.2 }}
            >
              {categoryScores.map((score, i) => (
                <div
                  key={i}
                  className="sum-category-chip"
                  style={{ background: CATEGORY_COLORS[i as Category] }}
                >
                  <div className="sum-category-name">{CATEGORY_NAMES[i as Category]}</div>
                  <div className="sum-category-score">{score}</div>
                </div>
              ))}
            </motion.div>

            {/* Total score */}
            <motion.div
              initial={{ scale: 0.5, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 0.4 }}
              style={{ textAlign: 'center' }}
            >
              <div className="sum-total-label">TOTAL SCORE</div>
              <div className="results-score-big" style={{ fontSize: 60 }}>{displayTotal}</div>
            </motion.div>

            {/* Brain type reveal */}
            {revealBrain && (
              <motion.div
                className="sum-brain-reveal"
                initial={{ scale: 0, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ type: 'spring', bounce: 0.4 }}
              >
                <img
                  src={`/assets/sprites/brain-type-${brainType.index + 1}.png`}
                  alt={brainType.name}
                  className="summary-brain-img"
                />
                <div className="summary-brain-name">{brainType.name}</div>
                <p className="sum-brain-desc">{brainType.description}</p>
              </motion.div>
            )}

            {/* Play Again button */}
            {revealBrain && (
              <motion.button
                className="sum-play-again"
                initial={{ y: 15, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: 0.3 }}
                whileHover={{ scale: 1.08 }}
                whileTap={{ scale: 0.95 }}
                onClick={handlePlayAgain}
              >
                PLAY AGAIN
              </motion.button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
