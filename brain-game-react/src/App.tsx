// Main App - Game Router and State Manager
import { useGameStore } from './store/gameStore';
import { MainMenu } from './components/screens/MainMenu';
import { Tutorial } from './components/screens/Tutorial';
import { CountdownScreen } from './components/screens/Countdown';
import { Results } from './components/screens/Results';
import { Summary } from './components/screens/Summary';
import { GAME_COMPONENTS } from './components/games';
import { GameCanvasWrapper } from './components/layout/GameCanvas';

function App() {
  const currentScreen = useGameStore((state) => state.currentScreen);
  const currentMinigame = useGameStore((state) => state.currentMinigame);

  // Render current screen
  const renderScreen = () => {
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
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-900 to-slate-800">
      {renderScreen()}
    </div>
  );
}

export default App;
