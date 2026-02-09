// Phase 2: Generate all mini-game assets via FLUX Pro + BiRefNet
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { createFalClient } from '@fal-ai/client';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const fal = createFalClient({
  credentials: 'c7e538a9-3ca4-4b8f-a288-62660428defd:c2b20e0ab503ca6d58aff89616a5ddd7'
});

const ASSETS_DIR = path.join(__dirname, '..', 'public', 'assets', 'generated');
const MANIFEST_PATH = path.join(ASSETS_DIR, 'manifest-v2.json');

const ART_SUFFIX = ', premium mobile game art style, glossy 3D render, rich gradients, deep purple and gold color palette with neon accents, high detail, 4K quality';

// Load or init manifest
let manifest = {};
if (fs.existsSync(MANIFEST_PATH)) {
  manifest = JSON.parse(fs.readFileSync(MANIFEST_PATH, 'utf-8'));
}

function saveManifest() {
  fs.writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2));
}

// All assets to generate, grouped by game
const ASSETS = [
  // === CARD PAIRS (MatchCard) ===
  { file: 'card-back.png', prompt: 'Playing card back design, ornate purple and gold pattern, swirling motifs, premium game card, square format, centered on solid black background', size: 'square', removeBg: true },
  { file: 'card-front-star.png', prompt: 'Glowing golden star symbol on dark purple card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-front-moon.png', prompt: 'Glowing silver crescent moon symbol on dark blue card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-front-sun.png', prompt: 'Glowing orange sun symbol on dark red card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-front-lightning.png', prompt: 'Glowing yellow lightning bolt symbol on dark teal card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-front-diamond.png', prompt: 'Glowing cyan diamond gem symbol on dark purple card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-front-heart.png', prompt: 'Glowing pink heart symbol on dark magenta card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-front-crown.png', prompt: 'Glowing gold crown symbol on dark navy card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-front-flame.png', prompt: 'Glowing orange flame symbol on dark crimson card face, game card illustration, centered design, ornate border', size: 'square', removeBg: true },
  { file: 'card-match-effect.png', prompt: 'Sparkle burst effect, golden particles radiating outward, celebration sparkles, transparent background', size: 'square', removeBg: true },

  // === SHAPE SEQUENCE (ShapeOrder) ===
  { file: 'shape-circle.png', prompt: 'Glossy 3D sphere, vibrant red gradient, glass reflection highlight, floating game piece, single object centered', size: 'square', removeBg: true },
  { file: 'shape-square.png', prompt: 'Glossy 3D cube, vibrant blue gradient, glass reflection highlight, floating game piece, single object centered', size: 'square', removeBg: true },
  { file: 'shape-triangle.png', prompt: 'Glossy 3D pyramid, vibrant green gradient, glass reflection highlight, floating game piece, single object centered', size: 'square', removeBg: true },
  { file: 'shape-star.png', prompt: 'Glossy 3D star shape, vibrant yellow gradient, metallic sheen, floating game piece, single object centered', size: 'square', removeBg: true },
  { file: 'shape-diamond.png', prompt: 'Glossy 3D diamond shape, vibrant purple gradient, crystalline reflections, floating game piece, single object centered', size: 'square', removeBg: true },
  { file: 'shape-hexagon.png', prompt: 'Glossy 3D hexagon, vibrant orange gradient, glass reflection highlight, floating game piece, single object centered', size: 'square', removeBg: true },
  { file: 'shape-slot-empty.png', prompt: 'Empty rounded square slot, dark glass panel with subtle dashed glow border, placeholder indicator, game UI element', size: 'square', removeBg: true },
  { file: 'shape-slot-correct.png', prompt: 'Rounded square slot with bright green glow border, correct answer indicator, glass panel, game UI element', size: 'square', removeBg: true },

  // === CALCULATE / MISSING NUMBER ===
  { file: 'calc-display-panel.png', prompt: 'Futuristic holographic display panel, dark glass with electric blue glow edges, math equation display screen, wide format, sci-fi game UI', size: 'landscape_16_9', removeBg: false },
  { file: 'calc-number-tile.png', prompt: 'Number tile button, dark glass with blue neon glow edge, rounded square, game UI button element, centered', size: 'square', removeBg: true },
  { file: 'calc-operator-plus.png', prompt: 'Plus sign mathematical operator, green neon glow, glossy 3D button, math game UI element', size: 'square', removeBg: true },
  { file: 'calc-operator-minus.png', prompt: 'Minus sign mathematical operator, red neon glow, glossy 3D button, math game UI element', size: 'square', removeBg: true },
  { file: 'calc-operator-multiply.png', prompt: 'Multiply sign X mathematical operator, orange neon glow, glossy 3D button, math game UI element', size: 'square', removeBg: true },
  { file: 'calc-operator-divide.png', prompt: 'Division sign mathematical operator, purple neon glow, glossy 3D button, math game UI element', size: 'square', removeBg: true },
  { file: 'calc-equals.png', prompt: 'Equals sign, golden neon glow, glossy 3D button, math game UI element', size: 'square', removeBg: true },
  { file: 'missing-sign-question.png', prompt: 'Glowing question mark inside neon circle, mystery symbol, blue and purple neon glow, game UI element', size: 'square', removeBg: true },

  // === CUBE COUNTER ===
  { file: 'cube-blue.png', prompt: 'Single isometric cube, blue gradient with subtle shadow, clean geometric edges, game piece, 3D render', size: 'square', removeBg: true },
  { file: 'cube-red.png', prompt: 'Single isometric cube, red gradient with subtle shadow, clean geometric edges, game piece, 3D render', size: 'square', removeBg: true },
  { file: 'cube-green.png', prompt: 'Single isometric cube, green gradient with subtle shadow, clean geometric edges, game piece, 3D render', size: 'square', removeBg: true },
  { file: 'cube-yellow.png', prompt: 'Single isometric cube, yellow gradient with subtle shadow, clean geometric edges, game piece, 3D render', size: 'square', removeBg: true },
  { file: 'cube-grid-base.png', prompt: 'Isometric grid floor platform, subtle grid lines, dark glass surface with faint blue glow, perspective view, game board base', size: 'landscape_16_9', removeBg: false },

  // === WEIGHT BALANCE ===
  { file: 'scale-balance.png', prompt: 'Golden ornate balance scale, two hanging platforms, scientific weighing instrument, centered composition, game prop illustration', size: 'landscape_16_9', removeBg: true },
  { file: 'weight-anvil.png', prompt: 'Cartoon anvil, heavy dark metallic, stylized game object, single item centered', size: 'square', removeBg: true },
  { file: 'weight-feather.png', prompt: 'Single colorful feather, light and delicate, floating, stylized game object', size: 'square', removeBg: true },
  { file: 'weight-brick.png', prompt: 'Red brick, heavy looking, textured, stylized cartoon game object, single item', size: 'square', removeBg: true },
  { file: 'weight-ball.png', prompt: 'Iron cannonball, heavy dark metallic sphere, stylized game object, single item', size: 'square', removeBg: true },
  { file: 'weight-balloon.png', prompt: 'Colorful helium balloon with string, light floating, stylized game object', size: 'square', removeBg: true },
  { file: 'weight-rock.png', prompt: 'Grey stone rock, heavy granite, stylized cartoon game object, single item', size: 'square', removeBg: true },
  { file: 'weight-cloud.png', prompt: 'Fluffy white cloud, light and airy, cartoon style, stylized game object', size: 'square', removeBg: true },
  { file: 'weight-gold-bar.png', prompt: 'Gold bar ingot, shiny precious metal, heavy looking, stylized game object, single item', size: 'square', removeBg: true },

  // === METEOR SEQUENCE ===
  { file: 'meteor-red.png', prompt: 'Flaming red meteor with fire trail, glowing space rock, game sprite, dynamic angle', size: 'square', removeBg: true },
  { file: 'meteor-blue.png', prompt: 'Icy blue meteor with frost crystal trail, glowing space rock, game sprite, dynamic angle', size: 'square', removeBg: true },
  { file: 'meteor-green.png', prompt: 'Glowing green meteor with energy trail, radioactive space rock, game sprite, dynamic angle', size: 'square', removeBg: true },
  { file: 'meteor-yellow.png', prompt: 'Golden meteor with spark trail, bright space rock, game sprite, dynamic angle', size: 'square', removeBg: true },
  { file: 'meteor-purple.png', prompt: 'Mystic purple meteor with magic particle trail, space rock, game sprite, dynamic angle', size: 'square', removeBg: true },
  { file: 'meteor-explosion.png', prompt: 'Colorful explosion burst, impact shockwave effect, space debris particles, game VFX', size: 'square', removeBg: true },
  { file: 'space-bg-game.png', prompt: 'Deep space starfield with colorful nebula clouds, dark blues and purples, stars twinkling, game background, wide format', size: 'landscape_16_9', removeBg: false },

  // === JIGSAW ===
  { file: 'jigsaw-frame.png', prompt: 'Empty jigsaw puzzle frame, dark polished wood texture border, empty center area, game board, wide format', size: 'landscape_16_9', removeBg: false },
  { file: 'jigsaw-piece-glow.png', prompt: 'Single jigsaw puzzle piece with golden glow outline, highlighted selection, game UI element', size: 'square', removeBg: true },
  { file: 'jigsaw-complete-effect.png', prompt: 'Completion celebration effect, golden sparkles and confetti burst radiating outward, game VFX', size: 'square', removeBg: true },

  // === NUMBER CRUNCH (MathCombination) ===
  ...Array.from({length: 9}, (_, i) => ({
    file: `number-bubble-${i+1}.png`,
    prompt: `Number ${i+1} digit inside glossy floating translucent bubble, colorful iridescent gradient, game UI element, centered`,
    size: 'square',
    removeBg: true
  })),
  { file: 'number-target-display.png', prompt: 'Target number display panel, golden ornate frame with LED style display area, dark center, game UI scoreboard', size: 'landscape_16_9', removeBg: false },
  { file: 'number-pop-effect.png', prompt: 'Bubble pop splash effect, colorful liquid droplets splashing outward, game VFX', size: 'square', removeBg: true },

  // === MEMORY SEQUENCE ===
  { file: 'memory-orb-red.png', prompt: 'Glowing red mystical energy sphere orb, inner light, magical aura, game element, centered', size: 'square', removeBg: true },
  { file: 'memory-orb-blue.png', prompt: 'Glowing blue mystical energy sphere orb, inner light, magical aura, game element, centered', size: 'square', removeBg: true },
  { file: 'memory-orb-green.png', prompt: 'Glowing green mystical energy sphere orb, inner light, magical aura, game element, centered', size: 'square', removeBg: true },
  { file: 'memory-orb-yellow.png', prompt: 'Glowing yellow mystical energy sphere orb, inner light, magical aura, game element, centered', size: 'square', removeBg: true },
  { file: 'memory-orb-purple.png', prompt: 'Glowing purple mystical energy sphere orb, inner light, magical aura, game element, centered', size: 'square', removeBg: true },
  { file: 'memory-orb-dim.png', prompt: 'Dim grey translucent sphere orb, inactive state, subtle faint inner glow, game element, centered', size: 'square', removeBg: true },
  { file: 'memory-grid-bg.png', prompt: 'Mystical stone platform with glowing rune circle markings, dark atmospheric, magical game board surface, wide format', size: 'landscape_16_9', removeBg: false },

  // === HEX TRACE (SequenceMatch) ===
  { file: 'hex-tile-inactive.png', prompt: 'Dark hexagon tile with subtle border edge glow, inactive muted state, game piece, geometric', size: 'square', removeBg: true },
  { file: 'hex-tile-active.png', prompt: 'Bright glowing hexagon tile, vivid neon blue energy fill, active highlighted state, game piece', size: 'square', removeBg: true },
  { file: 'hex-tile-correct.png', prompt: 'Bright green glowing hexagon tile, correct success state, emerald energy, game piece', size: 'square', removeBg: true },
  { file: 'hex-tile-wrong.png', prompt: 'Red flashing hexagon tile, error wrong state, crimson glow, game piece', size: 'square', removeBg: true },
  { file: 'hex-grid-bg.png', prompt: 'Hexagonal grid pattern background, dark surface with subtle neon blue lines forming hexagons, circuit board tech style, wide format', size: 'landscape_16_9', removeBg: false },

  // === CAR PATH ===
  { file: 'car-red.png', prompt: 'Cartoon red sports car, top-down aerial view, stylized game sprite, clean design', size: 'square', removeBg: true },
  { file: 'car-blue.png', prompt: 'Cartoon blue sedan car, top-down aerial view, stylized game sprite, clean design', size: 'square', removeBg: true },
  { file: 'car-green.png', prompt: 'Cartoon green SUV car, top-down aerial view, stylized game sprite, clean design', size: 'square', removeBg: true },
  { file: 'car-yellow.png', prompt: 'Cartoon yellow taxi cab car, top-down aerial view, stylized game sprite, clean design', size: 'square', removeBg: true },
  { file: 'car-purple.png', prompt: 'Cartoon purple muscle car, top-down aerial view, stylized game sprite, clean design', size: 'square', removeBg: true },
  { file: 'road-tile.png', prompt: 'Road segment tile, dark asphalt with white lane markings, top-down view, game tile, square format', size: 'square', removeBg: false },
  { file: 'intersection-tile.png', prompt: 'Road intersection crossroads tile, dark asphalt with lane markings, top-down view, game tile, square format', size: 'square', removeBg: false },
  { file: 'road-bg.png', prompt: 'Miniature city aerial view with roads and colorful buildings, cartoon tilt-shift style, game background, wide format', size: 'landscape_16_9', removeBg: false },

  // === SHARED UI ELEMENTS ===
  { file: 'correct-feedback.png', prompt: 'Green checkmark with sparkle burst particles, correct answer celebration, game feedback icon', size: 'square', removeBg: true },
  { file: 'wrong-feedback.png', prompt: 'Red X mark with shake motion lines, wrong answer indicator, game feedback icon', size: 'square', removeBg: true },
  { file: 'score-display.png', prompt: 'Score counter display panel, dark glass with golden frame, LED style number area, game HUD element', size: 'square', removeBg: true },
  { file: 'timer-bar-frame.png', prompt: 'Progress bar frame border, dark glass panel with golden edge trim, horizontal bar shape, game UI', size: 'landscape_16_9', removeBg: true },
];

async function generateImage(prompt, size) {
  const result = await fal.subscribe('fal-ai/flux-pro/v1.1', {
    input: {
      prompt: prompt + ART_SUFFIX,
      image_size: size,
      num_images: 1,
    }
  });
  return result.data.images[0].url;
}

async function removeBackground(imageUrl) {
  const result = await fal.subscribe('fal-ai/birefnet', {
    input: { image_url: imageUrl }
  });
  return result.data.image.url;
}

async function downloadImage(url, filePath) {
  const response = await fetch(url);
  const buffer = Buffer.from(await response.arrayBuffer());
  fs.writeFileSync(filePath, buffer);
}

async function main() {
  // Filter out already-generated assets
  const toGenerate = ASSETS.filter(a => !fs.existsSync(path.join(ASSETS_DIR, a.file)));

  console.log(`Total assets defined: ${ASSETS.length}`);
  console.log(`Already exist: ${ASSETS.length - toGenerate.length}`);
  console.log(`To generate: ${toGenerate.length}`);
  console.log(`Estimated cost: ~$${(toGenerate.length * 0.04 + toGenerate.filter(a => a.removeBg).length * 0.01).toFixed(2)}\n`);

  let done = 0;
  let failed = 0;

  for (const asset of toGenerate) {
    const filePath = path.join(ASSETS_DIR, asset.file);
    try {
      // Step 1: Generate with FLUX Pro
      const imageUrl = await generateImage(asset.prompt, asset.size);

      // Step 2: Remove background if needed
      let finalUrl = imageUrl;
      if (asset.removeBg) {
        finalUrl = await removeBackground(imageUrl);
      }

      // Step 3: Download
      await downloadImage(finalUrl, filePath);

      // Step 4: Update manifest
      manifest[asset.file] = {
        prompt: asset.prompt + ART_SUFFIX,
        model: 'fal-ai/flux-pro/v1.1',
        bgRemoved: asset.removeBg,
        size: asset.size,
        cost: asset.removeBg ? 0.05 : 0.04,
        timestamp: new Date().toISOString(),
      };
      saveManifest();

      done++;
      console.log(`✓ ${done}/${toGenerate.length}: ${asset.file} (${asset.removeBg ? 'gen+bg' : 'gen only'})`);
    } catch (err) {
      failed++;
      console.error(`✗ FAILED ${asset.file}: ${err.message}`);
    }
  }

  console.log(`\nDone! ${done} generated, ${failed} failed out of ${toGenerate.length}`);
  const totalCost = Object.values(manifest).reduce((sum, a) => sum + (a.cost || 0), 0);
  console.log(`Total manifest cost: ~$${totalCost.toFixed(2)}`);
}

main().catch(console.error);
