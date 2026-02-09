// WeightGame (Balance Scale) - Ported from original Flash ActionScript
// Player sees balance scales comparing items, must click the heaviest item
// CORRECT_SCORE: 24, INCORRECT_SCORE: -16
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

const WEIGHT_IMAGES = [
  '/assets/generated/weight-anvil.png',
  '/assets/generated/weight-feather.png',
  '/assets/generated/weight-brick.png',
  '/assets/generated/weight-ball.png',
  '/assets/generated/weight-balloon.png',
  '/assets/generated/weight-rock.png',
  '/assets/generated/weight-cloud.png',
  '/assets/generated/weight-gold-bar.png',
];

const NUM_CORRECT_BEFORE_ADDING_SCALE = 8;
const MAX_NUM_SCALES = 4;
const MAX_ITEMS_PER_SIDE = 3;

interface ScalePair {
  left: number[];   // item indices (heavier side)
  right: number[];  // item indices (lighter side)
}

interface Puzzle {
  numItems: number;
  itemWeights: number[];
  scalePairs: ScalePair[];
  heaviestItemType: number;
  itemOrder: number[]; // shuffled item indices for bottom panel
}

// Helper: pick n unique random ints from range [min, max)
function randomBasket(min: number, max: number, count: number): number[] {
  const pool = Array.from({ length: max - min }, (_, i) => i + min);
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, count);
}

function rnd(min: number, max: number): number {
  return min + Math.floor(Math.random() * (max - min));
}

export function WeightGameGame() {
  const [puzzle, setPuzzle] = useState<Puzzle | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);

  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): Puzzle => {
    // From original ActionScript: WeightGame.as
    const correctInCycle = totalCorrect % NUM_CORRECT_BEFORE_ADDING_SCALE;
    const numScales = Math.min(
      1 + Math.floor(totalCorrect / NUM_CORRECT_BEFORE_ADDING_SCALE),
      MAX_NUM_SCALES
    );

    // Extra items when player is halfway through current cycle
    let extraItems = 0;
    if (correctInCycle >= NUM_CORRECT_BEFORE_ADDING_SCALE / 2) {
      extraItems = rnd(0, 2);
    }
    const numItems = numScales + 1 + extraItems;

    // Generate unique random weights (sorted descending — index 0 is heaviest)
    const rawWeights = randomBasket(1, numItems * 2, numItems);
    const itemWeights = rawWeights.sort((a, b) => b - a);

    // Make extra items very light (weight=1) per original
    for (let i = 0; i < extraItems; i++) {
      itemWeights[numItems - 1 - i] = 1;
    }

    const heaviestItemType = 0; // index 0 always heaviest after sort

    // Generate scale pairs (from original logic)
    const scalePairs: ScalePair[] = [];
    for (let i = 0; i < numScales; i++) {
      const heavierItem = i + 1; // heavier side item
      const lighterItem = rnd(0, heavierItem); // lighter side item (could be 0=heaviest)
      scalePairs.push({
        left: [heavierItem],
        right: [lighterItem],
      });
    }

    // Add extra items to scales to balance or complicate (from original logic)
    for (let i = 0; i < extraItems; i++) {
      const extraIdx = numItems - 1 - i;
      // Find a scale where adding this item to the heavier side still keeps it lighter
      const candidates: number[] = [];
      for (let s = 0; s < numScales; s++) {
        const leftW = scalePairs[s].left.reduce((sum, idx) => sum + itemWeights[idx], 0);
        const rightW = scalePairs[s].right.reduce((sum, idx) => sum + itemWeights[idx], 0);
        if (itemWeights[extraIdx] <= rightW - leftW) {
          candidates.push(s);
        }
      }
      if (candidates.length > 0) {
        const chosen = candidates[rnd(0, candidates.length)];
        scalePairs[chosen].left.push(extraIdx);
      }
    }

    // Additional complexity at higher difficulty (from original correctInCycle >= 3)
    if (correctInCycle >= 3) {
      for (let i = 0; i < scalePairs.length; i++) {
        if (rnd(0, NUM_CORRECT_BEFORE_ADDING_SCALE - correctInCycle) === 0) {
          // Try to add a light item to the heavier side
          const leftW = scalePairs[i].left.reduce((sum, idx) => sum + itemWeights[idx], 0);
          const rightW = scalePairs[i].right.reduce((sum, idx) => sum + itemWeights[idx], 0);
          const diff = rightW - leftW;
          const addable = itemWeights.map((w, idx) => ({ w, idx })).filter(x => x.w <= diff);
          if (addable.length > 0) {
            scalePairs[i].left.push(addable[rnd(0, addable.length)].idx);
          }
        } else if (
          scalePairs[i].left.length < MAX_ITEMS_PER_SIDE &&
          scalePairs[i].right.length < MAX_ITEMS_PER_SIDE &&
          rnd(0, 2) === 0
        ) {
          // Add same item to both sides (doesn't change comparison)
          const sameItem = rnd(0, numItems);
          scalePairs[i].left.push(sameItem);
          scalePairs[i].right.push(sameItem);
        }
      }
    }

    // Shuffle scale order
    for (let i = scalePairs.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [scalePairs[i], scalePairs[j]] = [scalePairs[j], scalePairs[i]];
    }

    // Shuffle item order for bottom panel
    const itemOrder = Array.from({ length: numItems }, (_, i) => i);
    for (let i = itemOrder.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [itemOrder[i], itemOrder[j]] = [itemOrder[j], itemOrder[i]];
    }

    return { numItems, itemWeights, scalePairs, heaviestItemType, itemOrder };
  }, [totalCorrect]);

  useEffect(() => {
    setPuzzle(generatePuzzle());
  }, []);

  const handleItemClick = (itemIndex: number) => {
    if (!puzzle) return;

    if (itemIndex === puzzle.heaviestItemType) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
    } else {
      playIncorrect();
      addIncorrect();
    }

    setPuzzle(generatePuzzle());
  };

  if (!puzzle || timeRemaining <= 0) return null;

  const numScales = puzzle.scalePairs.length;
  const numRows = Math.ceil(numScales / 2);

  return (
    <GameContainer>
      <div className="flex flex-col items-center h-full">
        <div
          className="text-sm text-gray-300 mb-2"
          style={{ fontFamily: 'Baveuse, cursive' }}
        >
          Which object is the HEAVIEST?
        </div>

        {/* Scales grid — 2 per row, centered if odd last */}
        <div className="flex-1 w-full flex flex-col justify-center gap-2 mb-2">
          {Array.from({ length: numRows }).map((_, row) => {
            const startIdx = row * 2;
            const scalesInRow = Math.min(2, numScales - startIdx);
            return (
              <div key={row} className="flex justify-center gap-4">
                {Array.from({ length: scalesInRow }).map((_, col) => {
                  const pair = puzzle.scalePairs[startIdx + col];
                  const leftWeight = pair.left.reduce((s, i) => s + puzzle.itemWeights[i], 0);
                  const rightWeight = pair.right.reduce((s, i) => s + puzzle.itemWeights[i], 0);
                  const tilt = leftWeight > rightWeight ? -8 : leftWeight < rightWeight ? 8 : 0;
                  const flipH = Math.random() > 0.5; // visual variety

                  return (
                    <BalanceScale
                      key={startIdx + col}
                      leftItems={pair.left}
                      rightItems={pair.right}
                      tilt={tilt}
                      itemWeights={puzzle.itemWeights}
                    />
                  );
                })}
              </div>
            );
          })}
        </div>

        {/* Bottom item selection panel */}
        <div
          className="flex justify-center gap-3 pb-1"
        >
          {puzzle.itemOrder.map((itemIdx) => (
            <motion.button
              key={itemIdx}
              onClick={() => handleItemClick(itemIdx)}
              className="w-16 h-16 rounded-xl flex items-center justify-center overflow-hidden"
              style={{
                background: 'linear-gradient(180deg, #3a3a6a 0%, #2a2a4a 100%)',
                border: '3px solid rgba(255,255,255,0.15)',
                boxShadow: '0 4px 8px rgba(0,0,0,0.3)',
              }}
              whileHover={{ scale: 1.1, boxShadow: '0 0 18px rgba(255,215,0,0.5)', borderColor: 'rgba(255,215,0,0.6)' }}
              whileTap={{ scale: 0.9 }}
            >
              <img
                src={WEIGHT_IMAGES[itemIdx % WEIGHT_IMAGES.length]}
                className="w-12 h-12 object-contain"
                draggable={false}
                alt=""
              />
            </motion.button>
          ))}
        </div>
      </div>
    </GameContainer>
  );
}

// Balance Scale component — shows a tilting beam with items on each side
function BalanceScale({
  leftItems,
  rightItems,
  tilt,
  itemWeights,
}: {
  leftItems: number[];
  rightItems: number[];
  tilt: number;
  itemWeights: number[];
}) {
  const beamWidth = 200;
  const beamY = 50;
  const fulcrumHeight = 30;
  const platformWidth = 70;

  return (
    <div className="relative" style={{ width: beamWidth + 40, height: 110 }}>
      <svg
        width={beamWidth + 40}
        height={110}
        viewBox={`0 0 ${beamWidth + 40} 110`}
      >
        {/* Fulcrum (triangle base) */}
        <polygon
          points={`${beamWidth / 2 + 20},${beamY + 5} ${beamWidth / 2 + 10},${beamY + fulcrumHeight + 5} ${beamWidth / 2 + 30},${beamY + fulcrumHeight + 5}`}
          fill="#8b7355"
          stroke="#6b5335"
          strokeWidth="1.5"
        />
        {/* Base */}
        <rect
          x={beamWidth / 2 - 10}
          y={beamY + fulcrumHeight + 3}
          width={60}
          height={8}
          rx={3}
          fill="#6b5335"
        />

        {/* Beam (tilts) */}
        <g
          transform={`rotate(${tilt}, ${beamWidth / 2 + 20}, ${beamY})`}
        >
          {/* Main beam */}
          <rect
            x={10}
            y={beamY - 3}
            width={beamWidth + 20}
            height={6}
            rx={3}
            fill="#a08060"
            stroke="#8b7355"
            strokeWidth="1"
          />

          {/* Left platform */}
          <rect
            x={5}
            y={beamY - 6}
            width={platformWidth}
            height={5}
            rx={2}
            fill="#c0a070"
          />
          {/* Left chains */}
          <line x1={15} y1={beamY - 6} x2={20} y2={beamY - 1} stroke="#a08060" strokeWidth="1.5" />
          <line x1={platformWidth} y1={beamY - 6} x2={platformWidth - 5} y2={beamY - 1} stroke="#a08060" strokeWidth="1.5" />

          {/* Right platform */}
          <rect
            x={beamWidth + 40 - platformWidth - 5}
            y={beamY - 6}
            width={platformWidth}
            height={5}
            rx={2}
            fill="#c0a070"
          />
          {/* Right chains */}
          <line x1={beamWidth + 40 - platformWidth + 5} y1={beamY - 6} x2={beamWidth + 40 - platformWidth + 10} y2={beamY - 1} stroke="#a08060" strokeWidth="1.5" />
          <line x1={beamWidth + 30} y1={beamY - 6} x2={beamWidth + 25} y2={beamY - 1} stroke="#a08060" strokeWidth="1.5" />
        </g>
      </svg>

      {/* Left items (positioned on left platform, rotate with beam) */}
      <div
        className="absolute flex gap-0.5 justify-center"
        style={{
          left: 5,
          width: platformWidth,
          bottom: 110 - beamY + 4 + (tilt < 0 ? 8 : tilt > 0 ? -8 : 0),
          transform: `rotate(${tilt}deg)`,
          transformOrigin: 'center bottom',
        }}
      >
        {leftItems.map((itemIdx, i) => (
          <img
            key={i}
            src={WEIGHT_IMAGES[itemIdx % WEIGHT_IMAGES.length]}
            className="w-6 h-6 object-contain"
            draggable={false}
            alt=""
          />
        ))}
      </div>

      {/* Right items (positioned on right platform) */}
      <div
        className="absolute flex gap-0.5 justify-center"
        style={{
          right: 5,
          width: platformWidth,
          bottom: 110 - beamY + 4 + (tilt > 0 ? 8 : tilt < 0 ? -8 : 0),
          transform: `rotate(${tilt}deg)`,
          transformOrigin: 'center bottom',
        }}
      >
        {rightItems.map((itemIdx, i) => (
          <img
            key={i}
            src={WEIGHT_IMAGES[itemIdx % WEIGHT_IMAGES.length]}
            className="w-6 h-6 object-contain"
            draggable={false}
            alt=""
          />
        ))}
      </div>
    </div>
  );
}
