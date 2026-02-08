// Game timer hook - 60 second countdown with warning sounds
import { useEffect, useRef, useCallback } from 'react';
import { useGameStore } from '../store/gameStore';
import { useSound } from './useSound';
import { TIMER_WARNING_THRESHOLD, TOTAL_GAME_TIME } from '../lib/constants';

export function useGameTimer() {
  const { timeRemaining, isTimerRunning, tickTimer, startTimer, stopTimer, setTimeRemaining } = useGameStore();
  const { play: playSound } = useSound();
  
  const lastTickRef = useRef<number>(0);
  const lastWarningSecond = useRef<number>(11); // Track which warning second we last played
  const frameRef = useRef<number>(0);

  const tick = useCallback((timestamp: number) => {
    if (!lastTickRef.current) {
      lastTickRef.current = timestamp;
    }
    
    const delta = timestamp - lastTickRef.current;
    lastTickRef.current = timestamp;
    
    tickTimer(delta);
    
    // Check for timer warning sound (last 10 seconds)
    const currentTimeRemaining = useGameStore.getState().timeRemaining;
    const currentSecond = Math.ceil(currentTimeRemaining / 1000);
    
    if (currentTimeRemaining <= TIMER_WARNING_THRESHOLD && currentTimeRemaining > 0) {
      if (currentSecond < lastWarningSecond.current) {
        playSound('timer');
        lastWarningSecond.current = currentSecond;
      }
    }
    
    if (useGameStore.getState().isTimerRunning) {
      frameRef.current = requestAnimationFrame(tick);
    }
  }, [tickTimer, playSound]);

  useEffect(() => {
    if (isTimerRunning) {
      lastTickRef.current = 0;
      lastWarningSecond.current = 11;
      frameRef.current = requestAnimationFrame(tick);
    } else {
      if (frameRef.current) {
        cancelAnimationFrame(frameRef.current);
      }
    }
    
    return () => {
      if (frameRef.current) {
        cancelAnimationFrame(frameRef.current);
      }
    };
  }, [isTimerRunning, tick]);

  const reset = useCallback(() => {
    setTimeRemaining(TOTAL_GAME_TIME);
    lastWarningSecond.current = 11;
  }, [setTimeRemaining]);

  return {
    timeRemaining,
    isRunning: isTimerRunning,
    start: startTimer,
    stop: stopTimer,
    reset,
    seconds: Math.ceil(timeRemaining / 1000),
  };
}
