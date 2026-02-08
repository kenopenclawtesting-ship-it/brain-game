export default {
  async fetch(request, env) {
    return new Response('<!DOCTYPE html><html><body><h1>Test works!</h1></body></html>', {
      headers: { 'Content-Type': 'text/html' }
    });
  }
};
