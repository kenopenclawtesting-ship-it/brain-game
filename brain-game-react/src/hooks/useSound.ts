// Sound system using Howler.js - matches Flash sound triggers from SOURCE.md
import { useCallback, useEffect, useRef } from 'react';
import { Howl, Howler } from 'howler';
import { useGameStore } from '../store/gameStore';

type SoundName = 
  | 'theme'
  | 'ingame'
  | 'buttonMenu'
  | 'buttonInGame'
  | 'timer'
  | 'start'
  | 'correct'
  | 'wrong'
  | 'applause'
  | 'cheer'
  | 'scoreCount'
  | 'scoreCountEnd';

interface SoundConfig {
  src: string;
  loop?: boolean;
  volume?: number;
}

const SOUND_CONFIG: Record<SoundName, SoundConfig> = {
  theme: { src: '/sounds/ThemeMusic.mp3', loop: true, volume: 0.5 },
  ingame: { src: '/sounds/IngameMusic.mp3', loop: true, volume: 0.5 },
  buttonMenu: { src: '/sounds/ButtonMenu.mp3', volume: 0.7 },
  buttonInGame: { src: '/sounds/ButtonInGame.mp3', volume: 0.7 },
  timer: { src: '/sounds/TimerSound.mp3', volume: 0.8 },
  start: { src: '/sounds/StartSound.mp3', volume: 0.8 },
  correct: { src: '/sounds/Correct.mp3', volume: 0.6 },
  wrong: { src: '/sounds/Wrong.mp3', volume: 0.6 },
  applause: { src: '/sounds/ApplauseSound.mp3', volume: 0.7 },
  cheer: { src: '/sounds/CrowdCheerSound.mp3', volume: 0.7 },
  scoreCount: { src: '/sounds/ScoreCountSound.mp3', volume: 0.5 },
  scoreCountEnd: { src: '/sounds/ScoreCountEndSound.mp3', volume: 0.6 },
};

// Singleton sound manager with lazy loading
class SoundManager {
  private sounds: Map<SoundName, Howl> = new Map();
  private muted = false;
  private initialized = false;

  init() {
    if (this.initialized) return;
    this.initialized = true;
    
    try {
      // Pre-load all sounds
      Object.entries(SOUND_CONFIG).forEach(([name, config]) => {
        try {
          const sound = new Howl({
            src: [config.src],
            loop: config.loop || false,
            volume: config.volume || 1,
            preload: true,
            onloaderror: (id, err) => {
              console.warn(`Failed to load sound ${name}:`, err);
            },
          });
          this.sounds.set(name as SoundName, sound);
        } catch (e) {
          console.warn(`Error creating sound ${name}:`, e);
        }
      });
    } catch (e) {
      console.warn('Error initializing sound manager:', e);
    }
  }

  play(name: SoundName) {
    if (this.muted) return;
    try {
      const sound = this.sounds.get(name);
      if (sound) {
        sound.play();
      }
    } catch (e) {
      console.warn(`Error playing sound ${name}:`, e);
    }
  }

  stop(name: SoundName) {
    try {
      const sound = this.sounds.get(name);
      if (sound) {
        sound.stop();
      }
    } catch (e) {
      console.warn(`Error stopping sound ${name}:`, e);
    }
  }

  stopAll() {
    this.sounds.forEach(sound => {
      try {
        sound.stop();
      } catch (e) {
        // ignore
      }
    });
  }

  setMuted(muted: boolean) {
    this.muted = muted;
    try {
      Howler.mute(muted);
    } catch (e) {
      // ignore
    }
  }

  fadeOut(name: SoundName, duration = 500) {
    try {
      const sound = this.sounds.get(name);
      if (sound) {
        sound.fade(sound.volume(), 0, duration);
        setTimeout(() => sound.stop(), duration);
      }
    } catch (e) {
      // ignore
    }
  }
}

let soundManager: SoundManager | null = null;

function getSoundManager(): SoundManager {
  if (!soundManager) {
    soundManager = new SoundManager();
  }
  return soundManager;
}

export function useSound() {
  const isMuted = useGameStore((state) => state.isMuted);
  const managerRef = useRef<SoundManager | null>(null);

  useEffect(() => {
    managerRef.current = getSoundManager();
    // Lazy init sounds on first use
    managerRef.current.init();
  }, []);

  useEffect(() => {
    managerRef.current?.setMuted(isMuted);
  }, [isMuted]);

  const play = useCallback((name: SoundName) => {
    managerRef.current?.play(name);
  }, []);

  const stop = useCallback((name: SoundName) => {
    managerRef.current?.stop(name);
  }, []);

  const stopAll = useCallback(() => {
    managerRef.current?.stopAll();
  }, []);

  const fadeOut = useCallback((name: SoundName, duration?: number) => {
    managerRef.current?.fadeOut(name, duration);
  }, []);

  return { play, stop, stopAll, fadeOut };
}

// Hook for playing correct/incorrect sounds with feedback
export function useFeedbackSound() {
  const { play } = useSound();
  
  const playCorrect = useCallback(() => play('correct'), [play]);
  const playIncorrect = useCallback(() => play('wrong'), [play]);
  
  return { playCorrect, playIncorrect };
}
