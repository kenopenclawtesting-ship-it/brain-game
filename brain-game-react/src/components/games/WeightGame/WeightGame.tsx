// WeightGame — 3 visual styles selectable via ?wv=1|2|3
import { useState, useEffect, useCallback, useMemo } from 'react';
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

// Read style from URL: ?wv=1 (neon), ?wv=2 (flash), ?wv=3 (royal)
function getStyleVariant(): 1 | 2 | 3 {
  const p = new URLSearchParams(window.location.search).get('wv');
  if (p === '2') return 2;
  if (p === '3') return 3;
  return 1;
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
  const styleVariant = useMemo(getStyleVariant, []);

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
    // If numItems > WEIGHT_IMAGES.length, wrap
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

    if (styleVariant === 2) return <ScaleFlash key={pairIdx} g={g} id={pairIdx} w={cw} getImg={getImg} />;
    if (styleVariant === 3) return <ScaleRoyal key={pairIdx} g={g} id={pairIdx} w={cw} getImg={getImg} />;
    return <ScaleNeon key={pairIdx} g={g} id={pairIdx} w={cw} getImg={getImg} />;
  };

  // Style-specific wrapper backgrounds
  const scaleAreaStyle: React.CSSProperties = styleVariant === 2
    ? { background: 'linear-gradient(180deg, #e8eaf0 0%, #d0d4e0 100%)', borderRadius: 12, padding: '8px 4px', border: '1px solid rgba(0,0,0,0.1)' }
    : styleVariant === 3
    ? { background: 'radial-gradient(ellipse at 50% 40%, rgba(60,40,20,0.5) 0%, rgba(10,10,30,0.3) 100%)', borderRadius: 12, padding: '8px 4px', border: '1px solid rgba(255,200,80,0.12)' }
    : { background: 'rgba(0,0,0,0.25)', borderRadius: 12, padding: '8px 4px', border: '1px solid rgba(100,200,255,0.08)' };

  const titleStyle: React.CSSProperties = styleVariant === 2
    ? { fontFamily: 'Baveuse, cursive', color: '#333', textShadow: 'none' }
    : styleVariant === 3
    ? { fontFamily: 'Baveuse, cursive', color: '#ffd700', textShadow: '0 0 15px rgba(255,200,50,0.4), 0 2px 4px rgba(0,0,0,0.6)' }
    : { fontFamily: 'Baveuse, cursive', color: '#60d0ff', textShadow: '0 0 15px rgba(80,200,255,0.4), 0 2px 4px rgba(0,0,0,0.6)' };

  return (
    <GameContainer>
      <div className="flex flex-col items-center h-full">
        <div className="text-base tracking-wide" style={titleStyle}>
          Tap the HEAVIEST object
        </div>

        <div className="flex-1 w-full flex flex-col justify-center gap-1 my-1" style={scaleAreaStyle}>
          {Array.from({ length: numRows }).map((_, row) => {
            const si = row * 2;
            return (
              <div key={row} className="flex justify-center gap-2">
                {Array.from({ length: Math.min(2, numScales - si) }).map((_, col) => renderScale(si + col))}
              </div>
            );
          })}
        </div>

        {/* Bottom buttons — style-specific */}
        <div className="flex justify-center gap-3 py-2 flex-wrap">
          {puzzle.itemOrder.map((itemIdx) => {
            const btnStyle: React.CSSProperties = styleVariant === 2
              ? { width: 72, height: 72, background: '#fff', border: '2px solid #ccc', borderRadius: 14, boxShadow: '0 2px 8px rgba(0,0,0,0.15)' }
              : styleVariant === 3
              ? { width: 70, height: 70, background: 'radial-gradient(circle, #2a2040 0%, #1a1030 100%)', border: '2.5px solid #c8a040', borderRadius: '50%', boxShadow: '0 0 12px rgba(200,160,60,0.3), 0 4px 10px rgba(0,0,0,0.5)' }
              : { width: 70, height: 70, background: 'linear-gradient(180deg, rgba(20,30,60,0.9) 0%, rgba(10,15,40,0.95) 100%)', border: '2px solid rgba(80,180,255,0.3)', borderRadius: 14, boxShadow: '0 0 10px rgba(60,160,255,0.15), 0 4px 10px rgba(0,0,0,0.4)' };
            const hoverStyle = styleVariant === 2
              ? { scale: 1.12, boxShadow: '0 4px 16px rgba(0,0,0,0.25)', borderColor: '#4a90d9' }
              : styleVariant === 3
              ? { scale: 1.12, boxShadow: '0 0 20px rgba(255,200,50,0.5), 0 4px 10px rgba(0,0,0,0.5)', borderColor: '#ffd700' }
              : { scale: 1.12, boxShadow: '0 0 20px rgba(60,180,255,0.5), 0 4px 10px rgba(0,0,0,0.5)', borderColor: 'rgba(80,200,255,0.8)' };
            const imgSize = styleVariant === 2 ? 54 : 48;
            return (
              <motion.button key={itemIdx} onClick={() => handleItemClick(itemIdx)}
                className="flex items-center justify-center overflow-hidden cursor-pointer"
                style={btnStyle} whileHover={hoverStyle} whileTap={{ scale: 0.9 }}>
                <img src={getImg(itemIdx)} style={{ width: imgSize, height: imgSize, objectFit: 'contain' }} draggable={false} alt="" />
              </motion.button>
            );
          })}
        </div>
      </div>
    </GameContainer>
  );
}

// ─── Shared Scale Props ────────────────────────────────────────────────
interface SP { g: Geo; id: number; w: number; getImg: (i: number) => string; }
const h = (w: number) => (w / VB_W) * VB_H;

// ═══════════════════════════════════════════════════════════════════════
// STYLE 1 — NEON GLOW
// Dark theme, items with colored glow halos, neon edge-lit scale
// ═══════════════════════════════════════════════════════════════════════
function ScaleNeon({ g, id, w, getImg }: SP) {
  return (
    <svg width={w} height={h(w)} viewBox={`0 0 ${VB_W} ${VB_H}`} style={{ display: 'block' }}>
      <defs>
        <linearGradient id={`nb-${id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#304060" />
          <stop offset="100%" stopColor="#1a2030" />
        </linearGradient>
        <linearGradient id={`np-${id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#405878" />
          <stop offset="100%" stopColor="#283848" />
        </linearGradient>
        <filter id={`ng-${id}`}>
          <feGaussianBlur in="SourceGraphic" stdDeviation="3" result="blur" />
          <feFlood floodColor="#40a0ff" floodOpacity="0.6" result="color" />
          <feComposite in="color" in2="blur" operator="in" result="glow" />
          <feMerge><feMergeNode in="glow" /><feMergeNode in="SourceGraphic" /></feMerge>
        </filter>
        <filter id={`nig-${id}`}>
          <feGaussianBlur in="SourceAlpha" stdDeviation="2.5" result="blur" />
          <feFlood floodColor="#60c0ff" floodOpacity="0.5" result="color" />
          <feComposite in="color" in2="blur" operator="in" result="glow" />
          <feMerge><feMergeNode in="glow" /><feMergeNode in="SourceGraphic" /></feMerge>
        </filter>
        <filter id={`nsh-${id}`}>
          <feDropShadow dx="0" dy="1" stdDeviation="2" floodColor="#000" floodOpacity="0.6" />
        </filter>
      </defs>

      {/* Fulcrum */}
      <polygon points={`${PIVOT_X},${g.ftop} ${PIVOT_X - 14},${g.fbot} ${PIVOT_X + 14},${g.fbot}`}
        fill={`url(#${`nb-${id}`})`} stroke="#406080" strokeWidth="1" strokeLinejoin="round" />
      <rect x={PIVOT_X - 20} y={g.fbot - 1} width={40} height={6} rx={3} fill="#283848" stroke="#406080" strokeWidth="0.6" />

      {/* Beam with neon edge */}
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke="#1a2030" strokeWidth={10} strokeLinecap="round" />
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke={`url(#${`nb-${id}`})`} strokeWidth={8} strokeLinecap="round" />
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke="rgba(80,180,255,0.3)" strokeWidth={10} strokeLinecap="round" filter={`url(#${`ng-${id}`})`} />
      {/* Pivot */}
      <circle cx={PIVOT_X} cy={PIVOT_Y} r={5} fill="#304060" stroke="#50a0e0" strokeWidth="1.5" />

      {/* Chains */}
      {[[g.lx, g.ly, g.lpx, g.lpy], [g.rx, g.ry, g.rpx, g.rpy]].map(([bx, by, px, py], ci) => (
        <g key={ci}>
          <line x1={bx - 5} y1={by + 5} x2={px - PLAT_W / 2 + 5} y2={py} stroke="#50a0e0" strokeWidth="1" opacity="0.6" />
          <line x1={bx + 5} y1={by + 5} x2={px + PLAT_W / 2 - 5} y2={py} stroke="#50a0e0" strokeWidth="1" opacity="0.6" />
        </g>
      ))}

      {/* Platforms */}
      {[[g.lpx, g.lpy], [g.rpx, g.rpy]].map(([cx, cy], pi) => (
        <g key={pi}>
          <rect x={cx - PLAT_W / 2} y={cy} width={PLAT_W} height={7} rx={3.5}
            fill={`url(#${`np-${id}`})`} stroke="#50a0e0" strokeWidth="0.8" opacity="0.8" />
          <rect x={cx - PLAT_W / 2 + 2} y={cy + 1} width={PLAT_W - 4} height={2} rx={1}
            fill="rgba(80,180,255,0.15)" />
        </g>
      ))}

      {/* Items with glow halos */}
      {[...g.leftItems, ...g.rightItems].map((pos, i) => (
        <g key={i} filter={`url(#${`nig-${id}`})`}>
          <rect x={pos.x - 2} y={pos.y - 2} width={ITEM_SIZE + 4} height={ITEM_SIZE + 4}
            rx={8} fill="rgba(15,20,40,0.85)" stroke="rgba(80,180,255,0.35)" strokeWidth="1.2" />
          <image href={getImg(pos.idx)} x={pos.x} y={pos.y} width={ITEM_SIZE} height={ITEM_SIZE} />
        </g>
      ))}
    </svg>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// STYLE 2 — FLASH REPLICA
// Light background, simple black-line scales, white cards, maximum clarity
// ═══════════════════════════════════════════════════════════════════════
function ScaleFlash({ g, id, w, getImg }: SP) {
  return (
    <svg width={w} height={h(w)} viewBox={`0 0 ${VB_W} ${VB_H}`} style={{ display: 'block' }}>
      <defs>
        <filter id={`fs-${id}`}>
          <feDropShadow dx="0" dy="1" stdDeviation="1.5" floodColor="#000" floodOpacity="0.18" />
        </filter>
      </defs>

      {/* Simple fulcrum — dark triangle */}
      <polygon points={`${PIVOT_X},${g.ftop} ${PIVOT_X - 12},${g.fbot} ${PIVOT_X + 12},${g.fbot}`}
        fill="#555" stroke="#333" strokeWidth="1.5" strokeLinejoin="round" />
      <rect x={PIVOT_X - 18} y={g.fbot} width={36} height={5} rx={2.5} fill="#444" />

      {/* Simple beam */}
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke="#3a3a3a" strokeWidth={7} strokeLinecap="round" />
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke="#5a5a5a" strokeWidth={5} strokeLinecap="round" />
      <circle cx={PIVOT_X} cy={PIVOT_Y} r={4} fill="#444" stroke="#333" strokeWidth="1.5" />

      {/* Simple chains — thin black lines */}
      {[[g.lx, g.ly, g.lpx, g.lpy], [g.rx, g.ry, g.rpx, g.rpy]].map(([bx, by, px, py], ci) => (
        <g key={ci}>
          <line x1={bx - 6} y1={by + 4} x2={px - PLAT_W / 2 + 4} y2={py} stroke="#555" strokeWidth="1.5" />
          <line x1={bx + 6} y1={by + 4} x2={px + PLAT_W / 2 - 4} y2={py} stroke="#555" strokeWidth="1.5" />
        </g>
      ))}

      {/* Platforms — solid dark */}
      {[[g.lpx, g.lpy], [g.rpx, g.rpy]].map(([cx, cy], pi) => (
        <rect key={pi} x={cx - PLAT_W / 2} y={cy} width={PLAT_W} height={7} rx={3}
          fill="#666" stroke="#444" strokeWidth="1" />
      ))}

      {/* Items on clean white cards */}
      {[...g.leftItems, ...g.rightItems].map((pos, i) => (
        <g key={i} filter={`url(#${`fs-${id}`})`}>
          <rect x={pos.x - 4} y={pos.y - 4} width={ITEM_SIZE + 8} height={ITEM_SIZE + 8}
            rx={8} fill="#fff" stroke="#ddd" strokeWidth="1" />
          <image href={getImg(pos.idx)} x={pos.x} y={pos.y} width={ITEM_SIZE} height={ITEM_SIZE} />
        </g>
      ))}
    </svg>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// STYLE 3 — ROYAL GOLD
// Ornate gold/brass scale, items in gold medallion circles, premium feel
// ═══════════════════════════════════════════════════════════════════════
function ScaleRoyal({ g, id, w, getImg }: SP) {
  const MR = ITEM_SIZE / 2 + 5; // medallion radius
  return (
    <svg width={w} height={h(w)} viewBox={`0 0 ${VB_W} ${VB_H}`} style={{ display: 'block' }}>
      <defs>
        <linearGradient id={`rb-${id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#f0d060" />
          <stop offset="30%" stopColor="#c8a030" />
          <stop offset="70%" stopColor="#a08020" />
          <stop offset="100%" stopColor="#806010" />
        </linearGradient>
        <linearGradient id={`rf-${id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#d4aa40" />
          <stop offset="100%" stopColor="#806010" />
        </linearGradient>
        <linearGradient id={`rp-${id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#e8c44a" />
          <stop offset="100%" stopColor="#a08020" />
        </linearGradient>
        <radialGradient id={`rm-${id}`}>
          <stop offset="0%" stopColor="#1a1528" />
          <stop offset="100%" stopColor="#10101a" />
        </radialGradient>
        <filter id={`rg-${id}`}>
          <feDropShadow dx="0" dy="1" stdDeviation="2" floodColor="#c8a030" floodOpacity="0.4" />
        </filter>
        <filter id={`rs-${id}`}>
          <feDropShadow dx="0" dy="1.5" stdDeviation="2" floodColor="#000" floodOpacity="0.5" />
        </filter>
      </defs>

      {/* Ornate fulcrum */}
      <polygon points={`${PIVOT_X},${g.ftop} ${PIVOT_X - 16},${g.fbot} ${PIVOT_X + 16},${g.fbot}`}
        fill={`url(#${`rf-${id}`})`} stroke="#705010" strokeWidth="1.2" strokeLinejoin="round" />
      {/* Fulcrum jewel */}
      <circle cx={PIVOT_X} cy={g.ftop + 12} r={3} fill="#e04040" stroke="#801010" strokeWidth="0.8" />
      {/* Base */}
      <rect x={PIVOT_X - 22} y={g.fbot - 1} width={44} height={7} rx={3.5}
        fill={`url(#${`rf-${id}`})`} stroke="#705010" strokeWidth="0.8" />
      <rect x={PIVOT_X - 19} y={g.fbot} width={38} height={2} rx={1} fill="rgba(255,255,255,0.2)" />

      {/* Gold beam */}
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke="#604010" strokeWidth={11} strokeLinecap="round" />
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke={`url(#${`rb-${id}`})`} strokeWidth={9} strokeLinecap="round" />
      <line x1={g.lx} y1={g.ly} x2={g.rx} y2={g.ry} stroke="rgba(255,255,255,0.25)" strokeWidth={5} strokeLinecap="round" />
      {/* Ornate pivot */}
      <circle cx={PIVOT_X} cy={PIVOT_Y} r={6} fill="#c8a030" stroke="#806010" strokeWidth="1.5" />
      <circle cx={PIVOT_X} cy={PIVOT_Y} r={3} fill="#f0d060" />

      {/* Gold chains — dashed for link effect */}
      {[[g.lx, g.ly, g.lpx, g.lpy], [g.rx, g.ry, g.rpx, g.rpy]].map(([bx, by, px, py], ci) => (
        <g key={ci}>
          <line x1={bx - 5} y1={by + 5} x2={px - PLAT_W / 2 + 5} y2={py}
            stroke="#c8a030" strokeWidth="2" strokeDasharray="3,2" />
          <line x1={bx + 5} y1={by + 5} x2={px + PLAT_W / 2 - 5} y2={py}
            stroke="#c8a030" strokeWidth="2" strokeDasharray="3,2" />
        </g>
      ))}

      {/* Gold platforms */}
      {[[g.lpx, g.lpy], [g.rpx, g.rpy]].map(([cx, cy], pi) => (
        <g key={pi}>
          <rect x={cx - PLAT_W / 2} y={cy} width={PLAT_W} height={8} rx={4}
            fill={`url(#${`rp-${id}`})`} stroke="#806010" strokeWidth="1" />
          <rect x={cx - PLAT_W / 2 + 4} y={cy + 1} width={PLAT_W - 8} height={3} rx={1.5}
            fill="rgba(255,255,255,0.25)" />
        </g>
      ))}

      {/* Items in gold medallion circles */}
      {[...g.leftItems, ...g.rightItems].map((pos, i) => {
        const cx = pos.x + ITEM_SIZE / 2;
        const cy = pos.y + ITEM_SIZE / 2;
        return (
          <g key={i} filter={`url(#${`rs-${id}`})`}>
            {/* Outer gold ring */}
            <circle cx={cx} cy={cy} r={MR + 2} fill="none" stroke="#c8a030" strokeWidth="3" />
            {/* Dark inner fill */}
            <circle cx={cx} cy={cy} r={MR} fill={`url(#${`rm-${id}`})`} />
            {/* Inner gold ring */}
            <circle cx={cx} cy={cy} r={MR - 1} fill="none" stroke="#a08020" strokeWidth="0.8" />
            {/* Highlight arc */}
            <path d={`M ${cx - MR + 4} ${cy - 6} A ${MR} ${MR} 0 0 1 ${cx + MR - 4} ${cy - 6}`}
              fill="none" stroke="rgba(255,255,255,0.15)" strokeWidth="2" />
            <image href={getImg(pos.idx)} x={pos.x + 1} y={pos.y + 1} width={ITEM_SIZE - 2} height={ITEM_SIZE - 2} />
          </g>
        );
      })}
    </svg>
  );
}
