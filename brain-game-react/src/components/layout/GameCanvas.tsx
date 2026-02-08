// Game Canvas Container - 640x480 play area matching Flash original
// Used by ALL screens EXCEPT MainMenu (which has its own layout)
import { ReactNode } from 'react';
import { CANVAS_WIDTH, CANVAS_HEIGHT } from '../../lib/constants';

interface GameCanvasProps {
  children: ReactNode;
  className?: string;
}

export function GameCanvas({ children, className = '' }: GameCanvasProps) {
  return (
    <div
      className={`game-canvas relative overflow-hidden ${className}`}
      style={{
        width: CANVAS_WIDTH,
        height: CANVAS_HEIGHT,
        maxWidth: '100%',
        aspectRatio: `${CANVAS_WIDTH} / ${CANVAS_HEIGHT}`,
      }}
    >
      {children}
    </div>
  );
}

// Full-screen wrapper - DARK TV game show background with spotlights
export function GameCanvasWrapper({ children }: { children: ReactNode }) {
  return (
    <div className="game-page" style={{ justifyContent: 'center' }}>
      {/* Spotlight beams */}
      <div className="spotlight spotlight-left" />
      <div className="spotlight spotlight-right" />
      <div className="spotlight spotlight-center" />

      <div
        style={{
          position: 'relative',
          zIndex: 1,
          width: '100%',
          maxWidth: CANVAS_WIDTH,
          padding: '10px',
          background: 'linear-gradient(180deg, rgba(80,80,180,0.25) 0%, rgba(60,40,120,0.2) 50%, rgba(40,20,80,0.25) 100%)',
          borderRadius: '16px',
          boxShadow: '0 0 50px rgba(100,80,200,0.35), 0 0 100px rgba(80,60,180,0.15)',
          border: '1px solid rgba(120,100,200,0.3)',
        }}
      >
        {children}
      </div>
    </div>
  );
}
