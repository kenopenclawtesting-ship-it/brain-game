// Tutorial Screen — v2 redesign: removed page-header, full-stage layout
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category, MinigameId } from '../../types';

const CATEGORY_COLORS: Record<Category, string> = {
  0: '#e74c3c',
  1: '#f1c40f',
  2: '#2ecc71',
  3: '#3498db',
};

const CATEGORY_BGS: Record<Category, string> = {
  0: '/assets/generated/cat-bg-analyse.png',
  1: '/assets/generated/cat-bg-calculate.png',
  2: '/assets/generated/cat-bg-memory.png',
  3: '/assets/generated/cat-bg-identify.png',
};

const GAME_INSTRUCTIONS: Record<MinigameId, { description: string; tips: string[] }> = {
  0: {
    description: 'Watch the sequence of shapes, then repeat it in the correct order.',
    tips: ['Pay attention to both shape AND color', 'The sequence gets longer each round'],
  },
  1: {
    description: 'Find matching pairs of cards. Cards may swap positions!',
    tips: ['Memorize card locations quickly', 'Watch out for swapping cards'],
  },
  2: {
    description: 'Solve the equation by finding the missing number.',
    tips: ['Higher levels include multiplication and division'],
  },
  3: {
    description: 'Find the missing operator that makes the equation true.',
    tips: ['Try each operator mentally'],
  },
  4: {
    description: 'Count all the cubes in the 3D structure, including hidden ones!',
    tips: ['Count column by column', 'Remember cubes behind others'],
  },
  5: {
    description: 'Determine which object is heaviest based on the scale comparisons.',
    tips: ['Make logical deductions from each scale'],
  },
  6: {
    description: 'Click the meteors in ascending numerical order.',
    tips: ['Numbers may become words at higher levels'],
  },
  7: {
    description: 'Match the jigsaw pieces to their correct outlines.',
    tips: ['Look at the piece shapes carefully'],
  },
  8: {
    description: 'Select numbers that add up to the target sum.',
    tips: ['Multiple combinations may work'],
  },
  9: {
    description: 'Find and trace the displayed sequence on the hexagon grid.',
    tips: ['Sequences can match forwards or backwards'],
  },
  10: {
    description: 'Watch the switches light up, then repeat the sequence.',
    tips: ['Like Simon Says - remember the order!'],
  },
  11: {
    description: 'Track where the car ends up after following the paths.',
    tips: ['Cars turn at every junction'],
  },
};

export function Tutorial() {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const startMinigame = useGameStore((state) => state.startMinigame);
  const { playClick } = useSound();

  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];
  const categoryColor = CATEGORY_COLORS[currentCategory as Category];
  const categoryBg = CATEGORY_BGS[currentCategory as Category];
  const instructions = GAME_INSTRUCTIONS[currentMinigame];

  const handleStart = () => {
    playClick();
    startMinigame();
  };

  return (
    <div className="game-page">
      <div className="game-stage">
        {/* Category-specific AI background */}
        <img src={categoryBg} alt="" className="stage-bg" draggable={false} />

        {/* Dark overlay for text readability */}
        <div style={{
          position: 'absolute', inset: 0,
          background: 'rgba(0,0,0,0.45)',
          pointerEvents: 'none',
        }} />

        <div className="stage-overlay">
          <div className="tut-container">
          {/* Category badge */}
          <motion.div
            initial={{ y: -15, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="tut-cat-badge"
            style={{
              background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}cc)`,
              boxShadow: `0 3px 12px ${categoryColor}66`,
            }}
          >
            {categoryName}
          </motion.div>

          {/* Game icon */}
          <motion.img
            src={`/assets/generated/icon-game-${currentMinigame + 1}.png`}
            alt={game.name}
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ type: 'spring', delay: 0.1 }}
            className="tut-game-icon"
            draggable={false}
          />

          {/* Game name */}
          <motion.div
            className="tut-game-name"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
          >
            {game.name}
          </motion.div>

          {/* Instructions card */}
          <motion.div
            className="tut-instructions"
            initial={{ y: 15, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
          >
            <p className="tut-desc">{instructions.description}</p>

            <div className="tut-tips">
              {instructions.tips.map((tip, i) => (
                <p key={i} className="tut-tip">• {tip}</p>
              ))}
            </div>

            <div className="tut-scoring">
              <span style={{ color: '#2ecc71' }}>+{game.correctPoints} pts</span>
              <span style={{ color: '#e74c3c' }}>{game.incorrectPoints} pts</span>
              <span style={{ color: 'rgba(255,255,255,0.5)' }}>60 seconds</span>
            </div>
          </motion.div>

          {/* START button */}
          <motion.button
            className="tut-start-btn"
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.5, type: 'spring' }}
            whileHover={{ scale: 1.08, filter: 'brightness(1.2)' }}
            whileTap={{ scale: 0.95 }}
            onClick={handleStart}
            style={{
              background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}bb)`,
              boxShadow: `0 4px 16px ${categoryColor}66`,
            }}
          >
            START GAME
          </motion.button>
          </div>
        </div>
      </div>
    </div>
  );
}
