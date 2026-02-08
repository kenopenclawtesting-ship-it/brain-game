// Timer display component - DARK theme
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { TIMER_WARNING_THRESHOLD } from '../../lib/constants';

export function Timer() {
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const seconds = Math.ceil(timeRemaining / 1000);
  const isWarning = timeRemaining <= TIMER_WARNING_THRESHOLD && timeRemaining > 0;

  return (
    <div className="flex items-center gap-2">
      <div className="text-sm font-medium text-gray-400">TIME</div>
      <motion.div
        className={`
          text-4xl font-bold tabular-nums min-w-[80px] text-center
          ${isWarning ? 'text-red-500' : 'text-white'}
        `}
        style={{ 
          fontFamily: 'Baveuse, cursive',
          textShadow: isWarning ? '0 0 10px rgba(255,0,0,0.5)' : '0 0 10px rgba(255,255,255,0.3)'
        }}
        animate={isWarning ? { scale: [1, 1.1, 1] } : {}}
        transition={{ duration: 0.3, repeat: isWarning ? Infinity : 0 }}
      >
        {seconds}
      </motion.div>
    </div>
  );
}

// Compact timer bar with category color
export function TimerCompact({ categoryColor = '#3498db' }: { categoryColor?: string }) {
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const seconds = Math.ceil(timeRemaining / 1000);
  const isWarning = timeRemaining <= TIMER_WARNING_THRESHOLD && timeRemaining > 0;
  const progress = timeRemaining / 60000; // 60 seconds total

  return (
    <div 
      className="relative w-full h-8 rounded-full overflow-hidden"
      style={{ 
        background: 'rgba(0,0,0,0.5)',
        border: '2px solid rgba(255,255,255,0.1)'
      }}
    >
      <motion.div
        className="absolute inset-y-0 left-0"
        style={{
          background: isWarning 
            ? 'linear-gradient(90deg, #e74c3c 0%, #c0392b 100%)'
            : `linear-gradient(90deg, ${categoryColor} 0%, ${categoryColor}99 100%)`,
          boxShadow: `0 0 10px ${isWarning ? '#e74c3c' : categoryColor}`
        }}
        initial={{ width: '100%' }}
        animate={{ width: `${progress * 100}%` }}
        transition={{ duration: 0.1 }}
      />
      <div className="absolute inset-0 flex items-center justify-center">
        <span 
          className={`font-bold ${isWarning ? 'text-white' : 'text-white'}`}
          style={{ 
            fontFamily: 'Baveuse, cursive',
            textShadow: '1px 1px 2px rgba(0,0,0,0.5)'
          }}
        >
          {seconds}s
        </span>
      </div>
    </div>
  );
}
