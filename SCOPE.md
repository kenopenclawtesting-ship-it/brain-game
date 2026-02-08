# SCOPE.md - React Conversion Plan

## 1. Conversion Overview

### 1.1 Technology Stack
| Flash AS3 | React/TypeScript |
|-----------|------------------|
| MovieClip | React Component |
| Sprite | SVG / Canvas / CSS |
| TextField | HTML input / div |
| Event listeners | React hooks + handlers |
| Timeline animations | CSS animations / Framer Motion |
| Sound (flash.media) | Web Audio API / Howler.js |
| SharedObject | localStorage / IndexedDB |

### 1.2 Architecture Approach
```
Flash (OOP + Timeline)  →  React (Functional + Hooks + State)

MovieClip hierarchy     →  Component tree
Static singletons       →  React Context / Zustand
Frame-based animation   →  CSS transitions / requestAnimationFrame
```

---

## 2. Component Tree Mapping

### 2.1 AS3 to React Component Map
```
GameWorld.as           → <GameProvider> (Context)
├── Engine.as          → App.tsx (main orchestrator)
├── MainMenu.as        → <MainMenu />
├── TutorialScreen.as  → <Tutorial />
├── MinigameBase.as    → <GameContainer />
│   ├── Calculate.as   → <CalculateGame />
│   ├── MatchCard.as   → <MatchCardGame />
│   ├── MissingSign.as → <MissingSignGame />
│   └── ... (12 games)
├── SummaryScreen.as   → <Summary />
├── HighScorePanel.as  → <Leaderboard />
└── AchievementHandler → <Achievements />
```

### 2.2 Detailed Component Structure
```
src/
├── components/
│   ├── layout/
│   │   ├── GameCanvas.tsx       # 640x480 canvas wrapper
│   │   ├── Timer.tsx            # Countdown timer
│   │   └── ScoreDisplay.tsx     # Current score
│   ├── screens/
│   │   ├── MainMenu.tsx
│   │   ├── Tutorial.tsx
│   │   ├── Summary.tsx
│   │   ├── Profile.tsx
│   │   └── Leaderboard.tsx
│   ├── games/
│   │   ├── GameContainer.tsx    # Common game wrapper
│   │   ├── Calculate/
│   │   │   ├── Calculate.tsx
│   │   │   ├── NumberPad.tsx
│   │   │   └── Equation.tsx
│   │   ├── MatchCard/
│   │   │   ├── MatchCard.tsx
│   │   │   └── Card.tsx
│   │   └── ... (12 game folders)
│   └── ui/
│       ├── Button.tsx
│       ├── Modal.tsx
│       ├── Professor.tsx
│       └── BrainSprite.tsx
├── hooks/
│   ├── useGameTimer.ts
│   ├── useScore.ts
│   ├── useSound.ts
│   └── useAnimation.ts
├── context/
│   ├── GameContext.tsx
│   └── UserContext.tsx
├── lib/
│   ├── scoring.ts               # Score calculations
│   ├── brainType.ts             # Brain size calc
│   ├── achievements.ts
│   └── constants.ts
├── types/
│   └── index.ts
└── assets/
    ├── sounds/
    ├── images/
    └── sprites/
```

---

## 3. State Management

### 3.1 Global State (Context/Zustand)
```typescript
interface GameState {
  // Game mode
  gameMode: 'menu' | 'fullTest' | 'practice' | 'challenge';
  currentScreen: Screen;
  
  // Current game session
  currentCategory: number;        // 0-3
  currentMinigame: number;        // 0-11
  categoryScores: number[];       // [score0, score1, score2, score3]
  totalScore: number;
  totalCorrect: number;
  totalIncorrect: number;
  
  // Timer
  timeRemaining: number;          // ms
  isTimerRunning: boolean;
  
  // User
  user: UserInfo;
  bestScores: number[];           // Best per minigame
  achievements: number;           // Bitmask
  playCount: number;
}
```

### 3.2 Per-Game Local State
```typescript
interface MinigameState {
  round: number;
  currentQuestion: Question;
  correctThisRound: number;
  incorrectThisRound: number;
  gamePhase: 'intro' | 'play' | 'feedback' | 'complete';
}
```

---

## 4. Asset Integration Plan

### 4.1 Sprite Conversion Strategy
| Flash Asset | React Implementation |
|-------------|---------------------|
| MovieClip (static) | PNG/SVG image |
| MovieClip (animated) | CSS animation / sprite sheet |
| Vector shapes | SVG components |
| Bitmap | PNG with proper resolution |
| Font (embedded) | Web font (@font-face) |

### 4.2 Animation Approaches
```
Option A: CSS Animations (preferred for UI)
- Simple state transitions
- Button hover/active states
- Modal open/close

Option B: Framer Motion (for complex UI)
- Page transitions
- Staggered lists
- Spring physics

Option C: Canvas/requestAnimationFrame (for games)
- MatchCard card flipping
- MeteorSequence falling objects
- CarPath vehicle movement

Option D: Lottie (for complex pre-made)
- Professor character
- Brain growth animation
- Victory celebration
```

### 4.3 Sound Integration
```typescript
// Using Howler.js
const sounds = {
  theme: new Howl({ src: ['/sounds/ThemeMusic.mp3'], loop: true }),
  ingame: new Howl({ src: ['/sounds/IngameMusic.mp3'], loop: true }),
  click: new Howl({ src: ['/sounds/ButtonInGame.mp3'] }),
  timer: new Howl({ src: ['/sounds/TimerSound.mp3'] }),
  start: new Howl({ src: ['/sounds/StartSound.mp3'] }),
  applause: new Howl({ src: ['/sounds/ApplauseSound.mp3'] }),
  cheer: new Howl({ src: ['/sounds/CrowdCheerSound.mp3'] }),
};
```

---

## 5. Phase Breakdown

### Phase 1: Foundation (1-2 weeks)
- [x] Extract and analyze source
- [ ] Set up React + TypeScript project
- [ ] Create game canvas container (640x480)
- [ ] Implement routing (React Router)
- [ ] Set up state management
- [ ] Create base UI components
- [ ] Implement sound system

**Deliverable**: Skeleton app with navigation

### Phase 2: Core Mechanics (2-3 weeks)
- [ ] Build timer component
- [ ] Build score system
- [ ] Build GameContainer (shared minigame wrapper)
- [ ] Implement countdown animation
- [ ] Implement correct/incorrect feedback
- [ ] Implement "Time's Up" screen

**Deliverable**: One working minigame (Calculate)

### Phase 3: All Minigames (4-6 weeks)
- [ ] Calculate (Missing Number) - 3 days
- [ ] MatchCard (Card Pairs) - 3 days
- [ ] MissingSign - 2 days
- [ ] CubeCounter - 3 days
- [ ] WeightGame - 3 days
- [ ] MeteorSequence - 3 days
- [ ] JigsawMatch - 4 days
- [ ] ShapeOrder - 2 days
- [ ] MathCombination (PRO) - 3 days
- [ ] SequenceMatch (PRO) - 4 days
- [ ] MemorySequence (PRO) - 3 days
- [ ] CarPath (PRO) - 4 days

**Deliverable**: All 12 games playable

### Phase 4: Game Flow (1-2 weeks)
- [ ] Main menu
- [ ] Tutorial screens per category
- [ ] Full test mode (4 categories)
- [ ] Practice mode
- [ ] Summary screen with brain calculation
- [ ] Results sharing

**Deliverable**: Complete single-player flow

### Phase 5: Polish (1-2 weeks)
- [ ] Professor animations
- [ ] Brain growth animation
- [ ] Particle effects
- [ ] Sound polish
- [ ] Mobile responsiveness
- [ ] Performance optimization

**Deliverable**: Production-ready game

### Phase 6: Social Features (Optional, 2-3 weeks)
- [ ] User accounts
- [ ] Leaderboards
- [ ] Challenge mode
- [ ] Achievement system
- [ ] Progress persistence

**Total Estimate**: 11-18 weeks

---

## 6. Effort Estimates

| Component | Complexity | Estimate |
|-----------|------------|----------|
| Project setup | Low | 1 day |
| State management | Medium | 2 days |
| Timer system | Low | 1 day |
| Score system | Low | 1 day |
| Sound system | Medium | 2 days |
| Calculate game | Medium | 3 days |
| MatchCard game | High | 4 days |
| MissingSign game | Low | 2 days |
| CubeCounter game | High | 4 days |
| WeightGame | Medium | 3 days |
| MeteorSequence | Medium | 3 days |
| JigsawMatch | High | 4 days |
| ShapeOrder | Medium | 2 days |
| MathCombination | Medium | 3 days |
| SequenceMatch | High | 4 days |
| MemorySequence | Medium | 3 days |
| CarPath | High | 4 days |
| Main menu | Medium | 2 days |
| Tutorial system | Medium | 2 days |
| Summary screen | Medium | 3 days |
| Animations | High | 5 days |
| Testing | Medium | 5 days |

**Total**: ~60 dev days (~12 weeks at sustainable pace)

---

## 7. Risk Register

### 7.1 High Risk
| Risk | Impact | Mitigation |
|------|--------|------------|
| Complex animations hard to replicate | Game feel suffers | Use Lottie for pre-made, simplify where needed |
| Canvas performance issues | Laggy gameplay | Use CSS transforms, virtualize where possible |
| Sound timing precision | Audio desync | Use Web Audio API with precise scheduling |

### 7.2 Medium Risk
| Risk | Impact | Mitigation |
|------|--------|------------|
| CubeCounter 3D rendering | Visual mismatch | Use pre-rendered isometric sprites |
| CarPath path logic | Bugs in movement | Thoroughly unit test path algorithms |
| Mobile touch events | Poor mobile UX | Design touch-first, test early |

### 7.3 Low Risk
| Risk | Impact | Mitigation |
|------|--------|------------|
| Font rendering differences | Minor visual diff | Use web-safe fallbacks |
| Browser compatibility | Edge cases | Test on major browsers early |

### 7.4 Won't Translate 1:1
- **Flash vector rendering** → May need PNG fallbacks for complex shapes
- **MovieClip timeline scrubbing** → Will use CSS keyframes instead
- **Embedded fonts (Baveuse)** → Need web font license or substitute
- **Facebook SDK integration** → Will use modern OAuth if needed

---

## 8. Technology Recommendations

### 8.1 Core Stack
```
React 18+          - Component framework
TypeScript 5+      - Type safety
Vite               - Build tool
Tailwind CSS       - Utility styling
Zustand            - State management (simpler than Redux)
React Router 6     - Navigation
```

### 8.2 Game-Specific
```
Howler.js          - Audio (cross-browser)
Framer Motion      - UI animations
react-spring       - Physics animations (optional)
```

### 8.3 Optional Enhancements
```
Lottie             - Complex animations
PixiJS             - If Canvas needed for performance
Firebase           - Backend (auth, leaderboards)
```

---

## 9. Testing Strategy

### 9.1 Unit Tests
- Score calculations
- Brain type calculations
- Timer logic
- Per-game question generation

### 9.2 Integration Tests
- Game flow (menu → tutorial → game → summary)
- State persistence
- Sound triggers

### 9.3 E2E Tests
- Complete game session
- Achievement unlocks
- Leaderboard updates

---

## 10. Deployment

### 10.1 Current Setup
- Domain: whosthesmartest.com
- Hosting: Cloudflare Pages
- Already configured in TOOLS.md

### 10.2 CI/CD Pipeline
```
GitHub Actions:
1. Lint + Type check
2. Run tests
3. Build production
4. Deploy to Cloudflare Pages
```

---

*This scope document is based on analysis of the decompiled Flash source.*
*Estimates assume a single developer working full-time.*
