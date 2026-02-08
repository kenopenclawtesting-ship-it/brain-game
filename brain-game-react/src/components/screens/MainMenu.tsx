// Main Menu Screen - Sprite-based composition matching original Flash game
// Uses extracted FrameGameShow sprite as background, positions interactive elements on top
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { useEffect, useState } from 'react';

export function MainMenu() {
  const setScreen = useGameStore((state) => state.setScreen);
  const { play, stop, playClick } = useSound();
  const [profSrc, setProfSrc] = useState('/assets/sprites/professor-happy.png');

  useEffect(() => {
    play('theme');
    return () => stop('theme');
  }, [play, stop]);

  return (
    <div className="game-page">
      {/* Page header - above the game frame */}
      <div className="page-header">
        <h1 className="page-title">WHO HAS THE BIGGEST BRAIN?</h1>
        <p className="page-subtitle">Pro Player Club</p>
      </div>

      {/* Game stage - the sprite IS the visual */}
      <div className="game-stage">
        {/* Background sprite from extracted FrameGameShow frame 30 */}
        <img
          src="/assets/sprites/stage-bg.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        {/* Interactive overlay layer */}
        <div className="stage-overlay">
          {/* English title (positioned over Chinese title in sprite) */}
          <div className="title-overlay">
            <span className="title-line1">WHO HAS THE BIGGEST</span>
            <span className="title-brain">BRAIN</span>
            <span className="title-q">?</span>
          </div>

          {/* Subtitle banner (positioned over Chinese subtitle) */}
          <div className="subtitle-banner">
            ★ PRO PLAYER CLUB ★
          </div>

          {/* PLAY button sprite */}
          <motion.img
            src="/assets/sprites/button-play.png"
            alt="Play"
            className="btn-play"
            draggable={false}
            whileHover={{ scale: 1.1, filter: 'brightness(1.15)' }}
            whileTap={{ scale: 0.95 }}
            onClick={() => { playClick(); setScreen('gameSelect'); }}
          />

          {/* CHALLENGE button sprite */}
          <motion.img
            src="/assets/sprites/button-invite.png"
            alt="Challenge"
            className="btn-challenge"
            draggable={false}
            whileHover={{ scale: 1.1, filter: 'brightness(1.15)' }}
            whileTap={{ scale: 0.95 }}
            onClick={() => playClick()}
          />

          {/* TROPHIES button sprite */}
          <motion.img
            src="/assets/sprites/button-trophies.png"
            alt="Trophies"
            className="btn-trophies"
            draggable={false}
            whileHover={{ scale: 1.1, filter: 'brightness(1.15)' }}
            whileTap={{ scale: 0.95 }}
            onClick={() => playClick()}
          />

          {/* Speech bubble */}
          <motion.div
            className="speech-bubble"
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.6, type: 'spring', stiffness: 200 }}
          >
            <p>
              <strong>Welcome!</strong> Got a Big BRAIN? Play Who Has The Biggest Brain? to find out!
            </p>
            <div className="speech-tail-left" />
          </motion.div>

          {/* Interactive professor - covers baked-in professor, adds hover effect */}
          <motion.img
            src={profSrc}
            alt="Professor"
            className="prof-interactive"
            draggable={false}
            onMouseEnter={() => setProfSrc('/assets/sprites/professor-talk.png')}
            onMouseLeave={() => setProfSrc('/assets/sprites/professor-happy.png')}
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.4 }}
          />
        </div>
      </div>

      {/* Footer */}
      <div className="page-footer">
        © 2007-2009 Playfish Ltd. All Rights Reserved.
      </div>
    </div>
  );
}
