# Who Has The Biggest Brain? - Recreation Project

## Overview
This is a faithful recreation of the classic Playfish Facebook game "Who Has The Biggest Brain?" - a brain training game that tests players across 4 cognitive categories.

## Game Structure

### 4 Mini-Games (12 in original pro version)
Currently implemented:

1. **Block Counting** (Analysis Category)
   - Count 3D isometric blocks displayed in a stack
   - Blocks arranged in complex 3D formations
   - Difficulty scales with number of blocks and complexity
   - 30 seconds time limit

2. **Memory Cards** (Memory Category)
   - Classic memory matching game
   - Players get a few seconds to memorize card positions
   - Must match pairs from memory
   - Number of pairs increases with difficulty
   - 45 seconds time limit

3. **Quick Math** (Calculation Category)
   - Rapid-fire arithmetic problems
   - Includes addition, subtraction, multiplication, division
   - Difficulty affects number range and operations
   - 40 seconds time limit

4. **Asteroid Sorting** (Visual Category)
   - Click the asteroid matching the target size
   - Asteroids float across space in real-time
   - Must visually estimate sizes while in motion
   - 35 seconds time limit

## Scoring System

- Each mini-game awards points based on:
  - Correct answers
  - Speed of completion
  - Difficulty multiplier
  
- Total score from all 4 games determines brain size:
  - < 500: Tiny Brain (1200 cm³)
  - 500-1000: Small Brain (1500 cm³)
  - 1000-1500: Average Brain (1800 cm³)
  - 1500-2000: Smart Brain (2100 cm³)
  - 2000-2500: Genius (2400 cm³)
  - 2500-3000: Einstein (2700 cm³)
  - 3000+: Space Alien (3000 cm³)

## What's Implemented

✅ Full game loop (menu → 4 mini-games → results)
✅ All 4 mini-games with authentic mechanics
✅ Score tracking and brain size calculation
✅ Smooth animations and transitions
✅ Responsive design
✅ Visual feedback (correct/incorrect)
✅ Progress bar
✅ Time limits per game
✅ Polished UI matching original aesthetic

## What's Missing (For Full Recreation)

The original game had 12 mini-games total (3 per category). Still need:

**Analysis Category:**
- Scales/Weight Balancing (determine heaviest objects on scales)
- Puzzle Pieces (select correct jigsaw piece to complete image)

**Memory Category:**
- Object Sequence Memory (remember order of displayed objects)
- Pattern Memory (reproduce patterns shown briefly)

**Calculation Category:**
- Number Sequences (complete numerical patterns)
- Mental Arithmetic Chains (solve multi-step problems)

**Visual Category:**
- Hexagon Path (trace correct path through hexagon maze)
- Pattern Matching (match rotating/transformed shapes)
- Sushi Memory (remember and identify sushi dish patterns)

**Additional Features:**
- Multiple difficulty levels
- Daily challenges
- Achievement system
- Social features (compare scores)
- Practice mode
- Progress calendar
- Sound effects and music
- Game show host character/animations
- More varied animations between rounds

## Technical Stack

- React 18 (via CDN)
- Vanilla CSS with animations
- SVG for graphics (blocks, asteroids)
- Standalone HTML file (no build process needed)

## How to Play

1. Open `brain-game.html` in any modern web browser
2. Click "Start Game"
3. Complete all 4 mini-games
4. View your brain size and score breakdown
5. Click "Play Again" to retry

## File Structure

```
brain-game.html          # Standalone playable game
brain-game.tsx           # React TypeScript source
README.md                # This file
```

## Next Steps for Full Recreation

1. **Add remaining 8 mini-games** from original
2. **Implement difficulty scaling** (easy/medium/hard rounds)
3. **Add animations** between games (transition effects)
4. **Create game host character** with voiceovers
5. **Add sound effects** for correct/incorrect answers
6. **Build practice mode** for individual games
7. **Implement achievement system**
8. **Add local storage** for high scores
9. **Polish animations** - more juice, particles, effects
10. **Mobile optimization** with touch controls

## Development Notes

The game is fully playable and demonstrates the core mechanics of the original. Each mini-game captures the essential gameplay loop while using modern web technologies (React, CSS animations, SVG graphics).

The scoring and difficulty systems are calibrated to feel similar to the original, though exact values may differ. Time limits are set to create appropriate challenge while allowing skillful players to excel.

All code is in a single HTML file for easy distribution and testing. Can be easily converted to a proper React project with separate components when ready to expand.

## Estimated Time to Full Recreation

- **Current state**: ~4 mini-games (33% of full game)
- **Time to complete**: 2-3 more sessions of 3-4 hours each
- **Total remaining**: 8 mini-games + polish + features

With focused development, the full recreation with all 12 mini-games and core features could be completed in approximately 10-15 hours of work.