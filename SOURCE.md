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

### 4.3 Cheat Detection
- **Memory modification**: ChecksumProtectedValues with checksum validation
- **Speed hack**: If game completed in < 62 seconds (60 + 2 buffer), flag as cheat
- **Calculate cheat**: Average answer time < 1 second = cheat

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
Brain types are visual - displayed via `BrainTypeSprite` MovieClip with 32 frames representing different brain sizes.

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
// At difficulty 0: numbers 1-20
// Increases by 10 per level, max 100

// Operators used
SIGN_PLUS = 0, SIGN_MINUS = 1, SIGN_MULTIPLY = 2, SIGN_DIVIDE = 3

// Complex equations (alternating)
if (difficulty > 1 && difficulty % 2 == 1) {
    // Nested operations like (3 + 2) * ? = 20
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
// Shows stacked cubes, count total including hidden ones
// Grid layout with shadows for depth perception
```

### 8.5 WeightGame (Balance Scale)
**Rules**: Determine which object is heaviest/lightest
```actionscript
// Shows balance scales with objects
// Deduce relative weights from tilt direction
```

### 8.6 MeteorSequence (Asteroids)
**Rules**: Click falling meteors in numerical order
```actionscript
// Meteors fall with numbers 1-N
// Click in ascending order before they reach bottom
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
**Rules**: Recreate the shown hexagon path
```actionscript
// Show a path through hexagons
// Reproduce it from memory
```

### 8.10 MemorySequence (PRO)
**Rules**: Repeat action sequences
```actionscript
// Simon-says style: watch sequence, repeat it
// Sequence length increases
```

### 8.11 CarPath (PRO)
**Rules**: Predict where the car ends up
```actionscript
// Shows road network
// Trace path mentally, click destination
```

### 8.12 ShapeOrder
**Rules**: Remember and reproduce shape sequence
```actionscript
// Shows shapes in order
// Click them in the same order from memory
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

### 12.1 Canvas Dimensions
```actionscript
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

### 14.1 Supported Languages
Defined in `LanguageTranslation.as` (168KB file):
- English, Spanish, French, German, Italian
- Portuguese, Dutch, Swedish, Norwegian, Danish
- Finnish, Polish, Turkish, Indonesian
- Chinese (Simplified), Japanese, Korean
- And more...

### 14.2 Language Selection
```actionscript
LanguageButton.currentLanguage  // Current language code
Engine.setFontForLang(textField, "FontName")  // Font per language
```

---

## 15. File Summary

| Type | Count | Size |
|------|-------|------|
| Core game logic | 45 files | ~400 KB |
| Minigames | 12 files | ~200 KB |
| UI components | 200+ files | ~50 KB |
| Facebook SDK | 300+ files | ~200 KB |
| Total AS files | 919 | ~1.2 MB |

---

*Generated from decompiled ActionScript 3.0 source*
*Original game: "Who Has The Biggest Brain?" by Playfish (EA)*
