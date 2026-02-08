// CubeCounter Game - FROM SOURCE.md
// Count 3D cubes in an isometric view, including hidden ones
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

interface CubeStructure {
  grid: number[][]; // Height at each x,y position
  totalCubes: number;
}

export function CubeCounterGame() {
  const [structure, setStructure] = useState<CubeStructure | null>(null);
  const [input, setInput] = useState('');
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateStructure = useCallback((): CubeStructure => {
    // From SOURCE.md: difficulty scaling
    const difficulty = Math.floor(totalCorrect / 1.5);
    const baseWidth = Math.min(2 + Math.floor(difficulty / 4), 4);
    const baseDepth = Math.min(2 + Math.floor(difficulty / 4), 4);
    const maxHeight = Math.min(2 + Math.floor(difficulty / 3), 4);
    
    const grid: number[][] = [];
    let totalCubes = 0;
    
    for (let x = 0; x < baseWidth; x++) {
      grid[x] = [];
      for (let y = 0; y < baseDepth; y++) {
        // Random height at each position, with some empty spaces
        const height = Math.random() < 0.8 ? Math.floor(Math.random() * maxHeight) + 1 : 0;
        grid[x][y] = height;
        totalCubes += height;
      }
    }
    
    // Ensure at least some cubes
    if (totalCubes < 3) {
      grid[0][0] = Math.max(grid[0][0], 2);
      totalCubes = grid.flat().reduce((a, b) => a + b, 0);
    }
    
    return { grid, totalCubes };
  }, [totalCorrect]);

  useEffect(() => {
    setStructure(generateStructure());
  }, []);

  const checkAnswer = useCallback(() => {
    if (!structure || !input) return;
    
    const userAnswer = parseInt(input, 10);
    
    if (userAnswer === structure.totalCubes) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
    } else {
      playIncorrect();
      addIncorrect();
    }
    
    setInput('');
    setStructure(generateStructure());
  }, [structure, input, addCorrect, addIncorrect, playCorrect, playIncorrect, generateStructure]);

  const handleKeyPress = (key: string) => {
    if (key === 'enter') {
      checkAnswer();
    } else if (key === 'backspace') {
      setInput((prev) => prev.slice(0, -1));
    } else if (/^\d$/.test(key) && input.length < 3) {
      setInput((prev) => prev + key);
    }
  };

  if (!structure || timeRemaining <= 0) return null;

  // Render isometric cubes
  const cubeSize = 30;
  const offsetX = 200;
  const offsetY = 100;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        <div className="text-sm text-gray-500 mb-4">
          Count ALL the cubes (including hidden ones!)
        </div>
        
        {/* Isometric cube display */}
        <div className="relative mb-6" style={{ width: 400, height: 200 }}>
          <svg width="400" height="200" viewBox="0 0 400 200">
            {structure.grid.map((row, x) =>
              row.map((height, y) =>
                Array.from({ length: height }).map((_, z) => {
                  // Isometric projection
                  const isoX = offsetX + (x - y) * cubeSize * 0.866;
                  const isoY = offsetY + (x + y) * cubeSize * 0.5 - z * cubeSize;
                  
                  return (
                    <IsometricCube
                      key={`${x}-${y}-${z}`}
                      x={isoX}
                      y={isoY}
                      size={cubeSize}
                      color={z % 2 === 0 ? '#60a5fa' : '#3b82f6'}
                    />
                  );
                })
              )
            )}
          </svg>
        </div>

        {/* Input display */}
        <div className="w-24 h-14 bg-white border-4 border-blue-500 rounded-lg flex items-center justify-center mb-4">
          <span className="text-3xl font-bold">{input || '_'}</span>
        </div>

        {/* Number pad */}
        <div className="grid grid-cols-5 gap-2">
          {[1, 2, 3, 4, 5, 6, 7, 8, 9, 0].map((key) => (
            <button
              key={key}
              onClick={() => handleKeyPress(String(key))}
              className="w-12 h-12 bg-gray-200 hover:bg-gray-300 rounded-lg text-xl font-bold transition-colors"
            >
              {key}
            </button>
          ))}
        </div>
        
        <div className="flex gap-2 mt-2">
          <button
            onClick={() => handleKeyPress('backspace')}
            className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded-lg font-bold"
          >
            ← Back
          </button>
          <button
            onClick={checkAnswer}
            disabled={!input}
            className="px-6 py-2 bg-green-500 hover:bg-green-600 disabled:bg-gray-300 text-white font-bold rounded-lg"
          >
            SUBMIT
          </button>
        </div>
      </div>
    </GameContainer>
  );
}

// Isometric cube component
function IsometricCube({ x, y, size, color }: { x: number; y: number; size: number; color: string }) {
  const h = size;
  const w = size * 0.866;
  
  // Three visible faces of an isometric cube
  const topPoints = `${x},${y - h/2} ${x + w},${y} ${x},${y + h/2} ${x - w},${y}`;
  const leftPoints = `${x - w},${y} ${x},${y + h/2} ${x},${y + h*1.5} ${x - w},${y + h}`;
  const rightPoints = `${x + w},${y} ${x},${y + h/2} ${x},${y + h*1.5} ${x + w},${y + h}`;

  return (
    <g>
      <polygon points={topPoints} fill={color} stroke="#1e40af" strokeWidth="1" />
      <polygon points={leftPoints} fill={adjustBrightness(color, -30)} stroke="#1e40af" strokeWidth="1" />
      <polygon points={rightPoints} fill={adjustBrightness(color, -60)} stroke="#1e40af" strokeWidth="1" />
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
