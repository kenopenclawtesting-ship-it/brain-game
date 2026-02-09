// CarPath (PRO) - Faithfully ported from CarPath.as
// Cars start at top of lanes, paths cross between lanes. Player must click the correct endpoint.
// CORRECT_SCORE: 26, INCORRECT_SCORE: -17
import { useState, useEffect, useCallback, useRef } from 'react';
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

// 28 difficulty levels from original CarPath.as
const DIFFICULTY_LEVEL_PARAMS = [
  { numCars: 1, numPath: 2, numCrossPath: 2, maxCrossPathWidth: 2, pathSegments: 2 },
  { numCars: 1, numPath: 3, numCrossPath: 2, maxCrossPathWidth: 1, pathSegments: 2 },
  { numCars: 1, numPath: 3, numCrossPath: 3, maxCrossPathWidth: 2, pathSegments: 2 },
  { numCars: 1, numPath: 3, numCrossPath: 3, maxCrossPathWidth: 1, pathSegments: 2 },
  { numCars: 1, numPath: 4, numCrossPath: 4, maxCrossPathWidth: 2, pathSegments: 2 },
  { numCars: 1, numPath: 4, numCrossPath: 5, maxCrossPathWidth: 1, pathSegments: 2 },
  { numCars: 1, numPath: 4, numCrossPath: 5, maxCrossPathWidth: 2, pathSegments: 2 },
  { numCars: 2, numPath: 4, numCrossPath: 5, maxCrossPathWidth: 1, pathSegments: 2 },
  { numCars: 2, numPath: 4, numCrossPath: 5, maxCrossPathWidth: 2, pathSegments: 2 },
  { numCars: 2, numPath: 5, numCrossPath: 6, maxCrossPathWidth: 1, pathSegments: 2 },
  { numCars: 2, numPath: 5, numCrossPath: 7, maxCrossPathWidth: 2, pathSegments: 2 },
  { numCars: 2, numPath: 5, numCrossPath: 8, maxCrossPathWidth: 1, pathSegments: 2 },
  { numCars: 2, numPath: 5, numCrossPath: 9, maxCrossPathWidth: 3, pathSegments: 2 },
  { numCars: 2, numPath: 5, numCrossPath: 9, maxCrossPathWidth: 2, pathSegments: 2 },
  { numCars: 2, numPath: 6, numCrossPath: 9, maxCrossPathWidth: 3, pathSegments: 3 },
  { numCars: 3, numPath: 6, numCrossPath: 9, maxCrossPathWidth: 2, pathSegments: 3 },
  { numCars: 3, numPath: 6, numCrossPath: 10, maxCrossPathWidth: 3, pathSegments: 3 },
  { numCars: 3, numPath: 6, numCrossPath: 10, maxCrossPathWidth: 2, pathSegments: 3 },
  { numCars: 3, numPath: 7, numCrossPath: 10, maxCrossPathWidth: 3, pathSegments: 3 },
  { numCars: 3, numPath: 7, numCrossPath: 11, maxCrossPathWidth: 2, pathSegments: 3 },
  { numCars: 3, numPath: 7, numCrossPath: 11, maxCrossPathWidth: 3, pathSegments: 4 },
  { numCars: 3, numPath: 7, numCrossPath: 12, maxCrossPathWidth: 2, pathSegments: 4 },
  { numCars: 3, numPath: 7, numCrossPath: 12, maxCrossPathWidth: 3, pathSegments: 4 },
  { numCars: 4, numPath: 8, numCrossPath: 12, maxCrossPathWidth: 2, pathSegments: 4 },
  { numCars: 4, numPath: 8, numCrossPath: 13, maxCrossPathWidth: 4, pathSegments: 4 },
  { numCars: 4, numPath: 8, numCrossPath: 14, maxCrossPathWidth: 3, pathSegments: 4 },
  { numCars: 4, numPath: 8, numCrossPath: 15, maxCrossPathWidth: 4, pathSegments: 4 },
  { numCars: 4, numPath: 8, numCrossPath: 16, maxCrossPathWidth: 3, pathSegments: 4 },
];

const PATH_SEGMENT_LENGTH = 5;

function rnd(min: number, max: number): number {
  return min + Math.floor(Math.random() * (max - min));
}

interface CrossPaths {
  grid: number[][]; // [pathGap][column] - 1 = crossing at this point
  widths: number[]; // width of each gap between paths
  counts: number[]; // crossing count per gap
}

interface PathPoint {
  row: number;
  col: number;
}

interface PuzzleData {
  numPath: number;
  numCars: number;
  numSegments: number;
  crossPaths: CrossPaths;
  carStarts: number[];   // starting path index for each car
  carEndRows: number[];  // ending row for each car
  carPaths: PathPoint[][]; // traced paths for animation
  endpointRows: number[]; // row of each endpoint (numPath endpoints)
}

function getRowOfPath(pathIndex: number, crossWidths: number[]): number {
  let row = pathIndex;
  for (let i = 0; i < pathIndex; i++) {
    row += crossWidths[i];
  }
  return row;
}

function tracePath(
  startPathIndex: number,
  crossGrid: number[][],
  crossWidths: number[],
  numSegments: number,
): PathPoint[] {
  const path: PathPoint[] = [];
  let row = getRowOfPath(startPathIndex, crossWidths);
  let col = 0;
  let currentPath = startPathIndex;

  path.push({ row, col });

  while (col < numSegments * PATH_SEGMENT_LENGTH) {
    // Check crossing going up (to path above)
    if (currentPath > 0 && crossGrid[currentPath - 1][col] === 1) {
      for (let i = 0; i < crossWidths[currentPath - 1] + 1; i++) {
        row--;
        path.push({ row, col });
      }
      col++;
      currentPath--;
    }
    // Check crossing going down (to path below)
    else if (currentPath < crossGrid.length && crossGrid[currentPath][col] === 1) {
      for (let i = 0; i < crossWidths[currentPath] + 1; i++) {
        row++;
        path.push({ row, col });
      }
      col++;
      currentPath++;
    }
    // No crossing, go right
    else {
      col++;
    }

    if (col < numSegments * PATH_SEGMENT_LENGTH) {
      path.push({ row, col });
    }
  }

  return path;
}

export function CarPathGame() {
  const [puzzle, setPuzzle] = useState<PuzzleData | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [clickedEndpoints, setClickedEndpoints] = useState<Set<number>>(new Set());
  const [correctCars, setCorrectCars] = useState<Set<number>>(new Set());
  const [wrongEndpoint, setWrongEndpoint] = useState<number | null>(null);
  const [disabled, setDisabled] = useState(false);

  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): PuzzleData => {
    const params = DIFFICULTY_LEVEL_PARAMS[Math.min(totalCorrect, DIFFICULTY_LEVEL_PARAMS.length - 1)];
    const { numCars, numPath, numCrossPath, maxCrossPathWidth, pathSegments: numSegments } = params;

    // Generate cross paths (from original CarPath.as restart())
    const grid: number[][] = [];
    const widths: number[] = [];
    const counts: number[] = [];

    for (let i = 0; i < numPath - 1; i++) {
      grid[i] = new Array(numSegments * PATH_SEGMENT_LENGTH).fill(0);
      counts[i] = 0;
      widths[i] = rnd(1, maxCrossPathWidth + 1);
    }

    // Place crossings
    let placed = 0;
    let attempts = 0;
    while (placed < numCrossPath && attempts < numCrossPath * 10) {
      // Prefer gaps with no crossings yet
      let gapIndex: number;
      const emptyCandidates = [];
      for (let i = 0; i < numPath - 1; i++) {
        if (counts[i] === 0) emptyCandidates.push(i);
      }
      if (emptyCandidates.length > 0) {
        gapIndex = emptyCandidates[rnd(0, emptyCandidates.length)];
      } else {
        gapIndex = rnd(0, numPath - 1);
      }

      const colIndex = rnd(1, numSegments * PATH_SEGMENT_LENGTH - 1);

      // Check adjacency constraints (from original)
      const noAboveConflict = gapIndex === 0 || grid[gapIndex - 1][colIndex] !== 1;
      const noBelowConflict = gapIndex === grid.length - 1 || grid[gapIndex + 1][colIndex] !== 1;
      const noSameConflict = grid[gapIndex][colIndex] === 0 &&
        (colIndex === 0 || grid[gapIndex][colIndex - 1] === 0) &&
        (colIndex === grid[gapIndex].length - 1 || grid[gapIndex][colIndex + 1] === 0);

      if (noAboveConflict && noBelowConflict && noSameConflict) {
        grid[gapIndex][colIndex] = 1;
        counts[gapIndex]++;
        placed++;
      }
      attempts++;
    }

    const crossPaths: CrossPaths = { grid, widths, counts };

    // Calculate endpoint rows
    const endpointRows: number[] = [];
    for (let i = 0; i < numPath; i++) {
      endpointRows.push(getRowOfPath(i, widths));
    }

    // Place cars (from original: ensure unique endpoints)
    const carStarts: number[] = [];
    const carEndRows: number[] = [];
    const carPaths: PathPoint[][] = [];
    const usedEndRows = new Set<number>();

    for (let c = 0; c < numCars; c++) {
      const candidates = Array.from({ length: numPath }, (_, i) => i)
        .sort(() => Math.random() - 0.5);

      let startPath = -1;
      for (const candidate of candidates) {
        const path = tracePath(candidate, grid, widths, numSegments);
        const endRow = path[path.length - 1].row;
        if (!usedEndRows.has(endRow)) {
          startPath = candidate;
          carStarts.push(candidate);
          carEndRows.push(endRow);
          carPaths.push(path);
          usedEndRows.add(endRow);
          break;
        }
      }

      if (startPath === -1) {
        // Fallback: just pick any unused start
        for (let i = 0; i < numPath; i++) {
          if (!carStarts.includes(i)) {
            const path = tracePath(i, grid, widths, numSegments);
            carStarts.push(i);
            carEndRows.push(path[path.length - 1].row);
            carPaths.push(path);
            break;
          }
        }
      }
    }

    return {
      numPath, numCars, numSegments,
      crossPaths, carStarts, carEndRows, carPaths,
      endpointRows,
    };
  }, [totalCorrect]);

  useEffect(() => {
    setPuzzle(generatePuzzle());
    setClickedEndpoints(new Set());
    setCorrectCars(new Set());
    setWrongEndpoint(null);
    setDisabled(false);
  }, []);

  const handleEndpointClick = (endpointIndex: number) => {
    if (!puzzle || disabled) return;

    const endRow = puzzle.endpointRows[endpointIndex];

    // Check if this endpoint is a correct answer for any car
    const carIndex = puzzle.carEndRows.findIndex(
      (row, i) => row === endRow && !correctCars.has(i)
    );

    if (carIndex !== -1) {
      // Correct!
      playCorrect();
      addCorrect();
      const newCorrectCars = new Set(correctCars);
      newCorrectCars.add(carIndex);
      setCorrectCars(newCorrectCars);
      const newClicked = new Set(clickedEndpoints);
      newClicked.add(endpointIndex);
      setClickedEndpoints(newClicked);

      // All cars found?
      if (newCorrectCars.size === puzzle.numCars) {
        setDisabled(true);
        setTotalCorrect((prev) => prev + 1);
        setTimeout(() => {
          setPuzzle(generatePuzzle());
          setClickedEndpoints(new Set());
          setCorrectCars(new Set());
          setWrongEndpoint(null);
          setDisabled(false);
        }, 600);
      }
    } else {
      // Wrong!
      playIncorrect();
      addIncorrect();
      setWrongEndpoint(endpointIndex);
      setDisabled(true);
      setTimeout(() => {
        setPuzzle(generatePuzzle());
        setClickedEndpoints(new Set());
        setCorrectCars(new Set());
        setWrongEndpoint(null);
        setDisabled(false);
      }, 800);
    }
  };

  if (!puzzle || timeRemaining <= 0) return null;

  // Calculate total rows for layout
  const totalRows = getRowOfPath(puzzle.numPath - 1, puzzle.crossPaths.widths) + 1;
  const totalCols = puzzle.numSegments * PATH_SEGMENT_LENGTH + 1;

  // SVG dimensions
  const cellW = Math.min(50, Math.floor(580 / totalCols));
  const cellH = Math.min(28, Math.floor(260 / totalRows));
  const svgW = totalCols * cellW + 80; // extra space for car/endpoint
  const svgH = totalRows * cellH + 20;
  const offsetX = 40;
  const offsetY = 10;

  return (
    <GameContainer>
      <div className="flex flex-col items-center h-full">
        <div
          className="text-sm text-gray-300 mb-2"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Where {puzzle.numCars > 1 ? 'do the cars' : 'does the car'} end up?
        </div>

        {/* Road visualization */}
        <div
          className="flex-1 flex items-center justify-center w-full overflow-hidden"
        >
          <svg
            width={Math.min(svgW, 600)}
            height={Math.min(svgH + 60, 320)}
            viewBox={`0 0 ${svgW} ${svgH + 60}`}
            style={{ maxWidth: '100%' }}
          >
            {/* Background */}
            <rect x="0" y="0" width={svgW} height={svgH + 60} rx="8" fill="#1a1a3a" fillOpacity="0.5" />

            {/* Draw horizontal road lanes */}
            {Array.from({ length: puzzle.numPath }).map((_, pathIdx) => {
              const row = getRowOfPath(pathIdx, puzzle.crossPaths.widths);
              const y = offsetY + row * cellH + cellH / 2;
              return (
                <line
                  key={`lane-${pathIdx}`}
                  x1={offsetX}
                  y1={y}
                  x2={offsetX + (totalCols - 1) * cellW}
                  y2={y}
                  stroke="rgba(255,255,255,0.15)"
                  strokeWidth={cellH * 0.7}
                  strokeLinecap="round"
                />
              );
            })}

            {/* Draw crossing paths */}
            {puzzle.crossPaths.grid.map((gapRow, gapIdx) =>
              gapRow.map((val, col) => {
                if (val !== 1) return null;
                const topRow = getRowOfPath(gapIdx, puzzle.crossPaths.widths);
                const bottomRow = getRowOfPath(gapIdx + 1, puzzle.crossPaths.widths);
                const x = offsetX + col * cellW;
                const y1 = offsetY + topRow * cellH + cellH / 2;
                const y2 = offsetY + bottomRow * cellH + cellH / 2;
                return (
                  <g key={`cross-${gapIdx}-${col}`}>
                    <line
                      x1={x} y1={y1} x2={x} y2={y2}
                      stroke="#ffd700"
                      strokeWidth={3}
                      strokeOpacity={0.7}
                      strokeLinecap="round"
                    />
                    {/* Arrow head pointing down */}
                    <polygon
                      points={`${x},${y2 + 2} ${x - 4},${y2 - 6} ${x + 4},${y2 - 6}`}
                      fill="#ffd700"
                      fillOpacity={0.7}
                    />
                    {/* Arrow head pointing up */}
                    <polygon
                      points={`${x},${y1 - 2} ${x - 4},${y1 + 6} ${x + 4},${y1 + 6}`}
                      fill="#ffd700"
                      fillOpacity={0.7}
                    />
                  </g>
                );
              })
            )}

            {/* Cars at start positions */}
            {puzzle.carStarts.map((startPath, carIdx) => {
              const row = getRowOfPath(startPath, puzzle.crossPaths.widths);
              const x = offsetX - 20;
              const y = offsetY + row * cellH + cellH / 2;
              return (
                <g key={`car-${carIdx}`}>
                  <circle cx={x} cy={y} r={12} fill={['#e74c3c', '#3498db', '#2ecc71', '#f1c40f', '#9b59b6'][carIdx % 5]} stroke="white" strokeWidth="2" />
                  <image
                    href={CAR_IMAGES[carIdx % CAR_IMAGES.length]}
                    x={x - 10} y={y - 10}
                    width="20" height="20"
                  />
                </g>
              );
            })}

            {/* Endpoint buttons at right side */}
            {puzzle.endpointRows.map((row, epIdx) => {
              const x = offsetX + (totalCols - 1) * cellW + 20;
              const y = offsetY + row * cellH + cellH / 2;
              const isCorrect = clickedEndpoints.has(epIdx);
              const isWrong = wrongEndpoint === epIdx;
              const label = puzzle.numPath - epIdx;

              return (
                <g
                  key={`ep-${epIdx}`}
                  onClick={() => handleEndpointClick(epIdx)}
                  style={{ cursor: disabled ? 'not-allowed' : 'pointer' }}
                >
                  <circle
                    cx={x} cy={y} r={14}
                    fill={isCorrect ? '#2ecc71' : isWrong ? '#e74c3c' : '#c0392b'}
                    stroke={isCorrect ? '#27ae60' : isWrong ? '#c0392b' : 'rgba(255,255,255,0.3)'}
                    strokeWidth="2"
                  />
                  <text
                    x={x} y={y + 1}
                    textAnchor="middle"
                    dominantBaseline="middle"
                    fill="white"
                    fontSize="12"
                    fontWeight="bold"
                    fontFamily="Baveuse, cursive"
                    style={{ pointerEvents: 'none' }}
                  >
                    {label}
                  </text>
                </g>
              );
            })}
          </svg>
        </div>

        <div
          className="text-gray-400 text-sm pb-1"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          The car crosses at every intersection it meets
        </div>
      </div>
    </GameContainer>
  );
}
