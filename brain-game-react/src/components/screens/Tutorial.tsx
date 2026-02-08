// Tutorial Screen - Shows game instructions before each minigame
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category, MinigameId } from '../../types';

// Category colors
const CATEGORY_COLORS: Record<Category, string> = {
  0: 'from-red-400 to-red-600',     // Analyse
  1: 'from-yellow-400 to-yellow-600', // Calculate
  2: 'from-green-400 to-green-600',   // Memory
  3: 'from-blue-400 to-blue-600',     // Identify
};

const CATEGORY_BG_COLORS: Record<Category, string> = {
  0: 'bg-red-100 text-red-700',
  1: 'bg-yellow-100 text-yellow-700',
  2: 'bg-green-100 text-green-700',
  3: 'bg-blue-100 text-blue-700',
};

// Game instructions from SOURCE.md
const GAME_INSTRUCTIONS: Record<MinigameId, { description: string; tips: string[] }> = {
  0: { 
    description: 'Watch the sequence of shapes, then repeat it in the correct order.',
    tips: ['Pay attention to both shape AND color', 'The sequence gets longer each round'],
  },
  1: { 
    description: 'Find matching pairs of cards. Cards may swap positions!',
    tips: ['Memorize card locations quickly', 'Watch out for swapping cards at higher levels'],
  },
  2: { 
    description: 'Solve the equation by finding the missing number.',
    tips: ['Start with simple addition/subtraction', 'Higher levels include multiplication and division'],
  },
  3: { 
    description: 'Find the missing operator that makes the equation true.',
    tips: ['Try each operator mentally', 'Work through them systematically'],
  },
  4: { 
    description: 'Count all the cubes in the 3D structure, including hidden ones!',
    tips: ['Count column by column', 'Remember there may be cubes behind others'],
  },
  5: { 
    description: 'Determine which object is heaviest based on the scale comparisons.',
    tips: ['Make logical deductions from each scale', 'Watch for equal weights'],
  },
  6: { 
    description: 'Click the meteors in ascending numerical order.',
    tips: ['Numbers may become words at higher levels', 'Meteors bounce and move!'],
  },
  7: { 
    description: 'Match the jigsaw pieces to their correct outlines.',
    tips: ['Look at the piece shapes carefully', 'Drag pieces to the matching outline'],
  },
  8: { 
    description: 'Select numbers that add up to the target sum.',
    tips: ['Multiple combinations may work', 'Look for obvious pairs first'],
  },
  9: { 
    description: 'Find and trace the displayed sequence on the hexagon grid.',
    tips: ['Sequences can be matched forwards or backwards', 'Grid grows at higher levels'],
  },
  10: { 
    description: 'Watch the switches light up, then repeat the sequence.',
    tips: ['Like Simon Says', 'Sequence gets longer and faster'],
  },
  11: { 
    description: 'Track where the car ends up after following the paths.',
    tips: ['Cars turn at every junction', 'Multiple cars appear at higher levels'],
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
  const categoryBgColor = CATEGORY_BG_COLORS[currentCategory as Category];

  const handleStart = () => {
    playClick();
    startMinigame();
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="relative w-full h-full bg-gradient-to-b from-sky-50 to-white overflow-hidden">
          {/* Category badge */}
          <motion.div
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="absolute top-4 left-1/2 transform -translate-x-1/2"
          >
            <span className={`px-6 py-2 rounded-full text-sm font-bold ${categoryBgColor}`}>
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
              className="w-24 h-24 object-contain"
            />
          </motion.div>

          {/* Game name */}
          <motion.h1
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="absolute top-44 left-0 right-0 text-center text-3xl text-gray-800"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {game.name}
          </motion.h1>

          {/* Instructions */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
            className="absolute top-56 left-8 right-8 text-center"
          >
            <p className="text-lg text-gray-700 mb-4">
              {instructions.description}
            </p>
            
            <div className="bg-white/80 rounded-xl p-4 shadow-md border border-gray-200">
              <h3 className="font-bold text-gray-800 mb-2">Tips</h3>
              <ul className="text-sm text-gray-600 space-y-1">
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
            <div className="text-green-600 font-bold">
              +{game.correctPoints} pts
            </div>
            <div className="text-red-600 font-bold">
              {game.incorrectPoints} pts
            </div>
            <div className="text-gray-600">
              60 seconds
            </div>
          </motion.div>

          {/* Start button */}
          <motion.button
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.5, type: 'spring' }}
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleStart}
            className={`absolute bottom-6 left-1/2 transform -translate-x-1/2 px-12 py-4 bg-gradient-to-b ${categoryColor} text-white text-xl rounded-xl shadow-lg border-4 border-white/30`}
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            START GAME
          </motion.button>
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
