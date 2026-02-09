// Main App - Screen router with smooth page transitions
import { AnimatePresence, motion } from 'framer-motion';
import { useGameStore } from './store/gameStore';
import { MainMenu } from './components/screens/MainMenu';
import { GameSelect } from './components/screens/GameSelect';
import { Tutorial } from './components/screens/Tutorial';
import { CountdownScreen } from './components/screens/Countdown';
import { Results } from './components/screens/Results';
import { Summary } from './components/screens/Summary';
import { GAME_COMPONENTS } from './components/games';
import { MinigameId } from './types';
import './index.css';

// Screens that should use fade transitions (not the game itself)
const TRANSITION_SCREENS = ['menu', 'gameSelect', 'tutorial', 'results', 'summary'];

function App() {
  const currentScreen = useGameStore((state) => state.currentScreen);
  const currentMinigame = useGameStore((state) => state.currentMinigame);

  const renderScreen = () => {
    switch (currentScreen) {
      case 'menu':
        return <MainMenu />;
      case 'gameSelect':
        return <GameSelect />;
      case 'tutorial':
        return <Tutorial />;
      case 'countdown':
        return <CountdownScreen />;
      case 'game': {
        const GameComponent = GAME_COMPONENTS[currentMinigame as MinigameId];
        return GameComponent ? <GameComponent /> : null;
      }
      case 'results':
        return <Results />;
      case 'summary':
        return <Summary />;
      default:
        return <MainMenu />;
    }
  };

  const useFade = TRANSITION_SCREENS.includes(currentScreen);

  return (
    <AnimatePresence mode="wait">
      {useFade ? (
        <motion.div
          key={currentScreen}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.25 }}
        >
          {renderScreen()}
        </motion.div>
      ) : (
        <div key={currentScreen}>
          {renderScreen()}
        </div>
      )}
    </AnimatePresence>
  );
}

export default App;
