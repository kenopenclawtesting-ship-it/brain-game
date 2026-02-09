// ShapeOrder Game - FROM SOURCE.md
// Watch the sequence of shapes, then repeat it in the correct order
// CORRECT_SCORE: 18 per shape, INCORRECT_SCORE: -12
import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

// Shape definitions with AI-generated images
const SHAPES = [
  { image: '/assets/generated/shape-circle.png', color: '#ef4444', name: 'circle' },
  { image: '/assets/generated/shape-square.png', color: '#3b82f6', name: 'square' },
  { image: '/assets/generated/shape-triangle.png', color: '#22c55e', name: 'triangle' },
  { image: '/assets/generated/shape-star.png', color: '#fbbf24', name: 'star' },
  { image: '/assets/generated/shape-diamond.png', color: '#a855f7', name: 'diamond' },
  { image: '/assets/generated/shape-hexagon.png', color: '#06b6d4', name: 'hexagon' },
  { image: '/assets/generated/shape-circle.png', color: '#ec4899', name: 'heart', hueRotate: 300 },
  { image: '/assets/generated/shape-star.png', color: '#f97316', name: 'sparkle', hueRotate: 30 },
] as const;

// Difficulty parameters from ActionScript DIFFICULTY_LEVEL_PARAMS
const DIFFICULTY_PARAMS = [
  { numIcons: 3, extraChoices: 1, speedMult: 1.2 },
  { numIcons: 3, extraChoices: 2, speedMult: 1.4 },
  { numIcons: 4, extraChoices: 1, speedMult: 1.4 },
  { numIcons: 4, extraChoices: 2, speedMult: 1.6 },
  { numIcons: 5, extraChoices: 1, speedMult: 1.6 },
  { numIcons: 5, extraChoices: 2, speedMult: 1.8 },
  { numIcons: 6, extraChoices: 1, speedMult: 1.8 },
  { numIcons: 6, extraChoices: 2, speedMult: 2.0 },
  { numIcons: 6, extraChoices: 2, speedMult: 2.2 },
  { numIcons: 7, extraChoices: 1, speedMult: 2.0 },
  { numIcons: 7, extraChoices: 2, speedMult: 2.2 },
  { numIcons: 7, extraChoices: 2, speedMult: 2.4 },
  { numIcons: 8, extraChoices: 1, speedMult: 2.2 },
  { numIcons: 8, extraChoices: 2, speedMult: 2.4 },
  { numIcons: 8, extraChoices: 2, speedMult: 2.6 },
];

type Phase = 'showing' | 'ready' | 'input';

export function ShapeOrderGame() {
  const [sequence, setSequence] = useState<number[]>([]);
  const [userSequence, setUserSequence] = useState<number[]>([]);
  const [phase, setPhase] = useState<Phase>('showing');
  const [showingIndex, setShowingIndex] = useState(-1);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [availableShapes, setAvailableShapes] = useState<number[]>([]);
  const [topPanelShapes, setTopPanelShapes] = useState<(number | null)[]>([]);
  
  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generateSequence = useCallback(() => {
    const params = DIFFICULTY_PARAMS[Math.min(totalCorrect, DIFFICULTY_PARAMS.length - 1)];
    const { numIcons, extraChoices } = params;
    
    // Generate random sequence (can have repeats)
    const seq: number[] = [];
    for (let i = 0; i < numIcons; i++) {
      seq.push(Math.floor(Math.random() * SHAPES.length));
    }
    
    // Available shapes for selection (unique shapes from sequence + extras)
    const uniqueShapes = new Set(seq);
    while (uniqueShapes.size < Math.min(numIcons + extraChoices, SHAPES.length)) {
      uniqueShapes.add(Math.floor(Math.random() * SHAPES.length));
    }
    
    setSequence(seq);
    setAvailableShapes(Array.from(uniqueShapes).sort(() => Math.random() - 0.5));
    setUserSequence([]);
    setTopPanelShapes(new Array(numIcons).fill(null));
    setPhase('showing');
    setShowingIndex(-1);
  }, [totalCorrect]);

  useEffect(() => {
    generateSequence();
  }, []);

  // Show sequence animation
  useEffect(() => {
    if (phase !== 'showing') return;
    
    const params = DIFFICULTY_PARAMS[Math.min(totalCorrect, DIFFICULTY_PARAMS.length - 1)];
    const baseSpeed = 1000 / params.speedMult;
    
    const showNext = () => {
      setShowingIndex((prev) => {
        const next = prev + 1;
        if (next >= sequence.length) {
          // Done showing - wait then go to ready
          setTimeout(() => {
            setPhase('ready');
            // After 3 second delay (or click), go to input
            setTimeout(() => setPhase('input'), 3000);
          }, 500);
          return prev;
        }
        return next;
      });
    };
    
    // Start showing after small delay
    const timer = setTimeout(showNext, showingIndex === -1 ? 300 : baseSpeed);
    
    return () => clearTimeout(timer);
  }, [phase, showingIndex, sequence.length, totalCorrect]);

  const handleSkip = () => {
    if (phase === 'ready') {
      setPhase('input');
    }
  };

  const handleShapeClick = (shapeIndex: number) => {
    if (phase !== 'input') return;
    
    const expectedIndex = userSequence.length;
    const expectedShape = sequence[expectedIndex];
    
    // Update top panel to show the guess
    const newTopPanels = [...topPanelShapes];
    newTopPanels[expectedIndex] = shapeIndex;
    setTopPanelShapes(newTopPanels);
    
    if (shapeIndex !== expectedShape) {
      playIncorrect();
      addIncorrect();
      setTimeout(() => generateSequence(), 500);
      return;
    }
    
    // Correct!
    playCorrect();
    addCorrect();
    const newUserSequence = [...userSequence, shapeIndex];
    setUserSequence(newUserSequence);
    
    // Check if complete
    if (newUserSequence.length === sequence.length) {
      setTotalCorrect((prev) => prev + 1);
      setTimeout(() => generateSequence(), 500);
    }
  };

  if (timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full" onClick={handleSkip}>
        {/* Status */}
        <div 
          className="text-sm text-gray-300 mb-3"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          {phase === 'showing' && 'Watch the sequence...'}
          {phase === 'ready' && (
            <span className="text-yellow-400 animate-pulse">PRESS ANY KEY</span>
          )}
          {phase === 'input' && `Select shape ${userSequence.length + 1} of ${sequence.length}`}
        </div>

        {/* Top panel - shows sequence positions */}
        <div className="flex gap-2 mb-4">
          {topPanelShapes.map((shape, i) => {
            const isActive = phase === 'showing' && showingIndex === i;
            const isCurrent = phase === 'input' && i === userSequence.length;
            const shapeData = isActive ? SHAPES[sequence[i]] : shape !== null ? SHAPES[shape] : null;
            return (
              <motion.div
                key={i}
                className="w-12 h-12 rounded-lg flex items-center justify-center overflow-hidden"
                style={{
                  background: isActive
                    ? 'linear-gradient(180deg, #4a4a8a 0%, #3a3a6a 100%)'
                    : 'linear-gradient(180deg, #2a2a4a 0%, #1a1a3a 100%)',
                  border: isCurrent
                    ? '2px solid #ffd700'
                    : '2px solid rgba(255,255,255,0.1)',
                  boxShadow: isActive
                    ? '0 0 15px rgba(100,100,255,0.5)'
                    : 'none',
                }}
                animate={{ scale: isActive ? 1.1 : 1 }}
              >
                {shapeData ? (
                  <img
                    src={shapeData.image}
                    className="w-9 h-9 object-contain"
                    style={{ filter: 'hueRotate' in shapeData ? `hue-rotate(${shapeData.hueRotate}deg)` : undefined }}
                    draggable={false}
                    alt=""
                  />
                ) : (
                  <img
                    src="/assets/generated/shape-slot-empty.png"
                    className="w-9 h-9 object-contain opacity-40"
                    draggable={false}
                    alt=""
                  />
                )}
              </motion.div>
            );
          })}
        </div>

        {/* Main display area during showing phase */}
        {phase === 'showing' && showingIndex >= 0 && (
          <motion.div
            key={showingIndex}
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0, opacity: 0 }}
            className="h-24 mb-4 flex items-center justify-center"
          >
            {SHAPES[sequence[showingIndex]] && (
              <img
                src={SHAPES[sequence[showingIndex]].image}
                className="h-20 w-20 object-contain drop-shadow-lg"
                style={{
                  filter: `drop-shadow(0 0 20px ${SHAPES[sequence[showingIndex]].color}66)${'hueRotate' in SHAPES[sequence[showingIndex]] ? ` hue-rotate(${(SHAPES[sequence[showingIndex]] as any).hueRotate}deg)` : ''}`,
                }}
                draggable={false}
                alt=""
              />
            )}
          </motion.div>
        )}

        {/* Shape selection - shown after reveal */}
        {(phase === 'ready' || phase === 'input') && (
          <motion.div
            initial={{ y: 50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            className="flex gap-3 flex-wrap justify-center mt-4"
          >
            {availableShapes.map((shapeIdx) => (
              <motion.button
                key={shapeIdx}
                onClick={(e) => {
                  e.stopPropagation();
                  handleShapeClick(shapeIdx);
                }}
                className="w-16 h-16 rounded-xl flex items-center justify-center overflow-hidden"
                style={{
                  background: 'linear-gradient(180deg, #3a3a6a 0%, #2a2a4a 100%)',
                  border: '2px solid rgba(255,255,255,0.2)',
                  cursor: phase === 'input' ? 'pointer' : 'not-allowed',
                  opacity: phase === 'input' ? 1 : 0.5,
                }}
                whileHover={phase === 'input' ? {
                  scale: 1.1,
                  boxShadow: `0 0 20px ${SHAPES[shapeIdx].color}66`
                } : {}}
                whileTap={phase === 'input' ? { scale: 0.9 } : {}}
                disabled={phase !== 'input'}
              >
                <img
                  src={SHAPES[shapeIdx].image}
                  className="w-11 h-11 object-contain"
                  style={{ filter: 'hueRotate' in SHAPES[shapeIdx] ? `hue-rotate(${(SHAPES[shapeIdx] as any).hueRotate}deg)` : undefined }}
                  draggable={false}
                  alt=""
                />
              </motion.button>
            ))}
          </motion.div>
        )}

        {/* Progress dots */}
        <div className="mt-4 flex gap-1">
          {sequence.map((_, i) => (
            <div
              key={i}
              className="w-2 h-2 rounded-full transition-colors"
              style={{
                background: i < userSequence.length ? '#22c55e' :
                  i === userSequence.length && phase === 'input' ? '#ffd700' : 
                  '#444',
              }}
            />
          ))}
        </div>
      </div>
    </GameContainer>
  );
}
