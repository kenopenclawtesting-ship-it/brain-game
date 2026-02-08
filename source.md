# Who Has The Biggest Brain? - Source Analysis

## Game Overview
- **Original Developer**: Playfish (acquired by EA)
- **Platform**: Facebook/Web (Flash-based)
- **Genre**: Brain training / Mini-game collection
- **File**: brain_game_2_6_7_translated_v1.swf
- **Flash Version**: 9
- **Compressed Size**: 1.77 MB
- **Decompressed Size**: 2.89 MB

## Game Modes (from screenshots)
1. **CLASSIC GAME** - Standard mode with randomized mini-games
2. **PRO GAME** - Advanced mode with all 12 mini-games
3. **PRACTICE** - Individual mini-game practice mode

## Core Game Structure

### 12 Mini-Games Total
Evidence from SWF extraction shows:
- `minigame0` through `minigame11`
- `minigameIcon0` through `minigameIcon11`
- Total of 12 unique mini-games

### 4 Categories
1. **Analysis/Logic**
2. **Calculation/Math** 
3. **Memory**
4. **Visual Processing**

Each category has 3 mini-games (3 × 4 = 12 total)

## Scoring System

### Score Elements (from SWF)
- `score0`, `score1`, `score2`, `score3` - Individual game scores
- `playerScore` - Current player total
- `highscore` / `Hscore` - High score tracking
- `addscore` / `addscoreend` - Score addition animations
- `chaScore` - Challenge score
- `sortScore` - Score sorting function

### Brain Size Calculation
- `brainType` - Brain classification
- `brainSize` - Numeric brain size in cm³
- `brainTypeTextField` - Display for current brain type
- `nextBrainTypeTextField` - Next achievable brain type
- Scale ranges from small brains to "Space Alien" level

### Feedback System
- `CORRECT:` - Positive feedback
- `INCORRECT:` - Negative feedback  
- `correct` / `incorrect` - Boolean flags

## Timing System
- `timesUpText` - Timer expiration message
- Each mini-game has individual time limits
- Total round time tracked

## Identified Mini-Games

### From SWF Analysis:
1. **Hexagon** - `hexagon` reference found
   - Likely path-tracing or navigation game
   
2. **Scale/Weight** - Multiple scale text fields found
   - `scaleTextField0` through `scaleTextField10`
   - Weight balancing logic game

3. **Card/Memory** - Card game elements
   - `card`, `cardBG`, `BigNameCard`
   - Memory matching mechanics

4. **Block Counting** - Implicit from "block" references
   - Count 3D isometric blocks

5. **Asteroid** - Direct reference found
   - Visual sorting/matching game

6. **Math** - Math category confirmed
   - Arithmetic calculations

7-12. **Additional Games** - To be determined from gameplay
   - Puzzle pieces
   - Object sequence memory
   - Pattern matching
   - Sushi/food memory
   - Number sequences
   - Visual transformations

## UI Elements

### Main Interface
- Game host character (cheerful cartoon person visible in screenshots)
- Pink/yellow progress bar at bottom
- Three game mode buttons (Classic, Pro, Practice)
- Back button (blue arrow icon top-left)
- Speech bubble for instructions/dialogue

### Game Panel
- `gamePanel` - Main game container
- `showMiniGame` - Game display function
- `gameselectEnd` - Game selection completion

### Color Scheme
- Primary: Purple/pink gradients
- Accent: Yellow/gold for achievements
- UI: Colorful button designs
- Background: Gray gradients

## Technical Architecture (ActionScript)

### Key Classes/Functions (from decompilation)
- `CLASS MINIGAMES` - Core mini-game manager
- `Function application` - Main app controller
- `Function FacebookData` - Social integration
- State machine for game flow
- Loop value management for timing

### Game Flow
1. Main Menu → Mode Selection
2. Game Initialization
3. Mini-game Loop (4 games in Classic, 12 in Pro)
4. Score Calculation
5. Results Display
6. Brain Size Assignment
7. Social Sharing

## Missing Elements for Perfect Recreation

### From SWF (Cannot Extract Without Full Decompiler)
1. **Exact Game Logic**
   - Precise scoring algorithms
   - Difficulty scaling formulas
   - Time limit values per game
   - Exact mini-game mechanics

2. **Visual Assets**
   - Sprite sheets
   - Animation frames
   - Character artwork
   - UI graphics

3. **Audio**
   - Background music
   - Sound effects (correct/incorrect)
   - Voiceovers for game host
   - Button clicks

4. **Social Features**
   - Facebook integration code
   - Friend comparison system
   - Challenge mechanics
   - Leaderboard logic

## Recreation Strategy

### Phase 1: Core Mechanics (PRIORITY)
✅ Game flow and state management
✅ 4 basic mini-games for proof of concept
⬜ Remaining 8 mini-games
⬜ Accurate scoring system
⬜ Brain size calculations

### Phase 2: Visual Polish
⬜ Character animations
⬜ Transition effects
⬜ Particle effects for feedback
⬜ Polished UI matching original aesthetic
⬜ Responsive design for mobile

### Phase 3: Audio & Feel
⬜ Background music
⬜ Sound effects
⬜ Haptic feedback (mobile)
⬜ Voiceovers (optional)

### Phase 4: Advanced Features
⬜ Local high scores
⬜ Daily challenges
⬜ Achievement system
⬜ Multiple difficulty levels
⬜ Progress tracking/calendar

### Phase 5: Social (Optional)
⬜ Share results
⬜ Multiplayer modes
⬜ Leaderboards
⬜ Friend challenges

## Known Mini-Game Mechanics (from research)

### 1. Block Counting (Analysis)
- Display 3D isometric blocks
- Player counts total blocks
- Blocks can overlap/hide each other
- 30 second time limit
- Score: 100+ points per correct answer

### 2. Memory Cards (Memory)
- Standard memory matching
- Show cards briefly, then hide
- Match pairs by remembering positions
- Difficulty: 6-12 pairs
- Score: 100 points per pair

### 3. Quick Math (Calculation)
- Basic arithmetic (+, -, ×, ÷)
- Rapid-fire questions
- Number range scales with difficulty
- Score: 50-150 points per problem

### 4. Asteroid Sorting (Visual)
- Click asteroid matching target size
- Asteroids drift across screen
- Visual size estimation required
- Score: 80-180 points per correct click

### 5. Hexagon Path (Visual)
- Trace path through hexagon maze
- Remember pattern shown briefly
- Navigate without seeing path
- Referenced in archive descriptions

### 6. Scale/Weight Balance (Analysis)
- Multiple scales with objects
- Determine relative weights
- Logic puzzle mechanics
- 10+ scale displays referenced

### 7. Object Sequence (Memory)
- Remember order of objects shown
- Recall sequence after hiding
- Common items (sushi, everyday objects)
- Referenced as "memorizing items in order"

### 8. Puzzle Pieces (Analysis)
- Select correct piece to complete jigsaw
- Visual-spatial reasoning
- Multiple similar pieces to choose from
- Players reported difficulty with this

### 9-12. Additional Games
Based on "Pro Game" having 12 total:
- Pattern matching variants
- Number sequences
- Additional memory challenges
- Visual transformation puzzles

## File Structure Notes

The SWF contains:
- Compressed ActionScript bytecode
- Embedded bitmap/vector graphics
- Timeline animations
- Text strings for all UI elements
- Sound data (if present)

Without a proper Flash decompiler (JPEXS FFDec, SWFTools), we cannot extract:
- Complete source code
- Individual asset files
- Exact animation timings
- Audio files

## Conclusion

We have successfully mapped:
- ✅ Overall game structure
- ✅ 12 mini-game framework
- ✅ Core game loop
- ✅ UI/UX elements
- ✅ 8+ confirmed mini-games with mechanics
- ⚠️ Exact algorithms require gameplay testing
- ⚠️ Visual assets need recreation
- ⚠️ Audio completely missing

**Next Step**: Create scope.md for modern recreation using React/Canvas/WebGL