// WeightGame — single clean warm scale style
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
  '/assets/generated/weight-cube-blue.png',
  '/assets/generated/weight-cylinder-gold.png',
  '/assets/generated/weight-diamond-purple.png',
  '/assets/generated/weight-pyramid-green.png',
  '/assets/generated/weight-sphere-red.png',
  '/assets/generated/weight-star-orange.png',
];

const NUM_CORRECT_BEFORE_ADDING_SCALE = 8;
const MAX_NUM_SCALES = 4;
const MAX_ITEMS_PER_SIDE = 3;

interface ScalePair { left: number[]; right: number[]; flipped: boolean; }
interface Puzzle {
  numItems: number; itemWeights: number[]; scalePairs: ScalePair[];
  heaviestItemType: number; itemOrder: number[]; imageMap: number[];
}

function randomBasket(min: number, max: number, count: number): number[] {
  const pool = Array.from({ length: max - min }, (_, i) => i + min);
  for (let i = pool.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [pool[i], pool[j]] = [pool[j], pool[i]]; }
  return pool.slice(0, count);
}
function rnd(min: number, max: number) { return min + Math.floor(Math.random() * (max - min)); }
function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [a[i], a[j]] = [a[j], a[i]]; }
  return a;
}

// ─── Shared Geometry ───────────────────────────────────────────────────
const TILT_DEG = 12;
const TILT_RAD = (TILT_DEG * Math.PI) / 180;
const SIN_T = Math.sin(TILT_RAD);
const COS_T = Math.cos(TILT_RAD);

const VB_W = 300, VB_H = 160;
const PIVOT_X = VB_W / 2, PIVOT_Y = 46;
const BEAM_HALF = 105;
const CHAIN_LEN = 34, PLAT_W = 90, ITEM_SIZE = 42;

interface Geo {
  lx: number; ly: number; rx: number; ry: number;
  lpx: number; lpy: number; rpx: number; rpy: number;
  leftItems: { idx: number; x: number; y: number }[];
  rightItems: { idx: number; x: number; y: number }[];
  ftop: number; fbot: number;
}

function calcGeo(leftArr: number[], rightArr: number[], heavierSide: 'left' | 'right'): Geo {
  const ts = heavierSide === 'right' ? 1 : -1;
  const lx = PIVOT_X - BEAM_HALF * COS_T, ly = PIVOT_Y - ts * BEAM_HALF * SIN_T;
  const rx = PIVOT_X + BEAM_HALF * COS_T, ry = PIVOT_Y + ts * BEAM_HALF * SIN_T;
  const lpx = lx, lpy = ly + CHAIN_LEN;
  const rpx = rx, rpy = ry + CHAIN_LEN;

  const layout = (items: number[], cx: number, py: number) => {
    if (!items.length) return [];
    const sp = Math.min(ITEM_SIZE, (PLAT_W - 4) / items.length);
    const tw = sp * items.length;
    const sx = cx - tw / 2 + sp / 2 - ITEM_SIZE / 2;
    return items.map((idx, i) => ({ idx, x: sx + i * sp, y: py - ITEM_SIZE }));
  };

  return {
    lx, ly, rx, ry, lpx, lpy, rpx, rpy,
    leftItems: layout(leftArr, lpx, lpy),
    rightItems: layout(rightArr, rpx, rpy),
    ftop: PIVOT_Y + 5.5, fbot: PIVOT_Y + 5.5 + 28,
  };
}

// ─── Main Component ────────────────────────────────────────────────────
export function WeightGameGame() {
  const [puzzle, setPuzzle] = useState<Puzzle | null>(null);
  const [totalCorrect, setTotalCorrect] = useState(0);

  const addCorrect = useGameStore((s) => s.addCorrect);
  const addIncorrect = useGameStore((s) => s.addIncorrect);
  const timeRemaining = useGameStore((s) => s.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback((): Puzzle => {
    const correctInCycle = totalCorrect % NUM_CORRECT_BEFORE_ADDING_SCALE;
    const numScales = Math.min(1 + Math.floor(totalCorrect / NUM_CORRECT_BEFORE_ADDING_SCALE), MAX_NUM_SCALES);
    let extraItems = 0;
    if (correctInCycle >= NUM_CORRECT_BEFORE_ADDING_SCALE / 2) extraItems = rnd(0, 2);
    const numItems = numScales + 1 + extraItems;
    const itemWeights = randomBasket(1, numItems * 2, numItems).sort((a, b) => b - a);
    for (let i = 0; i < extraItems; i++) itemWeights[numItems - 1 - i] = 1;

    const imageMap = shuffle(Array.from({ length: WEIGHT_IMAGES.length }, (_, i) => i))
      .slice(0, numItems);
    while (imageMap.length < numItems) imageMap.push(imageMap[imageMap.length % WEIGHT_IMAGES.length]);

    const scalePairs: ScalePair[] = [];
    for (let i = 0; i < numScales; i++) {
      scalePairs.push({ left: [i + 1], right: [rnd(0, i + 1)], flipped: Math.random() > 0.5 });
    }
    for (let i = 0; i < extraItems; i++) {
      const extraIdx = numItems - 1 - i;
      const cands: number[] = [];
      for (let s = 0; s < numScales; s++) {
        const lw = scalePairs[s].left.reduce((sum, idx) => sum + itemWeights[idx], 0);
        const rw = scalePairs[s].right.reduce((sum, idx) => sum + itemWeights[idx], 0);
        if (itemWeights[extraIdx] <= rw - lw) cands.push(s);
      }
      if (cands.length > 0) scalePairs[cands[rnd(0, cands.length)]].left.push(extraIdx);
    }
    if (correctInCycle >= 3) {
      for (let i = 0; i < scalePairs.length; i++) {
        if (rnd(0, NUM_CORRECT_BEFORE_ADDING_SCALE - correctInCycle) === 0) {
          const lw = scalePairs[i].left.reduce((s, idx) => s + itemWeights[idx], 0);
          const rw = scalePairs[i].right.reduce((s, idx) => s + itemWeights[idx], 0);
          const addable = itemWeights.map((w, idx) => ({ w, idx })).filter(x => x.w <= rw - lw);
          if (addable.length > 0) scalePairs[i].left.push(addable[rnd(0, addable.length)].idx);
        } else if (scalePairs[i].left.length < MAX_ITEMS_PER_SIDE && scalePairs[i].right.length < MAX_ITEMS_PER_SIDE && rnd(0, 2) === 0) {
          const s = rnd(0, numItems); scalePairs[i].left.push(s); scalePairs[i].right.push(s);
        }
      }
    }
    for (let i = scalePairs.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [scalePairs[i], scalePairs[j]] = [scalePairs[j], scalePairs[i]]; }
    return { numItems, itemWeights, scalePairs, heaviestItemType: 0, itemOrder: shuffle(Array.from({ length: numItems }, (_, i) => i)), imageMap };
  }, [totalCorrect]);

  useEffect(() => { setPuzzle(generatePuzzle()); }, []);

  const handleItemClick = (itemIndex: number) => {
    if (!puzzle) return;
    if (itemIndex === puzzle.heaviestItemType) { playCorrect(); addCorrect(); setTotalCorrect(p => p + 1); }
    else { playIncorrect(); addIncorrect(); }
    setPuzzle(generatePuzzle());
  };

  if (!puzzle || timeRemaining <= 0) return null;

  const numScales = puzzle.scalePairs.length;
  const numRows = Math.ceil(numScales / 2);
  const getImg = (i: number) => WEIGHT_IMAGES[puzzle.imageMap[i]];
  const cw = numScales === 1 ? 500 : numScales === 2 ? 285 : 265;

  const renderScale = (pairIdx: number) => {
    const pair = puzzle.scalePairs[pairIdx];
    const lw = pair.left.reduce((s, i) => s + puzzle.itemWeights[i], 0);
    const rw = pair.right.reduce((s, i) => s + puzzle.itemWeights[i], 0);
    const hs: 'left' | 'right' = lw > rw ? 'left' : 'right';
    const li = pair.flipped ? pair.right : pair.left;
    const ri = pair.flipped ? pair.left : pair.right;
    const fhs = pair.flipped ? (hs === 'left' ? 'right' : 'left') : hs;
    const g = calcGeo(li, ri, fhs as 'left' | 'right');

    return <ScaleClean key={pairIdx} g={g} id={pairIdx} w={cw} getImg={getImg} />;
  };

  return (
    <GameContainer>
      <div className="flex flex-col items-center h-full">
        <div className="text-base tracking-wide" style={{
          fontFamily: 'Baveuse, cursive',
          color: '#5a4030',
          textShadow: 'none',
        }}>
          Tap the HEAVIEST object
        </div>

        <div className="flex-1 w-full flex flex-col justify-center gap-1 my-1" style={{
          background: 'linear-gradient(180deg, #f5efe8 0%, #ebe3d8 100%)',
          borderRadius: 12,
          padding: '8px 4px',
          border: '1px solid rgba(0,0,0,0.08)',
        }}>
          {Array.from({ length: numRows }).map((_, row) => {
            const si = row * 2;
            return (
              <div key={row} className="flex justify-center gap-2">
                {Array.from({ length: Math.min(2, numScales - si) }).map((_, col) => renderScale(si + col))}
              </div>
            );
          })}
        </div>

        {/* Bottom buttons — light rounded cards */}
        <div className="flex justify-center gap-3 py-2 flex-wrap">
          {puzzle.itemOrder.map((itemIdx) => (
            <motion.button key={itemIdx} onClick={() => handleItemClick(itemIdx)}
              className="flex items-center justify-center overflow-hidden cursor-pointer"
              style={{
                width: 72,
                height: 72,
                background: '#fff',
                border: '2px solid #ddd',
                borderRadius: 14,
                boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
              }}
              whileHover={{
                scale: 1.12,
                boxShadow: '0 4px 16px rgba(0,0,0,0.18)',
                borderColor: '#e74c3c',
              }}
              whileTap={{ scale: 0.9 }}>
              <img src={getImg(itemIdx)} style={{ width: 54, height: 54, objectFit: 'contain' }} draggable={false} alt="" />
            </motion.button>
          ))}
        </div>
      </div>
    </GameContainer>
  );
}

// ─── Scale Props ────────────────────────────────────────────────────
interface SP { g: Geo; id: number; w: number; getImg: (i: number) => string; }
const h = (w: number) => (w / VB_W) * VB_H;

// ═══════════════════════════════════════════════════════════════════════
// SINGLE CLEAN STYLE — Warm wood beam, clean cards, soft shadows
// ═══════════════════════════════════════════════════════════════════════
function ScaleClean({ g, id, w, getImg }: SP) {
  return (
    <svg width={w} height={h(w)} viewBox={`0 0 ${VB_W} ${VB_H}`} style={{ display: 'block' }}>
      <defs>
        <linearGradient id={`beam-${id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#b08050" />
          <stop offset="50%" stopColor="#8c6438" />
          <stop offset="100%" stopColor="#6a4828" />
        </linearGradient>
        <linearGradient id={`plat-${id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#d4a860" />
          <stop offset="100%" stopColor="#b08040" />
        </linearGradient>
        <filter id={`sh-${id}`}>
          <feDropShadow dx="0" dy="1" stdDeviation="1.5" floodColor="#000" floodOpacity="0.15" />
        </filter>
      </defs>

      {/* Fulcrum — dark simple triangle */}
      <polygon points={`${PIVOT_X},${g.ftop} ${PIVOT_X - 12},${g.fbot} ${PIVOT_X + 12},${g.fbot}`}
        fill="#5a4030" stroke="#3a2820" strokeWidth="1.5" strokeLinejoin="round" />
      <rect x={PIVOT_X - 18} y={g.fbot} width={36} height={5} rx={2.5} fill="#4a3828" />

      {/* Warm wood beam */}
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke="#4a3020" strokeWidth={7} strokeLinecap="round" />
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke={`url(#beam-${id})`} strokeWidth={5} strokeLinecap="round" />
      <circle cx={PIVOT_X} cy={PIVOT_Y} r={4} fill="#6a4828" stroke="#4a3020" strokeWidth="1.5" />

      {/* Chains — brown rope lines */}
      {[[g.lx, g.ly, g.lpx, g.lpy], [g.rx, g.ry, g.rpx, g.rpy]].map(([bx, by, px, py], ci) => (
        <g key={ci}>
          <line x1={bx - 6} y1={by + 4} x2={px - PLAT_W / 2 + 4} y2={py} stroke="#8c6438" strokeWidth="1.5" />
          <line x1={bx + 6} y1={by + 4} x2={px + PLAT_W / 2 - 4} y2={py} stroke="#8c6438" strokeWidth="1.5" />
        </g>
      ))}

      {/* Platforms — tan/gold */}
      {[[g.lpx, g.lpy], [g.rpx, g.rpy]].map(([cx, cy], pi) => (
        <rect key={pi} x={cx - PLAT_W / 2} y={cy} width={PLAT_W} height={7} rx={3}
          fill={`url(#plat-${id})`} stroke="#8c6438" strokeWidth="1" />
      ))}

      {/* Items on light rounded cards with soft shadows */}
      {[...g.leftItems, ...g.rightItems].map((pos, i) => (
        <g key={i} filter={`url(#sh-${id})`}>
          <rect x={pos.x - 4} y={pos.y - 4} width={ITEM_SIZE + 8} height={ITEM_SIZE + 8}
            rx={8} fill="#fff" stroke="#e0d4c8" strokeWidth="1" />
          <image href={getImg(pos.idx)} x={pos.x} y={pos.y} width={ITEM_SIZE} height={ITEM_SIZE} />
        </g>
      ))}
    </svg>
  );
}
