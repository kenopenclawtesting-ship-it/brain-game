// Phase 1: Remove opaque backgrounds from sprite/icon assets via BiRefNet
// Skips full-screen backgrounds (they don't need transparency)
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { createFalClient } from '@fal-ai/client';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const fal = createFalClient({
  credentials: 'c7e538a9-3ca4-4b8f-a288-62660428defd:c2b20e0ab503ca6d58aff89616a5ddd7'
});

const ASSETS_DIR = path.join(__dirname, '..', 'public', 'assets', 'generated');

// Full-screen backgrounds — do NOT remove their backgrounds
const SKIP_FILES = new Set([
  'main-menu-bg.png',
  'mainmenu-bg.png',
  'game-select-bg.png',
  'gameselect-bg.png',
  'countdown-bg.png',
  'summary-bg.png',
  'results-bg.png',
  'results-bg-v2.png',
  'cat-bg-analyse.png',
  'cat-bg-calculate.png',
  'cat-bg-memory.png',
  'cat-bg-identify.png',
  'game-bg-calculate.png',
  'game-bg-memory.png',
  'game-bg-logic.png',
  'game-bg-visual.png',
  'mainmenu-sunburst.png',
  'marquee-frame.png',
]);

async function removeBackground(filePath) {
  const fileData = fs.readFileSync(filePath);
  const base64 = fileData.toString('base64');
  const dataUri = `data:image/png;base64,${base64}`;

  const result = await fal.subscribe('fal-ai/birefnet', {
    input: { image_url: dataUri }
  });

  // Download the result
  const imageUrl = result.data.image.url;
  const response = await fetch(imageUrl);
  const buffer = Buffer.from(await response.arrayBuffer());
  fs.writeFileSync(filePath, buffer);
}

async function main() {
  const files = fs.readdirSync(ASSETS_DIR).filter(f => f.endsWith('.png'));
  const toProcess = files.filter(f => !SKIP_FILES.has(f));

  console.log(`Found ${files.length} total PNGs, processing ${toProcess.length} (skipping ${files.length - toProcess.length} backgrounds)\n`);

  let done = 0;
  let failed = 0;

  for (const file of toProcess) {
    const filePath = path.join(ASSETS_DIR, file);
    try {
      await removeBackground(filePath);
      done++;
      console.log(`✓ ${done}/${toProcess.length}: ${file}`);
    } catch (err) {
      failed++;
      console.error(`✗ FAILED ${file}: ${err.message}`);
    }
  }

  console.log(`\nDone! ${done} processed, ${failed} failed out of ${toProcess.length}`);
  console.log(`Estimated cost: ~$${(done * 0.01).toFixed(2)}`);
}

main().catch(console.error);
