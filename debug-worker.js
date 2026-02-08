export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    
    // Debug: show what we have
    const debug = {
      path: url.pathname,
      hasAssets: !!env.ASSETS,
      envKeys: Object.keys(env || {}),
    };
    
    if (!env.ASSETS) {
      return new Response(JSON.stringify({error: 'No ASSETS binding', debug}), {
        status: 500,
        headers: {'Content-Type': 'application/json'}
      });
    }
    
    try {
      return await env.ASSETS.fetch(request);
    } catch (e) {
      return new Response(JSON.stringify({error: e.message, stack: e.stack, debug}), {
        status: 500,
        headers: {'Content-Type': 'application/json'}
      });
    }
  }
};
