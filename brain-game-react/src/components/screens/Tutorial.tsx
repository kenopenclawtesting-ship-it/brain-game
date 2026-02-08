// Tutorial Screen - Shows game instructions before each minigame
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { Button } from '../ui/Button';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { MINIGAMES, CATEGORY_NAMES } from '../../lib/constants';
import { Category, MinigameId } from '../../types';

// Game instructions from SOURCE.md
const GAME_INSTRUCTIONS: Record<MinigameId, { description: string; tips: string[] }> = {
  0: { // Shape Order
    description: 'Watch the sequence of shapes, then repeat it in the correct order.',
    tips: ['Pay attention to both shape AND color', 'The sequence gets longer each round'],
  },
  1: { // Card Pairs
    description: 'Find matching pairs of cards. Cards may swap positions!',
    tips: ['Memorize card locations quickly', 'Watch out for swapping cards at higher levels'],
  },
  2: { // Missing Number (Calculate)
    description: 'Solve the equation by finding the missing number.',
    tips: ['Start with simple addition/subtraction', 'Higher levels include multiplication and division'],
  },
  3: { // Missing Sign
    description: 'Find the missing operator (+, -, ×, ÷) that makes the equation true.',
    tips: ['Try each operator mentally', 'Work through them systematically'],
  },
  4: { // Cube Counter
    description: 'Count all the cubes in the 3D structure, including hidden ones!',
    tips: ['Count column by column', 'Remember there may be cubes behind others'],
  },
  5: { // Balance Scale (Weight Game)
    description: 'Determine which object is heaviest based on the scale comparisons.',
    tips: ['Make logical deductions from each scale', 'Watch for equal weights at higher levels'],
  },
  6: { // Asteroids (Meteor Sequence)
    description: 'Click the meteors in ascending numerical order.',
    tips: ['Numbers may become words at higher levels', 'Meteors bounce and move!'],
  },
  7: { // Jigsaw
    description: 'Match the jigsaw pieces to their correct outlines.',
    tips: ['Look at the piece shapes carefully', 'Drag pieces to the matching outline'],
  },
  8: { // Math Combo
    description: 'Select numbers that add up to the target sum.',
    tips: ['Multiple combinations may work', 'Look for obvious pairs first'],
  },
  9: { // Hex Path (Sequence Match)
    description: 'Find and trace the displayed sequence on the hexagon grid.',
    tips: ['Sequences can be matched forwards or backwards', 'Grid grows at higher levels'],
  },
  10: { // Action Sequence (Memory Sequence)
    description: 'Watch the switches light up, then repeat the sequence.',
    tips: ['Like Simon Says', 'Sequence gets longer and faster'],
  },
  11: { // Car Path
    description: 'Track where the car ends up after following the paths.',
    tips: ['Cars turn at every junction', 'Multiple cars appear at higher levels'],
  },
};

export function Tutorial() {
  const currentMinigame = useGameStore((state) => state.currentMinigame);
  const currentCategory = useGameStore((state) => state.currentCategory);
  const startMinigame = useGameStore((state) => state.startMinigame);
  
  const game = MINIGAMES[currentMinigame];
  const categoryName = CATEGORY_NAMES[currentCategory as Category];
  const instructions = GAME_INSTRUCTIONS[currentMinigame];

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="flex flex-col items-center justify-center h-full p-8">
          {/* Category badge */}
          <motion.div
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="mb-4"
          >
            <span className="px-4 py-1 bg-purple-100 text-purple-700 rounded-full text-sm font-medium">
              {categoryName}
            </span>
          </motion.div>

          {/* Game name */}
          <motion.h1
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.1 }}
            className="text-3xl font-bold text-gray-800 mb-6"
          >
            {game.name}
          </motion.h1>

          {/* Instructions */}
          <motion.div
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="text-center max-w-md mb-6"
          >
            <p className="text-lg text-gray-700 mb-4">
              {instructions.description}
            </p>
            
            <div className="bg-blue-50 rounded-lg p-4">
              <h3 className="font-medium text-blue-800 mb-2">💡 Tips</h3>
              <ul className="text-sm text-blue-700 space-y-1">
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
            transition={{ delay: 0.3 }}
            className="flex gap-6 mb-8 text-sm"
          >
            <div className="text-green-600">
              <span className="font-bold">Correct:</span> +{game.correctPoints} pts
            </div>
            <div className="text-red-600">
              <span className="font-bold">Wrong:</span> {game.incorrectPoints} pts
            </div>
            <div className="text-gray-600">
              <span className="font-bold">Time:</span> 60 seconds
            </div>
          </motion.div>

          {/* Start button */}
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.4, type: 'spring' }}
          >
            <Button variant="primary" size="large" onClick={startMinigame}>
              START GAME
            </Button>
          </motion.div>
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
