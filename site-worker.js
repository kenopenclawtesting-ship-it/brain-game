const HTML = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Who Has The Biggest Brain? | Play Now</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Bangers&family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root{--neon-cyan:#00e5ff;--neon-pink:#ff2d87;--neon-yellow:#ffe135;--deep-navy:#0a0e27;--card-bg:rgba(15,20,50,0.85);--glow-cyan:0 0 20px rgba(0,229,255,0.4);--glow-pink:0 0 20px rgba(255,45,135,0.4)}*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Quicksand',sans-serif;background:var(--deep-navy);color:#e0e6f0;min-height:100vh;overflow-x:hidden}body::before{content:'';position:fixed;top:0;left:0;right:0;bottom:0;background:radial-gradient(ellipse at 20% 50%,rgba(0,229,255,0.08) 0%,transparent 50%),radial-gradient(ellipse at 80% 20%,rgba(255,45,135,0.06) 0%,transparent 50%),radial-gradient(ellipse at 50% 80%,rgba(255,225,53,0.04) 0%,transparent 50%);z-index:0;animation:bgPulse 8s ease-in-out infinite alternate}@keyframes bgPulse{0%{opacity:0.7}100%{opacity:1}}body::after{content:'';position:fixed;top:0;left:0;right:0;bottom:0;background-image:linear-gradient(rgba(0,229,255,0.03) 1px,transparent 1px),linear-gradient(90deg,rgba(0,229,255,0.03) 1px,transparent 1px);background-size:60px 60px;z-index:0;pointer-events:none}.page-wrapper{position:relative;z-index:1;display:flex;flex-direction:column;align-items:center;min-height:100vh;padding:20px}header{text-align:center;margin-bottom:24px;animation:slideDown 0.6s ease-out}@keyframes slideDown{from{opacity:0;transform:translateY(-30px)}to{opacity:1;transform:translateY(0)}}.logo-title{font-family:'Bangers',cursive;font-size:clamp(2rem,5vw,3.2rem);letter-spacing:3px;background:linear-gradient(135deg,var(--neon-cyan),var(--neon-pink),var(--neon-yellow));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;filter:drop-shadow(0 0 12px rgba(0,229,255,0.3));line-height:1.1}.subtitle{font-size:0.9rem;color:rgba(224,230,240,0.5);margin-top:4px;letter-spacing:4px;text-transform:uppercase;font-weight:600}.game-stage{position:relative;width:100%;max-width:820px;animation:fadeScale 0.8s ease-out 0.2s both}@keyframes fadeScale{from{opacity:0;transform:scale(0.95)}to{opacity:1;transform:scale(1)}}.game-frame{position:relative;background:var(--card-bg);border:1px solid rgba(0,229,255,0.2);border-radius:16px;padding:8px;box-shadow:var(--glow-cyan),inset 0 1px 0 rgba(255,255,255,0.05);overflow:hidden}.game-frame::before{content:'';position:absolute;top:-1px;left:-1px;right:-1px;bottom:-1px;border-radius:17px;background:linear-gradient(135deg,var(--neon-cyan),transparent 40%,transparent 60%,var(--neon-pink));z-index:-1;opacity:0.4}#game-container{width:100%;aspect-ratio:4/3;background:#000;border-radius:10px;display:flex;align-items:center;justify-content:center;position:relative;overflow:hidden}#game-container ruffle-player,#game-container ruffle-embed{width:100%!important;height:100%!important}.loading-overlay{position:absolute;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center;background:rgba(10,14,39,0.95);border-radius:10px;z-index:10;transition:opacity 0.5s ease}.loading-overlay.hidden{opacity:0;pointer-events:none}.brain-icon{font-size:3rem;animation:bounce 1.2s ease-in-out infinite;margin-bottom:16px}@keyframes bounce{0%,100%{transform:translateY(0) scale(1)}50%{transform:translateY(-10px) scale(1.1)}}.loading-text{font-family:'Bangers',cursive;font-size:1.3rem;letter-spacing:2px;color:var(--neon-cyan)}.loading-bar{width:200px;height:4px;background:rgba(255,255,255,0.1);border-radius:2px;margin-top:12px;overflow:hidden}.loading-bar-fill{height:100%;width:40%;background:linear-gradient(90deg,var(--neon-cyan),var(--neon-pink));border-radius:2px;animation:loadSlide 1.5s ease-in-out infinite}@keyframes loadSlide{0%{transform:translateX(-100%)}100%{transform:translateX(350%)}}.controls-bar{display:flex;align-items:center;justify-content:space-between;margin-top:8px;padding:0 4px}.control-btn{background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);color:rgba(224,230,240,0.7);padding:8px 16px;border-radius:8px;font-family:'Quicksand',sans-serif;font-weight:600;font-size:0.8rem;cursor:pointer;transition:all 0.2s ease;letter-spacing:1px;text-transform:uppercase}.control-btn:hover{background:rgba(0,229,255,0.1);border-color:rgba(0,229,255,0.3);color:var(--neon-cyan);box-shadow:var(--glow-cyan)}.control-btn.primary{background:linear-gradient(135deg,rgba(0,229,255,0.15),rgba(255,45,135,0.15));border-color:rgba(0,229,255,0.3);color:var(--neon-cyan)}.badge{display:inline-block;background:rgba(255,225,53,0.15);border:1px solid rgba(255,225,53,0.3);color:var(--neon-yellow);padding:4px 10px;border-radius:20px;font-size:0.7rem;font-weight:700;letter-spacing:1px}.info-section{max-width:820px;width:100%;margin-top:32px;display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:16px;animation:fadeScale 0.8s ease-out 0.4s both}.info-card{background:var(--card-bg);border:1px solid rgba(255,255,255,0.06);border-radius:12px;padding:20px;transition:border-color 0.3s ease}.info-card:hover{border-color:rgba(0,229,255,0.2)}.info-card h3{font-family:'Bangers',cursive;font-size:1.1rem;letter-spacing:2px;color:var(--neon-cyan);margin-bottom:8px}.info-card p{font-size:0.85rem;line-height:1.6;color:rgba(224,230,240,0.6)}footer{margin-top:40px;padding:20px;text-align:center;font-size:0.75rem;color:rgba(224,230,240,0.25);letter-spacing:1px}@media(max-width:600px){.controls-bar{flex-wrap:wrap;gap:8px;justify-content:center}.info-section{grid-template-columns:1fr}}
    </style>
</head>
<body>
    <div class="page-wrapper">
        <header>
            <h1 class="logo-title">Who Has The Biggest Brain?</h1>
            <p class="subtitle">Pro Player Club</p>
        </header>
        <main class="game-stage">
            <div class="game-frame">
                <div id="game-container">
                    <div class="loading-overlay" id="loading">
                        <div class="brain-icon">🧠</div>
                        <div class="loading-text">Loading Brain Power...</div>
                        <div class="loading-bar"><div class="loading-bar-fill"></div></div>
                    </div>
                </div>
            </div>
            <div class="controls-bar">
                <span class="badge">Flash → Ruffle</span>
                <div style="display:flex;gap:8px;">
                    <button class="control-btn" onclick="toggleFullscreen()">⛶ Fullscreen</button>
                    <button class="control-btn primary" onclick="restartGame()">↻ Restart</button>
                </div>
            </div>
        </main>
        <section class="info-section">
            <div class="info-card"><h3>🧩 How It Works</h3><p>This classic brain training game runs through Ruffle, an open-source Flash emulator. No plugins needed.</p></div>
            <div class="info-card"><h3>🏆 Game Modes</h3><p>Test your skills across calculation, memory, logic, and visual puzzles. Compete for the highest brain score!</p></div>
            <div class="info-card"><h3>🚀 Coming Soon</h3><p>New animations, updated visuals, and expanded game modes are in development. Stay tuned!</p></div>
        </section>
        <footer>Original game © 2007-2008 Playfish Ltd. Preservation project powered by Ruffle.</footer>
    </div>
    <script src="https://unpkg.com/@ruffle-rs/ruffle"><\/script>
    <script>
        document.addEventListener("DOMContentLoaded",()=>{const container=document.getElementById("game-container");const loading=document.getElementById("loading");const ruffle=window.RufflePlayer.newest();const player=ruffle.createPlayer();player.style.width="100%";player.style.height="100%";container.appendChild(player);player.ruffle().load({url:"/assets/brain_game_2_6_7_translated_v1.swf",autoplay:"on",unmuteOverlay:"visible",backgroundColor:"#000000",letterbox:"on",warnOnUnsupportedContent:false,contextMenu:"rightClickOnly"}).then(()=>{loading.classList.add("hidden");}).catch(err=>{loading.innerHTML='<div class="brain-icon">⚠️</div><div class="loading-text" style="color:var(--neon-pink);">Failed to load</div><p style="color:rgba(224,230,240,0.5);margin-top:8px;font-size:0.85rem;">'+err.message+'</p>';});});
        function toggleFullscreen(){const c=document.getElementById("game-container");if(!document.fullscreenElement)c.requestFullscreen().catch(()=>{});else document.exitFullscreen();}
        function restartGame(){location.reload();}
    <\/script>
</body>
</html>`;

const SWF_URL = "https://raw.githubusercontent.com/kenopenclawtesting-ship-it/brain-game/main/assets/brain_game_2_6_7_translated_v1.swf";
const PNG_URL = "https://raw.githubusercontent.com/kenopenclawtesting-ship-it/brain-game/main/assets/WHTBBSS.png";

export default {
  async fetch(request) {
    const url = new URL(request.url);
    
    if (url.pathname === "/assets/brain_game_2_6_7_translated_v1.swf") {
      const res = await fetch(SWF_URL);
      return new Response(res.body, {
        headers: { "Content-Type": "application/x-shockwave-flash", "Access-Control-Allow-Origin": "*", "Cache-Control": "public, max-age=86400" }
      });
    }
    
    if (url.pathname === "/assets/WHTBBSS.png") {
      const res = await fetch(PNG_URL);
      return new Response(res.body, { headers: { "Content-Type": "image/png", "Cache-Control": "public, max-age=86400" } });
    }
    
    return new Response(HTML, { headers: { "Content-Type": "text/html; charset=utf-8" } });
  }
};
