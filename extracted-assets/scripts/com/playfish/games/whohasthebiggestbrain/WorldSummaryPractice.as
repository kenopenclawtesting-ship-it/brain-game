package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class WorldSummaryPractice extends BaseWorld
   {
       
      
      internal const STATE_ACHIEVEMENT:int = 1;
      
      internal var cheatDetected:Boolean = false;
      
      internal const STATE_SHOW_CHART:int = 2;
      
      internal var scene:MovieClip;
      
      internal var practiceMinigameIndex:int;
      
      internal const SCORE_COUNT_SPEED:int = 125;
      
      internal var practiceMinigameScore:int;
      
      internal var skipButton:MovieClip;
      
      internal const STATE_POST_SCORE_COUNTING:int = 4;
      
      internal var curScore:int;
      
      internal var state:int = 0;
      
      internal var totalScore:int;
      
      internal var speechText:SpeechTextObject;
      
      internal var uploadScoreDone:Boolean = false;
      
      internal const STATE_SCORE_COUNTING:int = 3;
      
      internal const STATE_FADE_OUT:int = 5;
      
      internal var finalTextEffect:MovieClip;
      
      internal var uploadScorePopup:OverlayConfirm;
      
      internal const STATE_INTRO:int = 0;
      
      public function WorldSummaryPractice(param1:int, param2:int)
      {
         super();
         this.practiceMinigameIndex = param1;
         this.practiceMinigameScore = param2;
         totalScore = param2;
         WorldAdvert.loadAd();
         GameWorld.addGameShowFrame("zoomout1");
         scene = new SummaryScenePractice();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         scene.scoreTextField.text = 0;
         scene.chart.gotoAndStop(param1 + 1);
         skipButton = new ButtonOk();
         skipButton.x = 0;
         skipButton.y = GameWorld.CANVAS_HEIGHT / 2 - skipButton.height;
         setButtonMode(skipButton,true);
         scene.addChild(skipButton);
         skipButton.addEventListener(MouseEvent.CLICK,skipButtonDownListener);
         skipButton.visible = false;
         if(GameWorld.languageButtonNew != null)
         {
            GameWorld.languageButtonNew.visible = false;
         }
         if(!GameWorld.protectedValues.checkAllValues() || GameWorld.memoryModificationCheatDetected)
         {
            cheatDetected = true;
            GameWorld.rpcClient.recordGameEvent(RpcClient.GAME_EVENT_DEBUG,SummaryScreen.MEMORY_MOD_CHEAT,GameWorld.dummy,GameWorld.dummy);
         }
         else
         {
            uploadScoreDone = false;
         }
         speechText = new SpeechTextObject(GameWorld.gameShowFrame.tutorialSpeechTextField.speechText,GameWorld.gameShowFrame.tutorialSpeechTextField);
         speechText.addString(LanguageTranslation.getSumUpText(LanguageButton.currentLanguage));
         GameWorld.setProfessorState("ProfessorTalk");
         Engine.playSound("ThemeMusic",0);
         Engine.playSound("ApplauseSound",1);
         Engine.playSound("CrowdCheerSound",1);
      }
      
      public static function getUserInfoOK(param1:UserInfo, param2:String) : *
      {
         GameWorld.setCurrentUserInfo(param1);
      }
      
      public static function getUserInfoFail() : *
      {
      }
      
      public function achievementOK(param1:uint) : *
      {
      }
      
      public function scoreUploadCancel() : *
      {
         uploadScorePopup = null;
      }
      
      public function scoreUploadOK(param1:Boolean) : *
      {
         cheatDetected = !param1;
         uploadScoreDone = true;
         uploadScorePopup.end();
         uploadScorePopup = null;
         trace("cheatDetected=" + cheatDetected + " success=" + param1);
      }
      
      override public function tick(param1:uint) : *
      {
         if(finalTextEffect != null)
         {
            if(finalTextEffect.currentFrame >= finalTextEffect.totalFrames)
            {
               scene.removeChild(finalTextEffect);
               finalTextEffect = null;
            }
         }
         if(state == STATE_INTRO)
         {
            if(uploadScorePopup == null)
            {
               if(!uploadScoreDone || cheatDetected)
               {
                  AchievementHandler.pendingAchievements = 0;
               }
               AchievementHandler.showPendingAchievement(this);
               state = STATE_ACHIEVEMENT;
            }
         }
         else if(state == STATE_ACHIEVEMENT)
         {
            if(AchievementHandler.pendingAchievements == 0)
            {
               skipButton.visible = true;
               state = STATE_SHOW_CHART;
               scene.gotoAndPlay("showchart");
            }
         }
         else if(state == STATE_SHOW_CHART)
         {
            if(scene.currentLabel == "addscore")
            {
               state = STATE_SCORE_COUNTING;
               Engine.playSound("ScoreCountSound",0);
            }
         }
         else if(state == STATE_SCORE_COUNTING)
         {
            trace("curScore = " + curScore);
            curScore += SCORE_COUNT_SPEED * param1 / 1000;
            curScore = Math.min(curScore,totalScore);
            scene.scoreTextField.text = curScore;
            if(curScore == totalScore)
            {
               Engine.stopSound("ScoreCountSound");
               Engine.playSound("ScoreCountEndSound",1);
               speechText.reset();
               if(cheatDetected)
               {
                  speechText.addString(LanguageTranslation.getScoreText2(LanguageButton.currentLanguage));
                  GameWorld.setProfessorState("ProfessorSad");
               }
               else if(GameWorld.bestMinigameScores[practiceMinigameIndex] == 0)
               {
                  speechText.addString(LanguageTranslation.getPracticeText2(LanguageButton.currentLanguage));
                  GameWorld.setProfessorState("ProfessorHappy");
               }
               else if(totalScore > GameWorld.bestMinigameScores[practiceMinigameIndex])
               {
                  speechText.addString(LanguageTranslation.getPracticeText3(LanguageButton.currentLanguage));
                  GameWorld.setProfessorState("ProfessorHappy");
               }
               else if(totalScore < 300)
               {
                  speechText.addString(LanguageTranslation.getPracticeText4(LanguageButton.currentLanguage));
                  GameWorld.setProfessorState("ProfessorSad");
               }
               else
               {
                  speechText.addString(LanguageTranslation.getPracticeText5(LanguageButton.currentLanguage));
               }
               state = STATE_POST_SCORE_COUNTING;
            }
         }
         else if(state == STATE_FADE_OUT)
         {
            if(WorldAdvert.isAdReady())
            {
               Engine.setActiveWorld(new WorldAdvert());
            }
            else
            {
               WorldAdvert.destroyAd();
               Engine.setActiveWorld(new WorldMenuPractice());
               Engine.playSound("ApplauseSound",1);
            }
         }
      }
      
      public function uploadScore() : *
      {
         GameWorld.rpcClient.beginBatch(RpcClient.BATCHMODE_CONDITIONAL);
         GameWorld.rpcClient.addAchievements(AchievementHandler.pendingAchievements,AchievementHandler.achievementOK,achievementFail);
         GameWorld.rpcClient.uploadPracticeScore(new MinigameScore(practiceMinigameIndex,practiceMinigameScore),scoreUploadOK,scoreUploadFail);
         GameWorld.rpcClient.getUserInfo(getUserInfoOK,getUserInfoFail);
         GameWorld.rpcClient.endBatch();
         uploadScorePopup = new OverlayConfirm(this,"Uploading score...",null,null,new UploadingScorePopUp());
      }
      
      public function achievementFail() : *
      {
      }
      
      public function scoreUploadFail() : *
      {
         uploadScorePopup.end();
         uploadScorePopup = new OverlayConfirm(this,LanguageTranslation.getUploadFailedText(LanguageButton.currentLanguage),uploadScore,scoreUploadCancel);
      }
      
      public function skipButtonDownListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         if(state == STATE_SHOW_CHART || state == STATE_SCORE_COUNTING)
         {
            state = STATE_SCORE_COUNTING;
            curScore = totalScore;
            scene.gotoAndPlay("addscoreend");
         }
         else if(state == STATE_POST_SCORE_COUNTING)
         {
            state = STATE_FADE_OUT;
            skipButton.visible = false;
         }
      }
   }
}
