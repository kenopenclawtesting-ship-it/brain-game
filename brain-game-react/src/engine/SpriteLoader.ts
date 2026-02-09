import * as PIXI from 'pixi.js';
import { SpriteAsset } from './types';

class SpriteLoaderClass {
  private textureCache: Map<string, PIXI.Texture> = new Map();
  private loadingPromises: Map<string, Promise<PIXI.Texture>> = new Map();

  /**
   * Load a single sprite texture
   */
  async loadTexture(path: string): Promise<PIXI.Texture> {
    // Return cached texture if available
    if (this.textureCache.has(path)) {
      return this.textureCache.get(path)!;
    }

    // Return existing loading promise if in progress
    if (this.loadingPromises.has(path)) {
      return this.loadingPromises.get(path)!;
    }

    // Start loading
    const promise = new Promise<PIXI.Texture>((resolve, reject) => {
      PIXI.Assets.load(path)
        .then((texture: PIXI.Texture) => {
          this.textureCache.set(path, texture);
          this.loadingPromises.delete(path);
          resolve(texture);
        })
        .catch((error) => {
          this.loadingPromises.delete(path);
          reject(error);
        });
    });

    this.loadingPromises.set(path, promise);
    return promise;
  }

  /**
   * Load multiple sprites in parallel
   */
  async loadSprites(sprites: SpriteAsset[]): Promise<Map<string, PIXI.Texture>> {
    const loadPromises = sprites.map(sprite => 
      this.loadTexture(sprite.path).then(texture => ({
        name: sprite.name,
        texture
      }))
    );

    const results = await Promise.all(loadPromises);
    const textureMap = new Map<string, PIXI.Texture>();
    
    results.forEach(({ name, texture }) => {
      textureMap.set(name, texture);
    });

    return textureMap;
  }

  /**
   * Preload sprites for a game
   */
  async preloadGameSprites(gameId: string, sprites: SpriteAsset[]): Promise<void> {
    console.log(`Preloading sprites for game: ${gameId}`);
    await this.loadSprites(sprites);
    console.log(`Finished preloading ${sprites.length} sprites for ${gameId}`);
  }

  /**
   * Load sprite sheet atlas (JSON + PNG)
   */
  async loadSpriteSheet(jsonPath: string): Promise<PIXI.Spritesheet> {
    try {
      const resource = await PIXI.Assets.load(jsonPath);
      return resource;
    } catch (error) {
      console.error('Failed to load sprite sheet:', jsonPath, error);
      throw error;
    }
  }

  /**
   * Get texture from cache (sync)
   */
  getTexture(path: string): PIXI.Texture | null {
    return this.textureCache.get(path) || null;
  }

  /**
   * Check if texture is loaded
   */
  isLoaded(path: string): boolean {
    return this.textureCache.has(path);
  }

  /**
   * Get all loaded textures for debugging
   */
  getLoadedTextures(): string[] {
    return Array.from(this.textureCache.keys());
  }

  /**
   * Clear cache (useful for memory management)
   */
  clearCache(): void {
    this.textureCache.clear();
  }

  /**
   * Create sprite from loaded texture
   */
  createSprite(path: string): PIXI.Sprite | null {
    const texture = this.getTexture(path);
    if (!texture) {
      console.warn(`Texture not loaded: ${path}`);
      return null;
    }
    return new PIXI.Sprite(texture);
  }

  /**
   * Helper to generate common sprite paths
   */
  static getSpritePath(filename: string): string {
    return `/sprites/${filename}`;
  }

  static getImagePath(filename: string): string {
    return `/sprites/${filename}`;
  }
}

// Export singleton instance
export const SpriteLoader = new SpriteLoaderClass();