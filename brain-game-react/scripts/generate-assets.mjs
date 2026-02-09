/**
 * Asset Generation Script for "Who Has The Biggest Brain?" v2
 * Uses fal.ai API to generate all game assets
 *
 * Usage:
 *   node scripts/generate-assets.mjs mainmenu
 *   node scripts/generate-assets.mjs gameselect
 *   node scripts/generate-assets.mjs all
 */

import { fal } from '@fal-ai/client';
import { writeFileSync, readFileSync, existsSync, mkdirSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import https from 'https';
import http from 'http';

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, '..');
const ASSETS_DIR = join(ROOT, 'public', 'assets', 'generated');
const MANIFEST_PATH = join(ASSETS_DIR, 'manifest.json');

// ─── Config ─────────────────────────────────────────────────────────────
const FAL_KEY = process.env.FAL_KEY || 'c7e538a9-3ca4-4b8f-a288-62660428defd:c2b20e0ab503ca6d58aff89616a5ddd7';

fal.config({ credentials: FAL_KEY });

// Cost estimates per model
const COSTS = {
  'fal-ai/flux-pro/v1.1': 0.04,
  'fal-ai/flux/dev': 0.025,
  'fal-ai/recraft-v3': 0.04,
  'fal-ai/real-esrgan': 0.01,
  'fal-ai/wan-i2v': 0.40,
};

let totalSpent = 0;
const BUDGET_LIMIT = 200;

// ─── Manifest ───────────────────────────────────────────────────────────
function loadManifest() {
  if (existsSync(MANIFEST_PATH)) {
    return JSON.parse(readFileSync(MANIFEST_PATH, 'utf-8'));
  }
  return { assets: [], totalSpent: 0, generated: new Date().toISOString() };
}

function saveManifest(manifest) {
  manifest.lastUpdated = new Date().toISOString();
  writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2));
}

function addToManifest(manifest, entry) {
  manifest.assets.push(entry);
  manifest.totalSpent = (manifest.totalSpent || 0) + (entry.cost || 0);
  saveManifest(manifest);
}

// ─── Download helper ────────────────────────────────────────────────────
function downloadFile(url, dest) {
  return new Promise((resolve, reject) => {
    const mod = url.startsWith('https') ? https : http;
    const file = [];
    mod.get(url, (res) => {
      if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
        return downloadFile(res.headers.location, dest).then(resolve).catch(reject);
      }
      res.on('data', (chunk) => file.push(chunk));
      res.on('end', () => {
        const buf = Buffer.concat(file);
        writeFileSync(dest, buf);
        resolve(dest);
      });
      res.on('error', reject);
    }).on('error', reject);
  });
}

// ─── Generate Image ─────────────────────────────────────────────────────
async function generateImage(prompt, filename, options = {}) {
  const {
    model = 'fal-ai/flux-pro/v1.1',
    width = 1280,
    height = 720,
    maxRetries = 3,
    seed = undefined,
  } = options;

  const cost = COSTS[model] || 0.04;
  if (totalSpent + cost > BUDGET_LIMIT) {
    console.error(`  BUDGET LIMIT reached ($${totalSpent.toFixed(2)}/$${BUDGET_LIMIT}). Skipping.`);
    return null;
  }

  const outPath = join(ASSETS_DIR, filename);
  if (existsSync(outPath) && !options.force) {
    console.log(`  ⏭ ${filename} already exists, skipping (use --force to regenerate)`);
    return outPath;
  }

  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      console.log(`  🎨 Generating ${filename} (attempt ${attempt}/${maxRetries})...`);
      console.log(`     Model: ${model} | ${width}x${height} | ~$${cost}`);
      console.log(`     Prompt: "${prompt.slice(0, 80)}..."`);

      const input = {
        prompt,
        image_size: { width, height },
        num_images: 1,
        enable_safety_checker: false,
      };
      if (seed !== undefined) input.seed = seed;

      const result = await fal.subscribe(model, { input });
      const imageUrl = result.data?.images?.[0]?.url;

      if (!imageUrl) {
        console.error(`  ❌ No image URL in response`, JSON.stringify(result.data).slice(0, 200));
        continue;
      }

      await downloadFile(imageUrl, outPath);
      totalSpent += cost;
      console.log(`  ✅ Saved: ${filename} ($${totalSpent.toFixed(2)} total spent)`);
      return outPath;

    } catch (err) {
      console.error(`  ❌ Attempt ${attempt} failed: ${err.message}`);
      if (attempt === maxRetries) {
        console.error(`  💀 All ${maxRetries} attempts failed for ${filename}`);
        return null;
      }
      await new Promise(r => setTimeout(r, 2000 * attempt));
    }
  }
  return null;
}

// ─── Generate SVG/Icon ──────────────────────────────────────────────────
async function generateIcon(prompt, filename, options = {}) {
  return generateImage(prompt, filename, {
    model: 'fal-ai/recraft-v3',
    width: options.width || 512,
    height: options.height || 512,
    ...options,
  });
}

// ─── Asset Definitions ──────────────────────────────────────────────────

const MAINMENU_ASSETS = [
  {
    id: 'mainmenu-bg',
    filename: 'mainmenu-bg.png',
    prompt: 'Game show stage background, dramatic purple and blue lighting, spotlights from above, golden frame border, marquee lights around the edge, premium TV quiz show set, deep rich colors, no text, no people, cinematic, wide angle, 4K quality, dark purple velvet curtains, gold trim details, theatrical stage design',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'professor-hero',
    filename: 'professor-hero.png',
    prompt: 'Cartoon professor character, male, friendly smile, big round glasses, messy dark hair, white lab coat, holding glowing brain, warm colors, game character art style like Candy Crush or Clash Royale, clean vector-like illustration, transparent background style on solid dark purple, full body standing pose, expressive face, premium mobile game quality',
    width: 768,
    height: 1024,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'brain-logo',
    filename: 'brain-logo.png',
    prompt: 'Glowing neon brain icon, electric purple and cyan colors, digital neural network style, game logo design, premium quality, dark background, radiating light effects, futuristic, clean edges, symmetrical, vivid glow effect',
    width: 512,
    height: 512,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'play-button',
    filename: 'play-button.png',
    prompt: 'Large golden PLAY button for a game, 3D beveled style, glowing gold gradient, premium mobile game UI, slight shadow, clean design, no text, circular shape with play triangle icon, metallic gold finish, ornate border detail, dark background',
    width: 512,
    height: 512,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'mainmenu-sunburst',
    filename: 'mainmenu-sunburst.png',
    prompt: 'Radial sunburst pattern, golden yellow rays emanating from center, game show style light burst effect, clean graphic design, warm gold and amber colors on dark background, theatrical spotlight effect, no text, decorative pattern',
    width: 1024,
    height: 1024,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'marquee-frame',
    filename: 'marquee-frame.png',
    prompt: 'Ornate game show picture frame border, golden metallic frame with round light bulbs around the edge like a theatre marquee, premium TV show style, rectangular frame shape, transparent center, dark background, theatrical gold detailing, no text, clean design',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
];

const GAMESELECT_ASSETS = [
  {
    id: 'gameselect-bg',
    filename: 'gameselect-bg.png',
    prompt: 'Quiz game selection screen background, dark blue purple gradient, four glowing category zones arranged in quadrants, analytical pink zone top-left, calculate yellow zone top-right, memory green zone bottom-left, visual blue zone bottom-right, premium game UI, subtle grid pattern, no text, clean modern game design',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
];

const CATEGORY_BG_ASSETS = [
  {
    id: 'bg-analyse',
    filename: 'bg-analyse.png',
    prompt: 'Abstract analytical brain puzzle background, warm pink and coral gradient, geometric shapes and gears floating, puzzle pieces, magnifying glass motifs, premium mobile game background, soft warm lighting, no text, depth of field blur, game UI backdrop',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'bg-calculate',
    filename: 'bg-calculate.png',
    prompt: 'Mathematical calculation themed background, warm yellow and amber gradient, floating numbers and math symbols, plus minus multiply divide signs, chalkboard equation motifs, premium mobile game background, soft lighting, no text, depth of field, game UI backdrop',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'bg-memory',
    filename: 'bg-memory.png',
    prompt: 'Memory and recall themed background, green and emerald gradient, floating playing cards and brain motifs, memory palace corridor, premium mobile game background, soft green lighting, no text, ethereal glow, depth of field, game UI backdrop',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'bg-identify',
    filename: 'bg-identify.png',
    prompt: 'Visual perception themed background, cool blue and teal gradient, floating eyes and optical illusion patterns, kaleidoscope motifs, premium mobile game background, soft blue lighting, no text, ethereal glow, depth of field, game UI backdrop',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
];

const COUNTDOWN_ASSETS = [
  {
    id: 'countdown-bg',
    filename: 'countdown-bg.png',
    prompt: 'Dramatic countdown screen background, dark purple and gold, radiating light beams from center, theatrical spotlight effect, premium game show atmosphere, intense energy, particles floating, cinematic feel, no text, no numbers',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
];

const RESULTS_ASSETS = [
  {
    id: 'results-bg',
    filename: 'results-bg.png',
    prompt: 'Score results screen background, premium game show style, golden confetti and sparkles, spotlight from above, dark purple background with gold accents, celebration atmosphere, premium TV quiz show, no text, cinematic lighting',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
  {
    id: 'summary-bg',
    filename: 'summary-bg.png',
    prompt: 'Final results celebration background, premium game show victory screen, golden fireworks and confetti, dramatic spotlights, dark purple to gold gradient, trophy and crown motifs, premium mobile game, no text, cinematic, particles floating',
    width: 1280,
    height: 960,
    model: 'fal-ai/flux-pro/v1.1',
  },
];

// ─── Asset Groups ───────────────────────────────────────────────────────
const ASSET_GROUPS = {
  mainmenu: MAINMENU_ASSETS,
  gameselect: GAMESELECT_ASSETS,
  categories: CATEGORY_BG_ASSETS,
  countdown: COUNTDOWN_ASSETS,
  results: [...RESULTS_ASSETS],
  all: [...MAINMENU_ASSETS, ...GAMESELECT_ASSETS, ...CATEGORY_BG_ASSETS, ...COUNTDOWN_ASSETS, ...RESULTS_ASSETS],
};

// ─── Main ───────────────────────────────────────────────────────────────
async function main() {
  const group = process.argv[2] || 'mainmenu';
  const force = process.argv.includes('--force');

  const assets = ASSET_GROUPS[group];
  if (!assets) {
    console.error(`Unknown group: ${group}`);
    console.log('Available groups:', Object.keys(ASSET_GROUPS).join(', '));
    process.exit(1);
  }

  // Ensure output dir
  mkdirSync(ASSETS_DIR, { recursive: true });

  const manifest = loadManifest();
  totalSpent = manifest.totalSpent || 0;

  console.log(`\n🧠 Generating "${group}" assets (${assets.length} images)`);
  console.log(`   Budget: $${totalSpent.toFixed(2)} / $${BUDGET_LIMIT} spent\n`);

  for (const asset of assets) {
    const result = await generateImage(asset.prompt, asset.filename, {
      model: asset.model,
      width: asset.width,
      height: asset.height,
      seed: asset.seed,
      force,
    });

    if (result) {
      addToManifest(manifest, {
        id: asset.id,
        filename: asset.filename,
        prompt: asset.prompt,
        model: asset.model,
        width: asset.width,
        height: asset.height,
        cost: COSTS[asset.model] || 0.04,
        timestamp: new Date().toISOString(),
      });
    }
    console.log('');
  }

  console.log(`\n✅ Done! Total spent: $${totalSpent.toFixed(2)}`);
  console.log(`   Assets saved to: ${ASSETS_DIR}`);
}

main().catch(console.error);
