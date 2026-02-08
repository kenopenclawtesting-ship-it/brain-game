// Export all mini-games
export { CalculateGame } from './Calculate/Calculate';
export { MatchCardGame } from './MatchCard/MatchCard';
export { MissingSignGame } from './MissingSign/MissingSign';
export { CubeCounterGame } from './CubeCounter/CubeCounter';
export { WeightGameGame } from './WeightGame/WeightGame';
export { MeteorSequenceGame } from './MeteorSequence/MeteorSequence';
export { JigsawMatchGame } from './JigsawMatch/JigsawMatch';
export { ShapeOrderGame } from './ShapeOrder/ShapeOrder';
export { MathCombinationGame } from './MathCombination/MathCombination';
export { SequenceMatchGame } from './SequenceMatch/SequenceMatch';
export { MemorySequenceGame } from './MemorySequence/MemorySequence';
export { CarPathGame } from './CarPath/CarPath';

export { GameContainer } from './GameContainer';

// Game component map by ID (matches MINIGAMES array in constants.ts)
import { CalculateGame } from './Calculate/Calculate';
import { MatchCardGame } from './MatchCard/MatchCard';
import { MissingSignGame } from './MissingSign/MissingSign';
import { CubeCounterGame } from './CubeCounter/CubeCounter';
import { WeightGameGame } from './WeightGame/WeightGame';
import { MeteorSequenceGame } from './MeteorSequence/MeteorSequence';
import { JigsawMatchGame } from './JigsawMatch/JigsawMatch';
import { ShapeOrderGame } from './ShapeOrder/ShapeOrder';
import { MathCombinationGame } from './MathCombination/MathCombination';
import { SequenceMatchGame } from './SequenceMatch/SequenceMatch';
import { MemorySequenceGame } from './MemorySequence/MemorySequence';
import { CarPathGame } from './CarPath/CarPath';
import { MinigameId } from '../../types';
import { ComponentType } from 'react';

export const GAME_COMPONENTS: Record<MinigameId, ComponentType> = {
  0: ShapeOrderGame,      // Shape Order - Memory
  1: MatchCardGame,       // Card Pairs - Memory
  2: CalculateGame,       // Missing Number - Calculate
  3: MissingSignGame,     // Missing Sign - Calculate
  4: CubeCounterGame,     // Cube Counter - Analyse
  5: WeightGameGame,      // Balance Scale - Analyse
  6: MeteorSequenceGame,  // Asteroids - Identify
  7: JigsawMatchGame,     // Jigsaw - Identify
  8: MathCombinationGame, // Math Combo - Calculate (PRO)
  9: SequenceMatchGame,   // Hex Path - Identify (PRO)
  10: MemorySequenceGame, // Action Sequence - Memory (PRO)
  11: CarPathGame,        // Car Path - Analyse (PRO)
};
