// JigsawMatch Game - Rewritten from original JigsawMatch.as
// Original: picture board with jigsaw pieces cut out. Player clicks correct
// pieces from a mix of correct + wrong distractors at bottom.
// React version: colorful mosaic grid with holes. Pieces at bottom colored
// to match grid positions. Correct pieces fill holes, wrong ones are decoys.
// Click correct → +score per piece. Click wrong → -score + puzzle restart.
// CORRECT_SCORE: 19, INCORRECT_SCORE: -13
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const GRID_COLS = 5;
const GRID_ROWS = 4;
const TOTAL_CELLS = GRID_COLS * GRID_ROWS;
const CELL_SIZE = 50;
const CELL_GAP = 2;

// Golden angle distribution for maximally distinct hues
function getCellStyle(cellIndex: number, seed: number) {
  const hue = ((cellIndex * 137.508 + seed * 47.3) % 360 + 360) % 360;
  const hue2 = (hue + 35) % 360;
  // Vary saturation and lightness slightly for extra distinction
  const sat = 60 + (cellIndex % 3) * 8;
  const lit = 48 + (cellIndex % 5) * 4;
  return {
    bg: `linear-gradient(135deg, hsl(${hue}, ${sat}%, ${lit + 10}%) 0%, hsl(${hue2}, ${sat - 10}%, ${lit - 8}%) 100%)`,
    border: `hsl(${hue}, ${sat}%, ${lit + 20}%)`,
  };
}

interface BoardPiece {
  cellIndex: number;
  isCorrect: boolean;
  uid: number;
}

interface Puzzle {
  seed: number;
  missingCells: number[];
  pieces: BoardPiece[];
  foundCells: number[];
}

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

let uidCounter = 0;

export function JigsawMatchGame() {
  const [puzzle, setPuzzle] = useState<Puzzle | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [locked, setLocked] = useState(false);

  const addCorrect = useGameStore((s) => s.addCorrect);
  const addIncorrect = useGameStore((s) => s.addIncorrect);
  const timeRemaining = useGameStore((s) => s.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): Puzzle => {
    // From JigsawMatch.as restart():
    // numCorrect = 1 + totalCorrect/4, numWrong = min(2 + totalCorrect/8, 3)
    const numCorrect = Math.min(1 + Math.floor(totalCorrect / 4), 6);
    const numWrong = Math.min(2 + Math.floor(totalCorrect / 8), 3);

    const seed = Math.floor(Math.random() * 10000);
    const allIndices = shuffle(Array.from({ length: TOTAL_CELLS }, (_, i) => i));

    const missingCells = allIndices.slice(0, numCorrect);
    const filledCells = allIndices.slice(numCorrect);

    // Correct pieces — colors match the holes (not visible on board)
    const correct: BoardPiece[] = missingCells.map((ci) => ({
      cellIndex: ci,
      isCorrect: true,
      uid: ++uidCounter,
    }));

    // Wrong pieces — colors match VISIBLE cells (decoys)
    const wrongCells = shuffle(filledCells).slice(0, numWrong);
    const wrong: BoardPiece[] = wrongCells.map((ci) => ({
      cellIndex: ci,
      isCorrect: false,
      uid: ++uidCounter,
    }));

    return {
      seed,
      missingCells,
      pieces: shuffle([...correct, ...wrong]),
      foundCells: [],
    };
  }, [totalCorrect]);

  useEffect(() => {
    setPuzzle(generatePuzzle());
  }, []);

  const handlePieceClick = (pieceIndex: number) => {
    if (!puzzle || locked) return;
    const piece = puzzle.pieces[pieceIndex];

    if (piece.isCorrect) {
      playCorrect();
      addCorrect();

      const newFound = [...puzzle.foundCells, piece.cellIndex];
      const newPieces = puzzle.pieces.filter((_, i) => i !== pieceIndex);
      const remainingCorrect = newPieces.filter((p) => p.isCorrect);

      if (remainingCorrect.length === 0) {
        // All correct pieces found → next puzzle
        setTotalCorrect((prev) => prev + 1);
        setLocked(true);
        setTimeout(() => {
          setPuzzle(generatePuzzle());
          setLocked(false);
        }, 600);
      } else {
        setPuzzle({ ...puzzle, foundCells: newFound, pieces: newPieces });
      }
    } else {
      // Wrong piece → fail + restart puzzle (from original: fail(true,...))
      playIncorrect();
      addIncorrect();
      setLocked(true);
      setTimeout(() => {
        setPuzzle(generatePuzzle());
        setLocked(false);
      }, 800);
    }
  };

  if (!puzzle || timeRemaining <= 0) return null;

  const holesLeft = puzzle.missingCells.length - puzzle.foundCells.length;
  const gridW = GRID_COLS * CELL_SIZE + (GRID_COLS - 1) * CELL_GAP;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        <div
          className="text-sm text-gray-300 mb-2"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Find the {holesLeft} missing piece{holesLeft !== 1 ? 's' : ''}!
        </div>

        {/* Mosaic Board */}
        <div
          className="rounded-xl overflow-hidden mb-3"
          style={{
            display: 'grid',
            gridTemplateColumns: `repeat(${GRID_COLS}, ${CELL_SIZE}px)`,
            gap: `${CELL_GAP}px`,
            background: 'rgba(0,0,0,0.6)',
            padding: '4px',
            border: '2px solid rgba(255,255,255,0.12)',
            boxShadow: '0 8px 24px rgba(0,0,0,0.5)',
          }}
        >
          {Array.from({ length: TOTAL_CELLS }).map((_, i) => {
            const isMissing =
              puzzle.missingCells.includes(i) && !puzzle.foundCells.includes(i);
            const isFound = puzzle.foundCells.includes(i);
            const style = getCellStyle(i, puzzle.seed);

            return (
              <motion.div
                key={i}
                animate={
                  isFound
                    ? { scale: [0.7, 1.08, 1], opacity: [0.4, 1] }
                    : {}
                }
                transition={{ duration: 0.35, ease: 'easeOut' }}
                style={{
                  width: CELL_SIZE,
                  height: CELL_SIZE,
                  background: isMissing
                    ? 'rgba(8,8,30,0.9)'
                    : style.bg,
                  border: isMissing
                    ? '2px dashed rgba(255,215,0,0.3)'
                    : isFound
                      ? `2px solid rgba(34,197,94,0.5)`
                      : `1px solid rgba(255,255,255,0.06)`,
                  borderRadius: '4px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  boxShadow: isFound
                    ? '0 0 10px rgba(34,197,94,0.25)'
                    : isMissing
                      ? 'inset 0 2px 8px rgba(0,0,0,0.4)'
                      : 'none',
                }}
              >
                {isMissing && (
                  <span
                    style={{
                      color: 'rgba(255,215,0,0.2)',
                      fontSize: 18,
                      fontWeight: 'bold',
                    }}
                  >
                    ?
                  </span>
                )}
              </motion.div>
            );
          })}
        </div>

        {/* Pieces to choose */}
        <div
          className="flex flex-wrap justify-center gap-2"
          style={{ maxWidth: gridW + 40 }}
        >
          {puzzle.pieces.map((piece, i) => {
            const style = getCellStyle(piece.cellIndex, puzzle.seed);
            return (
              <motion.button
                key={piece.uid}
                onClick={() => handlePieceClick(i)}
                disabled={locked}
                className="rounded-lg"
                style={{
                  width: CELL_SIZE + 6,
                  height: CELL_SIZE + 6,
                  background: style.bg,
                  border: '3px solid rgba(255,255,255,0.2)',
                  boxShadow: '0 4px 12px rgba(0,0,0,0.4)',
                  cursor: locked ? 'not-allowed' : 'pointer',
                }}
                whileHover={
                  !locked
                    ? {
                        scale: 1.12,
                        boxShadow: '0 0 20px rgba(255,215,0,0.5)',
                        borderColor: 'rgba(255,215,0,0.6)',
                      }
                    : {}
                }
                whileTap={!locked ? { scale: 0.9 } : {}}
                initial={{ opacity: 0, y: 16 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: i * 0.04, duration: 0.25 }}
              />
            );
          })}
        </div>

        <div
          className="mt-2 text-xs text-gray-500"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {puzzle.pieces.filter((p) => p.isCorrect).length} correct /{' '}
          {puzzle.pieces.length} pieces
        </div>
      </div>
    </GameContainer>
  );
}
