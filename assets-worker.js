export default {
  async fetch(request, env) {
    try {
      // Try to use ASSETS
      if (env.ASSETS) {
        return env.ASSETS.fetch(request);
      }
      // Fallback
      return new Response('ASSETS not available', { status: 500 });
    } catch (e) {
      return new Response('Error: ' + e.message, { status: 500 });
    }
  }
};
