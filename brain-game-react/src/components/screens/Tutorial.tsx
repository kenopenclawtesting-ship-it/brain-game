// Tutorial Screen - DARK TV Game Show Theme
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category, MinigameId } from '../../types';

// Category colors
const CATEGORY_COLORS: Record<Category, string> = {
  0: '#e74c3c', // Analyse - red
  1: '#f1c40f', // Calculate - yellow
  2: '#2ecc71', // Memory - green
  3: '#3498db', // Identify - blue
};

// Game instructions from SOURCE.md
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
    tips: ['Like Simon Says'],
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
  const instructions = GAME_INSTRUCTIONS[currentMinigame];
  const categoryColor = CATEGORY_COLORS[currentCategory as Category];

  const handleStart = () => {
    playClick();
    startMinigame();
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="relative w-full h-full overflow-hidden">
          {/* Category badge */}
          <motion.div
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-4 left-1/2 transform -translate-x-1/2"
          >
            <span 
              className="px-6 py-2 rounded-full text-sm font-bold text-white shadow-lg"
              style={{ 
                background: `linear-gradient(180deg, ${categoryColor} 0%, ${categoryColor}cc 100%)`,
                boxShadow: `0 4px 15px ${categoryColor}66`
              }}
            >
              {categoryName}
            </span>
          </motion.div>

          {/* Game icon */}
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ type: 'spring', delay: 0.1 }}
            className="absolute top-16 left-1/2 transform -translate-x-1/2"
          >
            <img
              src={`/assets/icons/game-${currentMinigame + 1}.png`}
              alt={game.name}
              className="w-20 h-20 object-contain"
            />
          </motion.div>

          {/* Game name */}
          <motion.h1
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="absolute top-40 left-0 right-0 text-center text-3xl gold-glow"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {game.name}
          </motion.h1>

          {/* Instructions */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
            className="absolute top-52 left-8 right-8 text-center"
          >
            <p className="text-lg text-gray-300 mb-4">
              {instructions.description}
            </p>
            
            <div 
              className="rounded-xl p-4 shadow-lg"
              style={{ 
                background: 'linear-gradient(180deg, #2a2a5a 0%, #1a1a3a 100%)',
                border: '1px solid rgba(255,255,255,0.1)'
              }}
            >
              <h3 className="font-bold text-white mb-2">Tips</h3>
              <ul className="text-sm text-gray-400 space-y-1">
                {instructions.tips.map((tip, i) => (
                  <li key={i}>• {tip}</li>
                ))}
              </ul>
            </div>
          </motion.div>

          {/* Scoring info */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="absolute bottom-24 left-0 right-0 flex justify-center gap-8 text-sm"
          >
            <div className="text-green-400 font-bold">+{game.correctPoints} pts</div>
            <div className="text-red-400 font-bold">{game.incorrectPoints} pts</div>
            <div className="text-gray-400">60 seconds</div>
          </motion.div>

          {/* Start button */}
          <motion.button
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.5, type: 'spring' }}
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleStart}
            className="absolute bottom-6 left-1/2 transform -translate-x-1/2 px-12 py-4 text-white text-xl rounded-xl shadow-lg"
            style={{ 
              fontFamily: 'Baveuse, cursive',
              background: `linear-gradient(180deg, ${categoryColor} 0%, ${categoryColor}bb 100%)`,
              boxShadow: `0 4px 20px ${categoryColor}66`,
              border: '2px solid rgba(255,255,255,0.2)'
            }}
          >
            START GAME
          </motion.button>
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
