// Main App - Game Router and State Manager
import { useState, useEffect } from 'react';
import { useGameStore } from './store/gameStore';
import { MainMenu } from './components/screens/MainMenu';
import { Tutorial } from './components/screens/Tutorial';
import { CountdownScreen } from './components/screens/Countdown';
import { Results } from './components/screens/Results';
import { Summary } from './components/screens/Summary';
import { GAME_COMPONENTS } from './components/games';
import { GameCanvasWrapper } from './components/layout/GameCanvas';

function App() {
  const [error, setError] = useState<string | null>(null);
  const currentScreen = useGameStore((state) => state.currentScreen);
  const currentMinigame = useGameStore((state) => state.currentMinigame);

  useEffect(() => {
    // Global error handler
    const handleError = (event: ErrorEvent) => {
      setError(event.message);
      console.error('App error:', event.error);
    };
    window.addEventListener('error', handleError);
    return () => window.removeEventListener('error', handleError);
  }, []);

  // Show error if any
  if (error) {
    return (
      <div className="min-h-screen bg-red-900 text-white flex items-center justify-center p-8">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Something went wrong</h1>
          <p className="text-red-200">{error}</p>
          <button 
            onClick={() => window.location.reload()} 
            className="mt-4 px-4 py-2 bg-white text-red-900 rounded"
          >
            Reload
          </button>
        </div>
      </div>
    );
  }

  // Render current screen
  const renderScreen = () => {
    try {
      switch (currentScreen) {
        case 'menu':
        case 'splash':
          return <MainMenu />;
        
        case 'tutorial':
          return <Tutorial />;
        
        case 'countdown':
          return <CountdownScreen />;
        
        case 'game':
          const GameComponent = GAME_COMPONENTS[currentMinigame];
          return GameComponent ? (
            <GameCanvasWrapper>
              <GameComponent />
            </GameCanvasWrapper>
          ) : null;
        
        case 'results':
          return <Results />;
        
        case 'summary':
          return <Summary />;
        
        default:
          return <MainMenu />;
      }
    } catch (e) {
      console.error('Render error:', e);
      return <div className="text-white p-8">Error rendering: {String(e)}</div>;
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-900 to-slate-800">
      {renderScreen()}
    </div>
  );
}

export default App;
