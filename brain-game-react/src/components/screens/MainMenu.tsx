// Main Menu Screen - DARK TV Game Show Theme
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { GameCanvas, GameCanvasWrapper } from '../layout/GameCanvas';
import { useEffect, useState } from 'react';

export function MainMenu() {
  const setScreen = useGameStore((state) => state.setScreen);
  const { play, stop, playClick } = useSound();
  const [professorImg, setProfessorImg] = useState('/assets/sprites/professor-happy.png');

  useEffect(() => {
    play('theme');
    return () => stop('theme');
  }, [play, stop]);

  const handlePlayClick = () => {
    playClick();
    setScreen('gameSelect');
  };

  const handleTrophiesClick = () => {
    playClick();
    // TODO: trophies screen
  };

  const handleChallengeClick = () => {
    playClick();
    // TODO: challenge mode
  };

  const handleProfileClick = () => {
    playClick();
    // TODO: profile screen
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="relative w-full h-full overflow-hidden">
          {/* Title with gold glow */}
          <motion.div
            initial={{ y: -30, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ duration: 0.5 }}
            className="absolute top-4 left-0 right-0 text-center"
          >
            <h1 
              className="text-2xl gold-glow"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              WHO HAS THE
            </h1>
            <h1 
              className="text-4xl gold-glow mt-1"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              BIGGEST BRAIN?
            </h1>
          </motion.div>

          {/* 2x2 Button Grid - center-left */}
          <motion.div
            initial={{ x: -50, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            transition={{ delay: 0.3 }}
            className="absolute left-8 top-28 grid grid-cols-2 gap-3"
          >
            {/* PLAY button */}
            <motion.img
              src="/assets/sprites/button-play.png"
              alt="Play"
              className="sprite-button w-[130px] h-auto"
              whileHover={{ scale: 1.08 }}
              whileTap={{ scale: 0.95 }}
              onClick={handlePlayClick}
              draggable={false}
            />

            {/* CHALLENGE button - teal/green */}
            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={handleChallengeClick}
              className="menu-button w-[130px] h-[60px]"
              style={{ 
                background: 'linear-gradient(180deg, #20b2aa 0%, #008080 100%)',
              }}
            >
              <span>👤</span>
              <span>CHALLENGE</span>
            </motion.button>

            {/* TROPHIES button */}
            <motion.img
              src="/assets/sprites/button-trophies.png"
              alt="Trophies"
              className="sprite-button w-[130px] h-auto"
              whileHover={{ scale: 1.08 }}
              whileTap={{ scale: 0.95 }}
              onClick={handleTrophiesClick}
              draggable={false}
            />

            {/* PROFILE button - purple */}
            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={handleProfileClick}
              className="menu-button w-[130px] h-[60px]"
              style={{ 
                background: 'linear-gradient(180deg, #9370db 0%, #663399 100%)',
              }}
            >
              <span>👤</span>
              <span>PROFILE</span>
            </motion.button>
          </motion.div>

          {/* Speech bubble - right side */}
          <motion.div
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.5, type: 'spring' }}
            className="speech-bubble absolute right-6 top-32 max-w-[180px]"
          >
            <p className="text-sm text-gray-800 leading-snug">
              <strong>Welcome!</strong> Got a Big BRAIN? Play Who Has The Biggest Brain to find out!
            </p>
          </motion.div>

          {/* Professor on podium - bottom center */}
          <motion.div
            initial={{ y: 50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.6 }}
            className="absolute bottom-0 left-1/2 transform -translate-x-1/2"
          >
            {/* Podium */}
            <div 
              className="professor-podium absolute bottom-0 left-1/2 transform -translate-x-1/2"
              style={{ width: '180px', height: '40px' }}
            />
            
            {/* Professor */}
            <img
              src={professorImg}
              alt="Professor"
              className="relative z-10 h-[180px] w-auto"
              onMouseEnter={() => setProfessorImg('/assets/sprites/professor-talk.png')}
              onMouseLeave={() => setProfessorImg('/assets/sprites/professor-happy.png')}
              draggable={false}
            />
          </motion.div>

          {/* Bottom decoration bar */}
          <div className="absolute bottom-0 left-0 right-0 h-2 bg-gradient-to-r from-purple-600 via-blue-500 to-purple-600 opacity-50" />
        </div>
      </GameCanvas>

      {/* Bottom links bar */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1 }}
        className="mt-4 text-center text-xs text-gray-500"
      >
        <span className="opacity-50">© Playfish • Terms • Privacy</span>
      </motion.div>
    </GameCanvasWrapper>
  );
}
