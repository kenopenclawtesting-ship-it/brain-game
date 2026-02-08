// Cloudflare Pages Worker with KV Storage
export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // API: Get leaderboard
    if (url.pathname === '/api/leaderboard' && request.method === 'GET') {
      try {
        const data = await env.LEADERBOARD.get('leaderboard_v1', { type: 'json' });
        return Response.json({ success: true, leaderboard: data || [] });
      } catch (e) {
        return Response.json({ success: true, leaderboard: [] });
      }
    }
    
    // API: Submit score  
    if (url.pathname === '/api/score' && request.method === 'POST') {
      try {
        const { name, score, brainSize, brainLabel } = await request.json();
        
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
        
        let leaderboard = [];
        try {
          const data = await env.LEADERBOARD.get('leaderboard_v1', { type: 'json' });
          leaderboard = data || [];
        } catch (e) {}
        
        leaderboard.push(entry);
        leaderboard.sort((a, b) => b.score - a.score);
        leaderboard = leaderboard.slice(0, 500);
        
        await env.LEADERBOARD.put('leaderboard_v1', JSON.stringify(leaderboard));
        
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
    
    // Pass through to static assets
    return env.ASSETS.fetch(request);
  }
};
