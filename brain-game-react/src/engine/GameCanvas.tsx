import React, { useCallback, useRef, useEffect } from 'react';
import { Stage, useApp } from '@pixi/react';
import * as PIXI from 'pixi.js';

// Flash stage dimensions
const STAGE_WIDTH = 640;
const STAGE_HEIGHT = 480;

interface GameCanvasProps {
  children: React.ReactNode;
}

// Context for providing PIXI app to child components
export const PixiAppContext = React.createContext<PIXI.Application | null>(null);

export const usePixiApp = () => {
  const app = React.useContext(PixiAppContext);
  if (!app) {
    throw new Error('usePixiApp must be used within a GameCanvas');
  }
  return app;
};

// Stage wrapper component to provide context
function StageWrapper({ children }: { children: React.ReactNode }) {
  const app = useApp();
  
  return (
    <PixiAppContext.Provider value={app}>
      {children}
    </PixiAppContext.Provider>
  );
}

export function GameCanvas({ children }: GameCanvasProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const [scale, setScale] = React.useState(1);
  const [offset, setOffset] = React.useState({ x: 0, y: 0 });

  const calculateLayout = useCallback(() => {
    if (!containerRef.current) return;

    const container = containerRef.current;
    const containerWidth = container.clientWidth;
    const containerHeight = container.clientHeight;

    // Calculate scale to fit while maintaining aspect ratio
    const scaleX = containerWidth / STAGE_WIDTH;
    const scaleY = containerHeight / STAGE_HEIGHT;
    const newScale = Math.min(scaleX, scaleY);

    // Calculate centering offset (letterboxing)
    const scaledWidth = STAGE_WIDTH * newScale;
    const scaledHeight = STAGE_HEIGHT * newScale;
    const offsetX = (containerWidth - scaledWidth) / 2;
    const offsetY = (containerHeight - scaledHeight) / 2;

    setScale(newScale);
    setOffset({ x: offsetX, y: offsetY });
  }, []);

  useEffect(() => {
    calculateLayout();
    
    const handleResize = () => {
      calculateLayout();
    };

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, [calculateLayout]);

  // PIXI.js app options
  const options: Partial<PIXI.ApplicationOptions> = {
    width: STAGE_WIDTH,
    height: STAGE_HEIGHT,
    backgroundColor: 0x000000,
    antialias: true,
    autoDensity: true,
    resolution: Math.max(1, window.devicePixelRatio || 1),
  };

  return (
    <div 
      ref={containerRef}
      className="relative w-full h-full overflow-hidden bg-black"
      style={{
        minHeight: '400px',
      }}
    >
      <div
        className="absolute"
        style={{
          left: `${offset.x}px`,
          top: `${offset.y}px`,
          width: `${STAGE_WIDTH * scale}px`,
          height: `${STAGE_HEIGHT * scale}px`,
          transformOrigin: '0 0',
          transform: `scale(${scale})`,
        }}
      >
        <Stage 
          {...options}
          width={STAGE_WIDTH}
          height={STAGE_HEIGHT}
        >
          <StageWrapper>
            {children}
          </StageWrapper>
        </Stage>
      </div>
    </div>
  );
}

export { STAGE_WIDTH, STAGE_HEIGHT };