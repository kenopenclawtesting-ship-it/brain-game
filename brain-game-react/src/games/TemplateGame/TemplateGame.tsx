import React, { useEffect, useRef } from 'react';
import * as PIXI from 'pixi.js';
import { BaseGame } from '../../engine/BaseGame';
import { GameConfig, GameCallbacks, SpriteAsset } from '../../engine/types';
import { AnimationManager } from '../../engine/AnimationManager';
import { SpriteLoader } from '../../engine/SpriteLoader';
import { usePixiApp } from '../../engine/GameCanvas';

// Template game implementation
class TemplateGameLogic extends BaseGame {
  private circles: PIXI.Graphics[] = [];
  private targetCircle: PIXI.Graphics | null = null;
  private correctCircleIndex: number = 0;
  private uiText: PIXI.Text = new PIXI.Text();
  private scoreText: PIXI.Text = new PIXI.Text();
  private timerText: PIXI.Text = new PIXI.Text();

  async loadAssets(): Promise<void> {
    // Template game doesn't need external sprites
    // In real games, you would load sprites here:
    /*
    const sprites: SpriteAsset[] = [
      { name: 'background', path: '/sprites/bg.png', width: 640, height: 480 },
      { name: 'button', path: '/sprites/button.png', width: 100, height: 50 },
    ];
    await SpriteLoader.preloadGameSprites('template', sprites);
    */
    
    // Simulate loading delay
    await new Promise(resolve => setTimeout(resolve, 500));
  }

  initializeGame(): void {
    this.createUI();
    this.updateUI();
  }

  private createUI(): void {
    // Title text
    this.uiText.text = 'Click the RED circle!';
    this.uiText.style = new PIXI.TextStyle({
      fontSize: 24,
      fill: 0xFFFFFF,
      fontFamily: 'Arial',
      align: 'center',
    });
    this.uiText.anchor.set(0.5);
    this.uiText.x = this.app.screen.width / 2;
    this.uiText.y = 50;
    this.container.addChild(this.uiText);

    // Score text
    this.scoreText.style = new PIXI.TextStyle({
      fontSize: 18,
      fill: 0xFFFFFF,
      fontFamily: 'Arial',
    });
    this.scoreText.x = 20;
    this.scoreText.y = 20;
    this.container.addChild(this.scoreText);

    // Timer text
    this.timerText.style = new PIXI.TextStyle({
      fontSize: 18,
      fill: 0xFFFF00,
      fontFamily: 'Arial',
    });
    this.timerText.x = this.app.screen.width - 120;
    this.timerText.y = 20;
    this.container.addChild(this.timerText);
  }

  private updateUI(): void {
    this.scoreText.text = `Score: ${this.getScore() + this.getRoundScore()}`;
    this.timerText.text = `Time: ${Math.ceil(this.state.timeRemaining)}s`;
  }

  startRound(round: number): void {
    this.createCircles();
    this.startRoundTimer();
    
    // Update timer display every frame
    const updateTimer = () => {
      if (this.isTimerRunning) {
        this.updateUI();
        requestAnimationFrame(updateTimer);
      }
    };
    updateTimer();
  }

  private createCircles(): void {
    // Clear existing circles
    this.circles.forEach(circle => {
      this.container.removeChild(circle);
      circle.destroy();
    });
    this.circles = [];

    // Create 4 circles in a grid
    const difficulty = this.getDifficulty();
    const numCircles = Math.min(6, Math.floor(2 + difficulty)); // 3-6 circles based on difficulty
    const spacing = 120;
    const startX = (this.app.screen.width - (numCircles - 1) * spacing) / 2;
    const y = this.app.screen.height / 2;

    this.correctCircleIndex = Math.floor(Math.random() * numCircles);

    for (let i = 0; i < numCircles; i++) {
      const circle = new PIXI.Graphics();
      const isCorrect = i === this.correctCircleIndex;
      
      // Draw circle
      circle.beginFill(isCorrect ? 0xFF0000 : 0x0000FF); // Red for correct, blue for others
      circle.drawCircle(0, 0, 30);
      circle.endFill();
      
      circle.x = startX + i * spacing;
      circle.y = y;
      
      // Add click handler
      this.addClickHandler(circle, () => this.onCircleClick(i));
      
      this.container.addChild(circle);
      this.circles.push(circle);

      // Animate in
      AnimationManager.fadeIn(circle, { duration: 0.5, delay: i * 0.1 });
      AnimationManager.slideIn(circle, circle.x, circle.y - 50, { 
        duration: 0.8, 
        delay: i * 0.1 
      });
    }
  }

  private onCircleClick(index: number): void {
    const clickedCircle = this.circles[index];
    const isCorrect = index === this.correctCircleIndex;

    if (isCorrect) {
      // Correct answer
      const basePoints = 100;
      const timeBonus = Math.floor(this.state.timeRemaining * 2); // Bonus for quick answers
      const difficultyBonus = Math.floor(this.getDifficulty() * 10);
      const points = basePoints + timeBonus + difficultyBonus;
      
      this.addScore(points);
      
      // Animate success
      AnimationManager.scalePulse(clickedCircle);
      this.endRound(true);
    } else {
      // Wrong answer
      AnimationManager.shake(clickedCircle);
      // Continue playing - no penalty in template game
    }
    
    this.updateUI();
  }

  handleUserInput(input: any): void {
    // Template game handles input through click handlers
    // Other games might handle keyboard input here
  }

  protected onRoundStart(round: number): void {
    this.uiText.text = `Round ${round}: Click the RED circle!`;
  }

  protected onRoundEnd(roundData: any): void {
    // Show round results briefly
    const wasCorrect = roundData.correct;
    this.uiText.text = wasCorrect ? 'Correct!' : 'Time\'s up!';
    
    // Animate feedback
    if (wasCorrect) {
      AnimationManager.scalePulse(this.uiText);
    }
  }

  protected onGameOver(result: any): void {
    this.uiText.text = `Game Over! Final Score: ${result.score}`;
    
    // Clear circles
    this.circles.forEach(circle => {
      AnimationManager.fadeOut(circle, { duration: 0.5 });
    });
  }

  cleanup(): void {
    // Clean up resources
    this.circles.forEach(circle => {
      this.removeClickHandler(circle);
    });
    this.circles = [];
  }
}

// React component wrapper
interface TemplateGameProps {
  onGameEnd: (result: any) => void;
}

export function TemplateGame({ onGameEnd }: TemplateGameProps) {
  const app = usePixiApp();
  const gameRef = useRef<TemplateGameLogic | null>(null);

  useEffect(() => {
    if (!app) return;

    const config: GameConfig = {
      id: 'template',
      name: 'Template Game',
      category: 'Test',
      maxRounds: 4,
      timePerRound: 15,
      instructions: 'Click the red circle as fast as you can!',
    };

    const callbacks: GameCallbacks = {
      onRoundStart: (round) => {
        console.log(`Round ${round} started`);
      },
      onRoundEnd: (roundData) => {
        console.log('Round ended:', roundData);
      },
      onGameOver: (result) => {
        console.log('Game over:', result);
        onGameEnd(result);
      },
      onUserInput: (input) => {
        console.log('User input:', input);
      },
      onError: (error) => {
        console.error('Game error:', error);
      },
    };

    const game = new TemplateGameLogic(app, config, callbacks);
    gameRef.current = game;

    // Initialize and start the game
    game.initialize().then(() => {
      game.start();
    });

    // Cleanup on unmount
    return () => {
      if (gameRef.current) {
        gameRef.current.destroy();
        gameRef.current = null;
      }
    };
  }, [app, onGameEnd]);

  return null; // Game renders directly to PIXI canvas
}

export default TemplateGame;