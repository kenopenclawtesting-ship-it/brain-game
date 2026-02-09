export interface GameConfig {
  id: string;
  name: string;
  category: string;
  maxRounds: number;
  timePerRound: number; // seconds
  instructions: string;
}

export interface GameState {
  phase: 'INTRO' | 'READY' | 'PLAYING' | 'ROUND_END' | 'GAME_OVER';
  round: number;
  score: number;
  timeRemaining: number;
  isLoading: boolean;
  error?: string;
}

export interface GameResult {
  gameId: string;
  score: number;
  maxScore: number;
  roundScores: number[];
  timePlayed: number;
  accuracy: number;
}

export interface SpriteAsset {
  name: string;
  path: string;
  width: number;
  height: number;
}

export interface BrainTier {
  tier: number;
  name: string;
  minScore: number;
  maxScore: number;
  image: string;
}

export interface RoundData {
  round: number;
  score: number;
  maxScore: number;
  timeUsed: number;
  correct: boolean;
}

// Game lifecycle callbacks
export interface GameCallbacks {
  onRoundStart: (round: number) => void;
  onRoundEnd: (roundData: RoundData) => void;
  onGameOver: (result: GameResult) => void;
  onUserInput: (input: any) => void;
  onError: (error: string) => void;
}

// Animation interfaces
export interface AnimationConfig {
  duration: number;
  ease: string;
  delay?: number;
  repeat?: number;
  yoyo?: boolean;
}

export interface TweenTarget {
  x?: number;
  y?: number;
  alpha?: number;
  rotation?: number;
  scaleX?: number;
  scaleY?: number;
}