// Countdown Screen — v2 with category-colored accents
import { motion, AnimatePresence } from 'framer-motion';
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

export function CountdownScreen() {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const setScreen = useGameStore((state) => state.setScreen);
  const { play } = useSound();

  const [count, setCount] = useState(3);

  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];
  const categoryColor = CATEGORY_COLORS[currentCategory as Category];

  useEffect(() => {
    play('start');

    const timer = setInterval(() => {
      setCount((prev) => {
        if (prev <= 0) {
          clearInterval(timer);
          setScreen('game');
          return prev;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(timer);
  }, [play, setScreen]);

  return (
    <div className="game-page">
      <div className="page-header">
        <h1 className="page-title-rainbow">WHO HAS THE BIGGEST BRAIN?</h1>
      </div>

      <div className="game-stage">
        <img
          src="/assets/generated/countdown-bg.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        <div className="stage-overlay">
          <div className="countdown-container">
            {/* Category badge */}
            <motion.div
              initial={{ y: -30, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
            >
              <div
                className="countdown-category"
                style={{ color: categoryColor }}
              >
                {categoryName}
              </div>
              <div className="countdown-game-name">{game.name}</div>
            </motion.div>

            {/* Game icon */}
            <motion.img
              src={`/assets/generated/icon-game-${currentMinigame + 1}.png`}
              alt={game.name}
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ type: 'spring', delay: 0.1 }}
              style={{
                width: 60,
                height: 60,
                objectFit: 'contain',
                marginBottom: 16,
                filter: `drop-shadow(0 0 12px ${categoryColor}66)`,
              }}
              draggable={false}
            />

            {/* Countdown number */}
            <AnimatePresence mode="wait">
              <motion.div
                key={count}
                initial={{ scale: 2.5, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                exit={{ scale: 0.3, opacity: 0 }}
                transition={{ duration: 0.3 }}
              >
                {count > 0 ? (
                  <div className="countdown-number">{count}</div>
                ) : (
                  <div className="countdown-go">GO!</div>
                )}
              </motion.div>
            </AnimatePresence>

            {/* Info */}
            <motion.div
              className="countdown-info"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.5 }}
            >
              60 seconds • +{game.correctPoints} correct / {game.incorrectPoints} wrong
            </motion.div>
          </div>
        </div>
      </div>
    </div>
  );
}
