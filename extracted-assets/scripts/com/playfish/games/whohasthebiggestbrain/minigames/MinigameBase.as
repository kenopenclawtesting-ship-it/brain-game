package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.rpc.brain.*;
   import com.playfish.rpc.share.*;
   import flash.display.*;
   import flash.utils.*;
   
   public class MinigameBase extends BaseWorld
   {
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_CORRECT:int = 1;
      
      public static const STATE_FAIL:int = 2;
      
      public static const STATE_TIMEUP:int = 3;
      
      public static const TOTAL_GAME_TIME:* = Debug.SHORTTIME ? 5000 : 60000;
       
      
      internal var correctMC:MovieClip;
      
      public var gameTimerPrev:int;
      
      internal var timerClock:AnimatedSprite;
      
      public var gameTimerEnabled:Boolean;
      
      internal var startTime:int;
      
      internal var minigame:Minigame;
      
      internal var state:int;
      
      public var minigameIndex:int;
      
      internal var timeUpTimer:int;
      
      internal var restartAfterCorrect:Boolean;
      
      internal var clockBar:Sprite;
      
      internal var countDownMC:MovieClip;
      
      public const NUM_PROTECTED_VALUES:int = 2;
      
      public var protectedValues:ChecksumProtectedValues;
      
      public const PROTECTED_TOTAL_INCORRECT:int = 1;
      
      internal var correctTimer:int;
      
      public const PROTECTED_TOTAL_CORRECT:int = 0;
      
      public function MinigameBase(param1:int, param2:Class)
      {
         super();
         this.minigameIndex = param1;
         GameWorld.protectedValues.setValue(GameWorld.PROTECTED_VALUE_TIMER,TOTAL_GAME_TIME);
         GameWorld.protectedValues.setValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + GameWorld.curCategory,0);
         protectedValues = new ChecksumProtectedValues(NUM_PROTECTED_VALUES);
         gameTimerPrev = TOTAL_GAME_TIME;
         gameTimerEnabled = true;
         minigame = new param2(this);
         minigame.init();
         minigame.restart();
         timerClock = new AnimatedSprite("CountdownTimer");
         timerClock.mouseEnabled = false;
         timerClock.mouseChildren = false;
         timerClock.x = GameWorld.CANVAS_CENTER_X;
         timerClock.y = GameWorld.CANVAS_CENTER_Y;
         updateClockBar();
         startCountDown();
         Engine.resetKeys();
      }
      
      public function getTotalCorrect() : int
      {
         return protectedValues.getValue(PROTECTED_TOTAL_CORRECT);
      }
      
      override public function destroy() : *
      {
         if(correctMC != null)
         {
            correctMC.stop();
         }
         if(countDownMC != null)
         {
            countDownMC.stop();
         }
      }
      
      public function finish() : *
      {
         var _loc1_:uint = 0;
         Engine.stopSound("IngameMusic");
         GameWorld.totalIncorrect += getTotalIncorrect();
         GameWorld.totalScores += getScore();
         if(getScore() > GameWorld.bestMinigameScores[minigameIndex])
         {
            GameWorld.bestMinigameScores[minigameIndex] = getScore();
         }
         if(GameWorld.gameState == GameWorld.GS_FULL_GAME)
         {
            GameWorld.curCategoryMinigameType[GameWorld.curCategory] = minigameIndex;
            ++GameWorld.curCategory;
            if(!protectedValues.checkAllValues() || minigame.protectedValues != null && !minigame.protectedValues.checkAllValues())
            {
               GameWorld.memoryModificationCheatDetected = true;
            }
            if(GameWorld.curCategory >= MinigameDefines.NUM_MINIGAME_CAT)
            {
               awardEndFullGameAchievements();
               awardEndPracticeAchievements();
               GameWorld.removeRestartOverlay();
               Engine.setActiveWorld(new SummaryScreen());
            }
            else
            {
               GameWorld.startCategory(GameWorld.curCategory,GameWorld.curCategoryMinigameType[GameWorld.curCategory]);
            }
            GameWorld.setProfessorState("ProfessorHappy");
         }
         else if(GameWorld.gameState == GameWorld.GS_CHALLENGE)
         {
            trace("------------------------------");
            trace("ChallengeWorld.challengePlayer = " + ChallengeWorld.challengePlayer);
            _loc1_ = 0;
            while(_loc1_ < GameWorld.friendsInfo.length)
            {
               if(NetworkUid.areEqual(ChallengeWorld.challengePlayer.id,GameWorld.friendsInfo[_loc1_].id))
               {
                  ChallengeWorld.challengePlayer.highScore = GameWorld.friendsInfo[_loc1_].highScore;
               }
               _loc1_++;
            }
            trace("ChallengeWorld.challengePlayer = " + ChallengeWorld.challengePlayer);
            if(ChallengeWorld.challengeMode == ChallengeWorld.CHALLENGE_MODE_SELECT && ChallengeWorld._selectGameType == ChallengeWorld.SELECT_GAME_SINGLE)
            {
               awardEndPracticeAchievements();
               awardEndChallengeAchievements();
               Engine.setActiveWorld(new ChallengeSummary());
               ChallengeSummary.setResult(GameWorld.currentUserInfo,ChallengeWorld.challengePlayer,ChallengeWorld.getTotalChallengeScore(ChallengeWorld.miniGameScore),ChallengeWorld.challengerScore);
            }
            else
            {
               trace("minigameIndex == " + minigameIndex);
               GameWorld.curCategoryMinigameType[GameWorld.curCategory] = minigameIndex;
               ++GameWorld.curCategory;
               if(!protectedValues.checkAllValues() || minigame.protectedValues != null && !minigame.protectedValues.checkAllValues())
               {
                  GameWorld.memoryModificationCheatDetected = true;
               }
               if(GameWorld.curCategory >= MinigameDefines.NUM_MINIGAME_CAT)
               {
                  awardEndFullGameAchievements();
                  awardEndPracticeAchievements();
                  awardEndChallengeAchievements();
                  Engine.setActiveWorld(new ChallengeSummary());
                  ChallengeSummary.setResult(GameWorld.currentUserInfo,ChallengeWorld.challengePlayer,ChallengeWorld.getTotalChallengeScore(ChallengeWorld.miniGameScore),ChallengeWorld.challengerScore);
               }
               else
               {
                  trace("GameWorld.curCategoryMinigameType[GameWorld.curCategory] == " + GameWorld.curCategoryMinigameType[GameWorld.curCategory]);
                  trace("GameWorld.curCategory =" + GameWorld.curCategory);
                  GameWorld.startCategory(GameWorld.curCategory,GameWorld.curCategoryMinigameType[GameWorld.curCategory]);
               }
            }
         }
         else
         {
            awardEndPracticeAchievements();
            GameWorld.removeRestartOverlay();
            Engine.setActiveWorld(new WorldSummaryPractice(minigameIndex,GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + GameWorld.curCategory)));
         }
      }
      
      public function startCountDown() : *
      {
         countDownMC = new CountDown();
         countDownMC.x = GameWorld.CANVAS_CENTER_X;
         countDownMC.y = GameWorld.CANVAS_CENTER_Y;
         addChild(countDownMC);
      }
      
      override public function keyUp(param1:int, param2:int) : *
      {
         minigame.keyUp(param1,param2);
      }
      
      public function awardEndFullGameAchievements() : *
      {
         var _loc1_:int = GameWorld.playCount + 1;
         if(_loc1_ >= AchievementHandler.THRESHOLD_TESTS_20)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.TESTS_20);
         }
         if(_loc1_ >= AchievementHandler.THRESHOLD_TESTS_100)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.TESTS_100);
         }
         if(GameWorld.totalScores >= AchievementHandler.THRESHOLD_PRECISION && GameWorld.totalIncorrect == 0)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.PRECISION);
         }
      }
      
      public function getScore() : int
      {
         return GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + GameWorld.curCategory);
      }
      
      public function updateClockBar() : *
      {
         var _loc2_:* = undefined;
         var _loc1_:* = Math.ceil(GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_TIMER) / 1000);
         timerClock.mc.timer.textField.text = "" + _loc1_;
         if(_loc1_ <= 10)
         {
            _loc2_ = Math.ceil(gameTimerPrev / 1000);
            if(_loc1_ != _loc2_)
            {
               timerClock.mc.timer.scaleX = 2;
               timerClock.mc.timer.scaleY = 2;
               Engine.playSound("TimerSound",1);
            }
         }
      }
      
      override public function keyDown(param1:int, param2:int) : *
      {
         minigame.keyDown(param1,param2);
      }
      
      public function correct(param1:Boolean, param2:int, param3:int) : *
      {
         if(state != STATE_TIMEUP)
         {
            this.restartAfterCorrect = param1;
            if(correctMC != null)
            {
               removeChild(correctMC);
            }
            correctMC = new Correct();
            correctMC.mouseEnabled = false;
            correctMC.x = param2;
            correctMC.y = param3;
            addChild(correctMC);
            protectedValues.changeValue(PROTECTED_TOTAL_CORRECT,1);
            correctTimer = 80;
            if(param1)
            {
            }
            state = STATE_CORRECT;
         }
      }
      
      public function awardEndChallengeAchievements() : void
      {
      }
      
      public function fail(param1:Boolean, param2:int, param3:int) : *
      {
         if(state != STATE_TIMEUP)
         {
            this.restartAfterCorrect = param1;
            if(correctMC != null)
            {
               removeChild(correctMC);
            }
            correctMC = new Wrong();
            correctMC.mouseEnabled = false;
            correctMC.x = param2;
            correctMC.y = param3;
            addChild(correctMC);
            protectedValues.changeValue(PROTECTED_TOTAL_INCORRECT,1);
            correctTimer = 80;
            if(param1)
            {
            }
            state = STATE_FAIL;
         }
      }
      
      public function addScore(param1:int) : *
      {
         var _loc2_:* = GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + GameWorld.curCategory);
         var _loc3_:* = Math.max(_loc2_ + param1,0);
         GameWorld.protectedValues.setValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + GameWorld.curCategory,_loc3_);
      }
      
      override public function tick(param1:uint) : *
      {
         var intermission:* = undefined;
         var gameTimer:* = undefined;
         var timeDelta:uint = param1;
         if(countDownMC != null)
         {
            if(countDownMC.currentFrame == countDownMC.totalFrames)
            {
               graphics.clear();
               removeChild(countDownMC);
               countDownMC = null;
               addChild(minigame);
               addChild(timerClock);
               try
               {
                  GameWorld.rpcClient.noteTime();
               }
               catch(e:Error)
               {
               }
               startTime = getTimer();
               Engine.playSound("StartSound",1);
               Engine.playSound("IngameMusic",-1);
               minigame.show();
            }
            return;
         }
         if(gameTimerEnabled)
         {
            timerClock.tickAnimation(timeDelta);
            if(timerClock.mc.timer.scaleX > 1)
            {
               timerClock.mc.timer.scaleX = Math.max(timerClock.mc.timer.scaleX - 0.05,1);
               timerClock.mc.timer.scaleY = timerClock.mc.timer.scaleX;
            }
         }
         minigame.tick(timeDelta);
         if(state != STATE_NORMAL)
         {
            if(state == STATE_CORRECT || state == STATE_FAIL)
            {
               if(correctMC.currentFrame == correctMC.totalFrames)
               {
                  removeChild(correctMC);
                  correctMC = null;
                  if(restartAfterCorrect)
                  {
                     minigame.restart();
                  }
                  state = STATE_NORMAL;
               }
            }
            else if(state == STATE_TIMEUP)
            {
               if(correctMC.currentFrame == correctMC.totalFrames)
               {
                  removeChild(correctMC);
                  correctMC = null;
                  if(GameWorld.gameState == GameWorld.GS_CHALLENGE)
                  {
                     if(ChallengeWorld.miniGameScore != null)
                     {
                        ChallengeWorld.miniGameScore.push(getScore());
                     }
                  }
                  finish();
                  return;
               }
            }
         }
         if(state != STATE_TIMEUP)
         {
            if(gameTimerEnabled)
            {
               gameTimerPrev = GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_TIMER);
               gameTimer = Math.max(gameTimerPrev - timeDelta,0);
               GameWorld.protectedValues.setValue(GameWorld.PROTECTED_VALUE_TIMER,gameTimer);
               updateClockBar();
               if(!GameWorld.isPlayingGame && Math.ceil(GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_TIMER) / 1000) < 10)
               {
                  GameWorld.rpcClient.recordGameEvent(RpcClientBase.GAME_EVENT_IS_PLAYING,null,GameWorld.dummy,GameWorld.dummy);
                  GameWorld.isPlayingGame = true;
               }
               if(gameTimer <= 0)
               {
                  try
                  {
                     GameWorld.rpcClient.noteTime();
                  }
                  catch(e:Error)
                  {
                  }
                  if(getTimer() - startTime >= TOTAL_GAME_TIME + 2000)
                  {
                     GameWorld.speederCheatDetected = true;
                  }
                  if(correctMC != null)
                  {
                     removeChild(correctMC);
                     correctMC = null;
                  }
                  removeChild(timerClock);
                  Engine.stopSound("IngameMusic");
                  minigame.timeup();
                  correctMC = new TimesUp();
                  Engine.setFontForLang(correctMC.timesUpText.textField,"Baveuse");
                  correctMC.timesUpText.textField.text = LanguageTranslation.getTimesUpText(LanguageButton.currentLanguage);
                  correctMC.x = GameWorld.CANVAS_CENTER_X;
                  correctMC.y = GameWorld.CANVAS_CENTER_Y;
                  addChild(correctMC);
                  timeUpTimer = 2000;
                  state = STATE_TIMEUP;
               }
            }
         }
      }
      
      public function getTotalIncorrect() : int
      {
         return protectedValues.getValue(PROTECTED_TOTAL_INCORRECT);
      }
      
      public function awardEndPracticeAchievements() : *
      {
         var _loc1_:* = undefined;
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_CALCULATE] >= AchievementHandler.THRESHOLD_CALCULATE_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_CALCULATE_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_CAR_PATH] >= AchievementHandler.THRESHOLD_CAR_PATH_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_CAR_PATH_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_CUBE_COUNTER] >= AchievementHandler.THRESHOLD_CUBE_COUNT_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_CUBE_COUNT_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_JIGSAW_MATCH] >= AchievementHandler.THRESHOLD_PUZZLE_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_PUZZLE_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_MATCH_CARD] >= AchievementHandler.THRESHOLD_CARD_PAIR_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_CARD_PAIR_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_MATH_COMBINATION] >= AchievementHandler.THRESHOLD_MATH_COMBINATION_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_MATH_COMBINATION_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_MEMORY_SEQUENCE] >= AchievementHandler.THRESHOLD_MEMORY_SEQUENCE_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_MEMORY_SEQUENCE_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_METEOR_SEQUENCE] >= AchievementHandler.THRESHOLD_METEOR_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_METEOR_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_MISSING_SIGN] >= AchievementHandler.THRESHOLD_MISSING_SIGN_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_MISSING_SIGN_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_SEQUENCE_MATCH] >= AchievementHandler.THRESHOLD_HEXAGON_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_HEXAGON_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_SHAPE_ORDER] >= AchievementHandler.THRESHOLD_SHAPE_ORDER_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_SHAPE_ORDER_OVER);
         }
         if(GameWorld.bestMinigameScores[MinigameDefines.MINIGAME_WEIGHT_GAME] >= AchievementHandler.THRESHOLD_WEIGHT_OVER)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.MINIGAME_WEIGHT_OVER);
         }
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            if(GameWorld.bestMinigameScores[_loc1_] >= AchievementHandler.THRESHOLD_OVER_1000)
            {
               AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.OVER_1000);
               break;
            }
            _loc1_++;
         }
         var _loc2_:Boolean = true;
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            if(GameWorld.bestMinigameScores[_loc1_] < AchievementHandler.THRESHOLD_ALL_ROUNDER)
            {
               _loc2_ = false;
               break;
            }
            _loc1_++;
         }
         if(_loc2_)
         {
            AchievementHandler.awardAchievement(GameWorld.achievementMask,AchievementHandler.ALL_ROUNDER);
         }
      }
   }
}
