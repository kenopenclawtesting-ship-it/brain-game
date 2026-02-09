import React, { useCallback, useRef, useEffect, useState } from 'react';
import * as PIXI from 'pixi.js';

// Flash stage dimensions
const STAGE_WIDTH = 640;
const STAGE_HEIGHT = 480;

interface GameCanvasProps {
  children?: React.ReactNode;
  onAppReady?: (app: PIXI.Application) => void;
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

export function GameCanvas({ children, onAppReady }: GameCanvasProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLDivElement>(null);
  const appRef = useRef<PIXI.Application | null>(null);
  const [app, setApp] = useState<PIXI.Application | null>(null);

  // Initialize PixiJS application
  useEffect(() => {
    if (!canvasRef.current || appRef.current) return;

    const pixiApp = new PIXI.Application();
    appRef.current = pixiApp;

    pixiApp.init({
      width: STAGE_WIDTH,
      height: STAGE_HEIGHT,
      backgroundColor: 0x000000,
      antialias: true,
      autoDensity: true,
      resolution: Math.max(1, window.devicePixelRatio || 1),
    }).then(() => {
      if (canvasRef.current && pixiApp.canvas) {
        canvasRef.current.appendChild(pixiApp.canvas as HTMLCanvasElement);
        setApp(pixiApp);
        onAppReady?.(pixiApp);
      }
    });

    return () => {
      pixiApp.destroy(true);
      appRef.current = null;
    };
  }, [onAppReady]);

  // Handle responsive scaling
  const calculateLayout = useCallback(() => {
    if (!containerRef.current || !canvasRef.current) return;

    const container = containerRef.current;
    const containerWidth = container.clientWidth;
    const containerHeight = container.clientHeight;

    const scaleX = containerWidth / STAGE_WIDTH;
    const scaleY = containerHeight / STAGE_HEIGHT;
    const scale = Math.min(scaleX, scaleY);

    const scaledWidth = STAGE_WIDTH * scale;
    const scaledHeight = STAGE_HEIGHT * scale;
    const offsetX = (containerWidth - scaledWidth) / 2;
    const offsetY = (containerHeight - scaledHeight) / 2;

    canvasRef.current.style.left = `${offsetX}px`;
    canvasRef.current.style.top = `${offsetY}px`;
    canvasRef.current.style.width = `${STAGE_WIDTH}px`;
    canvasRef.current.style.height = `${STAGE_HEIGHT}px`;
    canvasRef.current.style.transformOrigin = '0 0';
    canvasRef.current.style.transform = `scale(${scale})`;
  }, []);

  useEffect(() => {
    calculateLayout();
    window.addEventListener('resize', calculateLayout);
    return () => window.removeEventListener('resize', calculateLayout);
  }, [calculateLayout]);

  return (
    <PixiAppContext.Provider value={app}>
      <div
        ref={containerRef}
        className="relative w-full h-full overflow-hidden bg-black"
        style={{ minHeight: '400px' }}
      >
        <div ref={canvasRef} className="absolute" />
      </div>
      {app && children}
    </PixiAppContext.Provider>
  );
}

export { STAGE_WIDTH, STAGE_HEIGHT };
