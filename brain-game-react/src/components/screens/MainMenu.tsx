// Main Menu Screen - Matching original Flash game
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

  const handleInviteClick = () => {
    playClick();
    // TODO: invite functionality
  };

  // Professor talks on hover
  const handleProfessorHover = (talking: boolean) => {
    setProfessorImg(talking ? '/assets/sprites/professor-talk.png' : '/assets/sprites/professor-happy.png');
  };

  return (
    <GameCanvasWrapper>
      <GameCanvas>
        <div className="relative w-full h-full bg-gradient-to-b from-sky-100 to-white overflow-hidden">
          {/* Title */}
          <motion.div
            initial={{ y: -30, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ duration: 0.5 }}
            className="absolute top-6 left-0 right-0 text-center"
          >
            <h1 
              className="text-3xl text-amber-600 drop-shadow-md"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              Who Has The
            </h1>
            <h1 
              className="text-4xl text-amber-500 drop-shadow-lg"
              style={{ fontFamily: 'Baveuse, cursive' }}
            >
              BIGGEST BRAIN?
            </h1>
          </motion.div>

          {/* Speech bubble */}
          <motion.div
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.3, type: 'spring' }}
            className="absolute top-28 left-8 bg-white rounded-2xl p-4 shadow-lg border-2 border-gray-200 max-w-[200px]"
          >
            <p className="text-sm text-gray-700">
              Welcome! Click <strong>PLAY</strong> to test your brain across 4 categories!
            </p>
            {/* Speech bubble tail */}
            <div className="absolute -bottom-3 left-12 w-6 h-6 bg-white border-b-2 border-r-2 border-gray-200 transform rotate-45" />
          </motion.div>

          {/* Menu buttons - right side */}
          <motion.div
            initial={{ x: 50, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="absolute right-8 top-28 flex flex-col gap-4"
          >
            {/* PLAY button */}
            <motion.img
              src="/assets/sprites/button-play.png"
              alt="Play"
              className="sprite-button w-48 h-auto"
              whileHover={{ scale: 1.08 }}
              whileTap={{ scale: 0.95 }}
              onClick={handlePlayClick}
              draggable={false}
            />

            {/* TROPHIES button */}
            <motion.img
              src="/assets/sprites/button-trophies.png"
              alt="Trophies"
              className="sprite-button w-48 h-auto"
              whileHover={{ scale: 1.08 }}
              whileTap={{ scale: 0.95 }}
              onClick={handleTrophiesClick}
              draggable={false}
            />

            {/* INVITE button */}
            <motion.img
              src="/assets/sprites/button-invite.png"
              alt="Invite"
              className="sprite-button w-48 h-auto"
              whileHover={{ scale: 1.08 }}
              whileTap={{ scale: 0.95 }}
              onClick={handleInviteClick}
              draggable={false}
            />
          </motion.div>

          {/* Professor character - bottom center */}
          <motion.img
            src={professorImg}
            alt="Professor"
            initial={{ y: 50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.6 }}
            className="absolute bottom-0 left-1/2 transform -translate-x-1/2 h-[200px] w-auto"
            onMouseEnter={() => handleProfessorHover(true)}
            onMouseLeave={() => handleProfessorHover(false)}
            draggable={false}
          />
        </div>
      </GameCanvas>
    </GameCanvasWrapper>
  );
}
