# Who Has The Biggest Brain? - Conversion Scope

## Project Goals
Convert Flash-based brain training game to modern web technologies while maintaining:
1. **Identical gameplay mechanics** - Same mini-games, scoring, feel
2. **Improved animations** - Smooth 60fps, modern effects
3. **Cross-platform** - Desktop, tablet, mobile responsive
4. **No external dependencies** - Self-contained, works offline

## Technology Stack

### Core Framework: **React 18 + TypeScript**
**Why**: 
- Component-based architecture perfect for 12 mini-games
- Type safety prevents bugs in complex game logic
- Hooks for state management
- Fast rendering with Virtual DOM

### Graphics Engine: **HTML5 Canvas + CSS Animations**
**Why**:
- Canvas for dynamic elements (blocks, asteroids, particles)
- CSS for UI animations and transitions
- No WebGL needed - simpler, better compatibility
- Native browser APIs, no framework overhead

**Alternative considered**: Three.js/WebGL
- Rejected: Overkill for 2D/2.5D games
- Canvas provides all needed rendering power

### Animation Library: **React Spring**
**Why**:
- Physics-based animations (bounce, elastic)
- Smooth 60fps performance
- Simple API for complex choreography
- Integrates perfectly with React

### State Management: **Zustand**
**Why**:
- Lightweight (<1kb)
- No boilerplate like Redux
- Perfect for game state (scores, timers, progression)
- TypeScript support

### Build Tool: **Vite**
**Why**:
- Lightning fast dev server
- Instant HMR (Hot Module Replacement)
- Optimized production builds
- Native ES modules

## Project Structure

```
brain-game/
├── src/
│   ├── components/
│   │   ├── GameHost.tsx          # Animated character
│   │   ├── GameMenu.tsx          # Mode selection
│   │   ├── ProgressBar.tsx       # Game progress
│   │   ├── ScoreDisplay.tsx      # Score UI
│   │   └── ResultsScreen.tsx     # End screen
│   │
│   ├── games/                     # 12 mini-games
│   │   ├── BlockCounting.tsx
│   │   ├── MemoryCards.tsx
│   │   ├── QuickMath.tsx
│   │   ├── AsteroidSorting.tsx
│   │   ├── HexagonPath.tsx
│   │   ├── ScaleBalance.tsx
│   │   ├── ObjectSequence.tsx
│   │   ├── PuzzlePieces.tsx
│   │   ├── PatternMatch.tsx
│   │   ├── NumberSequence.tsx
│   │   ├── VisualTransform.tsx
│   │   └── SushiMemory.tsx
│   │
│   ├── engine/                    # Game engine
│   │   ├── GameEngine.tsx        # Main game loop
│   │   ├── ScoreManager.ts       # Scoring logic
│   │   ├── TimerManager.ts       # Timing system
│   │   └── DifficultyScale.ts    # Difficulty algorithms
│   │
│   ├── hooks/                     # React hooks
│   │   ├── useGameState.ts       # Game state hook
│   │   ├── useTimer.ts           # Timer hook
│   │   ├── useScore.ts           # Score hook
│   │   └── useSound.ts           # Audio hook
│   │
│   ├── store/                     # Zustand stores
│   │   ├── gameStore.ts          # Main game state
│   │   ├── scoreStore.ts         # Score tracking
│   │   └── settingsStore.ts      # User settings
│   │
│   ├── utils/                     # Utilities
│   │   ├── animations.ts         # Animation helpers
│   │   ├── graphics.ts           # Canvas utilities
│   │   ├── scoring.ts            # Score calculations
│   │   └── constants.ts          # Game constants
│   │
│   ├── types/                     # TypeScript types
│   │   ├── game.types.ts
│   │   ├── score.types.ts
│   │   └── minigame.types.ts
│   │
│   ├── assets/                    # Assets
│   │   ├── sounds/               # Audio files
│   │   ├── images/               # Static images
│   │   └── fonts/                # Custom fonts
│   │
│   ├── App.tsx                    # Root component
│   ├── main.tsx                   # Entry point
│   └── styles/                    # Global styles
│       ├── animations.css
│       ├── variables.css
│       └── global.css
│
├── public/                        # Static assets
├── tests/                         # Test suite
│   ├── unit/                     # Unit tests
│   └── integration/              # Integration tests
│
├── package.json
├── tsconfig.json
├── vite.config.ts
└── README.md
```

## Development Phases

### Phase 1: Foundation (Week 1)
**Goal**: Working game shell with 1 mini-game

**Tasks**:
- [x] Project setup (Vite + React + TypeScript)
- [ ] Game engine architecture
- [ ] State management (Zustand)
- [ ] Timer system
- [ ] Score tracking
- [ ] 1 working mini-game (Block Counting)
- [ ] Basic UI (menu, game screen, results)

**Deliverable**: Playable prototype with full game loop

### Phase 2: Core Mini-Games (Week 2)
**Goal**: 8/12 mini-games implemented

**Tasks**:
- [ ] Memory Cards
- [ ] Quick Math
- [ ] Asteroid Sorting
- [ ] Hexagon Path
- [ ] Scale Balance
- [ ] Object Sequence
- [ ] Puzzle Pieces
- [ ] Unified scoring system
- [ ] Difficulty scaling

**Deliverable**: Feature-complete game without polish

### Phase 3: Polish & Animation (Week 3)
**Goal**: Production-quality animations

**Tasks**:
- [ ] Character animations (game host)
- [ ] Transition effects between games
- [ ] Particle systems (confetti, sparkles)
- [ ] Smooth UI animations
- [ ] Loading states
- [ ] Micro-interactions (hover, click)
- [ ] Score increment animations
- [ ] Timer animations

**Deliverable**: Polished, animated experience

### Phase 4: Remaining Games & Audio (Week 4)
**Goal**: Complete feature parity

**Tasks**:
- [ ] Pattern Match mini-game
- [ ] Number Sequence mini-game  
- [ ] Visual Transform mini-game
- [ ] Sushi Memory mini-game
- [ ] Background music
- [ ] Sound effects (correct, incorrect, timer)
- [ ] Audio settings (mute, volume)
- [ ] Mobile optimization
- [ ] Touch controls

**Deliverable**: Complete game, all 12 mini-games

### Phase 5: Testing & Deployment (Week 5)
**Goal**: Production-ready release

**Tasks**:
- [ ] Comprehensive testing suite
- [ ] Performance optimization
- [ ] Browser compatibility testing
- [ ] Mobile device testing
- [ ] Accessibility improvements (a11y)
- [ ] SEO optimization
- [ ] Deployment pipeline
- [ ] Analytics integration (optional)

**Deliverable**: Live, deployed game

## Mini-Game Implementation Details

### 1. Block Counting (Analysis)
**Tech**: Canvas 2D with isometric projection
**Challenge**: Efficient 3D-to-2D rendering
**Animation**: Block appearance stagger effect

```typescript
interface Block {
  x: number;
  y: number;
  z: number;
  color: string;
}

// Isometric projection math
const isoX = (x - z) * tileWidth / 2;
const isoY = (x + z) * tileHeight / 2 - y * tileDepth;
```

### 2. Memory Cards (Memory)
**Tech**: CSS Grid + Flip animations
**Challenge**: Smooth card flip with 3D transform
**Animation**: Bounce on reveal, shake on mismatch

```css
.card {
  transform-style: preserve-3d;
  transition: transform 0.6s;
}
.card.flipped {
  transform: rotateY(180deg);
}
```

### 3. Quick Math (Calculation)
**Tech**: Simple React state + input
**Challenge**: Instant feedback, rapid succession
**Animation**: Number pop-in, correct/incorrect flash

### 4. Asteroid Sorting (Visual)
**Tech**: Canvas with RequestAnimationFrame loop
**Challenge**: Smooth 60fps motion, hitbox detection
**Animation**: Asteroid rotation, drift motion

```typescript
// Game loop
const animate = () => {
  ctx.clearRect(0, 0, width, height);
  asteroids.forEach(a => {
    a.x += a.vx;
    a.y += a.vy;
    drawAsteroid(a);
  });
  requestAnimationFrame(animate);
};
```

### 5. Hexagon Path (Visual)
**Tech**: SVG for hexagons + Canvas for path
**Challenge**: Path memory, smooth tracing
**Animation**: Path reveal effect, glow on correct

### 6. Scale Balance (Analysis)
**Tech**: SVG scales with CSS transforms
**Challenge**: Weight calculation logic
**Animation**: Scale tilt based on weight, bounce effect

### 7. Object Sequence (Memory)
**Tech**: Image sprites + position tracking
**Challenge**: Sequence verification
**Animation**: Object slide-in sequence, fade out

### 8. Puzzle Pieces (Analysis)
**Tech**: Canvas or SVG pieces with drag/drop
**Challenge**: Piece matching algorithm
**Animation**: Piece snap into place, correct glow

### 9-12. Additional Games
**Pattern Match**: Canvas shape rendering + transforms
**Number Sequence**: React components + math logic
**Visual Transform**: Canvas with rotation/scaling
**Sushi Memory**: Sprite animation + timing

## Animation Improvements Over Original

### 1. Smooth Transitions
- **Original**: Instant cuts between screens
- **New**: Fade, slide, zoom transitions (300-500ms)

### 2. Feedback Effects
- **Original**: Simple text "CORRECT"/"INCORRECT"
- **New**: 
  - Particle burst on correct (confetti, sparkles)
  - Screen shake on incorrect
  - Score number fly-in animation
  - Progress bar smooth fill

### 3. Character Animation
- **Original**: Static sprite, minimal animation
- **New**:
  - Idle breathing animation
  - Talking mouth movement
  - Excited celebration on high scores
  - Encouraging gestures

### 4. Micro-interactions
- **Original**: Basic hover states
- **New**:
  - Button press depth effect
  - Elastic hover scale
  - Ripple click effect
  - Smooth focus indicators

### 5. Game-Specific Polish
- **Blocks**: Staggered appearance, 3D depth shadows
- **Cards**: Smooth flip, magnetic snap
- **Asteroids**: Trail effect, explosion on click
- **Math**: Number morph animations
- **Scales**: Physics-based tilt

## Performance Targets

### Frame Rate
- **Target**: 60fps constant
- **Method**: RequestAnimationFrame, canvas optimization
- **Fallback**: Reduce particle effects on low-end devices

### Load Time
- **Target**: < 2 seconds initial load
- **Method**: Code splitting, lazy loading mini-games
- **Assets**: Optimize images, use WebP, compress audio

### Memory
- **Target**: < 100MB peak usage
- **Method**: Dispose canvas contexts, cleanup timers
- **Monitoring**: Performance API tracking

## Testing Strategy

### Unit Tests (Vitest)
- Scoring calculations
- Timer logic
- Difficulty scaling
- Game state mutations

### Integration Tests (React Testing Library)
- Complete game flow
- Mini-game transitions
- Score accumulation
- Results calculation

### E2E Tests (Playwright)
- Full playthrough
- Mobile touch interactions
- Browser compatibility
- Performance benchmarks

### Manual Testing Checklist
- [ ] Play each mini-game 10x
- [ ] Verify score ranges match original
- [ ] Test all difficulty levels
- [ ] Mobile touch responsiveness
- [ ] Audio timing and sync
- [ ] Memory leaks (long sessions)

## Browser Support

### Target Browsers
- **Desktop**: Chrome 100+, Firefox 100+, Safari 15+, Edge 100+
- **Mobile**: iOS Safari 15+, Chrome Android 100+
- **Fallback**: Show upgrade message for older browsers

### Progressive Enhancement
- **Core**: Game works without CSS animations
- **Enhanced**: Full animations with requestAnimationFrame
- **Future**: WebGL for particle effects (optional)

## Accessibility (a11y)

### Keyboard Navigation
- Tab through all interactive elements
- Space/Enter to select
- Arrow keys for games where applicable

### Screen Reader Support
- ARIA labels on all buttons
- Live region for score updates
- Game instructions in alt text

### Visual Accessibility
- High contrast mode option
- Colorblind-friendly palettes
- Adjustable text size
- Reduce motion option

## Deployment Strategy

### Build Process
```bash
npm run build          # Vite production build
npm run preview        # Test production build
npm run deploy         # Deploy to hosting
```

### Hosting Options
1. **Vercel** (Recommended)
   - Free tier sufficient
   - Automatic deployments
   - Edge caching
   - Analytics

2. **Netlify** (Alternative)
   - Similar features
   - Slightly different workflow

3. **GitHub Pages** (Budget)
   - Free but manual
   - No server-side features

### Assets CDN
- Use Cloudinary for images
- Self-host audio (small size)
- Font subsetting for performance

## Success Metrics

### Technical
- [x] 60fps animation performance
- [ ] < 2s load time
- [ ] 100% test coverage on core logic
- [ ] 0 console errors in production
- [ ] < 100MB memory usage

### Gameplay
- [ ] Score ranges match original (±10%)
- [ ] Time limits feel identical
- [ ] Difficulty progression smooth
- [ ] All 12 mini-games implemented

### User Experience
- [ ] Animations feel polished
- [ ] Mobile touch works flawlessly
- [ ] Audio enhances (doesn't distract)
- [ ] Visual feedback is immediate

## Timeline Summary

| Phase | Duration | Deliverable |
|-------|----------|-------------|
| 1. Foundation | 3-5 days | Working prototype (1 game) |
| 2. Core Games | 5-7 days | 8/12 games complete |
| 3. Polish | 5-7 days | Animations production-ready |
| 4. Completion | 3-5 days | All 12 games + audio |
| 5. Testing | 3-5 days | Production release |

**Total**: 3-4 weeks for complete, polished recreation

## Next Steps

1. ✅ Source analysis complete (source.md)
2. ✅ Scope defined (this document)
3. ⬜ Set up project structure
4. ⬜ Implement game engine
5. ⬜ Build first mini-game
6. ⬜ Create checklist for remaining work

Ready to start Phase 1 implementation!