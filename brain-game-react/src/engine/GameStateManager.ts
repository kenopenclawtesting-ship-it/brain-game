import { create } from 'zustand';
import { GameConfig, GameResult, BrainTier } from './types';

// Brain tiers based on SOURCE.md - 32 tiers with score thresholds
const BRAIN_TIERS: BrainTier[] = [
  { tier: 1, name: "Barely Brain Dead", minScore: 0, maxScore: 199, image: "brain_tier_1.png" },
  { tier: 2, name: "Brain Dead", minScore: 200, maxScore: 399, image: "brain_tier_2.png" },
  { tier: 3, name: "Nearly Brain Dead", minScore: 400, maxScore: 599, image: "brain_tier_3.png" },
  { tier: 4, name: "Slow Thinker", minScore: 600, maxScore: 799, image: "brain_tier_4.png" },
  { tier: 5, name: "Sluggish", minScore: 800, maxScore: 999, image: "brain_tier_5.png" },
  { tier: 6, name: "Below Average", minScore: 1000, maxScore: 1199, image: "brain_tier_6.png" },
  { tier: 7, name: "Dull", minScore: 1200, maxScore: 1399, image: "brain_tier_7.png" },
  { tier: 8, name: "Not So Bright", minScore: 1400, maxScore: 1599, image: "brain_tier_8.png" },
  { tier: 9, name: "Dim Wit", minScore: 1600, maxScore: 1799, image: "brain_tier_9.png" },
  { tier: 10, name: "Half Wit", minScore: 1800, maxScore: 1999, image: "brain_tier_10.png" },
  { tier: 11, name: "Wit", minScore: 2000, maxScore: 2199, image: "brain_tier_11.png" },
  { tier: 12, name: "Quick Wit", minScore: 2200, maxScore: 2399, image: "brain_tier_12.png" },
  { tier: 13, name: "Average", minScore: 2400, maxScore: 2599, image: "brain_tier_13.png" },
  { tier: 14, name: "Above Average", minScore: 2600, maxScore: 2799, image: "brain_tier_14.png" },
  { tier: 15, name: "Pretty Good", minScore: 2800, maxScore: 2999, image: "brain_tier_15.png" },
  { tier: 16, name: "Good", minScore: 3000, maxScore: 3199, image: "brain_tier_16.png" },
  { tier: 17, name: "Really Good", minScore: 3200, maxScore: 3399, image: "brain_tier_17.png" },
  { tier: 18, name: "Very Good", minScore: 3400, maxScore: 3599, image: "brain_tier_18.png" },
  { tier: 19, name: "Smart", minScore: 3600, maxScore: 3799, image: "brain_tier_19.png" },
  { tier: 20, name: "Really Smart", minScore: 3800, maxScore: 3999, image: "brain_tier_20.png" },
  { tier: 21, name: "Very Smart", minScore: 4000, maxScore: 4199, image: "brain_tier_21.png" },
  { tier: 22, name: "Clever", minScore: 4200, maxScore: 4399, image: "brain_tier_22.png" },
  { tier: 23, name: "Bright", minScore: 4400, maxScore: 4599, image: "brain_tier_23.png" },
  { tier: 24, name: "Brilliant", minScore: 4600, maxScore: 4799, image: "brain_tier_24.png" },
  { tier: 25, name: "Gifted", minScore: 4800, maxScore: 4999, image: "brain_tier_25.png" },
  { tier: 26, name: "Genius", minScore: 5000, maxScore: 5199, image: "brain_tier_26.png" },
  { tier: 27, name: "Super Genius", minScore: 5200, maxScore: 5399, image: "brain_tier_27.png" },
  { tier: 28, name: "Mega Genius", minScore: 5400, maxScore: 5599, image: "brain_tier_28.png" },
  { tier: 29, name: "Ultra Genius", minScore: 5600, maxScore: 5799, image: "brain_tier_29.png" },
  { tier: 30, name: "Hyper Genius", minScore: 5800, maxScore: 5999, image: "brain_tier_30.png" },
  { tier: 31, name: "God-like", minScore: 6000, maxScore: 6199, image: "brain_tier_31.png" },
  { tier: 32, name: "All Knowing", minScore: 6200, maxScore: Infinity, image: "brain_tier_32.png" },
];

interface GameState {
  // Current game session
  currentGame: GameConfig | null;
  currentRound: number;
  totalScore: number;
  currentGameScore: number;
  brainTier: BrainTier;
  
  // Game history
  gamesPlayed: number;
  gameResults: GameResult[];
  
  // UI state
  isInGame: boolean;
  showResults: boolean;
  
  // Actions
  startGame: (game: GameConfig) => void;
  endGame: (result: GameResult) => void;
  updateScore: (newScore: number) => void;
  nextRound: () => void;
  resetGame: () => void;
  getBrainTier: (score: number) => BrainTier;
  getTotalGamesScore: () => number;
}

export const useGameState = create<GameState>((set, get) => ({
  // Initial state
  currentGame: null,
  currentRound: 0,
  totalScore: 0,
  currentGameScore: 0,
  brainTier: BRAIN_TIERS[0],
  gamesPlayed: 0,
  gameResults: [],
  isInGame: false,
  showResults: false,

  // Actions
  startGame: (game: GameConfig) => {
    set({
      currentGame: game,
      currentRound: 1,
      currentGameScore: 0,
      isInGame: true,
      showResults: false,
    });
  },

  endGame: (result: GameResult) => {
    const state = get();
    const newTotalScore = state.totalScore + result.score;
    const newBrainTier = get().getBrainTier(newTotalScore);
    
    set({
      totalScore: newTotalScore,
      brainTier: newBrainTier,
      gamesPlayed: state.gamesPlayed + 1,
      gameResults: [...state.gameResults, result],
      isInGame: false,
      showResults: true,
      currentGame: null,
      currentRound: 0,
      currentGameScore: 0,
    });
  },

  updateScore: (newScore: number) => {
    set({
      currentGameScore: newScore,
    });
  },

  nextRound: () => {
    const state = get();
    if (state.currentGame && state.currentRound < state.currentGame.maxRounds) {
      set({
        currentRound: state.currentRound + 1,
      });
    }
  },

  resetGame: () => {
    set({
      currentGame: null,
      currentRound: 0,
      currentGameScore: 0,
      isInGame: false,
      showResults: false,
    });
  },

  getBrainTier: (score: number) => {
    for (let i = BRAIN_TIERS.length - 1; i >= 0; i--) {
      if (score >= BRAIN_TIERS[i].minScore) {
        return BRAIN_TIERS[i];
      }
    }
    return BRAIN_TIERS[0];
  },

  getTotalGamesScore: () => {
    return get().gameResults.reduce((total, result) => total + result.score, 0);
  },
}));

// Available games configuration
export const AVAILABLE_GAMES: GameConfig[] = [
  {
    id: 'template',
    name: 'Template Game',
    category: 'Test',
    maxRounds: 4,
    timePerRound: 30,
    instructions: 'This is a template game for testing the engine.',
  },
  // More games will be added by Phase 2 agents
];

export { BRAIN_TIERS };