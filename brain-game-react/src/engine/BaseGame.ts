import * as PIXI from 'pixi.js';
import { gsap } from 'gsap';
import { GameConfig, GameState, GameResult, GameCallbacks, RoundData, SpriteAsset } from './types';
import { AnimationManager } from './AnimationManager';
import { SpriteLoader } from './SpriteLoader';
import { useGameState } from './GameStateManager';

export abstract class BaseGame {
  protected app: PIXI.Application;
  protected config: GameConfig;
  protected state: GameState;
  protected callbacks: GameCallbacks;
  protected container: PIXI.Container;
  protected roundTimer: number = 0;
  protected roundStartTime: number = 0;
  protected gameStartTime: number = 0;
  protected isTimerRunning: boolean = false;
  protected timerInterval: number | null = null;

  // Score tracking
  protected currentRoundScore: number = 0;
  protected totalScore: number = 0;
  protected roundScores: number[] = [];
  
  // Difficulty scaling
  protected baseDifficulty: number = 1;
  protected difficultyMultiplier: number = 0.25; // 25% harder each round

  constructor(app: PIXI.Application, config: GameConfig, callbacks: GameCallbacks) {
    this.app = app;
    this.config = config;
    this.callbacks = callbacks;
    this.container = new PIXI.Container();
    this.app.stage.addChild(this.container);

    // Initialize game state
    this.state = {
      phase: 'INTRO',
      round: 1,
      score: 0,
      timeRemaining: config.timePerRound,
      isLoading: true,
    };

    this.gameStartTime = Date.now();
  }

  /**
   * Abstract methods that each game must implement
   */
  abstract async loadAssets(): Promise<void>;
  abstract initializeGame(): void;
  abstract startRound(round: number): void;
  abstract handleUserInput(input: any): void;
  abstract cleanup(): void;

  /**
   * Override these for custom round behavior
   */
  protected onRoundStart(round: number): void {
    // Default implementation
  }

  protected onRoundEnd(roundData: RoundData): void {
    // Default implementation
  }

  protected onGameOver(result: GameResult): void {
    // Default implementation
  }

  /**
   * Game lifecycle management
   */
  async initialize(): Promise<void> {
    try {
      this.setState({ phase: 'INTRO', isLoading: true });
      await this.loadAssets();
      this.initializeGame();
      this.setState({ phase: 'READY', isLoading: false });
    } catch (error) {
      this.handleError(`Failed to initialize game: ${error}`);
    }
  }

  start(): void {
    if (this.state.phase !== 'READY') {
      this.handleError('Game not ready to start');
      return;
    }

    this.setState({ phase: 'PLAYING' });
    this.startRound(1);
  }

  /**
   * Round management
   */
  protected startRoundTimer(): void {
    this.roundStartTime = Date.now();
    this.roundTimer = this.config.timePerRound;
    this.isTimerRunning = true;
    
    this.timerInterval = window.setInterval(() => {
      this.roundTimer -= 0.1;
      this.setState({ timeRemaining: Math.max(0, this.roundTimer) });
      
      if (this.roundTimer <= 0) {
        this.endRound(false); // Time's up
      }
    }, 100);

    this.onRoundStart(this.state.round);
    this.callbacks.onRoundStart(this.state.round);
  }

  protected endRound(correct: boolean): void {
    if (!this.isTimerRunning) return;
    
    this.isTimerRunning = false;
    if (this.timerInterval) {
      clearInterval(this.timerInterval);
      this.timerInterval = null;
    }

    const timeUsed = this.config.timePerRound - this.roundTimer;
    const roundData: RoundData = {
      round: this.state.round,
      score: this.currentRoundScore,
      maxScore: this.getMaxRoundScore(),
      timeUsed,
      correct,
    };

    // Add round score to total
    this.roundScores.push(this.currentRoundScore);
    this.totalScore += this.currentRoundScore;
    this.setState({ 
      score: this.totalScore,
      phase: 'ROUND_END'
    });

    this.onRoundEnd(roundData);
    this.callbacks.onRoundEnd(roundData);

    // Check if game is over
    if (this.state.round >= this.config.maxRounds) {
      setTimeout(() => this.endGame(), 1000);
    } else {
      setTimeout(() => this.nextRound(), 1500);
    }
  }

  protected nextRound(): void {
    this.currentRoundScore = 0;
    this.setState({ 
      round: this.state.round + 1,
      phase: 'PLAYING',
      timeRemaining: this.config.timePerRound,
    });
    this.startRound(this.state.round);
  }

  protected endGame(): void {
    this.setState({ phase: 'GAME_OVER' });
    
    const totalTime = Date.now() - this.gameStartTime;
    const result: GameResult = {
      gameId: this.config.id,
      score: this.totalScore,
      maxScore: this.getMaxGameScore(),
      roundScores: [...this.roundScores],
      timePlayed: totalTime / 1000,
      accuracy: this.calculateAccuracy(),
    };

    this.onGameOver(result);
    this.callbacks.onGameOver(result);
  }

  /**
   * Scoring methods
   */
  protected addScore(points: number): void {
    this.currentRoundScore += points;
    this.setState({ score: this.totalScore + this.currentRoundScore });
  }

  protected getScore(): number {
    return this.totalScore;
  }

  protected getRoundScore(): number {
    return this.currentRoundScore;
  }

  protected getMaxRoundScore(): number {
    return 100; // Override in specific games
  }

  protected getMaxGameScore(): number {
    return this.getMaxRoundScore() * this.config.maxRounds;
  }

  protected calculateAccuracy(): number {
    if (this.roundScores.length === 0) return 0;
    const totalPossible = this.getMaxRoundScore() * this.roundScores.length;
    return totalPossible > 0 ? (this.totalScore / totalPossible) * 100 : 0;
  }

  /**
   * Difficulty scaling
   */
  protected getDifficulty(): number {
    return this.baseDifficulty + (this.state.round - 1) * this.difficultyMultiplier;
  }

  /**
   * Animation helpers
   */
  protected createTimeline(): gsap.core.Timeline {
    return AnimationManager.createTimeline();
  }

  protected killTimelines(): void {
    AnimationManager.killAll();
  }

  /**
   * State management
   */
  protected setState(newState: Partial<GameState>): void {
    this.state = { ...this.state, ...newState };
  }

  protected getState(): GameState {
    return { ...this.state };
  }

  /**
   * Input handling
   */
  protected processInput(input: any): void {
    if (this.state.phase !== 'PLAYING') return;
    
    this.handleUserInput(input);
    this.callbacks.onUserInput(input);
  }

  /**
   * Error handling
   */
  protected handleError(message: string): void {
    console.error(`[${this.config.name}] ${message}`);
    this.setState({ error: message });
    this.callbacks.onError(message);
  }

  /**
   * Cleanup resources
   */
  destroy(): void {
    this.killTimelines();
    
    if (this.timerInterval) {
      clearInterval(this.timerInterval);
    }
    
    if (this.container.parent) {
      this.container.parent.removeChild(this.container);
    }
    
    this.container.destroy({ children: true });
    this.cleanup();
  }

  /**
   * Helper methods for common game operations
   */
  protected centerSprite(sprite: PIXI.Sprite): void {
    sprite.anchor.set(0.5);
    sprite.x = this.app.screen.width / 2;
    sprite.y = this.app.screen.height / 2;
  }

  protected addClickHandler(target: PIXI.DisplayObject, handler: () => void): void {
    target.eventMode = 'static';
    target.cursor = 'pointer';
    target.on('pointerdown', handler);
  }

  protected removeClickHandler(target: PIXI.DisplayObject): void {
    target.off('pointerdown');
    target.eventMode = 'auto';
    target.cursor = 'default';
  }
}