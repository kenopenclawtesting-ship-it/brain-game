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

// Full-screen wrapper - warm light background
export function GameCanvasWrapper({ children }: { children: ReactNode }) {
  return (
    <div className="game-page" style={{ justifyContent: 'center' }}>
      <div
        style={{
          position: 'relative',
          zIndex: 1,
          width: '100%',
          maxWidth: CANVAS_WIDTH,
          padding: '10px',
          background: 'rgba(255, 255, 255, 0.3)',
          borderRadius: '16px',
          boxShadow: '0 2px 16px rgba(0, 0, 0, 0.08)',
          border: '1px solid rgba(0, 0, 0, 0.06)',
        }}
      >
        {children}
      </div>
    </div>
  );
}
