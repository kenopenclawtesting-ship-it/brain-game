// MeteorSequence (Asteroids) - FROM SOURCE.md
// Click floating meteors in ascending numerical order
// CORRECT_SCORE: 11, INCORRECT_SCORE: -11
import { useState, useEffect, useCallback, useRef } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
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
  rotation: number;
  rotationSpeed: number;
  clicked: boolean;
  radius: number;
}

// Number words for display variety (from ActionScript NUM_TO_STRING)
const NUMBER_WORDS = ['ZERO', 'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE', 'TEN'];

// Meteor AI-generated images
const METEOR_IMAGES = [
  '/assets/generated/meteor-red.png',
  '/assets/generated/meteor-blue.png',
  '/assets/generated/meteor-green.png',
  '/assets/generated/meteor-yellow.png',
  '/assets/generated/meteor-purple.png',
];

export function MeteorSequenceGame() {
  const [meteors, setMeteors] = useState<Meteor[]>([]);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [useLetters, setUseLetters] = useState(false);
  const frameRef = useRef<number>(0);
  const starsRef = useRef<Array<{x: number, y: number, size: number, opacity: number}>>([]);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  // Generate stars once
  useEffect(() => {
    starsRef.current = Array.from({ length: 50 }).map(() => ({
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: 1 + Math.random() * 2,
      opacity: 0.3 + Math.random() * 0.7,
    }));
  }, []);

  const generateMeteors = useCallback(() => {
    // From ActionScript: numMeteors = min(3 + floor(totalCorrect / 4), 6)
    const numMeteors = Math.min(3 + Math.floor(totalCorrect / 4), 6);
    
    // Speed increases with difficulty
    const speedMultiplier = Math.min(1 + totalCorrect / 10, 3);
    
    // At round 2 with 25% chance: use LETTERS (A-Z)
    const shouldUseLetters = totalCorrect % 4 === 2 && Math.random() < 0.25;
    setUseLetters(shouldUseLetters);
    
    // Max number range increases with difficulty
    const maxNumber = shouldUseLetters ? 26 : Math.min(15 + totalCorrect * 5, 100);
    
    // Generate unique random values (avoiding 6 and 9 which look similar)
    const values = new Set<number>();
    while (values.size < numMeteors) {
      const num = Math.floor(Math.random() * maxNumber);
      const numStr = num.toString();
      // Skip numbers containing 6 or 9 (as per ActionScript)
      if (!numStr.includes('6') && !numStr.includes('9')) {
        values.add(num);
      }
    }
    
    const sortedValues = Array.from(values).sort((a, b) => a - b);
    
    // Determine display mode: letters, words, or numbers
    const useWords = !shouldUseLetters && totalCorrect >= 5 && Math.random() < 0.3;
    
    return sortedValues.map((value, index) => {
      let displayValue: string;
      if (shouldUseLetters) {
        displayValue = String.fromCharCode(65 + value); // A-Z
      } else if (useWords && value < NUMBER_WORDS.length && Math.random() < 0.5) {
        displayValue = NUMBER_WORDS[value];
      } else {
        displayValue = String(value);
      }
      
      return {
        id: index,
        value,
        displayValue,
        x: 40 + Math.random() * 320,
        y: 40 + Math.random() * 160,
        vx: (Math.random() - 0.5) * 2 * speedMultiplier,
        vy: (Math.random() - 0.5) * 2 * speedMultiplier,
        rotation: Math.random() * 360,
        rotationSpeed: (Math.random() - 0.5) * 4,
        clicked: false,
        radius: 28,
      };
    });
  }, [totalCorrect]);

  useEffect(() => {
    setMeteors(generateMeteors());
  }, []);

  // Animation loop for meteor movement with collision detection
  useEffect(() => {
    const animate = () => {
      setMeteors((prev) => {
        const updated = prev.map((meteor) => {
          if (meteor.clicked) return meteor;
          
          let newX = meteor.x + meteor.vx;
          let newY = meteor.y + meteor.vy;
          let newVx = meteor.vx;
          let newVy = meteor.vy;
          
          // Bounce off walls
          if (newX < 35 || newX > 365) {
            newVx = -newVx;
            newX = Math.max(35, Math.min(365, newX));
          }
          if (newY < 35 || newY > 205) {
            newVy = -newVy;
            newY = Math.max(35, Math.min(205, newY));
          }
          
          return { 
            ...meteor, 
            x: newX, 
            y: newY, 
            vx: newVx, 
            vy: newVy,
            rotation: meteor.rotation + meteor.rotationSpeed,
          };
        });
        
        // Collision detection between meteors (from ActionScript)
        for (let i = 0; i < updated.length; i++) {
          for (let j = i + 1; j < updated.length; j++) {
            const m1 = updated[i];
            const m2 = updated[j];
            if (m1.clicked || m2.clicked) continue;
            
            const dx = m2.x - m1.x;
            const dy = m2.y - m1.y;
            const dist = Math.sqrt(dx * dx + dy * dy);
            const minDist = m1.radius + m2.radius;
            
            if (dist < minDist && dist > 0) {
              // Collision response - swap velocity components
              const nx = dx / dist;
              const ny = dy / dist;
              const dvx = m1.vx - m2.vx;
              const dvy = m1.vy - m2.vy;
              const dvn = dvx * nx + dvy * ny;
              
              if (dvn > 0) {
                updated[i] = { ...m1, vx: m1.vx - dvn * nx, vy: m1.vy - dvn * ny };
                updated[j] = { ...m2, vx: m2.vx + dvn * nx, vy: m2.vy + dvn * ny };
              }
            }
          }
        }
        
        return updated;
      });
      
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
        }, 500);
      }
    } else {
      playIncorrect();
      addIncorrect();
      // Reset on wrong answer
      setTimeout(() => {
        setMeteors(generateMeteors());
      }, 500);
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
        <div 
          className="text-sm text-gray-300 mb-2"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Click {useLetters ? 'letters' : 'meteors'} in order: <span className="text-yellow-400 font-bold">{nextExpected}</span>
        </div>
        
        {/* Meteor field - space background */}
        <div
          className="relative w-[400px] h-[240px] rounded-xl overflow-hidden"
          style={{ boxShadow: 'inset 0 0 50px rgba(0,0,50,0.5)' }}
        >
          <img
            src="/assets/generated/space-bg-game.png"
            className="absolute inset-0 w-full h-full object-cover"
            alt=""
          />

          {/* Meteors */}
          <AnimatePresence>
            {meteors.map((meteor) => (
              <motion.button
                key={meteor.id}
                onClick={() => handleMeteorClick(meteor)}
                initial={{ scale: 0, opacity: 0 }}
                animate={{
                  scale: meteor.clicked ? 0 : 1,
                  opacity: meteor.clicked ? 0 : 1,
                  x: meteor.x - 28,
                  y: meteor.y - 28,
                  rotate: meteor.rotation,
                }}
                exit={{ scale: 0, opacity: 0 }}
                transition={{
                  x: { duration: 0.016, ease: 'linear' },
                  y: { duration: 0.016, ease: 'linear' },
                  scale: { duration: 0.3 },
                  opacity: { duration: 0.3 },
                }}
                className="absolute w-14 h-14 flex items-center justify-center font-bold cursor-pointer"
                style={{
                  fontFamily: 'Baveuse, cursive',
                  fontSize: meteor.displayValue.length > 3 ? '10px' : '16px',
                  color: 'white',
                  textShadow: '1px 1px 3px black',
                }}
                whileHover={!meteor.clicked ? { scale: 1.15, filter: 'brightness(1.3)' } : {}}
                whileTap={!meteor.clicked ? { scale: 0.9 } : {}}
                disabled={meteor.clicked}
              >
                <img
                  src={METEOR_IMAGES[meteor.id % METEOR_IMAGES.length]}
                  className="absolute inset-0 w-full h-full object-contain"
                  draggable={false}
                  alt=""
                />
                <span className="relative z-10">{meteor.displayValue}</span>
              </motion.button>
            ))}
          </AnimatePresence>
        </div>
        
        <div 
          className="mt-3 text-gray-400 text-sm"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {meteors.filter((m) => !m.clicked).length} remaining
        </div>
      </div>
    </GameContainer>
  );
}
