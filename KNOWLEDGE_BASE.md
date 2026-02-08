# Knowledge Base - Technology Stack Reference

This document serves as the knowledge base for all technologies used in the conversion. 
(In Mark's workflow, this would be ingested via Context7 MCP)

## React 18 + TypeScript

### Key Concepts for Game Development

#### Component Architecture
```typescript
// Game component pattern
interface MiniGameProps {
  onComplete: (score: number) => void;
  difficulty: number;
  timeLimit: number;
}

const MiniGame: React.FC<MiniGameProps> = ({ onComplete, difficulty, timeLimit }) => {
  const [score, setScore] = useState(0);
  const [timeLeft, setTimeLeft] = useState(timeLimit);
  
  useEffect(() => {
    // Timer logic
    if (timeLeft <= 0) {
      onComplete(score);
    }
  }, [timeLeft]);
  
  return <div>Game UI</div>;
};
```

#### Hooks for Games
- `useState` - Game state (score, lives, etc.)
- `useEffect` - Timers, animations, side effects
- `useRef` - Canvas refs, timer refs
- `useCallback` - Memoized game functions
- `useMemo` - Expensive calculations
- Custom hooks - `useTimer`, `useScore`, `useGameLoop`

### TypeScript Best Practices
```typescript
// Strong typing for game state
type GameState = 'idle' | 'playing' | 'paused' | 'complete';
type Category = 'analysis' | 'calculation' | 'memory' | 'visual';

interface GameScore {
  category: Category;
  points: number;
  timeBonus: number;
  total: number;
}
```

## HTML5 Canvas

### Canvas Setup
```typescript
const canvasRef = useRef<HTMLCanvasElement>(null);

useEffect(() => {
  const canvas = canvasRef.current;
  if (!canvas) return;
  
  const ctx = canvas.getContext('2d');
  if (!ctx) return;
  
  // Game loop
  let animationId: number;
  const render = () => {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    // Draw game objects
    animationId = requestAnimationFrame(render);
  };
  
  render();
  
  return () => cancelAnimationFrame(animationId);
}, []);
```

### Isometric Projection (Block Counting)
```typescript
// Convert 3D grid coords to 2D isometric
function to2D(x: number, y: number, z: number) {
  const tileWidth = 40;
  const tileHeight = 20;
  const tileDepth = 30;
  
  return {
    x: (x - z) * (tileWidth / 2),
    y: (x + z) * (tileHeight / 2) - y * tileDepth
  };
}

// Draw isometric cube
function drawBlock(ctx: CanvasRenderingContext2D, x: number, y: number, z: number) {
  const pos = to2D(x, y, z);
  
  // Top face
  ctx.beginPath();
  ctx.moveTo(pos.x, pos.y);
  ctx.lineTo(pos.x + 20, pos.y + 10);
  ctx.lineTo(pos.x, pos.y + 20);
  ctx.lineTo(pos.x - 20, pos.y + 10);
  ctx.closePath();
  ctx.fillStyle = '#4a90e2';
  ctx.fill();
  
  // Left face
  ctx.beginPath();
  ctx.moveTo(pos.x, pos.y);
  ctx.lineTo(pos.x - 20, pos.y + 10);
  ctx.lineTo(pos.x - 20, pos.y + 40);
  ctx.lineTo(pos.x, pos.y + 30);
  ctx.closePath();
  ctx.fillStyle = '#357abd';
  ctx.fill();
  
  // Right face
  ctx.beginPath();
  ctx.moveTo(pos.x, pos.y);
  ctx.lineTo(pos.x + 20, pos.y + 10);
  ctx.lineTo(pos.x + 20, pos.y + 40);
  ctx.lineTo(pos.x, pos.y + 30);
  ctx.closePath();
  ctx.fillStyle = '#5ba3e8';
  ctx.fill();
}
```

### Collision Detection (Asteroids)
```typescript
function pointInCircle(px: number, py: number, cx: number, cy: number, radius: number): boolean {
  const dx = px - cx;
  const dy = py - cy;
  return dx * dx + dy * dy <= radius * radius;
}

// Click handler
canvas.addEventListener('click', (e) => {
  const rect = canvas.getBoundingClientRect();
  const x = e.clientX - rect.left;
  const y = e.clientY - rect.top;
  
  asteroids.forEach(asteroid => {
    if (pointInCircle(x, y, asteroid.x, asteroid.y, asteroid.radius)) {
      handleAsteroidClick(asteroid);
    }
  });
});
```

## React Spring (Animations)

### Spring Physics Animations
```typescript
import { useSpring, animated } from '@react-spring/web';

// Score increment animation
const scoreProps = useSpring({
  from: { number: 0 },
  to: { number: currentScore },
  config: { tension: 280, friction: 60 }
});

<animated.div>
  {scoreProps.number.to(n => Math.floor(n))}
</animated.div>

// Card flip animation
const flipProps = useSpring({
  transform: isFlipped ? 'rotateY(180deg)' : 'rotateY(0deg)',
  config: { tension: 200, friction: 20 }
});

// Button press
const [buttonProps, setButtonProps] = useSpring(() => ({
  scale: 1
}));

<animated.button
  style={{ transform: buttonProps.scale.to(s => `scale(${s})`) }}
  onMouseDown={() => setButtonProps({ scale: 0.95 })}
  onMouseUp={() => setButtonProps({ scale: 1 })}
>
  Click Me
</animated.button>
```

### Particle Effects
```typescript
const [particles, setParticles] = useState<Particle[]>([]);

// Spawn confetti on correct answer
function spawnConfetti(x: number, y: number) {
  const newParticles = Array.from({ length: 30 }, (_, i) => ({
    id: Date.now() + i,
    x,
    y,
    vx: (Math.random() - 0.5) * 10,
    vy: Math.random() * -10,
    color: ['#ff0', '#f0f', '#0ff', '#0f0'][Math.floor(Math.random() * 4)],
    life: 1
  }));
  
  setParticles(prev => [...prev, ...newParticles]);
}

// Animate particles
useEffect(() => {
  const interval = setInterval(() => {
    setParticles(prev => 
      prev
        .map(p => ({
          ...p,
          x: p.x + p.vx,
          y: p.y + p.vy,
          vy: p.vy + 0.5, // gravity
          life: p.life - 0.02
        }))
        .filter(p => p.life > 0)
    );
  }, 16);
  
  return () => clearInterval(interval);
}, []);
```

## Zustand (State Management)

### Game Store
```typescript
import create from 'zustand';

interface GameStore {
  gameState: 'menu' | 'playing' | 'results';
  currentGame: number;
  scores: number[];
  totalScore: number;
  
  startGame: () => void;
  completeGame: (score: number) => void;
  nextGame: () => void;
  resetGame: () => void;
}

export const useGameStore = create<GameStore>((set, get) => ({
  gameState: 'menu',
  currentGame: 0,
  scores: [],
  totalScore: 0,
  
  startGame: () => set({ gameState: 'playing', scores: [], currentGame: 0 }),
  
  completeGame: (score: number) => set(state => ({
    scores: [...state.scores, score],
    totalScore: state.totalScore + score
  })),
  
  nextGame: () => set(state => {
    const next = state.currentGame + 1;
    return next >= 4 
      ? { gameState: 'results' }
      : { currentGame: next };
  }),
  
  resetGame: () => set({
    gameState: 'menu',
    currentGame: 0,
    scores: [],
    totalScore: 0
  })
}));

// Usage in component
function GameComponent() {
  const { gameState, startGame, completeGame } = useGameStore();
  
  return (
    <div>
      {gameState === 'menu' && <button onClick={startGame}>Start</button>}
    </div>
  );
}
```

## Vite Configuration

### vite.config.ts
```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  build: {
    target: 'es2015',
    minify: 'terser',
    rollupOptions: {
      output: {
        manualChunks: {
          'react-vendor': ['react', 'react-dom'],
          'game-vendor': ['zustand', '@react-spring/web']
        }
      }
    }
  },
  server: {
    port: 3000,
    open: true
  }
});
```

## Testing

### Vitest Setup
```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: './src/test/setup.ts'
  }
});
```

### Unit Test Example
```typescript
import { describe, it, expect } from 'vitest';
import { calculateBrainSize } from './scoring';

describe('Score Calculations', () => {
  it('should calculate correct brain size', () => {
    expect(calculateBrainSize(500)).toBe(1200);
    expect(calculateBrainSize(1500)).toBe(1800);
    expect(calculateBrainSize(3000)).toBe(3000);
  });
  
  it('should scale score with difficulty', () => {
    const score1 = calculateScore(10, 0.5); // 10 correct, 0.5 difficulty
    const score2 = calculateScore(10, 1.0);
    expect(score2).toBeGreaterThan(score1);
  });
});
```

### React Testing Library
```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import { describe, it, expect, vi } from 'vitest';
import { BlockCounting } from './BlockCounting';

describe('BlockCounting', () => {
  it('should call onComplete when timer expires', async () => {
    const onComplete = vi.fn();
    render(<BlockCounting onComplete={onComplete} difficulty={0.5} />);
    
    // Fast-forward timer
    vi.advanceTimersByTime(30000);
    
    expect(onComplete).toHaveBeenCalledWith(expect.any(Number));
  });
  
  it('should increase score on correct answer', () => {
    render(<BlockCounting onComplete={() => {}} difficulty={0.5} />);
    
    const input = screen.getByPlaceholderText('How many blocks?');
    const button = screen.getByText('Submit');
    
    fireEvent.change(input, { target: { value: '10' } });
    fireEvent.click(button);
    
    expect(screen.getByText(/Score: \d+/)).toBeInTheDocument();
  });
});
```

## Performance Optimization

### Canvas Performance
```typescript
// Offscreen canvas for complex graphics
const offscreenCanvas = document.createElement('canvas');
const offscreenCtx = offscreenCanvas.getContext('2d');

// Pre-render static elements
function prerenderBackground() {
  // Draw to offscreen canvas
  offscreenCtx.fillStyle = '#000';
  offscreenCtx.fillRect(0, 0, width, height);
  // Draw stars, etc.
}

// Main render loop - just copy prerendered
function render() {
  ctx.drawImage(offscreenCanvas, 0, 0);
  // Draw dynamic elements
}
```

### RequestAnimationFrame Throttling
```typescript
let lastTime = 0;
const fps = 60;
const interval = 1000 / fps;

function gameLoop(currentTime: number) {
  requestAnimationFrame(gameLoop);
  
  const deltaTime = currentTime - lastTime;
  
  if (deltaTime > interval) {
    lastTime = currentTime - (deltaTime % interval);
    
    // Update game state
    update(deltaTime);
    render();
  }
}
```

### Memory Management
```typescript
useEffect(() => {
  // Setup
  const canvas = canvasRef.current;
  const ctx = canvas?.getContext('2d');
  
  // Cleanup
  return () => {
    // Cancel animations
    if (animationId) cancelAnimationFrame(animationId);
    
    // Clear timers
    clearInterval(timerId);
    
    // Remove event listeners
    canvas?.removeEventListener('click', handleClick);
    
    // Dispose canvas
    if (ctx) {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
    }
  };
}, []);
```

## Audio (Web Audio API)

### Audio Context Setup
```typescript
class AudioManager {
  private ctx: AudioContext;
  private sounds: Map<string, AudioBuffer> = new Map();
  private volume = 1.0;
  private muted = false;
  
  constructor() {
    this.ctx = new (window.AudioContext || window.webkitAudioContext)();
  }
  
  async loadSound(name: string, url: string) {
    const response = await fetch(url);
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await this.ctx.decodeAudioData(arrayBuffer);
    this.sounds.set(name, audioBuffer);
  }
  
  play(name: string) {
    if (this.muted) return;
    
    const buffer = this.sounds.get(name);
    if (!buffer) return;
    
    const source = this.ctx.createBufferSource();
    const gainNode = this.ctx.createGain();
    
    source.buffer = buffer;
    gainNode.gain.value = this.volume;
    
    source.connect(gainNode);
    gainNode.connect(this.ctx.destination);
    
    source.start(0);
  }
  
  setVolume(v: number) {
    this.volume = Math.max(0, Math.min(1, v));
  }
  
  toggleMute() {
    this.muted = !this.muted;
  }
}

// Hook
const audioManager = new AudioManager();

export function useAudio() {
  const [isLoaded, setIsLoaded] = useState(false);
  
  useEffect(() => {
    Promise.all([
      audioManager.loadSound('correct', '/sounds/correct.mp3'),
      audioManager.loadSound('incorrect', '/sounds/incorrect.mp3'),
      audioManager.loadSound('click', '/sounds/click.mp3')
    ]).then(() => setIsLoaded(true));
  }, []);
  
  return {
    isLoaded,
    play: (name: string) => audioManager.play(name),
    setVolume: (v: number) => audioManager.setVolume(v),
    toggleMute: () => audioManager.toggleMute()
  };
}
```

## Deployment (Vercel)

### vercel.json
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "devCommand": "npm run dev",
  "installCommand": "npm install",
  "framework": "vite",
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

## Quick Reference Commands

```bash
# Setup
npm create vite@latest brain-game -- --template react-ts
cd brain-game
npm install zustand @react-spring/web

# Development
npm run dev          # Start dev server
npm run build        # Production build
npm run preview      # Preview production build

# Testing
npm run test         # Run Vitest
npm run test:ui      # Vitest UI
npm run test:coverage # Coverage report

# Deployment
npm run deploy       # Deploy to Vercel
```

## Key Patterns Summary

1. **Component Structure**: Props interface → hooks → effects → render
2. **Game Loop**: RAF → update → render → repeat
3. **State**: Zustand for global, useState for local
4. **Animation**: React Spring for UI, Canvas for game objects
5. **Performance**: Memoization, offscreen canvas, throttling
6. **Testing**: Unit (Vitest) → Integration (RTL) → E2E (Playwright)
7. **Cleanup**: Always cleanup in useEffect returns

This KB covers 90% of what we'll need for implementation.