// Main Menu Screen — v2 with AI-generated assets
// Layers: stage bg → sunburst → marquee frame → brain logo → title → play button → professor → speech bubble
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
import { useEffect } from 'react';

export function MainMenu() {
  const setScreen = useGameStore((state) => state.setScreen);
  const { play, stop, playClick } = useSound();

  useEffect(() => {
    play('theme');
    return () => stop('theme');
  }, [play, stop]);

  return (
    <div className="game-page">
      {/* Page header */}
      <div className="page-header">
        <h1 className="page-title-rainbow">WHO HAS THE BIGGEST BRAIN?</h1>
        <p className="page-subtitle">PRO PLAYER CLUB</p>
      </div>

      {/* Game stage — AI-generated background */}
      <div className="game-stage">
        {/* Base stage background — game show set */}
        <img
          src="/assets/generated/mainmenu-bg.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        <div className="stage-overlay">
          {/* Sunburst — centered behind the marquee screen content */}
          <motion.img
            src="/assets/generated/mainmenu-sunburst.png"
            alt=""
            className="mm-sunburst"
            draggable={false}
            animate={{ rotate: 360 }}
            transition={{ duration: 30, repeat: Infinity, ease: 'linear' }}
          />

          {/* Brain logo — top center of the marquee area */}
          <motion.img
            src="/assets/generated/brain-logo.png"
            alt=""
            className="mm-brain-logo"
            draggable={false}
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.3, type: 'spring', stiffness: 200 }}
          />

          {/* In-stage title text */}
          <motion.div
            className="mm-title-area"
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.5, duration: 0.6 }}
          >
            <div className="mm-title-line1">WHO HAS THE</div>
            <div className="mm-title-line2">BIGGEST</div>
            <div className="mm-title-line1">BRAIN?</div>
          </motion.div>

          {/* PLAY button — golden, centered */}
          <motion.div
            className="mm-play-btn"
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.7, type: 'spring', stiffness: 200 }}
            whileHover={{ scale: 1.12 }}
            whileTap={{ scale: 0.92 }}
            onClick={() => { playClick(); setScreen('gameSelect'); }}
          >
            <img
              src="/assets/generated/play-button.png"
              alt="Play"
              draggable={false}
            />
            <motion.div
              className="mm-play-glow"
              animate={{ opacity: [0.4, 0.8, 0.4] }}
              transition={{ duration: 2, repeat: Infinity, ease: 'easeInOut' }}
            />
          </motion.div>

          {/* Secondary buttons — Invite & Trophies */}
          <motion.div
            className="mm-secondary-btns"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.9, duration: 0.5 }}
          >
            <button
              className="mm-secondary-btn"
              onClick={() => playClick()}
            >
              <span className="mm-btn-icon">👥</span>
              <span>INVITE</span>
            </button>
            <button
              className="mm-secondary-btn"
              onClick={() => playClick()}
            >
              <span className="mm-btn-icon">🏆</span>
              <span>TROPHIES</span>
            </button>
          </motion.div>

          {/* Professor character — right side */}
          <motion.img
            src="/assets/generated/professor-hero.png"
            alt="Professor"
            className="mm-professor"
            draggable={false}
            initial={{ x: 100, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            transition={{ delay: 0.4, duration: 0.7, ease: 'easeOut' }}
          />

          {/* Speech bubble — above professor */}
          <motion.div
            className="mm-speech-bubble"
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 1.0, type: 'spring', stiffness: 200 }}
          >
            <p>
              <strong>Welcome!</strong> Got a Big BRAIN?
              Play now to find out!
            </p>
            <div className="speech-tail-down" />
          </motion.div>
        </div>
      </div>

      {/* Bottom nav */}
      <div className="bottom-nav">
        <button className="bottom-nav-btn" onClick={() => playClick()}>
          <span className="bottom-nav-icon">🏆</span>
          <span className="bottom-nav-label">LEADERBOARD</span>
        </button>
        <button className="bottom-nav-btn" onClick={() => playClick()}>
          <span className="bottom-nav-icon">📖</span>
          <span className="bottom-nav-label">HOW IT WORKS</span>
        </button>
        <button className="bottom-nav-btn bottom-nav-btn-disabled">
          <span className="bottom-nav-icon">🔜</span>
          <span className="bottom-nav-label">COMING SOON</span>
        </button>
      </div>
    </div>
  );
}
