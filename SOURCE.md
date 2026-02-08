# SOURCE.md - Who Has The Biggest Brain - Complete Source Analysis

## 1. Architecture Overview

### 1.1 Core Package Structure
```
com/playfish/games/whohasthebiggestbrain/
├── Engine.as                    # Main game engine
├── GameWorld.as                 # Central game state manager (50KB)
├── MinigameDefines.as           # Game definitions & config
├── MinigameBase.as              # Base class for all minigames
├── SummaryScreen.as             # Score display & brain calculation
├── MainMenu.as                  # Main menu handler
├── HighScorePanel.as            # Leaderboard system
├── AchievementHandler.as        # Trophy/achievement system
├── ChallengeWorld.as            # Challenge mode
├── TutorialScreen.as            # Tutorial display
├── minigames/                   # 12 individual minigames
│   ├── Calculate.as
│   ├── CarPath.as
│   ├── CubeCounter.as
│   ├── JigsawMatch.as
│   ├── MatchCard.as
│   ├── MathCombination.as
│   ├── MemorySequence.as
│   ├── MeteorSequence.as
│   ├── MissingSign.as
│   ├── SequenceMatch.as
│   ├── ShapeOrder.as
│   └── WeightGame.as
└── utils/
    └── ProtectedInt.as          # Cheat-protected values
```

### 1.2 Inheritance Chains
```
BaseWorld
├── GameWorld (singleton-like state manager)
├── MainMenu
├── MinigameBase
│   └── [all minigames via composition with Minigame]
├── SummaryScreen
├── TutorialScreen
├── ChallengeWorld
└── WorldProfile/WorldStats/etc.

Minigame (abstract base)
├── Calculate
├── CarPath
├── CubeCounter
├── JigsawMatch
├── MatchCard
├── MathCombination
├── MemorySequence
├── MeteorSequence
├── MissingSign
├── SequenceMatch
├── ShapeOrder
└── WeightGame
```

---

## 2. Game Flow

### 2.1 Main Flow Sequence
```
1. BRAND → Intro splash screen
2. SPLASH → Logo + music
3. MAIN MENU → Play / Challenge / Profile / Stats
4. GAME SELECTION
   ├── Full Test (GS_FULL_GAME) → 4 categories, 1 game each
   ├── Practice (GS_TEST_MINIGAME) → Single game
   └── Challenge (GS_CHALLENGE) → vs friend
5. TUTORIAL → Category intro + game instructions
6. COUNTDOWN → 3-2-1-GO animation
7. MINIGAME → 60 seconds gameplay
8. RESULTS → Score display
9. SUMMARY → Brain size calculation
10. LEADERBOARD → High scores
```

### 2.2 Game States (GameWorld)
```actionscript
GS_BRAND = 0        // Initial brand screen
GS_SPLASH = 1       // Splash/logo
GS_FULL_GAME = 2    // Full 4-category test
GS_TEST_MINIGAME = 3 // Practice single game
GS_CHALLENGE = 4    // Challenge mode
```

### 2.3 Minigame States (MinigameBase)
```actionscript
STATE_NORMAL = 0    // Playing
STATE_CORRECT = 1   // Just got one right
STATE_FAIL = 2      // Just got one wrong
STATE_TIMEUP = 3    // Timer expired
```

---

## 3. The 12 Mini-Games

### 3.1 Game Index & Categories
| ID | Game | Category | Class | PRO |
|----|------|----------|-------|-----|
| 0 | Shape Order | Memory | ShapeOrder | ❌ |
| 1 | Card Pairs | Memory | MatchCard | ❌ |
| 2 | Missing Number | Calculate | Calculate | ❌ |
| 3 | Missing Sign | Calculate | MissingSign | ❌ |
| 4 | Cube Counter | Analyse | CubeCounter | ❌ |
| 5 | Balance Scale | Analyse | WeightGame | ❌ |
| 6 | Asteroids | Identify | MeteorSequence | ❌ |
| 7 | Jigsaw | Identify | JigsawMatch | ❌ |
| 8 | Math Combo | Calculate | MathCombination | ✅ |
| 9 | Hex Path | Identify | SequenceMatch | ✅ |
| 10 | Action Sequence | Memory | MemorySequence | ✅ |
| 11 | Car Path | Analyse | CarPath | ✅ |

### 3.2 Categories
```actionscript
MINIGAME_CAT_ANALYSE = 0    // Analytical thinking
MINIGAME_CAT_CALCULATE = 1  // Mathematical
MINIGAME_CAT_MEMORY = 2     // Memory recall
MINIGAME_CAT_IDENTIFY = 3   // Visual/Pattern recognition
```

---

## 4. Scoring System

### 4.1 Points Per Game
| Game | Correct | Incorrect | Ratio |
|------|---------|-----------|-------|
| ShapeOrder (0) | +18 | -12 | 1.5x |
| MatchCard (1) | +26 | -18 | 1.44x |
| Calculate (2) | +27 | -18 | 1.5x |
| MissingSign (3) | +20 | -12 | 1.67x |
| CubeCounter (4) | +49 | -33 | 1.48x |
| WeightGame (5) | +24 | -16 | 1.5x |
| MeteorSequence (6) | +11 | -11 | 1.0x |
| JigsawMatch (7) | +19 | -13 | 1.46x |
| MathCombination (8) | +44 | -29 | 1.52x |
| SequenceMatch (9) | +40 | -26 | 1.54x |
| MemorySequence (10) | +13 | -8 | 1.63x |
| CarPath (11) | +26 | -17 | 1.53x |

### 4.2 Score Calculation
```actionscript
// Per-minigame score (MinigameBase)
addScore(int points) {
    categoryScore = Math.max(categoryScore + points, 0);
}

// Total score (SummaryScreen)
combinedScore = 0;
for (i = 0; i < 4; i++) {
    combinedScore += categoryScores[i];
}
GameWorld.totalScores = combinedScore;
```

### 4.3 Cheat Detection & Anti-Cheat Systems
- **Memory modification**: `ProtectedInt` class with LFSR encryption
- **Speed hack**: If game completed in < 62 seconds (60 + 2 buffer), flag as cheat
- **Calculate cheat**: Average answer time < 1 second = cheat

### 4.4 ProtectedInt Implementation
```actionscript
// Anti-memory-editing protection (com/playfish/games/utils/ProtectedInt.as)
class ProtectedInt {
    private var _value:int;      // Encoded value
    private var checksum:int;    // CRC validation
    
    // 10 rounds of LFSR (Linear Feedback Shift Register)
    private static const POLY:uint = 3172090281;  // Feedback polynomial
    private static const ROUNDS:int = 10;
    
    // Get/set automatically encode/decode + validate checksum
    // If checksum invalid → randomize (breaks cheat)
}
```

### 4.5 Deterministic Random (for Challenges)
```actionscript
// com/playfish/games/utils/Random.as - Seeded PRNG
class Random {
    // 48-bit seed split into low/mid/high 16-bit words
    private var seedLow:uint, seedMid:uint, seedHigh:uint;
    
    // Linear congruential generator with multiplier/addend
    // MULTIPLIER = 5 * 65536 + 57068 * 65536 + 58989
    // ADDEND = 11
    
    function setSeed(seed0:uint, seed1:uint):void
    function nextInt(bound:int):uint  // Returns 0..bound-1
}
// Used in challenges so both players get identical puzzles
```

---

## 5. Brain Weight/Size Calculation

### 5.1 Brain Type Score Ranges
```actionscript
BRAIN_TYPE_SCORE_RANGE = [
    0,    100,  300,  500,  700,  900,   // 0-5
    1000, 1100, 1200, 1300, 1400, 1500,  // 6-11
    1600, 1700, 1800, 1900, 2000, 2100,  // 12-17
    2300, 2500, 2700, 2900, 3100, 3300,  // 18-23
    3500, 3700, 3900, 4100, 4300, 4500,  // 24-29
    4700, 4900                            // 30-31
];
// 32 brain types total
```

### 5.2 getBrainType Function
```actionscript
public static function getBrainType(score:int):int {
    for (var i:int = 0; i < BRAIN_TYPE_SCORE_RANGE.length - 1; i++) {
        if (score >= BRAIN_TYPE_SCORE_RANGE[i] && 
            score < BRAIN_TYPE_SCORE_RANGE[i + 1]) {
            return i;
        }
    }
    return BRAIN_TYPE_SCORE_RANGE.length - 1;
}
```

### 5.3 Brain Type Names (32 levels)
From `LanguageTranslation.as` (with descriptions):
| # | Name | Score Range | Description |
|---|------|-------------|-------------|
| 0 | AMOEBA | 0-99 | "I'm sure there's something good to say about AMOEBAS..." |
| 1 | EARTHWORM | 100-299 | Good for garden soil, not big thinkers |
| 2 | SNAIL | 300-499 | Kind of cute, tiny brains |
| 3 | RAT | 500-699 | Clever animals |
| 4 | CAT | 700-899 | Nine lives, so-so brains |
| 5 | DOG | 900-999 | Who wouldn't want to be a dog! |
| 6 | GOAT | 1000-1099 | Mountain skippers |
| 7 | CHIMP | 1100-1199 | Understands basic symbols |
| 8 | GORILLA | 1200-1299 | Largest primates, highly intelligent |
| 9 | MISSING LINK | 1300-1399 | Early man, relatively evolved |
| 10 | NEANDERTHAL | 1400-1499 | Geniuses of their time, controlled fire |
| 11 | AVERAGE JOE | 1500-1599 | Not amazing, not shabby |
| 12 | GEEK | 1600-1699 | Shows promise! |
| 13 | NERD | 1700-1799 | Will rule the universe! |
| 14 | SCHOLAR | 1800-1899 | Congratulations on a job well done! |
| 15 | SCIENTIST | 1900-1999 | Something to be proud of |
| 16 | GENIUS | 2000-2099 | Biggest brain in humans today |
| 17 | SPACE ACE | 2100-2299 | Ahead of your time |
| 18 | CYBORG | 2300-2499 | Man-machine combination |
| 19 | ALIEN | 2500-2699 | Welcome to Earth, visitor! |
| 20 | SQUIDLIAN | 2700-2899 | Mighty brain master |
| 21 | BITBOT | 2900-3099 | You're a machine! |
| 22 | SPACEBOT | 3100-3299 | RX-711 SPACEBOT |
| 23 | CALCUBOT | 3300-3499 | I always knew it! |
| 24 | ENCEPHALOBOT | 3500-3699 | Ask for autographs later |
| 25 | BRAINBOT | 3700-3899 | All that computing power! |
| 26 | NEUROBOT | 3900-4099 | One of the few in the universe |
| 27 | COMPUTRON | 4100-4299 | Computational elite |
| 28 | XENOS | 4300-4499 | Level few achieve |
| 29 | NEURONIAN | 4500-4699 | Monstrous brain |
| 30 | AEONIAN | 4700-4899 | Awe-inspiring brain capacity |
| 31 | GALAXIAN | 4900+ | Brain Master of the Universe |

---

## 6. Timing System

### 6.1 Core Timer Constants
```actionscript
TOTAL_GAME_TIME = 60000;  // 60 seconds per minigame (ms)
```

### 6.2 Timer Implementation (MinigameBase)
```actionscript
tick(timeDelta:uint) {
    if (gameTimerEnabled) {
        gameTimerPrev = timer;
        gameTimer = Math.max(gameTimerPrev - timeDelta, 0);
        
        // Sound warning at 10 seconds
        if (Math.ceil(gameTimer / 1000) <= 10) {
            Engine.playSound("TimerSound", 1);
        }
        
        // Time up
        if (gameTimer <= 0) {
            minigame.timeup();
            // Show "Time's Up!" animation
        }
    }
}
```

---

## 7. Achievement System

### 7.1 Achievement Types (21 total)
```actionscript
// Per-minigame mastery (0-11)
MINIGAME_WEIGHT_OVER = 0
MINIGAME_CUBE_COUNT_OVER = 1
MINIGAME_SHAPE_ORDER_OVER = 2
MINIGAME_CARD_PAIR_OVER = 3
MINIGAME_CALCULATE_OVER = 4
MINIGAME_MISSING_SIGN_OVER = 5
MINIGAME_METEOR_OVER = 6
MINIGAME_PUZZLE_OVER = 7
MINIGAME_CAR_PATH_OVER = 8
MINIGAME_HEXAGON_OVER = 9
MINIGAME_MATH_COMBINATION_OVER = 10
MINIGAME_MEMORY_SEQUENCE_OVER = 11

// General achievements (12-20)
CHALLENGE_WIN_TIMES = 12
ALL_ROUNDER = 13
PRECISION = 14
TESTS_20 = 15
TESTS_100 = 16
CHALLENGE_POINT_OVER = 17
OVER_1000 = 18
WEEKLY_TOP = 19
IPHONE_PLAYER = 20
```

### 7.2 Achievement Thresholds
```actionscript
THRESHOLD_WEIGHT_OVER = 650
THRESHOLD_CUBE_COUNT_OVER = 650
THRESHOLD_SHAPE_ORDER_OVER = 650
THRESHOLD_CARD_PAIR_OVER = 650
THRESHOLD_CALCULATE_OVER = 650
THRESHOLD_MISSING_SIGN_OVER = 650
THRESHOLD_METEOR_OVER = 650
THRESHOLD_PUZZLE_OVER = 650
THRESHOLD_CAR_PATH_OVER = 650
THRESHOLD_HEXAGON_OVER = 650
THRESHOLD_MATH_COMBINATION_OVER = 650
THRESHOLD_MEMORY_SEQUENCE_OVER = 650
THRESHOLD_ALL_ROUNDER = 500      // 500+ on ALL games
THRESHOLD_PRECISION = 2600       // 2600+ with 0 errors
THRESHOLD_TESTS_20 = 20
THRESHOLD_TESTS_100 = 100
THRESHOLD_OVER_1000 = 1000       // 1000+ on any game
THRESHOLD_CHALLENGE_WIN_TIMES = 10
THRESHOLD_CHALLENGE_POINTS_OVER = 1000
```

---

## 8. Individual Game Rules

### 8.1 Calculate (Missing Number)
**Rules**: Solve arithmetic equations (e.g., "5 + ? = 12")
```actionscript
// Difficulty scaling
difficulty = Math.floor(totalCorrect / 3.5);
// Numbers range: 1 to min(10 + difficulty*3, 99)

// Operators used
SIGN_PLUS = 0, SIGN_MINUS = 1, SIGN_MULTIPLY = 2, SIGN_DIVIDE = 3

// Complex equations (at higher difficulty, odd rounds)
if (difficulty >= 3 && totalCorrect % 2 == 1) {
    // Nested operations like (3 + 2) * ? = 20
    element.element1.setSign(Engine.rnd(0, NUM_SIGNS - 1));
}
```

### 8.2 MatchCard (Card Pairs)
**Rules**: Memory matching game
```actionscript
// Pairs increase with rounds
numPairs = 2 + Math.floor(round / 2);  // Max 5 pairs
numSwaps = Math.floor(round / 3);       // Cards swap positions!

// Card types
EASY: red, blue, green, yellow, grey (colors)
HARD: circle, square, star, triangle, dots (shapes)

// Reveal time before hide
startRevealDelay = 2000ms;
```

### 8.3 MissingSign
**Rules**: Find the missing operator (+, -, ×, ÷)
```actionscript
// Format: "3 ? 2 = 5" → answer is "+"
// Difficulty increases equation complexity
```

### 8.4 CubeCounter
**Rules**: Count 3D cubes in an isometric view
```actionscript
// Difficulty scaling
difficulty = Math.floor(totalCorrect / 1.5);
baseWidth = Engine.rnd(2, 5 + Math.floor(difficulty / 8));  // 2-5+ base
maxHeight = Engine.rnd(3, 5);  // Up to 4 blocks high
numBlocks = Math.min(Engine.rnd(2, 6) + difficulty, baseWidth^2 * maxHeight);

// Isometric view - must count hidden cubes!
// Alternating color patterns make counting harder
// Input via on-screen numeric keypad
```

### 8.5 WeightGame (Balance Scale)
**Rules**: Determine which object is heaviest from scale comparisons
```actionscript
// Difficulty scaling
numScales = Math.min(1 + Math.floor(totalCorrect / 8), 4);  // 1-4 scales
numItems = numScales + 1 + extraItems;  // Items to deduce from

// At round 4+: May have EQUAL weight items (traps!)
// At round 3+: May have multiple items per scale side (up to 3)

// Item groups (visual themes)
NORMAL_GROUP_INDICES = [0,1,2,3,4,6];  // Shapes0-6
EASTER_GROUP_INDEX = 5;  // Special Easter items
```

### 8.6 MeteorSequence (Asteroids)
**Rules**: Click floating meteors in ascending order
```actionscript
// Difficulty scaling
numMeteors = Math.min(3 + Math.floor(totalCorrect / 4), 6);
maxNumber = Math.min(15 + totalCorrect * 5, 100);
rotationSpeed = Math.min(1 + Math.floor(totalCorrect / 4), 5);

// At round 2 (25% chance): Shows LETTERS (A-Z) instead of numbers!
// At round 6+: Shows NUMBER WORDS ("THREE", "FIVE") instead of digits
// Localized words for 12 languages (NUMBERS_TEXT dictionary)
// Meteors BOUNCE off each other (physics simulation!)
```

### 8.7 JigsawMatch
**Rules**: Match jigsaw pieces to their outlines
```actionscript
// Drag pieces to matching holes
// Rotation may be required
```

### 8.8 MathCombination (PRO)
**Rules**: Select numbers that sum to target
```actionscript
// Given numbers, select subset that equals target
// E.g., target=15, numbers=[3,5,7,8,12] → select 3+5+7
```

### 8.9 SequenceMatch (Hex Path) (PRO)
**Rules**: Match sequences on a hexagon grid
```actionscript
// 37 difficulty levels! Grid grows and sequences get longer
DIFFICULTY_LEVEL_PARAMS = [
    { numRows:3, numColumes:2, numSequences:1, sequenceLength:2 },
    { numRows:3, numColumes:3, numSequences:1, sequenceLength:2 },
    { numRows:3, numColumes:3, numSequences:1, sequenceLength:3 },
    // ... progresses to max:
    { numRows:7, numColumes:10, numSequences:4, sequenceLength:6 }
];
// Click hexagons to form the displayed sequences
// Can match forward OR backward (both valid!)
```

### 8.10 MemorySequence (PRO)
**Rules**: Simon-says style memory game
```actionscript
// Difficulty scaling
layoutNum = Engine.rnd(Math.min(Math.floor(totalCorrect / 2), 8),
                        Math.min(2 + Math.floor(totalCorrect / 2), 10));
// 10 different switch layouts (SwitchLayout0-9)

sequenceLength = 3 + Math.floor((totalCorrect + 1) / 3);  // Grows with rounds
sequenceDelay = Math.max(500 - totalCorrect * 15, 300);   // Gets faster!

// 5 switch visual types (Switch0-4)
// Switches light up in sequence, repeat the pattern
// No repeat of same switch 3x in a row
```

### 8.11 CarPath (PRO)
**Rules**: Predict where the car ends up
```actionscript
// 28 difficulty levels!
DIFFICULTY_LEVEL_PARAMS = [
    { numCars:1, numPath:2, numCrossPath:2, maxCrossPathWidth:2, pathSegments:2 },
    { numCars:1, numPath:3, numCrossPath:2, maxCrossPathWidth:1, pathSegments:2 },
    // ... progresses to:
    { numCars:4, numPath:8, numCrossPath:16, maxCrossPathWidth:3, pathSegments:4 }
];
// numCars = how many cars to track simultaneously
// numPath = number of possible destinations
// numCrossPath = number of path intersections
// Cars turn at every junction - track mentally!
```

### 8.12 ShapeOrder
**Rules**: Remember and reproduce shape sequence
```actionscript
// Detailed difficulty progression (15 levels)
DIFFICULTY_LEVEL_PARAMS = [
    { numIcons:3, difficultShapes:false, extraChoosePanels:1, speedMutiplyer:1.2 },
    { numIcons:3, difficultShapes:false, extraChoosePanels:2, speedMutiplyer:1.4 },
    { numIcons:4, difficultShapes:false, extraChoosePanels:1, speedMutiplyer:1.4 },
    { numIcons:4, difficultShapes:false, extraChoosePanels:2, speedMutiplyer:1.6 },
    { numIcons:5, difficultShapes:false, extraChoosePanels:1, speedMutiplyer:1.6 },
    { numIcons:5, difficultShapes:true,  extraChoosePanels:2, speedMutiplyer:1.8 },
    { numIcons:6, difficultShapes:false, extraChoosePanels:1, speedMutiplyer:1.8 },
    { numIcons:6, difficultShapes:false, extraChoosePanels:2, speedMutiplyer:2.0 },
    // ... continues to max 8 icons
];
// difficultShapes = sushi set (more similar-looking)
// extraChoosePanels = decoy options
```

---

## 9. Data Structures

### 9.1 UserInfo
```actionscript
class UserInfo {
    id: NetworkUid
    firstName: String
    fullName: String
    imageUrl: String
    highScore: int
    challengesScore: int
    challengesWon: int
    challengesLost: int
    challengesTied: int
    playCount: int
    achievementMask: uint  // Bitmask for 21 achievements
    friendRank: int
    worldRank: int
    bestCategory: int
    isProUser: Boolean
}
```

### 9.2 Protected Values (Anti-Cheat)
```actionscript
// GameWorld protected values
PROTECTED_VALUE_CATEGORY_SCORE_1 = 0  // Score for category 0
PROTECTED_VALUE_CATEGORY_SCORE_2 = 1
PROTECTED_VALUE_CATEGORY_SCORE_3 = 2
PROTECTED_VALUE_CATEGORY_SCORE_4 = 3
PROTECTED_VALUE_TIMER = 4             // Current timer value

// Each minigame has:
PROTECTED_TOTAL_CORRECT = 0
PROTECTED_TOTAL_INCORRECT = 1
```

### 9.3 Minigame Aggregate Scores
```actionscript
minigameAggregateScores = [
    { type: 5, bestScore: 0, totalScore: 0, playCount: 0 },
    { type: 4, bestScore: 0, totalScore: 0, playCount: 0 },
    // ... for all 12 games
]
```

---

## 10. Sound System

### 10.1 Sound Assets
| File | Usage |
|------|-------|
| ThemeMusic.mp3 | Main menu background |
| IngameMusic.mp3 | During gameplay |
| ButtonInGame.mp3 | Button clicks in-game |
| ButtonMenu.mp3 | Menu button clicks |
| TimerSound.mp3 | Countdown warning (last 10s) |
| StartSound.mp3 | Game start |
| ApplauseSound.mp3 | Victory/high score |
| CrowdCheerSound.mp3 | Summary screen |
| ScoreCountSound.mp3 | Score counting up |
| ScoreCountEndSound.mp3 | Score count complete |

### 10.2 Sound Trigger Points
```actionscript
// Menu open
Engine.playSound("ThemeMusic", -1);  // Loop

// Game countdown complete
Engine.playSound("StartSound", 1);
Engine.playSound("IngameMusic", -1);

// Last 10 seconds
Engine.playSound("TimerSound", 1);  // Each second

// Correct answer
// (visual feedback only - no dedicated sound)

// Time up
Engine.stopSound("IngameMusic");

// Summary screen
Engine.playSound("CrowdCheerSound", 1);
Engine.playSound("ApplauseSound", 1);
```

---

## 11. Animation System

### 11.1 Key Animation Classes
```actionscript
// Frame-based animations
CountDown - 78 frames → frame79 stop
Correct - 10 frames → frame10 stop
Wrong - 13 frames → frame13 stop
TimesUp - 75 frames → frame75 stop

// Loop animations
FrameGameShow - menu_start/idle/zoomin/zoomout states
SummaryScene - Multiple labeled states for brain reveal
```

### 11.2 Frame Script Pattern
```actionscript
// Typical pattern in MovieClips
addFrameScript(targetFrame, function():void {
    stop();  // or gotoAndPlay("labelName")
});
```

---

## 12. UI Constants

### 12.1 Stage & Canvas Dimensions (Engine.as)
```actionscript
// Stage (full flash movie)
STAGE_WIDTH = 640
STAGE_HEIGHT = 700  // Full height including UI chrome
GAME_VERSION = "2.6.7"

// Game canvas (playable area - from GameWorld)
CANVAS_WIDTH = 640
CANVAS_HEIGHT = 480
CANVAS_CENTER_X = 320
CANVAS_CENTER_Y = 240
```

### 12.2 High Score Panel
```actionscript
NUM_TOP_SCORES = 10
NUM_CACHED_SCROLLABLE_FRIEND_SCORES = varies by context
```

---

## 13. External Dependencies

### 13.1 Facebook Integration
- Full Facebook SDK included (com/facebook/*)
- Social features: friends, challenges, feed posts
- Photo sharing for scores

### 13.2 Playfish Platform
- com/playfish/coretech/* - Core engine
- com/playfish/rpc/* - RPC client for backend
- com/playfish/feed/* - Feed templates

### 13.3 Ad Networks
- DoubleClick (DartShell)
- MochiAd

---

## 14. Localization

### 14.1 Supported Languages (12 Primary)
Defined in `LanguageTranslation.as`:
| Language | Code | Notes |
|----------|------|-------|
| English | ENGLISH | Default |
| Spanish | ESPAÑOL | |
| French | FRANÇAIS | |
| German | DEUTSCH | |
| Italian | ITALIANO | |
| Portuguese | PORTUGUÊS | |
| Dutch | NEDERLANDS | |
| Swedish | SVENSKA | |
| Norwegian | NORSK | |
| Finnish | SUOMI | |
| Polish | POLSKI | |
| Greek | ΕΛΛΗΝΙΚΑ | Special font handling |

### 14.2 Localized Content
- **Game Instructions**: All 12 minigame tutorials
- **Brain Type Names**: 32 brain types translated
- **Brain Type Descriptions**: Flavor text for each brain type
- **UI Strings**: Buttons, menus, messages
- **Number Words**: 0-10 as words (for MeteorSequence)

### 14.3 Font Handling
```actionscript
// Special handling for Greek (el) - uses Arial Black
// Chinese (CS/CT) - uses system Arial, no embed
// Others - embedded fonts
Engine.setFontForLang(textField:TextField, fontName:String)
```

---

## 15. Utility Classes

### 15.1 RandomBasket (Random Selection Without Replacement)
```actionscript
// com/playfish/games/whohasthebiggestbrain/utils/RandomBasket.as
class RandomBasket {
    var basket:Array;
    
    // Constructor can initialize with range
    RandomBasket(start:int, end:int)  // Fills basket with start..end-1
    
    // Get random item and REMOVE it from basket
    getNextItem():Object
    
    // Add/remove items
    addItems(...items)
    addItemArray(arr:Array)
    removeItems(...items)
    
    // Clone for backtracking
    clone():RandomBasket
}
// Used extensively for non-repeating random selection
```

### 15.2 Preferences (Local Storage)
```actionscript
// Uses SharedObject for persistence
class Preferences {
    static const SOUND:int = 0;
    static const QUALITY:int = 1;
    static const LANGUAGE:int = 2;
    static const PROGAME_SELECTION:int = 3;
    
    static var values:Array = [true, true, "en", null];
    
    static function load():void  // From SharedObject("brainPreferences")
    static function save(index:int = -1):void
}
```

### 15.3 GameObject Animation System
```actionscript
// Base game object with tweening
class GameObject extends Sprite {
    var speedX:Number, speedY:Number;
    var tweenType:uint;  // NONE, MOTION_TIME, MOTION_SPEED, ALPHA, SHAPE
    
    // Movement with easing
    tween(destX, destY, timeMs, ease)
    tweenMotionSpeed(destX, destY, speed, decel)
}

// Animated MovieClip wrapper
class AnimatedSprite extends Sprite {
    var mc:MovieClip;
    var numLoops:int;  // -1 = infinite
    var frameDelay:int = 40;  // ms per frame
    
    tickAnimation(timeDelta)  // Call each frame
    setAnimation(name, loops)
    manipulate(FLIP_HORIZONTAL | FLIP_VERTICAL | ROTATE_90...)
}
```

---

## 16. RPC Backend API

### 16.1 API Endpoints (RpcClient.as)
```actionscript
// Score submission
uploadScore(gameType, minigameScores[], checksum)
uploadPracticeScore(minigameScore)
uploadChallengeScore(challengeId, score, gameType, completed)

// User data
getUserInfo() → UserInfo + region
getScores(context, timeContext, gameType, includeMe, limit)
getHistoricScores() → Array<HistoricScore>

// Challenges
createChallenge(targetUserId, games[]) → challengeId, seed0, seed1
acceptChallenge(challengeId) → seed0, seed1
rejectChallenge(challengeId)
getPendingChallenges() → Array<PendingChallenge>

// Social
getChallengeFriends() → Array<UserInfo>
sendGloat(gloatId, message, targetUserId)
getGloatList() → Array<Gloat>

// Achievements
addAchievements(achievementMask) → newAchievements
```

### 16.2 Context Constants
```actionscript
USER_CONTEXT_ALL = 1
USER_CONTEXT_FRIENDS = 2
USER_CONTEXT_CHALLENGE_ALL = 5
USER_CONTEXT_CHALLENGE_FRIENDS = 6
USER_CONTEXT_CHALLENGE_REGION = 7

TIME_CONTEXT_ALL = 0
TIME_CONTEXT_WEEK = 16
TIME_CONTEXT_MONTH = 32
```

---

## 17. File Summary

| Type | Count | Size |
|------|-------|------|
| Core game logic | 45 files | ~400 KB |
| Minigames | 12 files | ~200 KB |
| UI components (brain_game_fla) | 200+ files | ~50 KB |
| Utility classes | 15 files | ~30 KB |
| Facebook SDK | 300+ files | ~200 KB |
| Playfish coretech | 50+ files | ~100 KB |
| RPC/networking | 25 files | ~80 KB |
| Total AS files | 919 | ~1.2 MB |
| Sprite assets | 6,791 | - |
| Images | 16 | - |
| Sounds | 15 | - |
| Fonts | 10 | - |

---

*Generated from decompiled ActionScript 3.0 source*
*Original game: "Who Has The Biggest Brain?" by Playfish (EA)*
*SWF Version: 2.6.7*
