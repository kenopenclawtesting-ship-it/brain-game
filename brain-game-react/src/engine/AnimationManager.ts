import { gsap } from 'gsap';
import * as PIXI from 'pixi.js';
import { AnimationConfig, TweenTarget } from './types';

class AnimationManagerClass {
  private timelines: Set<gsap.core.Timeline> = new Set();
  private tweens: Set<gsap.core.Tween> = new Set();

  /**
   * Create a new timeline and track it for cleanup
   */
  createTimeline(): gsap.core.Timeline {
    const timeline = gsap.timeline();
    this.timelines.add(timeline);
    
    // Remove from tracking when complete
    timeline.eventCallback('onComplete', () => {
      this.timelines.delete(timeline);
    });
    
    return timeline;
  }

  /**
   * Kill all animations and timelines
   */
  killAll(): void {
    this.timelines.forEach(timeline => timeline.kill());
    this.tweens.forEach(tween => tween.kill());
    this.timelines.clear();
    this.tweens.clear();
  }

  /**
   * Fade in animation
   */
  fadeIn(target: PIXI.DisplayObject, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 0.5, ease = "power2.out", delay = 0 } = config;
    target.alpha = 0;
    
    const tween = gsap.to(target, {
      alpha: 1,
      duration,
      ease,
      delay,
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Fade out animation
   */
  fadeOut(target: PIXI.DisplayObject, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 0.5, ease = "power2.out", delay = 0 } = config;
    
    const tween = gsap.to(target, {
      alpha: 0,
      duration,
      ease,
      delay,
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Slide in from position
   */
  slideIn(target: PIXI.DisplayObject, fromX: number, fromY: number, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 0.8, ease = "back.out(1.7)", delay = 0 } = config;
    const targetX = target.x;
    const targetY = target.y;
    
    target.x = fromX;
    target.y = fromY;
    
    const tween = gsap.to(target, {
      x: targetX,
      y: targetY,
      duration,
      ease,
      delay,
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Slide out to position
   */
  slideOut(target: PIXI.DisplayObject, toX: number, toY: number, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 0.5, ease = "power2.in", delay = 0 } = config;
    
    const tween = gsap.to(target, {
      x: toX,
      y: toY,
      duration,
      ease,
      delay,
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Scale pulse animation (like Flash button effects)
   */
  scalePulse(target: PIXI.DisplayObject, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 0.3, ease = "power2.out" } = config;
    const originalScale = target.scale.x;
    
    const tween = gsap.to(target.scale, {
      x: originalScale * 1.1,
      y: originalScale * 1.1,
      duration: duration / 2,
      ease,
      yoyo: true,
      repeat: 1,
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Shake animation for wrong answers
   */
  shake(target: PIXI.DisplayObject, intensity: number = 5, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 0.5, ease = "power2.out" } = config;
    const originalX = target.x;
    const originalY = target.y;
    
    const tween = gsap.to(target, {
      x: `+=${intensity}`,
      y: `+=${intensity * 0.5}`,
      duration: duration / 8,
      ease,
      yoyo: true,
      repeat: 7,
      onComplete: () => {
        target.x = originalX;
        target.y = originalY;
      }
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Number counting animation
   */
  countUp(target: { value: number }, from: number, to: number, onUpdate: (value: number) => void, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 1, ease = "power2.out", delay = 0 } = config;
    target.value = from;
    
    const tween = gsap.to(target, {
      value: to,
      duration,
      ease,
      delay,
      onUpdate: () => {
        onUpdate(Math.round(target.value));
      }
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Custom tween with any properties
   */
  to(target: any, properties: TweenTarget & { duration: number; ease?: string; delay?: number; onComplete?: () => void }): gsap.core.Tween {
    const tween = gsap.to(target, properties);
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Set properties immediately
   */
  set(target: any, properties: TweenTarget): gsap.core.Tween {
    return gsap.set(target, properties);
  }

  /**
   * Stagger animation for multiple objects
   */
  staggerFrom(targets: PIXI.DisplayObject[], fromProps: TweenTarget, config: Partial<AnimationConfig & { stagger: number }> = {}): gsap.core.Timeline {
    const { duration = 0.5, ease = "power2.out", stagger = 0.1, delay = 0 } = config;
    const timeline = this.createTimeline();
    
    timeline.staggerFrom(targets, duration, {
      ...fromProps,
      ease,
    }, stagger, delay);
    
    return timeline;
  }

  /**
   * Create a looping animation
   */
  loop(target: PIXI.DisplayObject, properties: TweenTarget, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 1, ease = "none" } = config;
    
    const tween = gsap.to(target, {
      ...properties,
      duration,
      ease,
      repeat: -1,
      yoyo: true,
    });
    
    this.tweens.add(tween);
    return tween;
  }

  /**
   * Rotation animation
   */
  spin(target: PIXI.DisplayObject, rotations: number = 1, config: Partial<AnimationConfig> = {}): gsap.core.Tween {
    const { duration = 1, ease = "none", repeat = -1 } = config;
    
    const tween = gsap.to(target, {
      rotation: `+=${Math.PI * 2 * rotations}`,
      duration,
      ease,
      repeat,
    });
    
    this.tweens.add(tween);
    return tween;
  }
}

// Export singleton instance
export const AnimationManager = new AnimationManagerClass();