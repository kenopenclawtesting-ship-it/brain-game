// Game State Store using Zustand
import { create } from 'zustand';
import { GameMode, Screen, MinigameId, Category } from '../types';
import { MINIGAMES, getRandomGameFromCategory, getBrainType, TOTAL_GAME_TIME } from '../lib/constants';

interface GameState {
  // Navigation
  currentScreen: Screen;
  gameMode: GameMode;
  
  // Game session
  currentCategory: Category;
  currentMinigame: MinigameId;
  categoryScores: [number, number, number, number];
  categoryGamesPlayed: [MinigameId | null, MinigameId | null, MinigameId | null, MinigameId | null];
  
  // Timer
  timeRemaining: number;
  isTimerRunning: boolean;
  
  // Current minigame stats
  currentCorrect: number;
  currentIncorrect: number;
  currentScore: number;
  
  // Overall stats
  totalGamesPlayed: number;
  
  // Sound
  isMuted: boolean;
  
  // Actions
  setScreen: (screen: Screen) => void;
  startFullTest: () => void;
  startPractice: (minigameId: MinigameId) => void;
  startNextCategory: () => void;
  startMinigame: () => void;
  
  // Timer actions
  setTimeRemaining: (time: number) => void;
  startTimer: () => void;
  stopTimer: () => void;
  tickTimer: (delta: number) => void;
  
  // Scoring actions
  addCorrect: () => void;
  addIncorrect: () => void;
  finishMinigame: () => void;
  
  // Sound
  toggleMute: () => void;
  
  // Reset
  resetGame: () => void;
  
  // Computed
  getTotalScore: () => number;
  getBrainType: () => ReturnType<typeof getBrainType>;
}

const initialState = {
  currentScreen: 'menu' as Screen,
  gameMode: 'menu' as GameMode,
  currentCategory: 0 as Category,
  currentMinigame: 0 as MinigameId,
  categoryScores: [0, 0, 0, 0] as [number, number, number, number],
  categoryGamesPlayed: [null, null, null, null] as [MinigameId | null, MinigameId | null, MinigameId | null, MinigameId | null],
  timeRemaining: TOTAL_GAME_TIME,
  isTimerRunning: false,
  currentCorrect: 0,
  currentIncorrect: 0,
  currentScore: 0,
  totalGamesPlayed: 0,
  isMuted: false,
};

export const useGameStore = create<GameState>((set, get) => ({
  ...initialState,
  
  setScreen: (screen) => set({ currentScreen: screen }),
  
  startFullTest: () => {
    const firstGame = getRandomGameFromCategory(0);
    set({
      gameMode: 'fullTest',
      currentCategory: 0,
      currentMinigame: firstGame,
      categoryScores: [0, 0, 0, 0],
      categoryGamesPlayed: [firstGame, null, null, null],
      currentScreen: 'tutorial',
    });
  },
  
  startPractice: (minigameId) => {
    const game = MINIGAMES[minigameId];
    set({
      gameMode: 'practice',
      currentCategory: game.category as Category,
      currentMinigame: minigameId,
      categoryScores: [0, 0, 0, 0],
      currentScreen: 'tutorial',
    });
  },
  
  startNextCategory: () => {
    const state = get();
    const nextCategory = (state.currentCategory + 1) as Category;
    
    if (nextCategory > 3) {
      // All categories done - show summary
      set({ currentScreen: 'summary' });
    } else {
      const nextGame = getRandomGameFromCategory(nextCategory);
      const newGamesPlayed = [...state.categoryGamesPlayed] as [MinigameId | null, MinigameId | null, MinigameId | null, MinigameId | null];
      newGamesPlayed[nextCategory] = nextGame;
      
      set({
        currentCategory: nextCategory,
        currentMinigame: nextGame,
        categoryGamesPlayed: newGamesPlayed,
        currentScreen: 'tutorial',
      });
    }
  },
  
  startMinigame: () => {
    set({
      currentScreen: 'countdown',
      timeRemaining: TOTAL_GAME_TIME,
      currentCorrect: 0,
      currentIncorrect: 0,
      currentScore: 0,
    });
  },
  
  setTimeRemaining: (time) => set({ timeRemaining: time }),
  
  startTimer: () => set({ isTimerRunning: true }),
  
  stopTimer: () => set({ isTimerRunning: false }),
  
  tickTimer: (delta) => {
    const state = get();
    if (state.isTimerRunning) {
      const newTime = Math.max(state.timeRemaining - delta, 0);
      set({ timeRemaining: newTime });
      
      if (newTime <= 0) {
        set({ isTimerRunning: false, currentScreen: 'results' });
      }
    }
  },
  
  addCorrect: () => {
    const state = get();
    const game = MINIGAMES[state.currentMinigame];
    const newScore = Math.max(state.currentScore + game.correctPoints, 0);
    
    set({
      currentCorrect: state.currentCorrect + 1,
      currentScore: newScore,
    });
  },
  
  addIncorrect: () => {
    const state = get();
    const game = MINIGAMES[state.currentMinigame];
    const newScore = Math.max(state.currentScore + game.incorrectPoints, 0);
    
    set({
      currentIncorrect: state.currentIncorrect + 1,
      currentScore: newScore,
    });
  },
  
  finishMinigame: () => {
    const state = get();
    const newCategoryScores = [...state.categoryScores] as [number, number, number, number];
    newCategoryScores[state.currentCategory] = state.currentScore;
    
    set({
      categoryScores: newCategoryScores,
      totalGamesPlayed: state.totalGamesPlayed + 1,
      isTimerRunning: false,
    });
    
    if (state.gameMode === 'practice') {
      set({ currentScreen: 'results' });
    } else {
      set({ currentScreen: 'results' });
    }
  },
  
  toggleMute: () => set((state) => ({ isMuted: !state.isMuted })),
  
  resetGame: () => set(initialState),
  
  getTotalScore: () => {
    const state = get();
    return state.categoryScores.reduce((sum, score) => sum + score, 0);
  },
  
  getBrainType: () => {
    const state = get();
    const total = state.categoryScores.reduce((sum, score) => sum + score, 0);
    return getBrainType(total);
  },
}));
