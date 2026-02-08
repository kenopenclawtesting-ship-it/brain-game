// JigsawMatch Game - FROM SOURCE.md
// Match jigsaw pieces to their correct outlines
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

// Simple shapes as "jigsaw pieces"
const PIECES = [
  { path: 'M0,0 L30,0 L30,30 L0,30 Z', name: 'square' },
  { path: 'M15,0 L30,30 L0,30 Z', name: 'triangle' },
  { path: 'M15,0 L30,15 L15,30 L0,15 Z', name: 'diamond' },
  { path: 'M0,15 Q15,0 30,15 Q15,30 0,15', name: 'oval' },
  { path: 'M15,0 L20,10 L30,12 L22,20 L25,30 L15,25 L5,30 L8,20 L0,12 L10,10 Z', name: 'star' },
  { path: 'M0,10 L10,10 L10,0 L20,0 L20,10 L30,10 L30,20 L20,20 L20,30 L10,30 L10,20 L0,20 Z', name: 'cross' },
];

const COLORS = ['#ef4444', '#3b82f6', '#22c55e', '#eab308', '#8b5cf6', '#ec4899'];

interface Piece {
  id: number;
  shapeIndex: number;
  color: string;
  rotation: number;
}

interface Slot {
  id: number;
  shapeIndex: number;
  rotation: number;
  matched: boolean;
}

export function JigsawMatchGame() {
  const [pieces, setPieces] = useState<Piece[]>([]);
  const [slots, setSlots] = useState<Slot[]>([]);
  const [selectedPiece, setSelectedPiece] = useState<number | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback(() => {
    const numPieces = Math.min(3 + Math.floor(totalCorrect / 3), 5);
    
    // Select random shapes
    const shapeIndices = Array.from({ length: PIECES.length }, (_, i) => i)
      .sort(() => Math.random() - 0.5)
      .slice(0, numPieces);
    
    // Create pieces (with random colors)
    const newPieces = shapeIndices.map((shapeIndex, i) => ({
      id: i,
      shapeIndex,
      color: COLORS[i % COLORS.length],
      rotation: 0,
    }));
    
    // Create slots (in different order)
    const shuffledIndices = [...shapeIndices].sort(() => Math.random() - 0.5);
    const newSlots = shuffledIndices.map((shapeIndex, i) => ({
      id: i,
      shapeIndex,
      rotation: 0,
      matched: false,
    }));
    
    setPieces(newPieces.sort(() => Math.random() - 0.5));
    setSlots(newSlots);
    setSelectedPiece(null);
  }, [totalCorrect]);

  useEffect(() => {
    generatePuzzle();
  }, []);

  const handlePieceClick = (pieceId: number) => {
    const piece = pieces.find((p) => p.id === pieceId);
    if (!piece) return;
    
    // Check if already matched
    const isMatched = slots.some(
      (s) => s.matched && s.shapeIndex === piece.shapeIndex
    );
    if (isMatched) return;
    
    setSelectedPiece(pieceId);
  };

  const handleSlotClick = (slotId: number) => {
    if (selectedPiece === null) return;
    
    const piece = pieces.find((p) => p.id === selectedPiece);
    const slot = slots.find((s) => s.id === slotId);
    
    if (!piece || !slot || slot.matched) return;
    
    if (piece.shapeIndex === slot.shapeIndex) {
      playCorrect();
      addCorrect();
      
      setSlots((prev) => prev.map((s) =>
        s.id === slotId ? { ...s, matched: true } : s
      ));
      
      // Check if all matched
      const allMatched = slots.filter((s) => s.id !== slotId).every((s) => s.matched);
      if (allMatched) {
        setTotalCorrect((prev) => prev + 1);
        setTimeout(() => generatePuzzle(), 500);
      }
    } else {
      playIncorrect();
      addIncorrect();
    }
    
    setSelectedPiece(null);
  };

  if (timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        <div className="text-sm text-gray-500 mb-4">
          {selectedPiece !== null 
            ? 'Now click a slot to place the piece' 
            : 'Click a piece, then click its matching slot'
          }
        </div>

        {/* Slots (outlines) */}
        <div className="flex gap-4 mb-8">
          {slots.map((slot) => (
            <motion.button
              key={slot.id}
              onClick={() => handleSlotClick(slot.id)}
              className={`
                w-20 h-20 rounded-lg border-4 flex items-center justify-center
                ${slot.matched 
                  ? 'bg-green-100 border-green-500' 
                  : 'bg-gray-100 border-dashed border-gray-400 hover:border-blue-500'
                }
              `}
              whileHover={!slot.matched ? { scale: 1.05 } : {}}
            >
              <svg width="40" height="40" viewBox="0 0 30 30">
                <path
                  d={PIECES[slot.shapeIndex].path}
                  fill={slot.matched ? '#22c55e' : 'none'}
                  stroke={slot.matched ? '#22c55e' : '#9ca3af'}
                  strokeWidth="2"
                  strokeDasharray={slot.matched ? 'none' : '4'}
                />
              </svg>
            </motion.button>
          ))}
        </div>

        {/* Pieces */}
        <div className="flex gap-4">
          {pieces.map((piece) => {
            const isMatched = slots.some(
              (s) => s.matched && s.shapeIndex === piece.shapeIndex
            );
            
            return (
              <motion.button
                key={piece.id}
                onClick={() => handlePieceClick(piece.id)}
                className={`
                  w-20 h-20 rounded-lg border-4 flex items-center justify-center
                  transition-all
                  ${isMatched 
                    ? 'opacity-30 cursor-not-allowed' 
                    : selectedPiece === piece.id
                      ? 'border-blue-500 bg-blue-50'
                      : 'border-gray-300 bg-white hover:border-blue-400'
                  }
                `}
                whileHover={!isMatched ? { scale: 1.05 } : {}}
                whileTap={!isMatched ? { scale: 0.95 } : {}}
                disabled={isMatched}
              >
                <svg width="40" height="40" viewBox="0 0 30 30">
                  <path
                    d={PIECES[piece.shapeIndex].path}
                    fill={piece.color}
                    stroke={piece.color}
                    strokeWidth="1"
                  />
                </svg>
              </motion.button>
            );
          })}
        </div>

        <div className="mt-6 text-sm text-gray-500">
          {slots.filter((s) => s.matched).length} / {slots.length} matched
        </div>
      </div>
    </GameContainer>
  );
}
