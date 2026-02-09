// SequenceMatch (Hex Path) (PRO) - FROM SOURCE.md
// Find and trace the displayed sequence on the hexagon grid
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const COLORS = ['#ef4444', '#3b82f6', '#22c55e', '#eab308', '#8b5cf6', '#ec4899'];

interface Cell {
  row: number;
  col: number;
  color: number;
  selected: boolean;
}

interface Puzzle {
  grid: Cell[][];
  sequence: number[]; // Color sequence to find
  rows: number;
  cols: number;
}

export function SequenceMatchGame() {
  const [puzzle, setPuzzle] = useState<Puzzle | null>(null);
  const [selectedCells, setSelectedCells] = useState<[number, number][]>([]);
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): Puzzle => {
    // Simplified difficulty from SOURCE.md's 37 levels
    const difficulty = Math.min(totalCorrect, 15);
    const rows = Math.min(3 + Math.floor(difficulty / 3), 5);
    const cols = Math.min(3 + Math.floor(difficulty / 2), 6);
    const seqLength = Math.min(2 + Math.floor(difficulty / 2), 5);
    
    // Generate random grid
    const grid: Cell[][] = [];
    for (let r = 0; r < rows; r++) {
      grid[r] = [];
      for (let c = 0; c < cols; c++) {
        grid[r][c] = {
          row: r,
          col: c,
          color: Math.floor(Math.random() * COLORS.length),
          selected: false,
        };
      }
    }
    
    // Generate a valid sequence path and extract colors
    const startRow = Math.floor(Math.random() * rows);
    const startCol = Math.floor(Math.random() * cols);
    const path: [number, number][] = [[startRow, startCol]];
    const sequence: number[] = [grid[startRow][startCol].color];
    
    for (let i = 1; i < seqLength; i++) {
      const [lastR, lastC] = path[path.length - 1];
      const neighbors = getNeighbors(lastR, lastC, rows, cols)
        .filter(([r, c]) => !path.some(([pr, pc]) => pr === r && pc === c));
      
      if (neighbors.length === 0) break;
      
      const [nextR, nextC] = neighbors[Math.floor(Math.random() * neighbors.length)];
      path.push([nextR, nextC]);
      sequence.push(grid[nextR][nextC].color);
    }
    
    return { grid, sequence, rows, cols };
  }, [totalCorrect]);

  useEffect(() => {
    setPuzzle(generatePuzzle());
    setSelectedCells([]);
  }, []);

  const handleCellClick = (row: number, col: number) => {
    if (!puzzle) return;
    
    const cell = puzzle.grid[row][col];
    const alreadySelected = selectedCells.some(([r, c]) => r === row && c === col);
    
    if (alreadySelected) {
      // Deselect from this point
      const index = selectedCells.findIndex(([r, c]) => r === row && c === col);
      setSelectedCells(selectedCells.slice(0, index));
      return;
    }
    
    // Check if valid neighbor of last selected
    if (selectedCells.length > 0) {
      const [lastR, lastC] = selectedCells[selectedCells.length - 1];
      const neighbors = getNeighbors(lastR, lastC, puzzle.rows, puzzle.cols);
      if (!neighbors.some(([r, c]) => r === row && c === col)) {
        return; // Not adjacent
      }
    }
    
    const newSelected = [...selectedCells, [row, col] as [number, number]];
    const selectedColors = newSelected.map(([r, c]) => puzzle.grid[r][c].color);
    
    // Check if matches sequence (forward or backward)
    const matchesForward = puzzle.sequence.every((c, i) => selectedColors[i] === c);
    const matchesBackward = [...puzzle.sequence].reverse().every((c, i) => selectedColors[i] === c);
    
    if (newSelected.length === puzzle.sequence.length) {
      if (matchesForward || matchesBackward) {
        playCorrect();
        addCorrect();
        setTotalCorrect((prev) => prev + 1);
        setTimeout(() => {
          setPuzzle(generatePuzzle());
          setSelectedCells([]);
        }, 500);
      } else {
        playIncorrect();
        addIncorrect();
        setSelectedCells([]);
      }
    } else {
      // Check if still on track
      const partialForward = puzzle.sequence.slice(0, newSelected.length).every((c, i) => selectedColors[i] === c);
      const partialBackward = [...puzzle.sequence].reverse().slice(0, newSelected.length).every((c, i) => selectedColors[i] === c);
      
      if (partialForward || partialBackward) {
        setSelectedCells(newSelected);
      } else {
        playIncorrect();
        addIncorrect();
        setSelectedCells([]);
      }
    }
  };

  if (!puzzle || timeRemaining <= 0) return null;

  const hexSize = Math.min(50, 300 / puzzle.cols);

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        {/* Target sequence */}
        <div className="mb-4">
          <div className="text-sm text-gray-300 mb-2" style={{ fontFamily: 'Baveuse, cursive' }}>Find this sequence:</div>
          <div className="flex gap-2">
            {puzzle.sequence.map((colorIdx, i) => (
              <div
                key={i}
                className="w-8 h-8 rounded-full relative overflow-hidden"
                style={{
                  border: i < selectedCells.length ? '2px solid #22c55e' : '2px solid rgba(255,255,255,0.2)',
                  boxShadow: i < selectedCells.length ? '0 0 8px rgba(34,197,94,0.5)' : 'none',
                  backgroundColor: COLORS[colorIdx],
                }}
              >
                <img
                  src={i < selectedCells.length ? '/assets/generated/hex-tile-correct.png' : '/assets/generated/hex-tile-active.png'}
                  className="absolute inset-0 w-full h-full object-cover opacity-40"
                  alt=""
                />
              </div>
            ))}
          </div>
        </div>

        {/* Hex grid */}
        <div className="relative rounded-xl p-3" style={{ height: puzzle.rows * hexSize * 1.5 + 40, background: 'rgba(15,15,40,0.5)', border: '2px solid rgba(255,255,255,0.05)' }}>
          <img
            src="/assets/generated/hex-grid-bg.png"
            className="absolute inset-0 w-full h-full object-cover rounded-xl opacity-20"
            alt=""
          />
          <div className="relative z-10">
            {puzzle.grid.map((row, rowIdx) => (
              <div
                key={rowIdx}
                className="flex gap-1"
                style={{ marginLeft: rowIdx % 2 === 1 ? hexSize / 2 : 0 }}
              >
                {row.map((cell, colIdx) => {
                  const isSelected = selectedCells.some(([r, c]) => r === rowIdx && c === colIdx);
                  const selectIndex = selectedCells.findIndex(([r, c]) => r === rowIdx && c === colIdx);

                  return (
                    <motion.button
                      key={colIdx}
                      onClick={() => handleCellClick(rowIdx, colIdx)}
                      className="rounded-full flex items-center justify-center font-bold text-white transition-all relative overflow-hidden"
                      style={{
                        width: hexSize,
                        height: hexSize,
                        backgroundColor: COLORS[cell.color],
                        border: isSelected ? '3px solid #ffd700' : '2px solid rgba(0,0,0,0.3)',
                        boxShadow: isSelected ? '0 0 12px rgba(255,215,0,0.5)' : '0 2px 4px rgba(0,0,0,0.3)',
                        fontFamily: 'Baveuse, cursive',
                      }}
                      whileHover={{ scale: 1.1, boxShadow: '0 0 12px rgba(255,215,0,0.3)' }}
                      whileTap={{ scale: 0.9 }}
                    >
                      <img
                        src={isSelected ? '/assets/generated/hex-tile-active.png' : '/assets/generated/hex-tile-inactive.png'}
                        className="absolute inset-0 w-full h-full object-cover opacity-30"
                        alt=""
                      />
                      <span className="relative z-10">{isSelected && (selectIndex + 1)}</span>
                    </motion.button>
                  );
                })}
              </div>
            ))}
          </div>
        </div>

        <div className="mt-4 text-sm text-gray-400" style={{ fontFamily: 'Baveuse, cursive' }}>
          {selectedCells.length} / {puzzle.sequence.length} selected
        </div>
      </div>
    </GameContainer>
  );
}

// Get adjacent cells (hex grid - offset coordinates)
function getNeighbors(row: number, col: number, maxRows: number, maxCols: number): [number, number][] {
  const neighbors: [number, number][] = [];
  const isOddRow = row % 2 === 1;
  
  // Direct neighbors
  const deltas = isOddRow
    ? [[-1, 0], [-1, 1], [0, -1], [0, 1], [1, 0], [1, 1]]
    : [[-1, -1], [-1, 0], [0, -1], [0, 1], [1, -1], [1, 0]];
  
  for (const [dr, dc] of deltas) {
    const newRow = row + dr;
    const newCol = col + dc;
    if (newRow >= 0 && newRow < maxRows && newCol >= 0 && newCol < maxCols) {
      neighbors.push([newRow, newCol]);
    }
  }
  
  return neighbors;
}
