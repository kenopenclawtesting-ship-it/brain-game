// Main Menu Screen - 1:1 Flash Game Show Theme
// Written by CTO - pixel-matched to original Flash game screenshot
import { motion } from 'framer-motion';
import { useGameStore } from '../../store/gameStore';
import { useSound } from '../../hooks/useSound';
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

  const handleChallengeClick = () => {
    playClick();
  };

  const handleTrophiesClick = () => {
    playClick();
  };

  const handleProfileClick = () => {
    playClick();
  };

  return (
    <div className="game-page">
      {/* Spotlight beams */}
      <div className="spotlight spotlight-left" />
      <div className="spotlight spotlight-right" />
      <div className="spotlight spotlight-center" />

      {/* Page title - ABOVE the game frame */}
      <div className="page-header">
        <h1 className="page-title">WHO HAS THE BIGGEST BRAIN?</h1>
        <p className="page-subtitle">Pro Player Club</p>
      </div>

      {/* Game frame with glow */}
      <div className="game-frame">
        <div className="game-frame-inner">

          {/* Brain Logo / Title Area */}
          <motion.div
            className="logo-area"
            initial={{ y: -20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ duration: 0.4 }}
          >
            <div className="brain-logo-container">
              <div className="brain-logo-text">
                <span className="logo-who">WHO HAS THE BIGGEST</span>
                <span className="logo-brain">BRAIN</span>
                <span className="logo-question">?</span>
              </div>
            </div>
          </motion.div>

          {/* Main content area */}
          <div className="menu-content">
            {/* 2x2 Button Grid */}
            <motion.div
              className="button-grid"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.3 }}
            >
              {/* PLAY button - top left */}
              <div className="menu-btn-wrapper" onClick={handlePlayClick}>
                <img
                  src="/assets/sprites/button-play.png"
                  alt="Play"
                  className="menu-btn-img"
                  draggable={false}
                />
              </div>

              {/* CHALLENGE button - top right */}
              <div className="menu-btn-wrapper" onClick={handleChallengeClick}>
                <div className="menu-btn-custom challenge-btn">
                  <img src="/assets/sprites/button-invite.png" alt="Challenge" className="menu-btn-icon" draggable={false} />
                  <span className="menu-btn-label">CHALLENGE</span>
                </div>
              </div>

              {/* TROPHIES button - bottom left */}
              <div className="menu-btn-wrapper" onClick={handleTrophiesClick}>
                <img
                  src="/assets/sprites/button-trophies.png"
                  alt="Trophies"
                  className="menu-btn-img"
                  draggable={false}
                />
              </div>

              {/* PROFILE button - bottom right */}
              <div className="menu-btn-wrapper" onClick={handleProfileClick}>
                <div className="menu-btn-custom profile-btn">
                  <div className="profile-icon">
                    <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
                      <circle cx="20" cy="14" r="8" fill="#fff" opacity="0.9"/>
                      <ellipse cx="20" cy="36" rx="14" ry="10" fill="#fff" opacity="0.9"/>
                    </svg>
                  </div>
                  <span className="menu-btn-label">PROFILE</span>
                </div>
              </div>
            </motion.div>

            {/* Speech bubble */}
            <motion.div
              className="speech-bubble"
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 0.5, type: 'spring', stiffness: 200 }}
            >
              <p>
                <strong>Welcome!</strong> Got a Big BRAIN? Play Who Has The Biggest Brain? to find out!
              </p>
              <div className="speech-tail" />
            </motion.div>
          </div>

          {/* Professor on podium */}
          <motion.div
            className="professor-area"
            initial={{ y: 40, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.6 }}
          >
            <img
              src={professorImg}
              alt="Professor"
              className="professor-img"
              onMouseEnter={() => setProfessorImg('/assets/sprites/professor-talk.png')}
              onMouseLeave={() => setProfessorImg('/assets/sprites/professor-happy.png')}
              draggable={false}
            />
            <div className="podium">
              <div className="podium-light podium-light-1" />
              <div className="podium-light podium-light-2" />
              <div className="podium-light podium-light-3" />
            </div>
          </motion.div>
        </div>
      </div>

      {/* Footer bar */}
      <div className="page-footer">
        <span>&copy; 2007-2009 Playfish Ltd. All Rights Reserved.</span>
      </div>
    </div>
  );
}
