// Tutorial Screen - Game instructions with stage background
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
  const instructions = GAME_INSTRUCTIONS[currentMinigame];

  const handleStart = () => {
    playClick();
    startMinigame();
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
          {/* Category badge */}
          <motion.div
            initial={{ y: -15, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            style={{
              position: 'absolute',
              top: '14%',
              left: '35%',
              transform: 'translateX(-50%)',
              zIndex: 3,
            }}
          >
            <span
              style={{
                fontFamily: 'Baveuse, cursive',
                fontSize: 12,
                color: '#fff',
                background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}cc)`,
                padding: '3px 14px',
                borderRadius: 12,
                boxShadow: `0 3px 10px ${categoryColor}66`,
              }}
            >
              {categoryName}
            </span>
          </motion.div>

          {/* Game icon */}
          <motion.img
            src={`/assets/icons/game-${currentMinigame + 1}.png`}
            alt={game.name}
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ type: 'spring', delay: 0.1 }}
            style={{
              position: 'absolute',
              top: '22%',
              left: '30%',
              transform: 'translateX(-50%)',
              width: 70,
              height: 70,
              objectFit: 'contain',
              zIndex: 3,
            }}
            draggable={false}
          />

          {/* Game name */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            style={{
              position: 'absolute',
              top: '39%',
              left: '35%',
              transform: 'translateX(-50%)',
              fontFamily: 'Baveuse, cursive',
              fontSize: 24,
              color: '#ffd700',
              textShadow: '0 0 10px rgba(255,215,0,0.5), 0 2px 4px rgba(0,0,0,0.3)',
              zIndex: 3,
              whiteSpace: 'nowrap',
            }}
          >
            {game.name}
          </motion.div>

          {/* Instructions */}
          <motion.div
            initial={{ y: 15, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
            style={{
              position: 'absolute',
              top: '48%',
              left: '12%',
              width: '52%',
              zIndex: 3,
            }}
          >
            <p style={{
              fontFamily: 'Baveuse, cursive',
              fontSize: 11,
              color: '#444',
              lineHeight: 1.4,
              textAlign: 'center',
              marginBottom: 8,
            }}>
              {instructions.description}
            </p>

            <div style={{
              background: 'rgba(0,0,0,0.08)',
              borderRadius: 8,
              padding: '6px 10px',
            }}>
              {instructions.tips.map((tip, i) => (
                <p key={i} style={{
                  fontFamily: 'Baveuse, cursive',
                  fontSize: 9,
                  color: '#555',
                  lineHeight: 1.5,
                }}>
                  • {tip}
                </p>
              ))}
            </div>

            <div style={{
              display: 'flex',
              justifyContent: 'center',
              gap: 20,
              marginTop: 8,
              fontFamily: 'Baveuse, cursive',
              fontSize: 10,
            }}>
              <span style={{ color: '#27ae60' }}>+{game.correctPoints} pts</span>
              <span style={{ color: '#e74c3c' }}>{game.incorrectPoints} pts</span>
              <span style={{ color: '#666' }}>60 seconds</span>
            </div>
          </motion.div>

          {/* START button */}
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.5, type: 'spring' }}
            whileHover={{ scale: 1.08 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleStart}
            style={{
              position: 'absolute',
              bottom: '20%',
              left: '30%',
              transform: 'translateX(-50%)',
              fontFamily: 'Baveuse, cursive',
              fontSize: 20,
              color: '#fff',
              background: `linear-gradient(180deg, ${categoryColor}, ${categoryColor}bb)`,
              padding: '10px 40px',
              borderRadius: 14,
              cursor: 'pointer',
              boxShadow: `0 4px 16px ${categoryColor}66`,
              border: '2px solid rgba(255,255,255,0.2)',
              zIndex: 3,
            }}
          >
            START GAME
          </motion.div>
        </div>
      </div>
    </div>
  );
}
