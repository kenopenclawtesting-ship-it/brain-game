// MemorySequence (Action Sequence) (PRO) - FROM SOURCE.md
// Simon-says style memory game - watch switches light up, repeat the pattern
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const SWITCH_COLORS = [
  { base: '#3b82f6', lit: '#60a5fa', name: 'blue', image: '/assets/generated/memory-orb-blue.png' },
  { base: '#ef4444', lit: '#f87171', name: 'red', image: '/assets/generated/memory-orb-red.png' },
  { base: '#22c55e', lit: '#4ade80', name: 'green', image: '/assets/generated/memory-orb-green.png' },
  { base: '#eab308', lit: '#facc15', name: 'yellow', image: '/assets/generated/memory-orb-yellow.png' },
  { base: '#8b5cf6', lit: '#a78bfa', name: 'purple', image: '/assets/generated/memory-orb-purple.png' },
];

type Phase = 'showing' | 'input' | 'feedback';

export function MemorySequenceGame() {
  const [sequence, setSequence] = useState<number[]>([]);
  const [userSequence, setUserSequence] = useState<number[]>([]);
  const [phase, setPhase] = useState<Phase>('showing');
  const [showingIndex, setShowingIndex] = useState(-1);
  const [litSwitch, setLitSwitch] = useState<number | null>(null);
  const [numSwitches, setNumSwitches] = useState(4);
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateSequence = useCallback(() => {
    // From SOURCE.md: sequenceLength = 3 + Math.floor((totalCorrect + 1) / 3)
    const seqLength = Math.min(3 + Math.floor((totalCorrect + 1) / 3), 8);
    const switches = Math.min(4 + Math.floor(totalCorrect / 4), 5);
    
    // Generate sequence avoiding 3 repeats in a row
    const seq: number[] = [];
    for (let i = 0; i < seqLength; i++) {
      let next: number;
      do {
        next = Math.floor(Math.random() * switches);
      } while (
        seq.length >= 2 &&
        seq[seq.length - 1] === next &&
        seq[seq.length - 2] === next
      );
      seq.push(next);
    }
    
    setSequence(seq);
    setNumSwitches(switches);
    setUserSequence([]);
    setPhase('showing');
    setShowingIndex(-1);
  }, [totalCorrect]);

  useEffect(() => {
    generateSequence();
  }, []);

  // Show sequence animation
  useEffect(() => {
    if (phase !== 'showing') return;
    
    // Speed from SOURCE.md: sequenceDelay = Math.max(500 - totalCorrect * 15, 300)
    const delay = Math.max(500 - totalCorrect * 15, 300);
    
    let index = -1;
    const showNext = () => {
      index++;
      if (index >= sequence.length) {
        setLitSwitch(null);
        setPhase('input');
        return;
      }
      
      setShowingIndex(index);
      setLitSwitch(sequence[index]);
      
      setTimeout(() => {
        setLitSwitch(null);
        setTimeout(showNext, 150);
      }, delay);
    };
    
    setTimeout(showNext, 500);
  }, [phase, sequence, totalCorrect]);

  const handleSwitchClick = (switchIndex: number) => {
    if (phase !== 'input') return;
    
    // Light up briefly
    setLitSwitch(switchIndex);
    setTimeout(() => setLitSwitch(null), 200);
    
    const newUserSequence = [...userSequence, switchIndex];
    setUserSequence(newUserSequence);
    
    // Check if correct
    const expectedIndex = userSequence.length;
    if (switchIndex !== sequence[expectedIndex]) {
      playIncorrect();
      addIncorrect();
      generateSequence();
      return;
    }
    
    // Check if complete
    if (newUserSequence.length === sequence.length) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
      setTimeout(() => generateSequence(), 500);
    }
  };

  if (timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        <div
          className="text-sm text-gray-300 mb-6"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {phase === 'showing'
            ? 'Watch the sequence...'
            : `Repeat the sequence (${userSequence.length}/${sequence.length})`
          }
        </div>

        {/* Switches in a circle layout */}
        <div className="relative w-64 h-64 mb-6">
          <img
            src="/assets/generated/memory-grid-bg.png"
            className="absolute inset-0 w-full h-full object-cover rounded-full opacity-20"
            alt=""
          />
          {Array.from({ length: numSwitches }).map((_, idx) => {
            const angle = (idx / numSwitches) * 2 * Math.PI - Math.PI / 2;
            const x = Math.cos(angle) * 80 + 128;
            const y = Math.sin(angle) * 80 + 128;
            const color = SWITCH_COLORS[idx];
            const isLit = litSwitch === idx;

            return (
              <motion.button
                key={idx}
                onClick={() => handleSwitchClick(idx)}
                className="absolute w-16 h-16 rounded-full overflow-hidden"
                style={{
                  left: x - 32,
                  top: y - 32,
                  boxShadow: isLit ? `0 0 25px ${color.lit}` : '0 4px 8px rgba(0,0,0,0.3)',
                }}
                whileHover={phase === 'input' ? { scale: 1.1 } : {}}
                whileTap={phase === 'input' ? { scale: 0.9 } : {}}
                disabled={phase !== 'input'}
                animate={isLit ? { scale: 1.15 } : { scale: 1 }}
              >
                <img
                  src={isLit ? color.image : '/assets/generated/memory-orb-dim.png'}
                  className="w-full h-full object-cover"
                  style={{ filter: isLit ? 'brightness(1.3)' : 'brightness(0.6)' }}
                  alt=""
                />
              </motion.button>
            );
          })}

          {/* Center indicator */}
          <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-center z-10">
            <div className="text-2xl font-bold text-white" style={{ fontFamily: 'Baveuse, cursive', textShadow: '0 0 10px rgba(0,0,0,0.5)' }}>
              {phase === 'showing' ? showingIndex + 1 : userSequence.length}
            </div>
            <div className="text-xs text-gray-400">/ {sequence.length}</div>
          </div>
        </div>

        {/* Progress dots */}
        <div className="flex gap-1">
          {sequence.map((_, i) => (
            <div
              key={i}
              className="w-2 h-2 rounded-full"
              style={{
                background: phase === 'showing' && i <= showingIndex ? '#ffd700' :
                  phase === 'input' && i < userSequence.length ? '#22c55e' :
                  'rgba(255,255,255,0.2)',
                boxShadow: (phase === 'showing' && i <= showingIndex) || (phase === 'input' && i < userSequence.length)
                  ? '0 0 4px currentColor' : 'none',
              }}
            />
          ))}
        </div>
      </div>
    </GameContainer>
  );
}
