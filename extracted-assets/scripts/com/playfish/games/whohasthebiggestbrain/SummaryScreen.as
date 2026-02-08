package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class SummaryScreen extends BaseWorld
   {
      
      public static const SPEEDER_CHEAT:String = "cheat2";
      
      public static const MEMORY_MOD_CHEAT:String = "cheat0";
      
      public static const MATH_SCORE_CHEAT:String = "cheat1";
      
      public static const MATH_SCORE_CHEAT_THRESHOLD:int = 2500;
       
      
      internal var activeOverlay:OverlayConfirm;
      
      internal const STATE_SHOW_CHART_END:* = 4;
      
      internal const STATE_SHOW_CHART:* = 3;
      
      internal var summaryScene:SummaryScene;
      
      internal const SCORE_COUNT_SPEED:int = 500;
      
      internal var showResultScreen:Boolean;
      
      internal var state:int;
      
      internal var combinedScore:int;
      
      internal var brainY:int;
      
      internal const STATE_END_SPEECH_1:* = 6;
      
      internal const STATE_END_SPEECH_2:* = 7;
      
      internal const STATE_END_SPEECH_3:* = 8;
      
      internal var brainX:int;
      
      internal var speechTextStep:int;
      
      internal var speechText:SpeechTextObject;
      
      internal var curScore:int = -1;
      
      internal var skipButton:MovieClip;
      
      internal var profileChart:ProfileChart;
      
      internal var uploadScoreDone:Boolean = false;
      
      internal const STATE_START_IDLE:* = 1;
      
      internal var timer:int;
      
      internal var brainType:int;
      
      internal const STATE_SHOW_ACHIEVEMENT:* = 2;
      
      internal var brainTypeSpriteState:Array;
      
      internal var scoreText:String;
      
      internal var lastBrainTypeSprite:MovieClip;
      
      internal var brainTypeSprites:Array;
      
      internal const STATE_ADD_SCORE:* = 5;
      
      internal var curCategoryScoreIndex:int;
      
      internal var feedButton:MovieClip;
      
      internal const STATE_START:* = 0;
      
      internal const STATE_FADE_OUT:* = 9;
      
      internal var playCrowdCheerSound:Boolean = false;
      
      internal var cheatDetected:Boolean = false;
      
      internal var BrainNames:Array;
      
      public function SummaryScreen()
      {
         this.brainTypeSpriteState = new Array();
         this.brainTypeSprites = new Array();
         this.BrainNames = [{"name":LanguageTranslation.getAmoebaNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getEarthwormNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getSnailNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getRatNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getCatNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getDogNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getGoatNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getChimpNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getGorillaNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getMissingLinkNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getNeanderthalNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getAverageJoeNameText(LanguageButton.currentLanguage)},{"name":"GEEK"},{"name":"NERD"},{"name":LanguageTranslation.getScholarNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getScientistNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getGeniusNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getSpaceAceNameText(LanguageButton.currentLanguage)},{"name":"CYBORG"},{"name":"ALIEN"},{"name":"SQUIDLIAN"},{"name":"BITBOT"},{"name":"SPACEBOT"},{"name":"CALCUBOT"},{"name":"ENCEPHALOBOT"},{"name":"BRAINBOT"},{"name":"NEUROBOT"},{"name":"COMPUTRON"},{"name":"XENOS"},{"name":"NEURONIAN"},{"name":"AEONIAN"},{"name":"GALAXION"}];
         super();
         ++GameWorld.numberRoundsPlayed;
         summaryScene = new SummaryScene();
         summaryScene.x = GameWorld.CANVAS_CENTER_X;
         summaryScene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(summaryScene);
         combinedScore = 0;
         var _loc1_:* = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
         {
            combinedScore += GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + _loc1_);
            _loc1_++;
         }
         GameWorld.totalScores = combinedScore;
         GameWorld.entireHighScore + combinedScore;
         GameWorld.playCountNew + 1;
         showResultScreen = true;
         scoreText = LanguageTranslation.getScoreText1(LanguageButton.currentLanguage);
         playCrowdCheerSound = true;
         brainType = GameWorld.getBrainType(combinedScore);
         if(!GameWorld.protectedValues.checkAllValues() || GameWorld.memoryModificationCheatDetected)
         {
            trace("==>CHEAT:" + "memory:" + GameWorld.memoryModificationCheatDetected);
            cheatDetected = true;
            GameWorld.rpcClient.recordGameEvent(RpcClient.GAME_EVENT_DEBUG,MEMORY_MOD_CHEAT,GameWorld.dummy,GameWorld.dummy);
         }
         if(!cheatDetected)
         {
            GameWorld.clearHighscoreCaches();
            GameWorld.highScorePanel.setTab(HighScorePanel.TAB_FRIEND_SCORES,HighScorePanel.SUB_TAB_MONTHLY);
            uploadScoreDone = false;
         }
         skipButton = new ButtonContinue();
         skipButton.x = -30;
         skipButton.y = GameWorld.CANVAS_HEIGHT / 2 - skipButton.height - 25;
         skipButton.text.text = LanguageTranslation.getContinueButtonText(LanguageButton.currentLanguage);
         Engine.setFontForLang(skipButton.text,"Arnold 2.1");
         Engine.setFontSize(skipButton.text,16,"EL",14);
         setButtonMode(skipButton,true);
         summaryScene.addChild(skipButton);
         skipButton.addEventListener(MouseEvent.CLICK,skipButtonDownListener,false,0,true);
         setButtonVisibility(false);
         speechText = new SpeechTextObject(summaryScene.speechTextField.speechText);
         speechText.addString(LanguageTranslation.getSumUpText(LanguageButton.currentLanguage));
         setProfessorState("ProfessorHappy");
         Engine.playSound("ThemeMusic",0);
         Engine.playSound("ApplauseSound",1);
         Engine.playSound("CrowdCheerSound",1);
      }
      
      public static function getChallengeFriendsFail() : *
      {
         trace("get challenge Friends fail");
      }
      
      public static function getUserInfoOK(param1:UserInfo, param2:String) : *
      {
         GameWorld.setCurrentUserInfo(param1);
      }
      
      public static function getUserInfoFail() : *
      {
      }
      
      public static function getChallengeFriendsSuccess(param1:Array) : *
      {
         trace("get challenge Friends Success");
         GameWorld.friendsInfo = new Array();
         GameWorld.friendsInfo = param1;
         trace(param1);
      }
      
      private function setButtonVisibility(param1:Boolean) : void
      {
         skipButton.visible = param1;
         if(feedButton != null)
         {
            feedButton.visible = param1;
         }
      }
      
      public function achievementFail() : *
      {
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:Number = Number(NaN);
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(lastBrainTypeSprite != null)
         {
            lastBrainTypeSprite.scaleX += 0.1;
            lastBrainTypeSprite.scaleY = lastBrainTypeSprite.scaleX;
            lastBrainTypeSprite.alpha -= 0.1;
            if(lastBrainTypeSprite.alpha <= 0)
            {
               summaryScene.removeChild(lastBrainTypeSprite);
               lastBrainTypeSprite = null;
            }
         }
         if(speechText != null)
         {
            speechText.tick(param1);
         }
         if(state == STATE_START)
         {
            if(summaryScene.currentLabel == "start_idle")
            {
               state = STATE_START_IDLE;
            }
         }
         else if(state == STATE_START_IDLE)
         {
            if(activeOverlay == null)
            {
               if(!uploadScoreDone || cheatDetected)
               {
                  AchievementHandler.pendingAchievements = 0;
               }
               AchievementHandler.showPendingAchievement(this);
               state = STATE_SHOW_ACHIEVEMENT;
            }
         }
         else if(state == STATE_SHOW_ACHIEVEMENT)
         {
            if(AchievementHandler.pendingAchievements == 0)
            {
               summaryScene.gotoAndPlay("showchart");
               profileChart = new ProfileChart(summaryScene,summaryScene.chart,[GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1),GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_2),GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_3),GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_4)]);
               brainX = summaryScene.chart.x;
               brainY = summaryScene.chart.y;
               setButtonVisibility(true);
               state = STATE_SHOW_CHART;
            }
         }
         else if(state == STATE_SHOW_CHART)
         {
            profileChart.tick();
         }
         else if(state == STATE_SHOW_CHART_END)
         {
            if(summaryScene.currentLabel == "addscore")
            {
               profileChart = null;
               Engine.playSound("ScoreCountSound",0);
               state = STATE_ADD_SCORE;
            }
         }
         else if(state == STATE_ADD_SCORE)
         {
            _loc2_ = Math.max(1,summaryScene.brain.scaleX);
            _loc3_ = brainTypeSprites.length - 1;
            while(_loc3_ >= 0)
            {
               if(brainTypeSpriteState[_loc3_] == 0)
               {
                  brainTypeSprites[_loc3_].scaleX += 0.1;
                  if(brainTypeSprites[_loc3_].scaleX >= _loc2_)
                  {
                     brainTypeSprites[_loc3_].scaleX = _loc2_;
                     if(_loc3_ != brainTypeSprites.length - 1)
                     {
                        brainTypeSpriteState[_loc3_] = 1;
                     }
                  }
                  brainTypeSprites[_loc3_].scaleY = brainTypeSprites[_loc3_].scaleX;
                  brainTypeSprites[_loc3_].alpha = brainTypeSprites[_loc3_].scaleX;
               }
               else if(brainTypeSpriteState[_loc3_] == 1)
               {
                  brainTypeSprites[_loc3_].scaleX -= 0.1;
                  if(brainTypeSprites[_loc3_].scaleX <= 0)
                  {
                     brainTypeSprites.splice(_loc3_,1);
                     brainTypeSpriteState.splice(_loc3_,1);
                  }
                  else
                  {
                     brainTypeSprites[_loc3_].scaleY = brainTypeSprites[_loc3_].scaleX;
                     brainTypeSprites[_loc3_].alpha = brainTypeSprites[_loc3_].scaleX;
                  }
               }
               _loc3_--;
            }
            if(curScore < combinedScore)
            {
               _loc4_ = curScore;
               curScore += SCORE_COUNT_SPEED * param1 / 1000;
               curScore = Math.min(curScore,combinedScore);
               _loc5_ = GameWorld.BRAIN_TYPE_SCORE_RANGE.length;
               summaryScene.brain.scaleX = 0.6 + (2 - 0.6) * Math.min(1,curScore / GameWorld.BRAIN_TYPE_SCORE_RANGE[_loc5_ - 1]);
               summaryScene.brain.scaleY = summaryScene.brain.scaleX;
               _loc3_ = 0;
               while(_loc3_ < _loc5_)
               {
                  if(_loc4_ < GameWorld.BRAIN_TYPE_SCORE_RANGE[_loc3_] && curScore >= GameWorld.BRAIN_TYPE_SCORE_RANGE[_loc3_])
                  {
                     addBrainTypeSprite(_loc3_,summaryScene.brain.x,summaryScene.brain.y);
                     break;
                  }
                  _loc3_++;
               }
               summaryScene.score.text = "" + curScore;
            }
            if(curScore == combinedScore && brainTypeSprites[0].currentFrame == brainType + 1 && brainTypeSprites[0].scaleX == _loc2_)
            {
               speechText.reset();
               speechText.addString(LanguageTranslation.getBrainTypeText1(LanguageButton.currentLanguage) + combinedScore + LanguageTranslation.getBrainTypeText2(LanguageButton.currentLanguage) + BrainNames[brainType].name + LanguageTranslation.getBrainTypeText3(LanguageButton.currentLanguage));
               lastBrainTypeSprite = new BrainTypeSprite();
               lastBrainTypeSprite.gotoAndStop(brainType + 1);
               lastBrainTypeSprite.x = summaryScene.brain.x;
               lastBrainTypeSprite.y = summaryScene.brain.y;
               lastBrainTypeSprite.scaleX = summaryScene.brain.scaleX;
               lastBrainTypeSprite.scaleY = summaryScene.brain.scaleY;
               summaryScene.addChild(lastBrainTypeSprite);
               setButtonVisibility(true);
               Engine.stopSound("ScoreCountSound");
               Engine.playSound("ScoreCountEndSound",1);
               state = STATE_END_SPEECH_1;
            }
         }
         else if(state != STATE_END_SPEECH_1)
         {
            if(state != STATE_END_SPEECH_2)
            {
               if(state != STATE_END_SPEECH_3)
               {
                  if(state == STATE_FADE_OUT)
                  {
                     if(summaryScene.currentFrame == summaryScene.totalFrames)
                     {
                        trace("--SummaryScreen--");
                        if(!cheatDetected && GameWorld.friendsInfo.length > 0 && uploadScoreDone)
                        {
                           trace("--ResultScreen--");
                           _loc6_ = new ResultScreen();
                           Engine.setActiveWorld(_loc6_);
                        }
                        else if(WorldAdvert.isAdReady())
                        {
                           Engine.setActiveWorld(new WorldAdvert());
                        }
                        else
                        {
                           WorldAdvert.destroyAd();
                           GameWorld.addGameShowFrame("menu_start");
                           GameWorld.startMainMenu();
                           Engine.playSound("ApplauseSound",1);
                        }
                        GameWorld.highScorePanel.showScores(GameWorld.highScorePanel.getContext());
                     }
                     return;
                  }
               }
            }
         }
      }
      
      public function scoreUploadCancel() : *
      {
         activeOverlay = null;
      }
      
      private function skipButtonDownListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         if(state == STATE_SHOW_CHART)
         {
            setButtonVisibility(false);
            summaryScene.gotoAndPlay("showchart_end");
            setProfessorState("ProfessorTalk");
            state = STATE_SHOW_CHART_END;
         }
         else if(state == STATE_END_SPEECH_1)
         {
            startState(STATE_END_SPEECH_2);
         }
         else if(state == STATE_END_SPEECH_2)
         {
            startState(STATE_END_SPEECH_3);
         }
         else if(state == STATE_END_SPEECH_3)
         {
            startState(STATE_FADE_OUT);
         }
      }
      
      public function uploadScore() : *
      {
         var minigameScore:MinigameScore = null;
         var minigameScores:Array = new Array();
         var i:* = 0;
         while(i < MinigameDefines.NUM_MINIGAME_CAT)
         {
            minigameScore = new MinigameScore(GameWorld.curCategoryMinigameType[i],GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + i));
            minigameScores[i] = minigameScore;
            trace("--SummaryScreen.uploadScore()--");
            trace(minigameScore.toString());
            i++;
         }
         try
         {
            GameWorld.rpcClient.beginBatch(RpcClient.BATCHMODE_CONDITIONAL);
            if(AchievementHandler.pendingAchievements != 0)
            {
               GameWorld.rpcClient.addAchievements(AchievementHandler.pendingAchievements,AchievementHandler.achievementOK,achievementFail);
            }
            GameWorld.rpcClient.uploadScore(combinedScore,minigameScores,0,scoreUploadOK,scoreUploadFail);
            GameWorld.rpcClient.getUserInfo(getUserInfoOK,getUserInfoFail);
            GameWorld.rpcClient.getChallengeFriends(getChallengeFriendsSuccess,getChallengeFriendsFail);
            GameWorld.getHighScores(RpcClient.USER_CONTEXT_FRIENDS,RpcClient.TIME_CONTEXT_MONTH,false);
            GameWorld.rpcClient.getScores(1,0,0,false,RpcClient.USER_CONTEXT_FRIENDS | RpcClient.TIME_CONTEXT_WEEK,GameWorld.weeklyTopScoreOK,GameWorld.weeklyTopScoreFail);
            GameWorld.rpcClient.endBatch();
         }
         catch(e:Error)
         {
         }
         activeOverlay = new OverlayConfirm(this,"Uploading score...",null,null,new UploadingScorePopUp());
      }
      
      public function achievementOK(param1:uint) : *
      {
      }
      
      public function scoreUploadOK(param1:Boolean) : *
      {
         cheatDetected = !param1;
         uploadScoreDone = true;
         activeOverlay.end();
         activeOverlay = null;
         trace("scoreUploadOK cheatDetected=" + cheatDetected + " success=" + param1);
         trace("==>CHEAT:" + "upload:" + param1);
      }
      
      public function achievementPopupConfirm() : *
      {
         activeOverlay = null;
      }
      
      public function showResultBrainTypeTxt(param1:int) : *
      {
         if(param1 == 0)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getAmoebaText(LanguageButton.currentLanguage));
         }
         else if(param1 == 1)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getEarthwormText(LanguageButton.currentLanguage));
         }
         else if(param1 == 2)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getSnailText(LanguageButton.currentLanguage));
         }
         else if(param1 == 3)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getRatText(LanguageButton.currentLanguage));
         }
         else if(param1 == 4)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getCatText(LanguageButton.currentLanguage));
         }
         else if(param1 == 5)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getDogText(LanguageButton.currentLanguage));
         }
         else if(param1 == 6)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getGoatText(LanguageButton.currentLanguage));
         }
         else if(param1 == 7)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getChimpText(LanguageButton.currentLanguage));
         }
         else if(param1 == 8)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getGorillaText(LanguageButton.currentLanguage));
         }
         else if(param1 == 9)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getMissingLinkText(LanguageButton.currentLanguage));
         }
         else if(param1 == 10)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getNeanderthalText(LanguageButton.currentLanguage));
         }
         else if(param1 == 11)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getAverageJoeText(LanguageButton.currentLanguage));
         }
         else if(param1 == 12)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getGeekText(LanguageButton.currentLanguage));
         }
         else if(param1 == 13)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getNerdText(LanguageButton.currentLanguage));
         }
         else if(param1 == 14)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getScholarText(LanguageButton.currentLanguage));
         }
         else if(param1 == 15)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getScientistText(LanguageButton.currentLanguage));
         }
         else if(param1 == 16)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getGeniusText(LanguageButton.currentLanguage));
         }
         else if(param1 == 17)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getSpaceAceText(LanguageButton.currentLanguage));
         }
         else if(param1 == 18)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getCyborgText(LanguageButton.currentLanguage));
         }
         else if(param1 == 19)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getAlienText(LanguageButton.currentLanguage));
         }
         else if(param1 == 20)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getSquidlianText(LanguageButton.currentLanguage));
         }
         else if(param1 == 21)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getBitBotText(LanguageButton.currentLanguage));
         }
         else if(param1 == 22)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getSpaceBotText(LanguageButton.currentLanguage));
         }
         else if(param1 == 23)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getCalcuBotText(LanguageButton.currentLanguage));
         }
         else if(param1 == 24)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getEncephaloBotText(LanguageButton.currentLanguage));
         }
         else if(param1 == 25)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getBrainBotText(LanguageButton.currentLanguage));
         }
         else if(param1 == 26)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getNeuroBotText(LanguageButton.currentLanguage));
         }
         else if(param1 == 27)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getComputronText(LanguageButton.currentLanguage));
         }
         else if(param1 == 28)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getXenosText(LanguageButton.currentLanguage));
         }
         else if(param1 == 29)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getNeuronianText(LanguageButton.currentLanguage));
         }
         else if(param1 == 30)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getAeonianText(LanguageButton.currentLanguage));
         }
         else if(param1 == 31)
         {
            speechText.reset();
            speechText.addString(LanguageTranslation.getGalaxionText(LanguageButton.currentLanguage));
         }
      }
      
      public function startState(param1:int) : *
      {
         var _loc2_:* = undefined;
         if(param1 == STATE_END_SPEECH_2)
         {
            showResultBrainTypeTxt(GameWorld.getBrainType(combinedScore));
         }
         else if(param1 == STATE_END_SPEECH_3)
         {
            speechText.reset();
            if(cheatDetected)
            {
               speechText.addString(LanguageTranslation.getScoreText2(LanguageButton.currentLanguage));
               setProfessorState("ProfessorSad");
            }
            else if(showResultScreen && GameWorld.getUserScoreRank(GameWorld.friendsHiscores,GameWorld.friendsHiscoresRank) == 1)
            {
               playCrowdCheerSound = true;
               speechText.addString(LanguageTranslation.getScoreText3(LanguageButton.currentLanguage));
            }
            else
            {
               speechText.addString(scoreText);
            }
            if(!cheatDetected && playCrowdCheerSound)
            {
               Engine.playSound("ApplauseSound",1);
               Engine.playSound("CrowdCheerSound",1);
               setProfessorState("ProfessorHappy");
            }
         }
         else if(param1 == STATE_FADE_OUT)
         {
            setButtonVisibility(false);
            _loc2_ = 0;
            while(_loc2_ < brainTypeSprites.length)
            {
               summaryScene.removeChild(brainTypeSprites[_loc2_]);
               _loc2_++;
            }
            summaryScene.gotoAndPlay("zoomin2");
            skipButton.removeEventListener(MouseEvent.CLICK,skipButtonDownListener);
            summaryScene.removeChild(skipButton);
            if(feedButton != null)
            {
               summaryScene.removeChild(feedButton);
            }
         }
         this.state = param1;
      }
      
      public function addBrainTypeSprite(param1:int, param2:int, param3:int) : *
      {
         var _loc4_:* = new BrainTypeSprite();
         _loc4_.gotoAndStop(param1 + 1);
         _loc4_.scaleX = 0.1;
         _loc4_.scaleY = 0.1;
         _loc4_.Alpha = 0.1;
         _loc4_.x = param2;
         _loc4_.y = param3;
         summaryScene.addChild(_loc4_);
         brainTypeSprites.push(_loc4_);
         brainTypeSpriteState.push(0);
      }
      
      public function setProfessorState(param1:String) : *
      {
         summaryScene.professor.gotoAndStop(param1);
      }
      
      public function scoreUploadFail() : *
      {
         trace("scoreUploadFail");
         activeOverlay.end();
         activeOverlay = new OverlayConfirm(this,LanguageTranslation.getUploadFailedText(LanguageButton.currentLanguage),uploadScore,scoreUploadCancel);
      }
   }
}
