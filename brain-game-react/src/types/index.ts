// Game Types - Based on SOURCE.md analysis

export type GameMode = 'menu' | 'fullTest' | 'practice' | 'challenge';

export type Screen = 
  | 'splash'
  | 'menu'
  | 'tutorial'
  | 'countdown'
  | 'game'
  | 'results'
  | 'summary'
  | 'leaderboard'
  | 'profile'
  | 'achievements';

export type MinigameState = 'intro' | 'playing' | 'feedback' | 'timeup' | 'complete';

export type Category = 0 | 1 | 2 | 3; // Analyse, Calculate, Memory, Identify

export const CATEGORY_NAMES = ['Analyse', 'Calculate', 'Memory', 'Identify'] as const;

// Mini-game IDs (0-11)
export type MinigameId = 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11;

export interface MinigameInfo {
  id: MinigameId;
  name: string;
  category: Category;
  isPro: boolean;
  correctPoints: number;
  incorrectPoints: number;
}

export interface GameSession {
  mode: GameMode;
  currentCategory: Category;
  currentMinigame: MinigameId;
  categoryScores: [number, number, number, number];
  totalCorrect: number;
  totalIncorrect: number;
  gamesPlayed: MinigameId[];
}

export interface UserInfo {
  id: string;
  name: string;
  highScore: number;
  playCount: number;
  achievements: number; // Bitmask for 21 achievements
  bestScores: number[]; // Best per minigame (12)
  minigameStats: MinigameStats[];
}

export interface MinigameStats {
  minigameId: MinigameId;
  bestScore: number;
  totalScore: number;
  playCount: number;
}

export interface BrainType {
  index: number;
  name: string;
  description: string;
  minScore: number;
  maxScore: number;
}
