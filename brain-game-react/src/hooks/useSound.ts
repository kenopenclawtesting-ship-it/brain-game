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
  | 'applause';

interface SoundConfig {
  src: string;
  loop?: boolean;
  volume?: number;
}

// Updated paths to use /assets/sounds/
const SOUND_CONFIG: Record<SoundName, SoundConfig> = {
  theme: { src: '/assets/sounds/theme-music.mp3', loop: true, volume: 0.5 },
  ingame: { src: '/assets/sounds/ingame-music.mp3', loop: true, volume: 0.5 },
  buttonMenu: { src: '/assets/sounds/button-menu.mp3', volume: 0.7 },
  buttonInGame: { src: '/assets/sounds/button-ingame.mp3', volume: 0.7 },
  timer: { src: '/assets/sounds/timer-sound.mp3', volume: 0.8 },
  start: { src: '/assets/sounds/start-sound.mp3', volume: 0.8 },
  correct: { src: '/assets/sounds/correct.mp3', volume: 0.6 },
  wrong: { src: '/assets/sounds/wrong.mp3', volume: 0.4 },
  applause: { src: '/assets/sounds/applause.mp3', volume: 0.7 },
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

  // Quick helper for menu button clicks
  const playClick = useCallback(() => {
    managerRef.current?.play('buttonMenu');
  }, []);

  return { play, stop, stopAll, fadeOut, playClick };
}

// Hook for playing correct/incorrect sounds with feedback
export function useFeedbackSound() {
  const { play } = useSound();
  
  const playCorrect = useCallback(() => play('correct'), [play]);
  const playIncorrect = useCallback(() => play('wrong'), [play]);
  
  return { playCorrect, playIncorrect };
}
