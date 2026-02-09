// Main App - V2 PixiJS Game Engine
import { useState, useEffect } from 'react';
import { useGameState, AVAILABLE_GAMES } from './engine/GameStateManager';
import { GameCanvas } from './engine/GameCanvas';
import TemplateGame from './games/TemplateGame/TemplateGame';
import './App.css';

type Screen = 'menu' | 'game' | 'results';

function App() {
  const [error, setError] = useState<string | null>(null);
  const [currentScreen, setCurrentScreen] = useState<Screen>('menu');
  const [selectedGameId, setSelectedGameId] = useState<string>('template');

  const gameState = useGameState();

  useEffect(() => {
    const handleError = (event: ErrorEvent) => {
      setError(event.message);
      console.error('App error:', event.error);
    };
    window.addEventListener('error', handleError);
    return () => window.removeEventListener('error', handleError);
  }, []);

  const handleStartGame = (gameId: string) => {
    const game = AVAILABLE_GAMES.find(g => g.id === gameId);
    if (game) {
      setSelectedGameId(gameId);
      gameState.startGame(game);
      setCurrentScreen('game');
    }
  };

  const handleGameEnd = (result: any) => {
    gameState.endGame(result);
    setCurrentScreen('results');
  };

  const handleBackToMenu = () => {
    gameState.resetGame();
    setCurrentScreen('menu');
  };

  if (error) {
    return (
      <div className="min-h-screen bg-gray-900 text-red-400 flex items-center justify-center p-8">
        <div className="text-center bg-gray-800 p-8 rounded-lg">
          <h1 className="text-2xl mb-4">Something went wrong</h1>
          <p className="text-red-300 mb-4">{error}</p>
          <button
            onClick={() => window.location.reload()}
            className="px-6 py-3 bg-red-600 text-white rounded hover:bg-red-700"
          >
            Reload
          </button>
        </div>
      </div>
    );
  }

  const renderScreen = () => {
    switch (currentScreen) {
      case 'menu':
        return <MainMenu onStartGame={handleStartGame} gameState={gameState} />;
      
      case 'game':
        return (
          <div className="w-full h-screen bg-black">
            <GameCanvas>
              {selectedGameId === 'template' && (
                <TemplateGame onGameEnd={handleGameEnd} />
              )}
              {/* Other games will be added here by Phase 2 agents */}
            </GameCanvas>
          </div>
        );
      
      case 'results':
        return <ResultsScreen onBackToMenu={handleBackToMenu} gameState={gameState} />;
      
      default:
        return <MainMenu onStartGame={handleStartGame} gameState={gameState} />;
    }
  };

  return (
    <div className="app">
      {renderScreen()}
    </div>
  );
}

// Main Menu Component
function MainMenu({ onStartGame, gameState }: { 
  onStartGame: (gameId: string) => void;
  gameState: ReturnType<typeof useGameState>;
}) {
  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-900 to-purple-900 flex flex-col items-center justify-center p-8">
      <div className="text-center mb-12">
        <h1 className="text-6xl font-bold text-white mb-4 font-mono">
          WHO HAS THE BIGGEST BRAIN?
        </h1>
        <p className="text-xl text-blue-200 mb-2">
          V2 - PixiJS + GSAP Engine
        </p>
        
        {/* Brain Tier Display */}
        <div className="bg-black bg-opacity-30 rounded-lg p-4 mt-6">
          <p className="text-lg text-white mb-2">Current Brain Tier:</p>
          <div className="text-2xl font-bold text-yellow-400">
            Tier {gameState.brainTier.tier}: {gameState.brainTier.name}
          </div>
          <p className="text-sm text-blue-200 mt-2">
            Total Score: {gameState.totalScore} | Games Played: {gameState.gamesPlayed}
          </p>
        </div>
      </div>

      <div className="space-y-4 w-full max-w-md">
        <h2 className="text-2xl font-bold text-white text-center mb-6">Select a Game:</h2>
        
        {AVAILABLE_GAMES.map((game) => (
          <button
            key={game.id}
            onClick={() => onStartGame(game.id)}
            className="w-full bg-white bg-opacity-20 hover:bg-opacity-30 text-white p-4 rounded-lg transition-all duration-200 hover:scale-105"
          >
            <div className="text-left">
              <div className="font-bold text-lg">{game.name}</div>
              <div className="text-sm text-blue-200">{game.category}</div>
              <div className="text-sm text-gray-300 mt-2">{game.instructions}</div>
              <div className="text-xs text-blue-300 mt-1">
                {game.maxRounds} rounds • {game.timePerRound}s per round
              </div>
            </div>
          </button>
        ))}
      </div>

      <div className="mt-12 text-center">
        <p className="text-blue-200 text-sm">
          Built with PixiJS + GSAP for amazing Flash-like visuals
        </p>
      </div>
    </div>
  );
}

// Results Screen Component
function ResultsScreen({ onBackToMenu, gameState }: {
  onBackToMenu: () => void;
  gameState: ReturnType<typeof useGameState>;
}) {
  const lastResult = gameState.gameResults[gameState.gameResults.length - 1];
  
  if (!lastResult) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-purple-900 to-blue-900 flex items-center justify-center">
        <button
          onClick={onBackToMenu}
          className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
        >
          Back to Menu
        </button>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-900 to-blue-900 flex flex-col items-center justify-center p-8">
      <div className="bg-black bg-opacity-40 rounded-lg p-8 max-w-md w-full text-center">
        <h1 className="text-3xl font-bold text-white mb-6">Game Complete!</h1>
        
        <div className="space-y-4 mb-8">
          <div className="bg-white bg-opacity-20 rounded p-4">
            <p className="text-lg font-bold text-yellow-400">Final Score</p>
            <p className="text-3xl font-bold text-white">{lastResult.score}</p>
            <p className="text-sm text-gray-300">out of {lastResult.maxScore}</p>
          </div>
          
          <div className="bg-white bg-opacity-20 rounded p-4">
            <p className="text-lg font-bold text-green-400">Accuracy</p>
            <p className="text-2xl font-bold text-white">{lastResult.accuracy.toFixed(1)}%</p>
          </div>
          
          <div className="bg-white bg-opacity-20 rounded p-4">
            <p className="text-lg font-bold text-blue-400">Time Played</p>
            <p className="text-xl font-bold text-white">{lastResult.timePlayed.toFixed(1)}s</p>
          </div>
        </div>

        {/* Brain Tier */}
        <div className="bg-yellow-600 bg-opacity-30 rounded-lg p-4 mb-6">
          <p className="text-sm text-yellow-200 mb-2">Current Brain Tier:</p>
          <div className="text-xl font-bold text-yellow-100">
            Tier {gameState.brainTier.tier}: {gameState.brainTier.name}
          </div>
          <p className="text-sm text-yellow-200 mt-2">
            Total Score: {gameState.totalScore}
          </p>
        </div>

        <button
          onClick={onBackToMenu}
          className="w-full px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-bold"
        >
          Play Again
        </button>
      </div>
    </div>
  );
}

export default App;