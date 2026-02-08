// Sound system using Howler.js - matches Flash sound triggers from SOURCE.md
import { useCallback, useEffect, useRef } from 'react';
import { Howl } from 'howler';
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

// Singleton sound manager
class SoundManager {
  private sounds: Map<SoundName, Howl> = new Map();
  private muted = false;

  constructor() {
    // Pre-load all sounds
    Object.entries(SOUND_CONFIG).forEach(([name, config]) => {
      const sound = new Howl({
        src: [config.src],
        loop: config.loop || false,
        volume: config.volume || 1,
        preload: true,
      });
      this.sounds.set(name as SoundName, sound);
    });
  }

  play(name: SoundName) {
    if (this.muted) return;
    const sound = this.sounds.get(name);
    if (sound) {
      sound.play();
    }
  }

  stop(name: SoundName) {
    const sound = this.sounds.get(name);
    if (sound) {
      sound.stop();
    }
  }

  stopAll() {
    this.sounds.forEach(sound => sound.stop());
  }

  setMuted(muted: boolean) {
    this.muted = muted;
    Howler.mute(muted);
  }

  fadeOut(name: SoundName, duration = 500) {
    const sound = this.sounds.get(name);
    if (sound) {
      sound.fade(sound.volume(), 0, duration);
      setTimeout(() => sound.stop(), duration);
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
