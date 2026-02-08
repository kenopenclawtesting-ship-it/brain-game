package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class ChallengeSummary extends BaseWorld
   {
      
      private static var _isCheckingResult:Boolean = false;
      
      private static var _bgMC:MovieClip;
      
      private static var _challenger1:UserInfo;
      
      public static var playerPoints:uint = 0;
      
      public static var challengePoints:uint = 0;
      
      public static var playerTotalScore:uint;
      
      private static var _playerPointA:Number;
      
      private static var _playerPointB:Number;
      
      private static var _challenger2:UserInfo;
      
      public static var BASE_POINT:Number = 5;
      
      public static var challengerTotalScore:uint;
       
      
      private var _okButton:MovieClip;
      
      internal var state:* = 0;
      
      internal var uploadScorePopup:OverlayConfirm;
      
      internal const STATE_SHOW_ACHIEVEMENT:int = 1;
      
      internal const STATE_IDLE:int = 0;
      
      private var _updateScoreEnd:Boolean;
      
      public function ChallengeSummary()
      {
         super();
         if(Debug.DEBUG)
         {
            Debug.init();
         }
         _bgMC = new ChallengeSummaryPage();
         _bgMC.x = GameWorld.CANVAS_CENTER_X;
         _bgMC.y = GameWorld.CANVAS_CENTER_Y;
         this.addChild(_bgMC);
         initButton();
         WorldAdvert.loadAd();
      }
      
      public static function setResult(param1:UserInfo, param2:UserInfo, param3:uint, param4:uint, param5:uint = 0, param6:uint = 0) : void
      {
         var _loc7_:* = undefined;
         playerPoints = param5;
         challengePoints = param6;
         _challenger1 = param1;
         _challenger2 = param2;
         if((_loc7_ = GameWorld.getFaceImageForUser(param1)) != null)
         {
            _bgMC.card0.picBG.addChild(_loc7_);
         }
         _bgMC.card0.T_name.text = param1.firstName;
         if((_loc7_ = GameWorld.getFaceImageForUser(param2)) != null)
         {
            _bgMC.card1.picBG.addChild(_loc7_);
         }
         _bgMC.card1.T_name.text = param2.firstName;
         trace("score1 = " + param3);
         trace("score2 = " + param4);
         _bgMC.score0.T_score.text = param3;
         _bgMC.score1.T_score.text = param4;
         playerTotalScore = param3;
         challengerTotalScore = param4;
      }
      
      public function updateShowChallengePoint(param1:uint, param2:uint, param3:int, param4:int) : void
      {
         _playerPointA = 0;
         _playerPointB = 0;
         if(param1 != param2)
         {
            _playerPointA = param3;
            _playerPointB = param4;
            if(param1 > param2)
            {
               _bgMC.pointBar0.textField.text = "+ " + _playerPointA;
               _bgMC.pointBar1.textField.text = "- " + _playerPointB;
            }
            else
            {
               _bgMC.pointBar0.textField.text = "- " + _playerPointA;
               _bgMC.pointBar1.textField.text = "+ " + _playerPointB;
            }
         }
         else
         {
            _bgMC.pointBar0.textField.text = _playerPointA;
            _bgMC.pointBar1.textField.text = _playerPointB;
         }
      }
      
      public function createChallengeFail() : void
      {
         if(uploadScorePopup != null)
         {
            uploadScorePopup.end();
         }
         uploadScorePopup = new OverlayConfirm(this,Engine.getText("ScoreUploadFailRetry"),uploadScore,scoreUploadCancel);
      }
      
      public function acceptChallengeSuccess(param1:uint, param2:uint) : void
      {
         trace("acceptChallengeSuccess !");
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < ChallengeWorld.miniGameScore.length)
         {
            _loc4_ += ChallengeWorld.miniGameScore[_loc5_];
            _loc5_++;
         }
         trace("2  _sumTotalScore = " + _loc4_);
         GameWorld.rpcClient.uploadChallengeScore(GameWorld.challengeID,_loc4_,0,true,updateChallengeScoreSucess,updateChallengeScoreFail);
      }
      
      public function achievementOK(param1:uint) : *
      {
         trace("achievementOK is ok!");
      }
      
      public function uploadScore() : void
      {
         if(!GameWorld.isBeChallenged)
         {
            uploadScorePopup = new OverlayConfirm(this,Engine.getText("ScoreUploading"),null,null,new UploadingScorePopUp());
         }
         try
         {
            _updateScoreEnd = false;
            if(GameWorld.isBeChallenged)
            {
               GameWorld.rpcClient.acceptChallenge(GameWorld.challengeID,acceptChallengeSuccess,acceptChallengeFail);
               GameWorld.rpcClient.endBatch();
            }
            else
            {
               GameWorld.rpcClient.createChallenge(ChallengeWorld.challengePlayer.id,ChallengeWorld.miniGameID,createChallengeSuccess,createChallengeFail);
            }
         }
         catch(ex:Error)
         {
         }
      }
      
      public function scoreUploadCancel() : *
      {
         uploadScorePopup = null;
         gotoMainMenu();
      }
      
      public function updateChallengePoint(param1:uint, param2:uint) : void
      {
         _playerPointA = 0;
         _playerPointB = 0;
         if(param1 != param2)
         {
            trace(Math.round(BASE_POINT + (_challenger2.highScore - _challenger1.highScore) / (_challenger2.highScore == 0 ? 1 : _challenger2.highScore) * BASE_POINT));
            if(param1 > param2)
            {
               _playerPointA = Math.max(BASE_POINT,Math.round(BASE_POINT + (_challenger2.highScore - _challenger1.highScore) / (_challenger2.highScore == 0 ? 1 : _challenger2.highScore) * BASE_POINT));
               _playerPointB = Math.round(_playerPointA / 2);
               _bgMC.pointBar0.textField.text = "+ " + _playerPointA;
               _bgMC.pointBar1.textField.text = "- " + _playerPointB;
            }
            else
            {
               _playerPointA = Math.max(BASE_POINT,Math.round(BASE_POINT + (_challenger1.highScore - _challenger2.highScore) / (_challenger1.highScore == 0 ? 1 : _challenger1.highScore) * BASE_POINT));
               _playerPointB = Math.round(_playerPointA / 2);
               _bgMC.pointBar0.textField.text = "- " + _playerPointB;
               _bgMC.pointBar1.textField.text = "+ " + _playerPointA;
            }
         }
         else
         {
            _bgMC.pointBar0.textField.text = _playerPointA;
            _bgMC.pointBar1.textField.text = _playerPointB;
         }
         trace("_playerPointA  = " + _playerPointA);
         trace("_playerPointB = " + _playerPointB);
      }
      
      public function updateChallengeScoreSucess(param1:Boolean) : void
      {
         trace("upload challenge score sucess");
         _updateScoreEnd = true;
         if(uploadScorePopup != null)
         {
            uploadScorePopup.end();
         }
         uploadScorePopup = null;
      }
      
      public function updateChallengeScoreFail() : void
      {
         trace("upload challenge score failed");
         if(uploadScorePopup != null)
         {
            uploadScorePopup.end();
         }
         uploadScorePopup = new OverlayConfirm(this,Engine.getText("ScoreUploadFailRetry"),uploadScore,scoreUploadCancel);
      }
      
      override public function tick(param1:uint) : *
      {
         if(state == STATE_IDLE)
         {
            if(uploadScorePopup == null && AchievementHandler.pendingAchievements != 0)
            {
               trace("AchievementHandler.pendingAchievements  = " + AchievementHandler.pendingAchievements);
               GameWorld.rpcClient.addAchievements(AchievementHandler.pendingAchievements,AchievementHandler.achievementOK,achievementFail);
               AchievementHandler.showPendingAchievement(this);
               state = STATE_SHOW_ACHIEVEMENT;
            }
         }
         else if(state == STATE_SHOW_ACHIEVEMENT)
         {
            if(AchievementHandler.pendingAchievements == 0)
            {
               state = STATE_IDLE;
            }
         }
         if(state == STATE_IDLE)
         {
            if(_bgMC != null && _bgMC.okButton != null && !_bgMC.okButton.visible)
            {
               if(_bgMC.currentLabel == "idle")
               {
                  setButtonVisibility(true);
               }
            }
            if(GameWorld.isCheckingResultPage)
            {
               if(_bgMC.currentLabel == "winEnd" || _bgMC.currentLabel == "loseEnd" || _bgMC.currentLabel == "tieEnd")
               {
                  setButtonVisibility(true);
                  if(_bgMC.currentLabel == "winEnd")
                  {
                     FeedForm.openWaitFeedDialog(new Array(_challenger2));
                  }
                  _isCheckingResult = false;
               }
            }
            else
            {
               if(!_updateScoreEnd && uploadScorePopup == null)
               {
                  if(_bgMC.currentLabel == "winEnd" || _bgMC.currentLabel == "loseEnd" || _bgMC.currentLabel == "tieEnd")
                  {
                     uploadScorePopup = new OverlayConfirm(this,Engine.getText("ScoreUploading"),null,null,new UploadingScorePopUp());
                  }
               }
               if(_updateScoreEnd)
               {
                  if(GameWorld.isBeChallenged)
                  {
                     if(_bgMC.currentLabel == "winEnd" || _bgMC.currentLabel == "loseEnd" || _bgMC.currentLabel == "tieEnd")
                     {
                        if(uploadScorePopup != null)
                        {
                           uploadScorePopup.end();
                        }
                        uploadScorePopup = null;
                        setButtonVisibility(true);
                        if(_bgMC.currentLabel == "winEnd")
                        {
                           FeedForm.openWaitFeedDialog(new Array(_challenger2));
                        }
                        _isCheckingResult = false;
                     }
                  }
                  else if(WorldAdvert.isAdReady())
                  {
                     rpcRecall();
                     Engine.setActiveWorld(new WorldAdvert());
                  }
                  else
                  {
                     WorldAdvert.destroyAd();
                     gotoMainMenu();
                     Engine.playSound("ApplauseSound",1);
                  }
               }
            }
         }
      }
      
      public function rpcRecall() : void
      {
         if(GameWorld.highScorePanel.curModeTab == HighScorePanel.MODE_TAB_CHALLENGE)
         {
            GameWorld.clearHighscoreCaches();
            GameWorld.retrievingChallengeScores[GameWorld.highScorePanel.getCurrentUserContext()] = false;
            GameWorld.rpcClient.beginBatch(RpcClient.BATCHMODE_CONDITIONAL);
            GameWorld.rpcClient.getUserInfo(GameWorld.getUserInfoOK,GameWorld.getUserInfoFail);
            GameWorld.rpcClient.getChallengeFriends(GameWorld.getChallengeFriendsSuccess,GameWorld.getChallengeFriendsFail);
            GameWorld.getChallengeScores(GameWorld.highScorePanel.getCurrentUserContext(),GameWorld.highScorePanel.getCurrentTimeContext());
            GameWorld.rpcClient.getPendingChallenges(GameWorld.getPendingChallengsSuccess,GameWorld.getPendingChallengsFail);
            GameWorld.rpcClient.endBatch();
         }
         else
         {
            GameWorld.rpcClient.getPendingChallenges(GameWorld.getPendingChallengsSuccess,GameWorld.getPendingChallengsFail);
         }
      }
      
      private function setButtonVisibility(param1:Boolean) : void
      {
         var isVisible:Boolean = param1;
         try
         {
            _bgMC.okButton.visible = isVisible;
            _bgMC.ok2Button.visible = isVisible;
            _bgMC.feedButton.visible = Debug.FEEDFORM_AUTO_LAUNCH && isVisible;
         }
         catch(e:Error)
         {
         }
      }
      
      public function initButton() : void
      {
         setButtonMode(_bgMC.okButton,true);
         setButtonMode(_bgMC.ok2Button,true);
         _isCheckingResult = true;
         _bgMC.okButton.addEventListener(MouseEvent.MOUSE_DOWN,okListener);
         _bgMC.ok2Button.addEventListener(MouseEvent.MOUSE_DOWN,okListener);
         _bgMC.okButton.text.text = Engine.getText("ContinueButton");
         Engine.setFontForLang(_bgMC.okButton.text,"Arnold 2.1");
         Engine.setFontSize(_bgMC.okButton.text,16,"EL",14);
         if(!Debug.FEEDFORM_ALWAYS_SHOW)
         {
            _bgMC.feedButton.feed.text.text = Engine.getText("ShareButton");
            Engine.setFontForLang(_bgMC.feedButton.feed.text,"Arnold 2.1");
            Engine.setFontSize(_bgMC.feedButton.feed.text,16,"EL",14);
            setButtonMode(_bgMC.feedButton,true);
            FeedForm.initButton(_bgMC.feedButton,FeedForm.FEEDID_CHALLENGEWIN,true);
         }
         else
         {
            FeedForm.waitFeed = FeedForm.FEEDID_CHALLENGEWIN;
         }
         setButtonVisibility(false);
      }
      
      public function achievementFail() : *
      {
         trace("achievement is fail!");
      }
      
      private function okListener(param1:Event) : void
      {
         Engine.playSound("ButtonMenu",1);
         if(GameWorld.isCheckingResultPage)
         {
            if(_isCheckingResult)
            {
               updateShowChallengePoint(playerTotalScore,challengerTotalScore,playerPoints,challengePoints);
               if(playerTotalScore > challengerTotalScore)
               {
                  _bgMC.gotoAndPlay("win");
               }
               else if(playerTotalScore == challengerTotalScore)
               {
                  _bgMC.gotoAndPlay("tie");
               }
               else
               {
                  _bgMC.gotoAndPlay("lose");
               }
               setButtonVisibility(false);
            }
            else
            {
               GameWorld.isCheckingResultPage = false;
               GameWorld.rpcClient.getPendingChallenges(GameWorld.getPendingChallengsSuccess,GameWorld.getPendingChallengsFail);
               GameWorld.removeGameShowFrame();
               GameWorld.startMainMenu();
               GameWorld.gameShowFrame.challengeRequest.gotoAndPlay("closeRequest");
            }
         }
         else if(_isCheckingResult)
         {
            if(GameWorld.isBeChallenged)
            {
               trace("challengerScore" + ChallengeWorld.challengerScore);
               updateChallengePoint(playerTotalScore,challengerTotalScore);
               if(playerTotalScore > challengerTotalScore)
               {
                  _bgMC.gotoAndPlay("win");
               }
               else if(playerTotalScore == challengerTotalScore)
               {
                  _bgMC.gotoAndPlay("tie");
               }
               else
               {
                  _bgMC.gotoAndPlay("lose");
               }
               setButtonVisibility(false);
            }
            uploadScore();
         }
         else if(WorldAdvert.isAdReady())
         {
            rpcRecall();
            Engine.setActiveWorld(new WorldAdvert());
         }
         else
         {
            WorldAdvert.destroyAd();
            gotoMainMenu();
            Engine.playSound("ApplauseSound",1);
         }
      }
      
      public function acceptChallengeFail() : void
      {
         if(uploadScorePopup != null)
         {
            uploadScorePopup.end();
         }
         uploadScorePopup = new OverlayConfirm(this,Engine.getText("ScoreUploadFailRetry"),uploadScore,scoreUploadCancel);
      }
      
      public function gotoMainMenu() : void
      {
         rpcRecall();
         _updateScoreEnd = false;
         GameWorld.removeGameShowFrame();
         GameWorld.startMainMenu();
         GameWorld.gameShowFrame.challengeRequest.gotoAndPlay("closeRequest");
      }
      
      public function createChallengeSuccess(param1:uint, param2:uint, param3:uint) : void
      {
         var _sumTotalScore:uint;
         var i:uint;
         var miniGameScores:Array;
         var _challengeId:uint = param1;
         var _highPart:uint = param2;
         var _lowPart:uint = param3;
         trace("challenge ID= " + _challengeId);
         miniGameScores = new Array();
         _sumTotalScore = 0;
         i = 0;
         while(i < ChallengeWorld.miniGameScore.length)
         {
            _sumTotalScore += ChallengeWorld.miniGameScore[i];
            i++;
         }
         try
         {
            trace("1  miniGameScores = " + miniGameScores);
            GameWorld.rpcClient.uploadChallengeScore(_challengeId,_sumTotalScore,0,true,updateChallengeScoreSucess,updateChallengeScoreFail);
         }
         catch(ex:Error)
         {
         }
      }
   }
}
