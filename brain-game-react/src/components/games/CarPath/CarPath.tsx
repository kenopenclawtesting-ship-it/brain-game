// CarPath (PRO) - FROM SOURCE.md
// Predict where the car ends up after following the paths
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const CAR_IMAGES = [
  '/assets/generated/car-red.png',
  '/assets/generated/car-blue.png',
  '/assets/generated/car-green.png',
  '/assets/generated/car-yellow.png',
  '/assets/generated/car-purple.png',
];

interface Path {
  from: number;
  to: number;
}

interface Puzzle {
  numPaths: number;
  paths: Path[];
  carStartPosition: number;
  correctEndPosition: number;
}

export function CarPathGame() {
  const [puzzle, setPuzzle] = useState<Puzzle | null>(null);
  const [showingPath, setShowingPath] = useState(false);
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): Puzzle => {
    // From SOURCE.md: 28 difficulty levels
    const difficulty = Math.min(totalCorrect, 10);
    const numPaths = Math.min(3 + Math.floor(difficulty / 2), 6);
    const numCrossings = Math.min(2 + difficulty, 8);
    
    // Generate crossing paths
    const paths: Path[] = [];
    for (let i = 0; i < numCrossings; i++) {
      const from = Math.floor(Math.random() * numPaths);
      let to = Math.floor(Math.random() * numPaths);
      while (to === from) {
        to = Math.floor(Math.random() * numPaths);
      }
      paths.push({ from, to });
    }
    
    // Calculate where car ends up
    const carStart = Math.floor(Math.random() * numPaths);
    let currentPosition = carStart;
    
    for (const path of paths) {
      if (path.from === currentPosition) {
        currentPosition = path.to;
      } else if (path.to === currentPosition) {
        currentPosition = path.from;
      }
    }
    
    return {
      numPaths,
      paths,
      carStartPosition: carStart,
      correctEndPosition: currentPosition,
    };
  }, [totalCorrect]);

  useEffect(() => {
    setPuzzle(generatePuzzle());
    setShowingPath(true);
    
    // Hide path after delay
    const timer = setTimeout(() => setShowingPath(false), 2000);
    return () => clearTimeout(timer);
  }, []);

  const handlePositionClick = (position: number) => {
    if (!puzzle || showingPath) return;
    
    if (position === puzzle.correctEndPosition) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
    } else {
      playIncorrect();
      addIncorrect();
    }
    
    setPuzzle(generatePuzzle());
    setShowingPath(true);
    setTimeout(() => setShowingPath(false), 2000);
  };

  if (!puzzle || timeRemaining <= 0) return null;

  const laneWidth = 60;
  const pathHeight = 200;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        <div
          className="text-sm text-gray-300 mb-4"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {showingPath
            ? 'Watch where the car goes...'
            : 'Where does the car end up?'
          }
        </div>

        {/* Path visualization */}
        <div
          className="relative rounded-xl overflow-hidden mb-6"
          style={{
            width: puzzle.numPaths * laneWidth + 40,
            height: pathHeight + 60,
          }}
        >
          <img
            src="/assets/generated/road-bg.png"
            className="absolute inset-0 w-full h-full object-cover"
            alt=""
          />

          {/* Lane markers */}
          {Array.from({ length: puzzle.numPaths }).map((_, i) => (
            <div
              key={i}
              className="absolute top-0 bottom-0 border-l-2 border-dashed border-yellow-500/30"
              style={{ left: 20 + i * laneWidth + laneWidth / 2 }}
            />
          ))}

          {/* Start positions (top) */}
          <div className="absolute top-2 left-0 right-0 flex justify-around px-5">
            {Array.from({ length: puzzle.numPaths }).map((_, i) => (
              <div
                key={i}
                className="w-12 h-12 rounded-full flex items-center justify-center relative overflow-hidden"
                style={{
                  background: i === puzzle.carStartPosition
                    ? 'linear-gradient(180deg, #2a6a2a 0%, #1a4a1a 100%)'
                    : 'rgba(30,30,60,0.6)',
                  border: '2px solid rgba(255,255,255,0.2)',
                }}
              >
                {i === puzzle.carStartPosition && (
                  <img
                    src={CAR_IMAGES[0]}
                    className="w-10 h-10 object-contain"
                    alt="car"
                  />
                )}
              </div>
            ))}
          </div>

          {/* Crossing paths with intersection tiles */}
          <svg
            className="absolute"
            style={{ top: 60, left: 20, width: puzzle.numPaths * laneWidth, height: pathHeight - 60 }}
          >
            {showingPath && puzzle.paths.map((path, i) => {
              const x1 = path.from * laneWidth + laneWidth / 2;
              const x2 = path.to * laneWidth + laneWidth / 2;
              const y = 20 + (i / puzzle.paths.length) * (pathHeight - 100);

              return (
                <g key={i}>
                  <line
                    x1={x1}
                    y1={y}
                    x2={x2}
                    y2={y + 30}
                    stroke="#ffd700"
                    strokeWidth="4"
                    strokeLinecap="round"
                    opacity="0.8"
                  />
                  <circle cx={x2} cy={y + 30} r="6" fill="#ffd700" opacity="0.8" />
                </g>
              );
            })}
          </svg>

          {/* End positions (bottom) - clickable */}
          <div className="absolute bottom-2 left-0 right-0 flex justify-around px-5">
            {Array.from({ length: puzzle.numPaths }).map((_, i) => (
              <motion.button
                key={i}
                onClick={() => handlePositionClick(i)}
                className="w-12 h-12 rounded-full flex items-center justify-center text-xl font-bold text-white"
                style={{
                  background: showingPath
                    ? 'linear-gradient(180deg, #4a4a6a 0%, #2a2a4a 100%)'
                    : 'linear-gradient(180deg, #c0392b 0%, #8b1a1a 100%)',
                  border: '2px solid rgba(255,255,255,0.2)',
                  cursor: showingPath ? 'not-allowed' : 'pointer',
                  fontFamily: 'Baveuse, cursive',
                }}
                whileHover={!showingPath ? { scale: 1.1, boxShadow: '0 0 15px rgba(255,215,0,0.5)' } : {}}
                whileTap={!showingPath ? { scale: 0.9 } : {}}
                disabled={showingPath}
              >
                {String.fromCharCode(65 + i)}
              </motion.button>
            ))}
          </div>
        </div>

        <div
          className="text-gray-400 text-sm"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          The car starts at the top and crosses at every intersection
        </div>
      </div>
    </GameContainer>
  );
}
