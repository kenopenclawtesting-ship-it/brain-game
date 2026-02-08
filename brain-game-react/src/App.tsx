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
    const handleError = (event: ErrorEvent) => {
      setError(event.message);
      console.error('App error:', event.error);
    };
    window.addEventListener('error', handleError);
    return () => window.removeEventListener('error', handleError);
  }, []);

  if (error) {
    return (
      <div style={{
        minHeight: '100vh',
        background: '#1a0a0a',
        color: '#ff6666',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: 32,
        fontFamily: 'Baveuse, cursive',
      }}>
        <div style={{ textAlign: 'center', background: '#2a1a1a', padding: 32, borderRadius: 16 }}>
          <h1 style={{ fontSize: 24, marginBottom: 16 }}>Something went wrong</h1>
          <p style={{ color: '#ff8888' }}>{error}</p>
          <button
            onClick={() => window.location.reload()}
            style={{
              marginTop: 16,
              padding: '10px 24px',
              background: '#cc3333',
              color: '#fff',
              border: 'none',
              borderRadius: 10,
              cursor: 'pointer',
              fontFamily: 'Baveuse, cursive',
              fontSize: 16,
            }}
          >
            Reload
          </button>
        </div>
      </div>
    );
  }

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
        <div style={{
          minHeight: '100vh',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          background: '#0a0e2a',
        }}>
          <div style={{
            background: '#2a1a3a',
            padding: 32,
            borderRadius: 16,
            color: '#ff6666',
            fontFamily: 'Baveuse, cursive',
          }}>
            Error rendering: {String(e)}
          </div>
        </div>
      );
    }
  };

  return renderScreen();
}

export default App;
