// MeteorSequence (Asteroids) - FROM SOURCE.md
// Click floating meteors in ascending numerical order
import { useState, useEffect, useCallback, useRef } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

interface Meteor {
  id: number;
  value: number;
  displayValue: string;
  x: number;
  y: number;
  vx: number;
  vy: number;
  clicked: boolean;
}

const NUMBER_WORDS = ['ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE', 'TEN'];

export function MeteorSequenceGame() {
  const [meteors, setMeteors] = useState<Meteor[]>([]);
  const [nextValue, setNextValue] = useState(0);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const frameRef = useRef<number>(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateMeteors = useCallback(() => {
    // From SOURCE.md: numMeteors = Math.min(3 + Math.floor(totalCorrect / 4), 6)
    const numMeteors = Math.min(3 + Math.floor(totalCorrect / 4), 6);
    const maxNumber = Math.min(15 + totalCorrect * 2, 50);
    
    // Generate unique random numbers
    const values = new Set<number>();
    while (values.size < numMeteors) {
      values.add(Math.floor(Math.random() * maxNumber) + 1);
    }
    
    const sortedValues = Array.from(values).sort((a, b) => a - b);
    const useWords = totalCorrect >= 6 && Math.random() < 0.25;
    
    return sortedValues.map((value, index) => ({
      id: index,
      value,
      displayValue: useWords && value <= 10 ? NUMBER_WORDS[value - 1] : String(value),
      x: 50 + Math.random() * 300,
      y: 50 + Math.random() * 150,
      vx: (Math.random() - 0.5) * 2,
      vy: (Math.random() - 0.5) * 2,
      clicked: false,
    }));
  }, [totalCorrect]);

  useEffect(() => {
    setMeteors(generateMeteors());
    setNextValue(0);
  }, []);

  // Animation loop for meteor movement
  useEffect(() => {
    const animate = () => {
      setMeteors((prev) => prev.map((meteor) => {
        if (meteor.clicked) return meteor;
        
        let newX = meteor.x + meteor.vx;
        let newY = meteor.y + meteor.vy;
        let newVx = meteor.vx;
        let newVy = meteor.vy;
        
        // Bounce off walls
        if (newX < 30 || newX > 370) {
          newVx = -newVx;
          newX = Math.max(30, Math.min(370, newX));
        }
        if (newY < 30 || newY > 200) {
          newVy = -newVy;
          newY = Math.max(30, Math.min(200, newY));
        }
        
        return { ...meteor, x: newX, y: newY, vx: newVx, vy: newVy };
      }));
      
      frameRef.current = requestAnimationFrame(animate);
    };
    
    frameRef.current = requestAnimationFrame(animate);
    return () => cancelAnimationFrame(frameRef.current);
  }, []);

  const handleMeteorClick = (meteor: Meteor) => {
    if (meteor.clicked) return;
    
    const sortedValues = meteors
      .filter((m) => !m.clicked)
      .map((m) => m.value)
      .sort((a, b) => a - b);
    
    const expectedValue = sortedValues[0];
    
    if (meteor.value === expectedValue) {
      playCorrect();
      addCorrect();
      
      setMeteors((prev) => prev.map((m) => 
        m.id === meteor.id ? { ...m, clicked: true } : m
      ));
      
      // Check if all clicked
      const remaining = meteors.filter((m) => !m.clicked && m.id !== meteor.id);
      if (remaining.length === 0) {
        setTotalCorrect((prev) => prev + 1);
        setTimeout(() => {
          setMeteors(generateMeteors());
          setNextValue(0);
        }, 500);
      }
    } else {
      playIncorrect();
      addIncorrect();
    }
  };

  if (timeRemaining <= 0) return null;

  const sortedRemaining = meteors
    .filter((m) => !m.clicked)
    .sort((a, b) => a.value - b.value);
  const nextExpected = sortedRemaining[0]?.displayValue || '?';

  return (
    <GameContainer>
      <div className="flex flex-col items-center h-full">
        <div className="text-sm text-gray-500 mb-2">
          Click meteors in ascending order! Next: <strong>{nextExpected}</strong>
        </div>
        
        {/* Meteor field */}
        <div className="relative w-[400px] h-[250px] bg-gradient-to-b from-gray-900 to-blue-900 rounded-lg overflow-hidden">
          {/* Stars background */}
          {Array.from({ length: 30 }).map((_, i) => (
            <div
              key={i}
              className="absolute w-1 h-1 bg-white rounded-full opacity-50"
              style={{
                left: `${Math.random() * 100}%`,
                top: `${Math.random() * 100}%`,
              }}
            />
          ))}
          
          {/* Meteors */}
          {meteors.map((meteor) => (
            <motion.button
              key={meteor.id}
              onClick={() => handleMeteorClick(meteor)}
              className={`
                absolute transform -translate-x-1/2 -translate-y-1/2
                w-14 h-14 rounded-full flex items-center justify-center
                font-bold text-lg transition-all
                ${meteor.clicked 
                  ? 'bg-green-500/50 text-green-200 scale-75' 
                  : 'bg-orange-500 hover:bg-orange-400 text-white cursor-pointer'
                }
              `}
              style={{
                left: meteor.x,
                top: meteor.y,
              }}
              whileHover={!meteor.clicked ? { scale: 1.2 } : {}}
              whileTap={!meteor.clicked ? { scale: 0.9 } : {}}
              disabled={meteor.clicked}
            >
              {meteor.displayValue}
            </motion.button>
          ))}
        </div>
        
        <div className="mt-4 text-gray-500 text-sm">
          {meteors.filter((m) => !m.clicked).length} meteors remaining
        </div>
      </div>
    </GameContainer>
  );
}
