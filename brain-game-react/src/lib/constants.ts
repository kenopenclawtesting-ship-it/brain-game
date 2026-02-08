// Constants from SOURCE.md - Who Has The Biggest Brain

import { MinigameInfo, MinigameId, BrainType, Category } from '../types';

// Category names
export const CATEGORY_NAMES = ['Analyse', 'Calculate', 'Memory', 'Identify'] as const;

// Game timing
export const TOTAL_GAME_TIME = 60000; // 60 seconds per minigame (ms)
export const COUNTDOWN_DURATION = 3000; // 3-2-1-GO
export const TIMER_WARNING_THRESHOLD = 10000; // Play warning sound at 10 seconds

// Canvas dimensions (matching Flash)
export const CANVAS_WIDTH = 640;
export const CANVAS_HEIGHT = 480;
export const CANVAS_CENTER_X = 320;
export const CANVAS_CENTER_Y = 240;

// Categories
export const CATEGORY_ANALYSE = 0;
export const CATEGORY_CALCULATE = 1;
export const CATEGORY_MEMORY = 2;
export const CATEGORY_IDENTIFY = 3;

// Mini-game definitions with scoring from SOURCE.md
export const MINIGAMES: MinigameInfo[] = [
  { id: 0, name: 'Shape Order', category: 2, isPro: false, correctPoints: 18, incorrectPoints: -12 },
  { id: 1, name: 'Card Pairs', category: 2, isPro: false, correctPoints: 26, incorrectPoints: -18 },
  { id: 2, name: 'Missing Number', category: 1, isPro: false, correctPoints: 27, incorrectPoints: -18 },
  { id: 3, name: 'Missing Sign', category: 1, isPro: false, correctPoints: 20, incorrectPoints: -12 },
  { id: 4, name: 'Cube Counter', category: 0, isPro: false, correctPoints: 49, incorrectPoints: -33 },
  { id: 5, name: 'Balance Scale', category: 0, isPro: false, correctPoints: 24, incorrectPoints: -16 },
  { id: 6, name: 'Asteroids', category: 3, isPro: false, correctPoints: 11, incorrectPoints: -11 },
  { id: 7, name: 'Jigsaw', category: 3, isPro: false, correctPoints: 19, incorrectPoints: -13 },
  { id: 8, name: 'Math Combo', category: 1, isPro: true, correctPoints: 44, incorrectPoints: -29 },
  { id: 9, name: 'Hex Path', category: 3, isPro: true, correctPoints: 40, incorrectPoints: -26 },
  { id: 10, name: 'Action Sequence', category: 2, isPro: true, correctPoints: 13, incorrectPoints: -8 },
  { id: 11, name: 'Car Path', category: 0, isPro: true, correctPoints: 26, incorrectPoints: -17 },
];

// Games by category (for full test mode - one from each)
export const GAMES_BY_CATEGORY: Record<Category, MinigameId[]> = {
  0: [4, 5, 11],  // Analyse: Cube Counter, Balance Scale, Car Path
  1: [2, 3, 8],   // Calculate: Missing Number, Missing Sign, Math Combo
  2: [0, 1, 10],  // Memory: Shape Order, Card Pairs, Action Sequence
  3: [6, 7, 9],   // Identify: Asteroids, Jigsaw, Hex Path
};

// Brain type score ranges (32 tiers from SOURCE.md)
export const BRAIN_TYPE_SCORE_RANGE = [
  0, 100, 300, 500, 700, 900,
  1000, 1100, 1200, 1300, 1400, 1500,
  1600, 1700, 1800, 1900, 2000, 2100,
  2300, 2500, 2700, 2900, 3100, 3300,
  3500, 3700, 3900, 4100, 4300, 4500,
  4700, 4900
];

// Brain types with names and descriptions from LanguageTranslation.as
export const BRAIN_TYPES: BrainType[] = [
  { index: 0, name: 'AMOEBA', description: "I'm sure there's something good to say about AMOEBAS...", minScore: 0, maxScore: 99 },
  { index: 1, name: 'EARTHWORM', description: 'Good for garden soil, not big thinkers', minScore: 100, maxScore: 299 },
  { index: 2, name: 'SNAIL', description: 'Kind of cute, tiny brains', minScore: 300, maxScore: 499 },
  { index: 3, name: 'RAT', description: 'Clever animals', minScore: 500, maxScore: 699 },
  { index: 4, name: 'CAT', description: 'Nine lives, so-so brains', minScore: 700, maxScore: 899 },
  { index: 5, name: 'DOG', description: "Who wouldn't want to be a dog!", minScore: 900, maxScore: 999 },
  { index: 6, name: 'GOAT', description: 'Mountain skippers', minScore: 1000, maxScore: 1099 },
  { index: 7, name: 'CHIMP', description: 'Understands basic symbols', minScore: 1100, maxScore: 1199 },
  { index: 8, name: 'GORILLA', description: 'Largest primates, highly intelligent', minScore: 1200, maxScore: 1299 },
  { index: 9, name: 'MISSING LINK', description: 'Early man, relatively evolved', minScore: 1300, maxScore: 1399 },
  { index: 10, name: 'NEANDERTHAL', description: 'Geniuses of their time, controlled fire', minScore: 1400, maxScore: 1499 },
  { index: 11, name: 'AVERAGE JOE', description: 'Not amazing, not shabby', minScore: 1500, maxScore: 1599 },
  { index: 12, name: 'GEEK', description: 'Shows promise!', minScore: 1600, maxScore: 1699 },
  { index: 13, name: 'NERD', description: 'Will rule the universe!', minScore: 1700, maxScore: 1799 },
  { index: 14, name: 'SCHOLAR', description: 'Congratulations on a job well done!', minScore: 1800, maxScore: 1899 },
  { index: 15, name: 'SCIENTIST', description: 'Something to be proud of', minScore: 1900, maxScore: 1999 },
  { index: 16, name: 'GENIUS', description: 'Biggest brain in humans today', minScore: 2000, maxScore: 2099 },
  { index: 17, name: 'SPACE ACE', description: 'Ahead of your time', minScore: 2100, maxScore: 2299 },
  { index: 18, name: 'CYBORG', description: 'Man-machine combination', minScore: 2300, maxScore: 2499 },
  { index: 19, name: 'ALIEN', description: 'Welcome to Earth, visitor!', minScore: 2500, maxScore: 2699 },
  { index: 20, name: 'SQUIDLIAN', description: 'Mighty brain master', minScore: 2700, maxScore: 2899 },
  { index: 21, name: 'BITBOT', description: "You're a machine!", minScore: 2900, maxScore: 3099 },
  { index: 22, name: 'SPACEBOT', description: 'RX-711 SPACEBOT', minScore: 3100, maxScore: 3299 },
  { index: 23, name: 'CALCUBOT', description: 'I always knew it!', minScore: 3300, maxScore: 3499 },
  { index: 24, name: 'ENCEPHALOBOT', description: 'Ask for autographs later', minScore: 3500, maxScore: 3699 },
  { index: 25, name: 'BRAINBOT', description: 'All that computing power!', minScore: 3700, maxScore: 3899 },
  { index: 26, name: 'NEUROBOT', description: 'One of the few in the universe', minScore: 3900, maxScore: 4099 },
  { index: 27, name: 'COMPUTRON', description: 'Computational elite', minScore: 4100, maxScore: 4299 },
  { index: 28, name: 'XENOS', description: 'Level few achieve', minScore: 4300, maxScore: 4499 },
  { index: 29, name: 'NEURONIAN', description: 'Monstrous brain', minScore: 4500, maxScore: 4699 },
  { index: 30, name: 'AEONIAN', description: 'Awe-inspiring brain capacity', minScore: 4700, maxScore: 4899 },
  { index: 31, name: 'GALAXIAN', description: 'Brain Master of the Universe', minScore: 4900, maxScore: Infinity },
];

// Achievement thresholds from SOURCE.md
export const ACHIEVEMENT_THRESHOLDS = {
  MINIGAME_SCORE: 650,       // Score needed per-game for mastery
  ALL_ROUNDER: 500,          // 500+ on ALL games
  PRECISION: 2600,           // 2600+ with 0 errors
  TESTS_20: 20,
  TESTS_100: 100,
  OVER_1000: 1000,           // 1000+ on any single game
  CHALLENGE_WIN_TIMES: 10,
  CHALLENGE_POINTS_OVER: 1000,
};

// Get brain type from score
export function getBrainType(score: number): BrainType {
  for (let i = BRAIN_TYPE_SCORE_RANGE.length - 1; i >= 0; i--) {
    if (score >= BRAIN_TYPE_SCORE_RANGE[i]) {
      return BRAIN_TYPES[i];
    }
  }
  return BRAIN_TYPES[0];
}

// Get minigame info by ID
export function getMinigameInfo(id: MinigameId): MinigameInfo {
  return MINIGAMES[id];
}

// Get random game from category (for full test)
export function getRandomGameFromCategory(category: Category, excludePro = false): MinigameId {
  const games = GAMES_BY_CATEGORY[category].filter(
    id => !excludePro || !MINIGAMES[id].isPro
  );
  return games[Math.floor(Math.random() * games.length)];
}
