// CubeCounter Game - FROM SOURCE.md
// Count 3D cubes in an isometric view, including hidden ones
// CORRECT_SCORE: 49, INCORRECT_SCORE: -33
import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

interface CubeStructure {
  grid: number[][]; // Height at each x,y position
  totalCubes: number;
  baseWidth: number;
}

// Cube colors that alternate for visibility
const CUBE_COLORS = ['#60a5fa', '#818cf8', '#a78bfa', '#c084fc', '#e879f9'];

export function CubeCounterGame() {
  const [structure, setStructure] = useState<CubeStructure | null>(null);
  const [input, setInput] = useState('');
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [showCubes, setShowCubes] = useState(false);
  const [feedback, setFeedback] = useState<'correct' | 'incorrect' | null>(null);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateStructure = useCallback((): CubeStructure => {
    // From ActionScript: difficulty = totalCorrect / 1.5
    const difficulty = Math.floor(totalCorrect / 1.5);
    
    // baseWidth = rnd(2, 5 + floor(difficulty/8))
    const baseWidthBonus = Math.floor(difficulty / 8);
    const baseWidth = 2 + Math.floor(Math.random() * (3 + baseWidthBonus));
    
    // maxHeight = rnd(max(floor(difficulty/8)+1, 3), MAX_HEIGHT+1) where MAX_HEIGHT=4
    const minHeight = Math.max(Math.floor(difficulty / 8) + 1, 3);
    const maxHeight = Math.min(minHeight + Math.floor(Math.random() * 2), 4);
    
    // numBlocks = min(rnd(2,6) + difficulty, baseWidth^2 * maxHeight)
    const maxPossibleCubes = baseWidth * baseWidth * maxHeight;
    const targetCubes = Math.min(
      2 + Math.floor(Math.random() * 4) + difficulty,
      maxPossibleCubes
    );
    
    // Build the structure ensuring cubes can't float
    const grid: number[][] = [];
    for (let x = 0; x < baseWidth; x++) {
      grid[x] = [];
      for (let y = 0; y < baseWidth; y++) {
        grid[x][y] = 0;
      }
    }
    
    // Place cubes following visibility rules from ActionScript
    let placed = 0;
    let attempts = 0;
    while (placed < targetCubes && attempts < 1000) {
      const x = Math.floor(Math.random() * baseWidth);
      const y = Math.floor(Math.random() * baseWidth);
      
      // Check if we can place here (not exceeding maxHeight)
      if (grid[x][y] < maxHeight) {
        // ActionScript validation: ensure cubes behind don't get hidden
        let canPlace = true;
        
        // Check diagonal visibility constraint
        if (x > 0 && y > 0) {
          const diagHeight = grid[x-1][y-1];
          if (diagHeight <= grid[x][y]) {
            canPlace = false;
          }
        }
        
        if (canPlace) {
          grid[x][y]++;
          placed++;
        }
      }
      attempts++;
    }
    
    const totalCubes = grid.flat().reduce((a, b) => a + b, 0);
    
    return { grid, totalCubes, baseWidth };
  }, [totalCorrect]);

  useEffect(() => {
    const newStructure = generateStructure();
    setStructure(newStructure);
    setShowCubes(false);
    // Animate cubes dropping in
    setTimeout(() => setShowCubes(true), 100);
  }, []);

  const checkAnswer = useCallback(() => {
    if (!structure || !input) return;
    
    const userAnswer = parseInt(input, 10);
    
    if (userAnswer === structure.totalCubes) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
      setFeedback('correct');
    } else {
      playIncorrect();
      addIncorrect();
      setFeedback('incorrect');
    }
    
    setTimeout(() => {
      setFeedback(null);
      setInput('');
      const newStructure = generateStructure();
      setStructure(newStructure);
      setShowCubes(false);
      setTimeout(() => setShowCubes(true), 100);
    }, 500);
  }, [structure, input, addCorrect, addIncorrect, playCorrect, playIncorrect, generateStructure]);

  const handleKeyPress = (key: string) => {
    if (key === 'enter') {
      checkAnswer();
    } else if (key === 'C') {
      setInput('');
    } else if (/^\d$/.test(key) && input.length < 3) {
      setInput((prev) => prev + key);
    }
  };

  // Keyboard support
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key >= '0' && e.key <= '9') {
        handleKeyPress(e.key);
      } else if (e.key === 'Enter') {
        handleKeyPress('enter');
      } else if (e.key === 'Backspace') {
        setInput((prev) => prev.slice(0, -1));
      }
    };
    
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [input, structure]);

  if (!structure || timeRemaining <= 0) return null;

  // Render isometric cubes
  const cubeSize = Math.min(35, 140 / structure.baseWidth);
  const offsetX = 280;
  const offsetY = 80;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full relative">
        {/* Feedback overlay */}
        <AnimatePresence>
          {feedback && (
            <motion.div
              initial={{ scale: 0.5, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.5, opacity: 0 }}
              className="absolute inset-0 flex items-center justify-center z-10 pointer-events-none"
            >
              <img
                src={feedback === 'correct' ? '/assets/generated/correct-feedback.png' : '/assets/generated/wrong-feedback.png'}
                className="w-24 h-24 object-contain"
                alt=""
              />
            </motion.div>
          )}
        </AnimatePresence>

        <div 
          className="text-sm text-gray-400 mb-2"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Count ALL the cubes (including hidden ones!)
        </div>
        
        {/* Isometric cube display */}
        <div className="relative mb-4 rounded-xl overflow-hidden" style={{ width: 400, height: 180 }}>
          <img
            src="/assets/generated/cube-grid-base.png"
            className="absolute inset-0 w-full h-full object-cover opacity-30"
            alt=""
          />
          <svg width="400" height="180" viewBox="0 0 400 180" className="relative z-10">
            {showCubes && structure.grid.map((row, x) =>
              row.map((height, y) =>
                Array.from({ length: height }).map((_, z) => {
                  // Isometric projection
                  const isoX = offsetX + (x - y) * cubeSize * 0.866;
                  const isoY = offsetY + (x + y) * cubeSize * 0.5 - z * cubeSize * 0.75;
                  
                  // Alternate colors for visibility
                  const colorIndex = (x + y + z) % CUBE_COLORS.length;
                  
                  return (
                    <motion.g
                      key={`${x}-${y}-${z}`}
                      initial={{ y: -200, opacity: 0 }}
                      animate={{ y: 0, opacity: 1 }}
                      transition={{ 
                        delay: (x + y + z) * 0.05,
                        type: 'spring',
                        stiffness: 200,
                        damping: 15
                      }}
                    >
                      <IsometricCube
                        x={isoX}
                        y={isoY}
                        size={cubeSize}
                        color={CUBE_COLORS[colorIndex]}
                      />
                    </motion.g>
                  );
                })
              )
            )}
          </svg>
        </div>

        {/* Input display */}
        <div 
          className="w-28 h-14 rounded-xl flex items-center justify-center mb-4 shadow-lg"
          style={{
            background: 'linear-gradient(180deg, #2a2a5a 0%, #1a1a3a 100%)',
            border: '3px solid #ffd700',
            boxShadow: '0 0 15px rgba(255, 215, 0, 0.3)'
          }}
        >
          <span 
            className="text-3xl font-bold text-yellow-400"
            style={{ fontFamily: 'Baveuse, cursive' }}
          >
            {input || '_'}
          </span>
        </div>

        {/* Number pad */}
        <div className="grid grid-cols-5 gap-2">
          {[1, 2, 3, 4, 5, 6, 7, 8, 9, 0].map((key) => (
            <motion.button
              key={key}
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.9 }}
              onClick={() => handleKeyPress(String(key))}
              className="w-11 h-11 rounded-lg text-lg font-bold text-white shadow-md"
              style={{ 
                fontFamily: 'Baveuse, cursive',
                background: 'linear-gradient(180deg, #4a4a8a 0%, #2a2a5a 100%)',
                border: '2px solid rgba(255,255,255,0.1)'
              }}
            >
              {key}
            </motion.button>
          ))}
        </div>
        
        <div className="flex gap-2 mt-3">
          <motion.button
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={() => setInput('')}
            className="px-4 py-2 rounded-lg font-bold text-white shadow-md"
            style={{ 
              fontFamily: 'Baveuse, cursive',
              background: 'linear-gradient(180deg, #e74c3c 0%, #c0392b 100%)'
            }}
          >
            CLEAR
          </motion.button>
          <motion.button
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={checkAnswer}
            disabled={!input}
            className="px-6 py-2 rounded-lg font-bold text-white shadow-md disabled:opacity-50"
            style={{ 
              fontFamily: 'Baveuse, cursive',
              background: 'linear-gradient(180deg, #27ae60 0%, #1e8449 100%)'
            }}
          >
            SUBMIT
          </motion.button>
        </div>
      </div>
    </GameContainer>
  );
}

// Isometric cube component
function IsometricCube({ x, y, size, color }: { x: number; y: number; size: number; color: string }) {
  const h = size * 0.75;
  const w = size * 0.866;
  
  // Three visible faces of an isometric cube
  const topPoints = `${x},${y - h/2} ${x + w},${y} ${x},${y + h/2} ${x - w},${y}`;
  const leftPoints = `${x - w},${y} ${x},${y + h/2} ${x},${y + h*1.5} ${x - w},${y + h}`;
  const rightPoints = `${x + w},${y} ${x},${y + h/2} ${x},${y + h*1.5} ${x + w},${y + h}`;

  return (
    <g>
      <polygon points={topPoints} fill={color} stroke="#1e1e4e" strokeWidth="1.5" />
      <polygon points={leftPoints} fill={adjustBrightness(color, -40)} stroke="#1e1e4e" strokeWidth="1.5" />
      <polygon points={rightPoints} fill={adjustBrightness(color, -70)} stroke="#1e1e4e" strokeWidth="1.5" />
    </g>
  );
}

function adjustBrightness(hex: string, amount: number): string {
  const num = parseInt(hex.slice(1), 16);
  const r = Math.max(0, Math.min(255, ((num >> 16) & 0xff) + amount));
  const g = Math.max(0, Math.min(255, ((num >> 8) & 0xff) + amount));
  const b = Math.max(0, Math.min(255, (num & 0xff) + amount));
  return `#${((r << 16) | (g << 8) | b).toString(16).padStart(6, '0')}`;
}
