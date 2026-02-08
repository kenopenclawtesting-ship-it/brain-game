// Main App - Game Router and State Manager
import { useState, useEffect } from 'react';
import { useGameStore } from './store/gameStore';
import { MainMenu } from './components/screens/MainMenu';
import { GameSelect } from './components/screens/GameSelect';
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
      <div className="min-h-screen bg-red-100 text-red-900 flex items-center justify-center p-8">
        <div className="text-center bg-white p-8 rounded-xl shadow-lg">
          <h1 className="text-2xl font-bold mb-4">Something went wrong</h1>
          <p className="text-red-600">{error}</p>
          <button 
            onClick={() => window.location.reload()} 
            className="mt-4 px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600"
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
        case 'splash':
        case 'menu':
          return <MainMenu />;
        
        case 'gameSelect':
          return <GameSelect />;
        
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
      return (
        <div className="min-h-screen flex items-center justify-center">
          <div className="bg-white p-8 rounded-xl shadow-lg text-red-600">
            Error rendering: {String(e)}
          </div>
        </div>
      );
    }
  };

  return (
    <div className="min-h-screen">
      {renderScreen()}
    </div>
  );
}

export default App;
