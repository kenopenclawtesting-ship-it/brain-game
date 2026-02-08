export default {
  fetch(request, env) {
    return new Response(JSON.stringify({
      envType: typeof env,
      envKeys: env ? Object.keys(env) : [],
      hasAssets: env && 'ASSETS' in env,
      assetsType: env && env.ASSETS ? typeof env.ASSETS : 'none'
    }), {headers: {'Content-Type': 'application/json'}});
  }
};