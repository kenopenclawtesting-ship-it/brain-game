// Timer display component - shows remaining seconds with warning state
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { TIMER_WARNING_THRESHOLD } from '../../lib/constants';

export function Timer() {
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const seconds = Math.ceil(timeRemaining / 1000);
  const isWarning = timeRemaining <= TIMER_WARNING_THRESHOLD && timeRemaining > 0;

  return (
    <div className="flex items-center gap-2">
      <div className="text-sm font-medium text-gray-600">TIME</div>
      <motion.div
        className={`
          text-4xl font-bold tabular-nums min-w-[80px] text-center
          ${isWarning ? 'text-red-500' : 'text-gray-800'}
        `}
        animate={isWarning ? { scale: [1, 1.1, 1] } : {}}
        transition={{ duration: 0.3, repeat: isWarning ? Infinity : 0 }}
      >
        {seconds}
      </motion.div>
    </div>
  );
}

// Compact timer for in-game UI
export function TimerCompact() {
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const seconds = Math.ceil(timeRemaining / 1000);
  const isWarning = timeRemaining <= TIMER_WARNING_THRESHOLD && timeRemaining > 0;
  const progress = timeRemaining / 60000; // 60 seconds total

  return (
    <div className="relative w-full h-8 bg-gray-200 rounded-full overflow-hidden">
      <motion.div
        className={`absolute inset-y-0 left-0 ${isWarning ? 'bg-red-500' : 'bg-green-500'}`}
        initial={{ width: '100%' }}
        animate={{ width: `${progress * 100}%` }}
        transition={{ duration: 0.1 }}
      />
      <div className="absolute inset-0 flex items-center justify-center">
        <span className={`font-bold ${isWarning ? 'text-white' : 'text-gray-800'}`}>
          {seconds}s
        </span>
      </div>
    </div>
  );
}
