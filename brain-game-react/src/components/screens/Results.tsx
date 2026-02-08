// Results Screen - Score display with stage background and professor
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

  const profImg = currentScore >= 300
    ? '/assets/sprites/professor-happy.png'
    : '/assets/sprites/professor-sad.png';

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
          {/* Category badge */}
          <motion.div
            initial={{ y: -15, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            style={{
              position: 'absolute',
              top: '13%',
              left: '35%',
              transform: 'translateX(-50%)',
              zIndex: 3,
            }}
          >
            <span style={{
              fontFamily: 'Baveuse, cursive',
              fontSize: 11,
              color: '#fff',
              background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}cc)`,
              padding: '3px 14px',
              borderRadius: 12,
            }}>
              {categoryName} — {game.name}
            </span>
          </motion.div>

          {/* YOUR SCORE label */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            style={{
              position: 'absolute',
              top: '22%',
              left: '35%',
              transform: 'translateX(-50%)',
              fontFamily: 'Baveuse, cursive',
              fontSize: 12,
              color: 'rgba(100,90,120,0.7)',
              zIndex: 3,
            }}
          >
            YOUR SCORE
          </motion.div>

          {/* Big score number */}
          <motion.div
            initial={{ scale: 0.5, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.3, type: 'spring' }}
            style={{
              position: 'absolute',
              top: '27%',
              left: '35%',
              transform: 'translateX(-50%)',
              zIndex: 3,
            }}
          >
            <div className="results-score-big">{displayScore}</div>
          </motion.div>

          {/* Stats row */}
          <motion.div
            initial={{ y: 15, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.5 }}
            style={{
              position: 'absolute',
              top: '48%',
              left: '10%',
              width: '55%',
              display: 'flex',
              justifyContent: 'center',
              gap: 10,
              zIndex: 3,
            }}
          >
            <div className="results-stat-box" style={{ background: 'rgba(39,174,96,0.2)', border: '1px solid rgba(39,174,96,0.3)' }}>
              <div className="results-stat-number" style={{ color: '#27ae60' }}>{currentCorrect}</div>
              <div className="results-stat-label">Correct</div>
            </div>
            <div className="results-stat-box" style={{ background: 'rgba(231,76,60,0.2)', border: '1px solid rgba(231,76,60,0.3)' }}>
              <div className="results-stat-number" style={{ color: '#e74c3c' }}>{currentIncorrect}</div>
              <div className="results-stat-label">Wrong</div>
            </div>
          </motion.div>

          {/* Progress dots (full test mode) */}
          {gameMode === 'fullTest' && (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.6 }}
              style={{
                position: 'absolute',
                top: '63%',
                left: '35%',
                transform: 'translateX(-50%)',
                display: 'flex',
                gap: 8,
                zIndex: 3,
              }}
            >
              {[0, 1, 2, 3].map((i) => (
                <div
                  key={i}
                  style={{
                    width: 12,
                    height: 12,
                    borderRadius: '50%',
                    background: i < currentCategory ? '#27ae60' :
                      i === currentCategory ? categoryColor : '#ccc',
                    boxShadow: i === currentCategory ? `0 0 8px ${categoryColor}` : 'none',
                  }}
                />
              ))}
            </motion.div>
          )}

          {/* Continue button */}
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.7, type: 'spring' }}
            whileHover={{ scale: 1.08 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleContinue}
            style={{
              position: 'absolute',
              bottom: '18%',
              left: '30%',
              transform: 'translateX(-50%)',
              fontFamily: 'Baveuse, cursive',
              fontSize: 18,
              color: '#fff',
              background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}bb)`,
              padding: '10px 36px',
              borderRadius: 14,
              cursor: 'pointer',
              boxShadow: `0 4px 16px ${categoryColor}66`,
              border: '2px solid rgba(255,255,255,0.2)',
              zIndex: 3,
            }}
          >
            {gameMode === 'practice' ? 'BACK TO MENU' :
              currentCategory >= 3 ? 'SEE RESULTS' : 'CONTINUE'}
          </motion.div>

          {/* Professor reaction (uses the baked-in professor position) */}
          <motion.img
            src={profImg}
            alt="Professor"
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.4 }}
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
