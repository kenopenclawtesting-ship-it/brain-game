// Game Canvas Container - 640x480 play area matching Flash original
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

// Full-screen responsive wrapper that scales the canvas - LIGHT background like original
export function GameCanvasWrapper({ children }: { children: ReactNode }) {
  return (
    <div 
      className="flex items-center justify-center min-h-screen p-4"
      style={{
        background: 'linear-gradient(180deg, #e8f4f8 0%, #ffffff 100%)',
      }}
    >
      <div 
        className="relative"
        style={{
          width: '100%',
          maxWidth: CANVAS_WIDTH,
        }}
      >
        {children}
      </div>
    </div>
  );
}
