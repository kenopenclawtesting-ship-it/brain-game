// MathCombination (PRO) - Faithfully ported from MathCombination.as + CalculateElement.as
// Player fills in numbers and operators to form an equation that equals the target result
// CORRECT_SCORE: 44, INCORRECT_SCORE: -29
import { useState, useEffect, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useGameStore } from '../../../store/gameStore';
import { useFeedbackSound } from '../../../hooks/useSound';
import { GameContainer } from '../GameContainer';

// CalculateElement tree (from CalculateElement.as)
const SIGN_PLUS = 0;
const SIGN_MINUS = 1;
const SIGN_MULTIPLY = 2;
const SIGN_DIVIDE = 3;
const NUM_SIGNS = 4;
const SIGN_STRING = ['+', '-', 'x', '/'];

interface CalcElement {
  number: number;
  isRoot: boolean;
  sign: number;
  element1: CalcElement | null;
  element2: CalcElement | null;
}

function rnd(min: number, max: number): number {
  if (min >= max) return min;
  return min + Math.floor(Math.random() * (max - min));
}

function createRoot(num: number): CalcElement {
  return { number: num, isRoot: true, sign: -1, element1: null, element2: null };
}

function getResult(el: CalcElement): number {
  if (el.isRoot) return el.number;
  const a = getResult(el.element1!);
  const b = getResult(el.element2!);
  switch (el.sign) {
    case SIGN_PLUS: return a + b;
    case SIGN_MINUS: return a - b;
    case SIGN_MULTIPLY: return a * b;
    case SIGN_DIVIDE: return Math.floor(a / b);
    default: return 0;
  }
}

function setSign(el: CalcElement, sign: number): void {
  let a = 0, b = 0;
  const n = el.number;
  switch (sign) {
    case SIGN_PLUS:
      a = rnd(Math.floor(n / 2), Math.floor(n * 3 / 4) + 1);
      b = n - a;
      break;
    case SIGN_MINUS:
      b = rnd(Math.floor(n / 4), Math.floor(n / 2) + 1);
      a = n + b;
      break;
    case SIGN_MULTIPLY: {
      const sq = Math.ceil(Math.sqrt(Math.max(1, n)));
      a = rnd(Math.max(1, Math.ceil(sq / 2)), Math.ceil(sq + sq / 2) + 1);
      b = a === 0 ? rnd(1, Math.max(2, n)) : Math.floor(n / a);
      break;
    }
    case SIGN_DIVIDE:
      b = Math.max(2, rnd(Math.ceil(n / 8), Math.ceil(n / 4) + 1));
      a = b * n;
      break;
  }
  el.sign = sign;
  el.isRoot = false;
  el.number = 0;
  el.element1 = createRoot(a);
  el.element2 = createRoot(b);
}

function getString(el: CalcElement, parens = true): string {
  if (el.isRoot) return '' + el.number;
  const s = getString(el.element1!) + ' ' + SIGN_STRING[el.sign] + ' ' + getString(el.element2!);
  return parens ? '(' + s + ')' : s;
}

function getSymbols(el: CalcElement, addParens = false): string[] {
  if (el.isRoot) return ['' + el.number];
  const result: string[] = [];
  if (addParens) result.push('(');
  result.push(...getSymbols(el.element1!, true));
  result.push(SIGN_STRING[el.sign]);
  result.push(...getSymbols(el.element2!, true));
  if (addParens) result.push(')');
  return result;
}

function getNumberElements(el: CalcElement): CalcElement[] {
  if (el.isRoot) return [el];
  return [...getNumberElements(el.element1!), ...getNumberElements(el.element2!)];
}

function getSignElements(el: CalcElement): CalcElement[] {
  if (el.isRoot) return [];
  if (el.element1!.isRoot && el.element2!.isRoot) return [el];
  return [...getSignElements(el.element1!), el, ...getSignElements(el.element2!)];
}

function cloneElement(el: CalcElement): CalcElement {
  if (el.isRoot) return createRoot(el.number);
  return {
    number: el.number,
    isRoot: false,
    sign: el.sign,
    element1: cloneElement(el.element1!),
    element2: cloneElement(el.element2!),
  };
}

function isIdentical(a: CalcElement, b: CalcElement): boolean {
  if (a.isRoot) return b.isRoot && a.number === b.number;
  return !b.isRoot && isIdentical(a.element1!, b.element1!) && isIdentical(a.element2!, b.element2!);
}

// Generate equation (from MathCombination.getEquation)
function generateEquation(difficulty: number, compound: boolean, history: CalcElement[]): CalcElement {
  let tries = 0;
  while (tries < 100) {
    tries++;
    let d = difficulty;
    const sign = rnd(0, NUM_SIGNS);
    if (sign === SIGN_DIVIDE) d = Math.floor(d / 2);
    else if (sign === SIGN_MULTIPLY) d += 2;

    const maxVal = Math.min(10 + 3 * d, 99);
    const minVal = Math.max(1, maxVal - 10);
    const num = rnd(minVal, maxVal + 1);

    const el = createRoot(num);
    setSign(el, sign);

    if (compound) {
      if (el.sign === SIGN_DIVIDE) {
        setSign(el.element1!, rnd(0, NUM_SIGNS - 2));
      } else {
        setSign(el.element1!, rnd(0, NUM_SIGNS - 1));
      }
    }

    // Check not duplicate
    let isDup = false;
    for (const h of history) {
      if (isIdentical(el, h)) { isDup = true; break; }
    }
    if (!isDup) return el;
  }
  // Fallback
  const el = createRoot(rnd(5, 30));
  setSign(el, rnd(0, 2));
  return el;
}

const EQUATION_SPLIT_START_LEVEL = 6;
const MAX_EXTRA_NUMBERS = 8;

interface SlotData {
  type: 'number' | 'sign' | 'paren';
  value: string; // the correct value
  filled: string | null; // what user has placed (null = empty)
  sourceIndex: number | null; // index of the selection card used to fill this
}

interface SelectionCard {
  type: 'number' | 'sign';
  value: string;
  used: boolean;
}

export function MathCombinationGame() {
  const [answer, setAnswer] = useState(0);
  const [slots, setSlots] = useState<SlotData[]>([]);
  const [selectionCards, setSelectionCards] = useState<SelectionCard[]>([]);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [equationHistory] = useState<CalcElement[]>([]);
  const [currentEquation, setCurrentEquation] = useState<CalcElement | null>(null);
  const [disabled, setDisabled] = useState(false);

  const addCorrect = useGameStore((state) => state.addCorrect);
  const addIncorrect = useGameStore((state) => state.addIncorrect);
  const timeRemaining = useGameStore((state) => state.timeRemaining);
  const { playCorrect, playIncorrect } = useFeedbackSound();

  const generatePuzzle = useCallback(() => {
    let level = totalCorrect;
    let compound = false;

    if (level >= EQUATION_SPLIT_START_LEVEL && level % 2 === 1) {
      compound = true;
      level -= EQUATION_SPLIT_START_LEVEL;
    }

    const equation = generateEquation(level, compound, equationHistory);
    equationHistory.push(equation);
    setCurrentEquation(equation);

    const result = getResult(equation);
    setAnswer(result);

    // Build slots from equation symbols
    const symbols = getSymbols(equation);
    const numberEls = getNumberElements(equation);
    const signEls = getSignElements(equation);

    const newSlots: SlotData[] = [];
    let numIdx = 0;
    let signIdx = 0;

    for (const sym of symbols) {
      if (sym === '(' || sym === ')') {
        newSlots.push({ type: 'paren', value: sym, filled: sym, sourceIndex: null });
      } else if (SIGN_STRING.includes(sym)) {
        newSlots.push({ type: 'sign', value: sym, filled: null, sourceIndex: null });
        signIdx++;
      } else {
        newSlots.push({ type: 'number', value: sym, filled: null, sourceIndex: null });
        numIdx++;
      }
    }

    // Build selection cards
    const cards: SelectionCard[] = [];

    // Add correct sign cards
    const correctSignCards: SelectionCard[] = [];
    for (const slot of newSlots) {
      if (slot.type === 'sign') {
        correctSignCards.push({ type: 'sign', value: slot.value, used: false });
      }
    }

    // Add correct number cards
    const correctNumberCards: SelectionCard[] = [];
    for (const slot of newSlots) {
      if (slot.type === 'number') {
        correctNumberCards.push({ type: 'number', value: slot.value, used: false });
      }
    }

    // Calculate extra cards based on difficulty
    let extraSigns = 0;
    let extraNumbers = 0;

    if (!compound) {
      extraSigns = Math.min(Math.floor(totalCorrect / 5), 3);
      extraNumbers = 1 + Math.floor(totalCorrect / 2.5) - extraSigns;
    } else {
      extraSigns = Math.min(Math.floor((totalCorrect - EQUATION_SPLIT_START_LEVEL) / 5), 6);
      extraNumbers = Math.floor((totalCorrect - EQUATION_SPLIT_START_LEVEL) / 3) - extraSigns;
    }
    extraNumbers = Math.min(Math.max(0, extraNumbers), MAX_EXTRA_NUMBERS);
    extraSigns = Math.max(0, extraSigns);

    // Add extra wrong sign cards
    const extraSignCards: SelectionCard[] = [];
    for (let i = 0; i < extraSigns; i++) {
      extraSignCards.push({
        type: 'sign',
        value: SIGN_STRING[rnd(0, NUM_SIGNS)],
        used: false,
      });
    }

    // Add extra wrong number cards
    const extraNumberCards: SelectionCard[] = [];
    for (let i = 0; i < extraNumbers; i++) {
      extraNumberCards.push({
        type: 'number',
        value: '' + rnd(0, Math.floor(10 + totalCorrect * 1.5)),
        used: false,
      });
    }

    // Combine and shuffle
    const allCards = [...correctSignCards, ...extraSignCards, ...correctNumberCards, ...extraNumberCards];
    for (let i = allCards.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [allCards[i], allCards[j]] = [allCards[j], allCards[i]];
    }

    setSlots(newSlots);
    setSelectionCards(allCards);
    setDisabled(false);
  }, [totalCorrect, equationHistory]);

  useEffect(() => {
    generatePuzzle();
  }, []);

  const handleCardClick = (cardIndex: number) => {
    if (disabled) return;
    const card = selectionCards[cardIndex];
    if (card.used) return;

    // Find first empty slot of matching type
    const slotIndex = slots.findIndex(
      (s) => s.type === card.type && s.filled === null
    );
    if (slotIndex === -1) return;

    // Place card in slot
    const newSlots = [...slots];
    newSlots[slotIndex] = { ...newSlots[slotIndex], filled: card.value, sourceIndex: cardIndex };

    const newCards = [...selectionCards];
    newCards[cardIndex] = { ...newCards[cardIndex], used: true };

    setSlots(newSlots);
    setSelectionCards(newCards);

    // Check if all slots are filled
    const allFilled = newSlots.every((s) => s.filled !== null);
    if (allFilled) {
      checkAnswer(newSlots, newCards);
    }
  };

  const handleSlotClick = (slotIndex: number) => {
    if (disabled) return;
    const slot = slots[slotIndex];
    if (slot.type === 'paren' || slot.filled === null || slot.sourceIndex === null) return;

    // Unplace card
    const newSlots = [...slots];
    newSlots[slotIndex] = { ...newSlots[slotIndex], filled: null, sourceIndex: null };

    const newCards = [...selectionCards];
    newCards[slot.sourceIndex] = { ...newCards[slot.sourceIndex], used: false };

    setSlots(newSlots);
    setSelectionCards(newCards);
  };

  const checkAnswer = (filledSlots: SlotData[], cards: SelectionCard[]) => {
    if (!currentEquation) return;

    // Reconstruct the equation from filled slots and evaluate
    const equationCopy = cloneElement(currentEquation);
    const numEls = getNumberElements(equationCopy);
    const signEls = getSignElements(equationCopy);

    let numIdx = 0;
    let signIdx = 0;

    for (const slot of filledSlots) {
      if (slot.type === 'number' && slot.filled !== null) {
        if (numIdx < numEls.length) {
          numEls[numIdx].number = parseInt(slot.filled, 10) || 0;
          numIdx++;
        }
      } else if (slot.type === 'sign' && slot.filled !== null) {
        if (signIdx < signEls.length) {
          signEls[signIdx].sign = SIGN_STRING.indexOf(slot.filled);
          signIdx++;
        }
      }
    }

    const result = getResult(equationCopy);

    setDisabled(true);

    if (result === answer) {
      playCorrect();
      addCorrect();
      setTotalCorrect((prev) => prev + 1);
      setTimeout(() => generatePuzzle(), 600);
    } else {
      playIncorrect();
      addIncorrect();
      setTimeout(() => generatePuzzle(), 800);
    }
  };

  if (timeRemaining <= 0) return null;

  return (
    <GameContainer>
      <div className="flex flex-col items-center justify-center h-full">
        {/* Target result */}
        <div className="text-center mb-3">
          <div className="text-sm text-gray-400" style={{ fontFamily: 'Baveuse, cursive' }}>
            Make the equation equal
          </div>
          <div
            className="text-4xl font-bold text-yellow-400"
            style={{ fontFamily: 'Baveuse, cursive', textShadow: '0 0 15px rgba(255,215,0,0.4)' }}
          >
            {answer}
          </div>
        </div>

        {/* Equation slots */}
        <div className="flex items-center gap-1 mb-6 flex-wrap justify-center">
          {slots.map((slot, idx) => {
            if (slot.type === 'paren') {
              return (
                <span key={idx} className="text-2xl text-gray-400 font-bold px-1" style={{ fontFamily: 'Baveuse, cursive' }}>
                  {slot.value}
                </span>
              );
            }

            const isEmpty = slot.filled === null;
            const isSign = slot.type === 'sign';

            return (
              <motion.button
                key={idx}
                onClick={() => handleSlotClick(idx)}
                className="rounded-lg flex items-center justify-center"
                style={{
                  width: isSign ? 40 : 52,
                  height: 44,
                  background: isEmpty
                    ? 'rgba(255,255,255,0.05)'
                    : isSign
                      ? 'linear-gradient(180deg, #2a5a8a 0%, #1a3a5a 100%)'
                      : 'linear-gradient(180deg, #3a3a7a 0%, #2a2a5a 100%)',
                  border: isEmpty
                    ? '2px dashed rgba(255,255,255,0.3)'
                    : '2px solid rgba(255,215,0,0.5)',
                  cursor: isEmpty ? 'default' : 'pointer',
                }}
                whileHover={!isEmpty ? { scale: 1.05 } : {}}
              >
                {slot.filled !== null ? (
                  <span
                    className="text-xl font-bold text-white"
                    style={{ fontFamily: 'Baveuse, cursive' }}
                  >
                    {slot.filled}
                  </span>
                ) : (
                  <span className="text-lg text-gray-500">
                    {isSign ? '?' : '#'}
                  </span>
                )}
              </motion.button>
            );
          })}
          <span className="text-2xl text-gray-400 font-bold px-2" style={{ fontFamily: 'Baveuse, cursive' }}>
            = {answer}
          </span>
        </div>

        {/* Selection cards */}
        <div className="flex gap-2 flex-wrap justify-center max-w-lg">
          {selectionCards.map((card, idx) => (
            <motion.button
              key={idx}
              onClick={() => handleCardClick(idx)}
              className="rounded-lg flex items-center justify-center"
              style={{
                width: card.type === 'sign' ? 44 : 52,
                height: 44,
                background: card.used
                  ? 'rgba(30,30,50,0.3)'
                  : card.type === 'sign'
                    ? 'linear-gradient(180deg, #2a5a8a 0%, #1a3a5a 100%)'
                    : 'linear-gradient(180deg, #3a3a6a 0%, #2a2a4a 100%)',
                border: card.used
                  ? '2px solid rgba(255,255,255,0.05)'
                  : '2px solid rgba(255,255,255,0.2)',
                opacity: card.used ? 0.25 : 1,
                cursor: card.used ? 'not-allowed' : 'pointer',
                transform: card.type === 'number' ? `rotate(${(idx * 7 - 15) % 15}deg)` : undefined,
              }}
              whileHover={!card.used ? { scale: 1.1, boxShadow: '0 0 12px rgba(255,215,0,0.4)' } : {}}
              whileTap={!card.used ? { scale: 0.9 } : {}}
              disabled={card.used || disabled}
            >
              <span
                className="text-xl font-bold text-white"
                style={{ fontFamily: 'Baveuse, cursive', textShadow: '1px 1px 2px rgba(0,0,0,0.5)' }}
              >
                {card.value}
              </span>
            </motion.button>
          ))}
        </div>

        <div className="mt-3 text-sm text-gray-400" style={{ fontFamily: 'Baveuse, cursive' }}>
          Click cards to fill the equation
        </div>
      </div>
    </GameContainer>
  );
}
