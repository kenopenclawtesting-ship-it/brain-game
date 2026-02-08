// Summary Screen - Brain type reveal with stage background
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
        <h1 className="page-title">WHO HAS THE BIGGEST BRAIN?</h1>
      </div>

      <div className="game-stage">
        <img
          src="/assets/sprites/stage-bg.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        <div className="stage-overlay">
          {/* Title */}
          <motion.div
            initial={{ y: -15, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            style={{
              position: 'absolute',
              top: '13%',
              left: '35%',
              transform: 'translateX(-50%)',
              fontFamily: 'Baveuse, cursive',
              fontSize: 18,
              color: '#ffd700',
              textShadow: '0 0 10px rgba(255,215,0,0.5)',
              zIndex: 3,
            }}
          >
            YOUR BRAIN SIZE
          </motion.div>

          {/* Category scores bar */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="summary-category-bar"
            style={{
              position: 'absolute',
              top: '21%',
              left: '35%',
              transform: 'translateX(-50%)',
              zIndex: 3,
            }}
          >
            {categoryScores.map((score, i) => (
              <div
                key={i}
                className="summary-category-chip"
                style={{ background: CATEGORY_COLORS[i as Category] }}
              >
                <div className="summary-category-name">{CATEGORY_NAMES[i as Category]}</div>
                <div className="summary-category-score">{score}</div>
              </div>
            ))}
          </motion.div>

          {/* Total score */}
          <motion.div
            initial={{ scale: 0.5, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.4 }}
            style={{
              position: 'absolute',
              top: '35%',
              left: '35%',
              transform: 'translateX(-50%)',
              textAlign: 'center',
              zIndex: 3,
            }}
          >
            <div style={{
              fontFamily: 'Baveuse, cursive',
              fontSize: 10,
              color: 'rgba(100,90,120,0.7)',
            }}>TOTAL SCORE</div>
            <div className="results-score-big" style={{ fontSize: 60 }}>{displayTotal}</div>
          </motion.div>

          {/* Brain type reveal */}
          {revealBrain && (
            <motion.div
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ type: 'spring', bounce: 0.4 }}
              style={{
                position: 'absolute',
                top: '51%',
                left: '35%',
                transform: 'translateX(-50%)',
                textAlign: 'center',
                zIndex: 3,
              }}
            >
              <img
                src={`/assets/sprites/brain-type-${brainType.index + 1}.png`}
                alt={brainType.name}
                className="summary-brain-img"
              />
              <div className="summary-brain-name">{brainType.name}</div>
              <p style={{
                fontFamily: 'Baveuse, cursive',
                fontSize: 10,
                color: '#666',
                maxWidth: 200,
                margin: '4px auto 0',
              }}>
                {brainType.description}
              </p>
            </motion.div>
          )}

          {/* Play Again button */}
          {revealBrain && (
            <motion.div
              initial={{ y: 15, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.3 }}
              whileHover={{ scale: 1.08 }}
              whileTap={{ scale: 0.95 }}
              onClick={handlePlayAgain}
              style={{
                position: 'absolute',
                bottom: '17%',
                left: '30%',
                transform: 'translateX(-50%)',
                fontFamily: 'Baveuse, cursive',
                fontSize: 18,
                color: '#fff',
                background: 'linear-gradient(180deg, #27ae60, #1e8449)',
                padding: '10px 40px',
                borderRadius: 14,
                cursor: 'pointer',
                boxShadow: '0 4px 16px rgba(39,174,96,0.5)',
                border: '2px solid rgba(255,255,255,0.2)',
                zIndex: 3,
              }}
            >
              PLAY AGAIN
            </motion.div>
          )}

          {/* Professor (happy or sad based on score) */}
          <motion.img
            src={totalScore >= 1500
              ? '/assets/sprites/professor-happy.png'
              : '/assets/sprites/professor-sad.png'
            }
            alt="Professor"
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
            style={{
              position: 'absolute',
              right: '5%',
              top: '43%',
              height: 155,
              width: 'auto',
              zIndex: 2,
              filter: 'drop-shadow(0 4px 8px rgba(0,0,0,0.3))',
            }}
            draggable={false}
          />
        </div>
      </div>
    </div>
  );
}
