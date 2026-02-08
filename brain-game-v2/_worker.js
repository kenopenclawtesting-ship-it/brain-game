// Cloudflare Pages Worker with KV Storage
// Persistent leaderboard data

const KV_KEY = 'leaderboard_v1';

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // API: Get leaderboard
    if (url.pathname === '/api/leaderboard' && request.method === 'GET') {
      try {
        const data = await env.LEADERBOARD.get(KV_KEY, { type: 'json' });
        const leaderboard = data || [];
        return Response.json({ success: true, leaderboard });
      } catch (e) {
        return Response.json({ success: true, leaderboard: [] });
      }
    }
    
    // API: Submit score  
    if (url.pathname === '/api/score' && request.method === 'POST') {
      try {
        const { name, score, brainSize, brainLabel, breakdown } = await request.json();
        
        if (!name || typeof score !== 'number') {
          return Response.json({ success: false, error: 'Invalid data' }, { status: 400 });
        }
        
        const entry = {
          id: crypto.randomUUID(),
          name: String(name).slice(0, 20).replace(/[<>]/g, ''),
          score: Math.floor(score),
          brainSize,
          brainLabel,
          timestamp: Date.now()
        };
        
        // Get existing leaderboard
        let leaderboard = [];
        try {
          const data = await env.LEADERBOARD.get(KV_KEY, { type: 'json' });
          leaderboard = data || [];
        } catch (e) {}
        
        // Add new entry, sort, and limit
        leaderboard.push(entry);
        leaderboard.sort((a, b) => b.score - a.score);
        leaderboard = leaderboard.slice(0, 500);
        
        // Save to KV
        await env.LEADERBOARD.put(KV_KEY, JSON.stringify(leaderboard));
        
        // Find rank
        const rank = leaderboard.findIndex(e => e.id === entry.id) + 1;
        
        return Response.json({ success: true, entry, rank });
      } catch (e) {
        return Response.json({ success: false, error: e.message }, { status: 500 });
      }
    }
    
    // CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, {
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type',
        }
      });
    }
    
    // Serve static assets for all other routes
    return env.ASSETS.fetch(request);
  }
};
