// Main Menu Screen — v2 redesign: clean, full-stage, one primary action
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
      <div className="game-stage">
        {/* AI background */}
        <img
          src="/assets/generated/mainmenu-bg.png"
          alt=""
          className="stage-bg"
          draggable={false}
        />

        {/* Dark vignette so UI pops against busy bg */}
        <div className="mm-vignette" />

        <div className="stage-overlay">
          {/* Sunburst — slow spin behind content */}
          <motion.img
            src="/assets/generated/mainmenu-sunburst.png"
            alt=""
            className="mm-sunburst"
            draggable={false}
            animate={{ rotate: 360 }}
            transition={{ duration: 30, repeat: Infinity, ease: 'linear' }}
          />

          {/* Centered vertical content block */}
          <div className="mm-content">
            {/* Brain logo */}
            <motion.img
              src="/assets/generated/brain-logo.png"
              alt=""
              className="mm-brain-logo"
              draggable={false}
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 0.3, type: 'spring', stiffness: 200 }}
            />

            {/* Title */}
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

            {/* PLAY button — large, glowing */}
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
                animate={{ opacity: [0.4, 0.9, 0.4] }}
                transition={{ duration: 2, repeat: Infinity, ease: 'easeInOut' }}
              />
            </motion.div>
          </div>

          {/* Professor — right side, properly contained */}
          <motion.img
            src="/assets/generated/professor-hero.png"
            alt="Professor"
            className="mm-professor"
            draggable={false}
            initial={{ x: 100, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            transition={{ delay: 0.4, duration: 0.7, ease: 'easeOut' }}
          />

          {/* Copyright */}
          <div className="mm-copyright">
            &copy; 2026 Who Has The Biggest Brain?
          </div>
        </div>
      </div>
    </div>
  );
}
