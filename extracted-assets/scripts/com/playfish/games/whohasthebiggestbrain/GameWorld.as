package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.coretech.engine.ui.PFPopUp;
   import com.playfish.coretech.messaging.Messaging;
   import com.playfish.feed.*;
   import com.playfish.games.ad2.*;
   import com.playfish.games.whohasthebiggestbrain.minigames.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import com.playfish.rpc.brain.*;
   import com.playfish.rpc.share.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class GameWorld extends BaseWorld
   {
      
      public static var currentUserScore:int;
      
      public static var rpcClient:RpcClient;
      
      public static var curCategoryMinigameType:Array;
      
      public static var challengeVsPage:ChallengeVS;
      
      public static var restartOverlay:MovieClip;
      
      public static var bestMinigameScores:Array;
      
      public static var professorState:String;
      
      public static var pendingChallenges:Array;
      
      public static var gameShowFrameBg:MovieClip;
      
      public static var totalScores:int;
      
      internal static var initDoneListener:Function;
      
      public static var gameShowFrame:MovieClip;
      
      public static var curCategoryProps:Array;
      
      public static var currentUserInfo:UserInfo;
      
      public static var calculateAverageAnsweringTime:Number;
      
      public static var challengeID:uint;
      
      public static var totalIncorrect:int;
      
      internal static var initCallBackDone:Array;
      
      public static var numberRoundsPlayed:int;
      
      public static var highScorePanel:HighScorePanel;
      
      public static var languageButtonNew:LanguageButton;
      
      public static const DEBUG:Boolean = Debug.DEBUG;
      
      public static const mobileUrl:String = "http://www.playfish.com/mobile/?game=how_to_download&pf_ref=fbingamebrain";
      
      public static const ENABLE_EASTER_ITEMS:Boolean = false;
      
      public static const CANVAS_WIDTH:int = 640;
      
      public static const CANVAS_HEIGHT:int = 480;
      
      public static const achievementMask:int = 0;
      
      public static const CANVAS_CENTER_X:int = CANVAS_WIDTH / 2;
      
      public static const CANVAS_CENTER_Y:int = CANVAS_HEIGHT / 2;
      
      public static const BRAIN_TYPE_SCORE_RANGE:Array = new Array(0,100,300,500,700,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2300,2500,2700,2900,3100,3300,3500,3700,3900,4100,4300,4500,4700,4900);
      
      public static var minigameAggregateScores:Array = [{
         "type":5,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":4,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":11,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":2,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":3,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":8,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":1,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":0,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":10,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":6,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":7,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      },{
         "type":9,
         "bestScore":0,
         "totalScore":0,
         "playCount":0,
         "score":0
      }];
      
      public static const GS_BRAND:* = 0;
      
      public static const GS_SPLASH:* = 1;
      
      public static const GS_FULL_GAME:* = 2;
      
      public static const GS_TEST_MINIGAME:* = 3;
      
      public static const GS_CHALLENGE:* = 4;
      
      public static var gameState:int = GS_BRAND;
      
      public static var curCategory:int = 0;
      
      public static var playCount:int = 0;
      
      public static var playCountNew:int = 0;
      
      public static var entireHighScore:int = 0;
      
      public static var weeklyTopUser:UserInfo = null;
      
      public static var calculateCheatDetect:Boolean = false;
      
      public static var friendsHiscores:Array = null;
      
      public static var friendsHiscoresRank:Array = null;
      
      public static var retrievingHiscores:Array = new Array();
      
      public static var retrievingChallengeScores:Array = new Array();
      
      public static var updateScoreTableAfterRetreivingScores:Boolean = true;
      
      public static var cachedHiscores:Array = new Array();
      
      public static var cachedHiscoresRank:Array = new Array();
      
      public static var friendsInfo:Array = new Array();
      
      public static var memoryModificationCheatDetected:Boolean = false;
      
      public static var speederCheatDetected:Boolean = false;
      
      public static var isBeChallenged:Boolean = false;
      
      public static var isCheckingResultPage:Boolean = false;
      
      public static var isPlayingGame:Boolean = false;
      
      internal static const INIT_CALLBACK_USER_INFO:* = 0;
      
      internal static const INIT_CALLBACK_LANG:* = 1;
      
      internal static const INIT_CALLBACK_COUNT:* = 2;
      
      public static const PROTECTED_VALUE_CATEGORY_SCORE_1:* = 0;
      
      public static const PROTECTED_VALUE_CATEGORY_SCORE_2:* = 1;
      
      public static const PROTECTED_VALUE_CATEGORY_SCORE_3:* = 2;
      
      public static const PROTECTED_VALUE_CATEGORY_SCORE_4:* = 3;
      
      public static const PROTECTED_VALUE_TIMER:* = 4;
      
      public static const NUM_PROTECTED_VALUE:* = 5;
      
      public static var protectedValues:ChecksumProtectedValues = new ChecksumProtectedValues(NUM_PROTECTED_VALUE);
       
      
      internal var brandMovieClip:MovieClip;
      
      internal var engine:Engine;
      
      internal var splashMovieClip:MovieClip;
      
      internal var textureBitmap:Bitmap;
      
      public function GameWorld(param1:Engine)
      {
         var worldMask:Sprite = null;
         var engine:Engine = param1;
         super();
         this.engine = engine;
         try
         {
            worldMask = new Sprite();
            worldMask.graphics.beginFill(16711680);
            worldMask.graphics.drawRect(0,0,CANVAS_WIDTH,CANVAS_HEIGHT);
            Engine.worldContainer.mask = worldMask;
            Engine.worldContainer.addChild(worldMask);
            if(DEBUG)
            {
               Debug.init();
            }
            splashMovieClip = new Intro();
            if(currentUserInfo.isProUser)
            {
               splashMovieClip.logo.gotoAndStop("pro");
               splashMovieClip.logo.proLogo.visible = true;
            }
            else
            {
               splashMovieClip.logo.gotoAndStop("normal");
               splashMovieClip.logo.proLogo.visible = false;
            }
            splashMovieClip.x = CANVAS_CENTER_X;
            splashMovieClip.y = CANVAS_CENTER_Y;
            addChild(splashMovieClip);
            Engine.playSound("ThemeMusic",-1);
         }
         catch(e:Error)
         {
            trace("error init gameworld: " + e.toString());
         }
      }
      
      public static function acceptChallengeRequest(param1:Event) : void
      {
         var _loc3_:uint = 0;
         ChallengeWorld.challengePlayer = param1.currentTarget.parent.challengeRequest.challenger;
         challengeID = param1.currentTarget.parent.challengeRequest.id;
         var _loc2_:uint = uint(param1.currentTarget.parent.challengeRequest.games.length);
         trace("_num = " + _loc2_);
         if(_loc2_ == 1)
         {
            ChallengeWorld.challengeMode = ChallengeWorld.CHALLENGE_MODE_SELECT;
            ChallengeWorld._selectGameType = ChallengeWorld.SELECT_GAME_SINGLE;
            _loc3_ = uint(param1.currentTarget.parent.challengeRequest.games[0]);
            ChallengeWorld.minigameCategory = MinigameDefines.MINIGAMES[_loc3_].category;
         }
         else if(_loc2_ == 4)
         {
            ChallengeWorld.challengeMode = ChallengeWorld.CHALLENGE_MODE_SELECT;
            ChallengeWorld._selectGameType = ChallengeWorld.SELECT_GAME_FULL;
         }
         ChallengeWorld.resetVar();
         ChallengeWorld.sortMiniGame(param1.currentTarget.parent.challengeRequest.games);
         ChallengeWorld.challengerScore = param1.currentTarget.parent.challengeRequest.score;
         trace("ChallengeWorld.miniGameID = " + ChallengeWorld.miniGameID);
         trace("ChallengeWorld.challengerScore = " + ChallengeWorld.challengerScore);
         isBeChallenged = true;
         trace("e.currentTarget.faceImage" + param1.currentTarget.faceImage);
         ChallengeWorld.challengerFace = param1.currentTarget.faceImage;
         challengeVsPage = new ChallengeVS();
         (Engine.curWorld as MainMenu).removeMouseListeners();
         Engine.setActiveWorld(challengeVsPage);
      }
      
      public static function getFaceImageFromURL(param1:String) : DisplayObject
      {
         var _loc2_:Loader = null;
         var _loc3_:URLRequest = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:* = undefined;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = new Loader();
            _loc3_ = new URLRequest(param1);
            _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,scaleFaceImage);
            _loc2_.load(_loc3_);
            _loc4_ = new MovieClip();
            _loc5_ = new MovieClip();
            _loc6_ = new MovieClip();
            _loc5_.addChild(_loc6_);
            GameWorld.fillRect(_loc6_.graphics,16777215,0,0,50,50);
            _loc5_.mask = _loc6_;
            _loc5_.addChild(_loc2_);
            _loc4_.addChild(_loc5_);
            _loc4_.x = -25;
            _loc4_.y = -25;
            return _loc4_;
         }
         return null;
      }
      
      public static function fillRect(param1:Graphics, param2:Number, param3:int, param4:int, param5:int, param6:int) : *
      {
         param1.clear();
         param1.moveTo(param3,param4);
         param1.beginFill(param2,1);
         param1.lineTo(param3 + param5,param4);
         param1.lineTo(param3 + param5,param4 + param6);
         param1.lineTo(param3,param4 + param6);
         param1.endFill();
      }
      
      public static function scaleFaceImage(param1:Event) : *
      {
         param1.target.removeEventListener(Event.COMPLETE,scaleFaceImage);
         var _loc2_:DisplayObject = DisplayObject(param1.target.loader);
         var _loc3_:* = _loc2_.height;
         var _loc4_:* = 50 / _loc2_.width;
         _loc2_.scaleX = _loc2_.scaleY = _loc4_;
         if(_loc2_.height < 50)
         {
            _loc4_ = 50 / _loc3_;
            _loc2_.scaleX = _loc2_.scaleY = _loc4_;
         }
      }
      
      public static function languageButtonClicked(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         Engine.localiser.initNextLang();
         Engine.setFontForLang(param1.currentTarget.button.textField,"Arial Black");
         param1.currentTarget.button.textField.text = Engine.localiser.getCurrentLanguageName();
         GameWorld.highScorePanel.notifyLanguageUpdate();
         Engine.curWorld.notifyLanguageUpdate();
         if(PFPopUp.getTopActivePopUp() != null)
         {
            PFPopUp.getTopActivePopUp().notifyLanguageUpdate();
         }
         trace("save lang " + Engine.localiser.curLangCode + " Preferences.values[Preferences.LANGUAGE]=" + Preferences.values[Preferences.LANGUAGE]);
         if(Engine.localiser.curLangCode != Preferences.values[Preferences.LANGUAGE])
         {
            Preferences.values[Preferences.LANGUAGE] = Engine.localiser.curLangCode;
            Preferences.save(Preferences.LANGUAGE);
         }
      }
      
      public static function init(param1:Function) : *
      {
         var defaultLangCode:*;
         var _initDoneListener:Function = param1;
         initDoneListener = _initDoneListener;
         initCallBackDone = new Array();
         var i:* = 0;
         while(i < INIT_CALLBACK_COUNT)
         {
            initCallBackDone[i] = false;
            i++;
         }
         defaultLangCode = Engine.instance.getParameter("pf_lang");
         trace("==>default:" + defaultLangCode);
         if(defaultLangCode != null)
         {
            Preferences.values[Preferences.LANGUAGE] = defaultLangCode;
         }
         Preferences.load();
         if(!Preferences.values[Preferences.SOUND])
         {
            Engine.setGlobalSoundVolume(0);
         }
         if(!Preferences.values[Preferences.QUALITY])
         {
            Engine.instance.stage.quality = StageQuality.LOW;
         }
         highScorePanel = new HighScorePanel();
         highScorePanel.x = CANVAS_CENTER_X;
         highScorePanel.y = CANVAS_HEIGHT + (Engine.stageHeight - CANVAS_HEIGHT) / 2;
         Engine.instance.addChild(highScorePanel);
         highScorePanel.visible = false;
         try
         {
            if(Debug.DEBUG)
            {
               Preferences.values[Preferences.LANGUAGE] = defaultLangCode;
            }
            Engine.registerLocaliser(new BrainGameLocaliser(Preferences.values[Preferences.LANGUAGE],langLoaded,langLoaded));
            trace("==>feed_list:" + PFEngine.instance.getParameterString("pf_feed_list"));
            if(PFEngine.instance.getParameterString("pf_feed_list").length > 0)
            {
               FeedTemplate.loadXML(PFEngine.instance.getParameterString("pf_feed_list"));
            }
            else
            {
               FeedForm.FEEDENABLE = false;
            }
         }
         catch(ex:Error)
         {
            if(Debug.DEBUG)
            {
               trace("ERROR : initialising localiser");
               trace(ex.message);
            }
         }
         trace("---------------");
         trace(Engine.instance.getParameter("pf_ingameads"));
         trace(Engine.instance.getParameter("pf_user_country"));
         trace(Engine.instance.getParameter("pf_network"));
         FakeUserInfo(null,null);
         if(Debug.DEBUG)
         {
            WorldAdvert.adClient = new AdClient("adconfig.xml",PFEngine.instance.getParameterString("pf_user_country"),PFEngine.instance.getParameterString("pf_network"),rpcClient);
         }
         else
         {
            WorldAdvert.adClient = new AdClient(PFEngine.instance.getParameterString("pf_ingameads"),PFEngine.instance.getParameterString("pf_user_country"),PFEngine.instance.getParameterString("pf_network"),rpcClient);
         }
         try
         {
            rpcClient.beginBatch(RpcClient.BATCHMODE_CONDITIONAL);
            rpcClient.numResourceCopies = 0;
            rpcClient.getChallengeFriends(getChallengeFriendsSuccess,getChallengeFriendsFail);
            rpcClient.getPendingChallenges(getPendingChallengsSuccess,getPendingChallengsFail);
            getHighScores(highScorePanel.getCurrentUserContext(),highScorePanel.getCurrentTimeContext());
            rpcClient.getScores(1,0,0,false,RpcClient.USER_CONTEXT_FRIENDS | RpcClient.TIME_CONTEXT_WEEK,weeklyTopScoreOK,weeklyTopScoreFail);
            rpcClient.getMessagingInfo(Messaging.getInfoSuccess,Messaging.getInfoFail);
            rpcClient.endBatch();
         }
         catch(ex:Error)
         {
         }
      }
      
      public static function weeklyTopScoreFail() : *
      {
      }
      
      public static function startChallenge(param1:Array, param2:int) : void
      {
         GameWorld.gameState = GS_CHALLENGE;
         trace("minigameId = " + param1);
         switch(param2)
         {
            case ChallengeWorld.CHALLENGE_MODE_RANDOM:
               startChallengeNewGame(param1);
               break;
            case ChallengeWorld.CHALLENGE_MODE_SELECT:
               if(ChallengeWorld._selectGameType == ChallengeWorld.SELECT_GAME_SINGLE)
               {
                  resetNewGameVars();
                  Engine.setActiveWorld(new TutorialScreen(param1[0],true,true));
                  GameWorld.rpcClient.resetTimes(getTimer);
                  rpcClient.recordGameEvent(RpcClient.GAME_EVENT_START,null,dummy,dummy);
                  break;
               }
               if(ChallengeWorld._selectGameType == ChallengeWorld.SELECT_GAME_FULL)
               {
                  startChallengeNewGame(param1);
               }
               break;
         }
      }
      
      public static function getBrainTypeMovieClip(param1:int, param2:DisplayObject = null) : MovieClip
      {
         var _loc3_:* = new BrainTypeSprite();
         _loc3_.gotoAndStop(param1 + 1);
         if(param2 != null)
         {
         }
         return _loc3_;
      }
      
      public static function getChallengeScores(param1:uint, param2:uint, param3:Boolean = true) : *
      {
         var userContext:uint = param1;
         var timeContext:uint = param2;
         var updateScoreTable:Boolean = param3;
         updateScoreTableAfterRetreivingScores = updateScoreTable;
         var context:uint = uint(userContext | timeContext);
         if(!retrievingChallengeScores[context])
         {
            rpcClient.numResourceCopies = 0;
            rpcClient.getScores(HighScorePanel.NUM_TOP_SCORES,HighScorePanel.NUM_CACHED_SCROLLABLE_FRIEND_SCORES / 2,HighScorePanel.NUM_CACHED_SCROLLABLE_FRIEND_SCORES / 2,true,context,function(param1:Array):*
            {
               getChallengeScoresOK(param1,userContext,timeContext);
            },function():*
            {
               getChallengeScoresFail(userContext,timeContext);
            });
            retrievingHiscores[context] = true;
            if(highScorePanel.getContext() == context)
            {
               highScorePanel.addLoadingAnimations();
            }
         }
      }
      
      public static function resetNewGameVars() : *
      {
         var _loc1_:* = undefined;
         calculateCheatDetect = false;
         curCategory = 0;
         totalIncorrect = 0;
         totalScores = 0;
         bestMinigameScores = new Array();
         _loc1_ = 0;
         while(_loc1_ < GameWorld.minigameAggregateScores.length)
         {
            if(GameWorld.minigameAggregateScores[_loc1_].type < MinigameDefines.NUM_MINIGAMES)
            {
               bestMinigameScores[GameWorld.minigameAggregateScores[_loc1_].type] = GameWorld.minigameAggregateScores[_loc1_].bestScore;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            if(bestMinigameScores[_loc1_] == null)
            {
               bestMinigameScores[_loc1_] = 0;
            }
            _loc1_++;
         }
         WorldStats.resetCachedStats();
      }
      
      public static function startNewFullGame(param1:Array = null) : *
      {
         var _loc2_:* = undefined;
         gameState = GS_FULL_GAME;
         resetNewGameVars();
         curCategoryMinigameType = param1;
         if(curCategoryMinigameType == null)
         {
            curCategoryMinigameType = new Array();
            _loc2_ = 0;
            while(_loc2_ < MinigameDefines.NUM_MINIGAME_CAT)
            {
               curCategoryMinigameType[_loc2_] = -1;
               _loc2_++;
            }
         }
         startCategory(curCategory,curCategoryMinigameType[0]);
         addRestartOverlay();
         GameWorld.rpcClient.resetTimes(getTimer);
         rpcClient.recordGameEvent(RpcClient.GAME_EVENT_START,null,dummy,dummy);
      }
      
      public static function weeklyTopScoreOK(param1:Array) : *
      {
         var _loc2_:UserInfo = null;
         trace("-- beging weeklyTopScoreOK--");
         if(param1.length > 0)
         {
            var _loc3_:* = param1;
            for each(_loc2_ in _loc3_)
            {
               weeklyTopUser = _loc2_;
            }
         }
         trace("-- end weeklyTopScoreOK--");
      }
      
      public static function cancelChallengeRequest(param1:Event) : void
      {
         gameShowFrame.challengeRequest.gotoAndPlay("closeRequest");
         rpcClient.rejectChallenge(param1.currentTarget.parent.challengeRequest.id,cancelChallengeSuccess,cancelChallengeFail);
      }
      
      public static function getScoresOK(param1:Array, param2:uint, param3:uint) : *
      {
         var _loc8_:int = 0;
         var _loc9_:UserInfo = null;
         trace("== begin getScoresOK ==");
         var _loc4_:uint = uint(param2 | param3);
         retrievingHiscores[_loc4_] = false;
         if(DEBUG)
         {
            trace("--- SCORES " + param2 + " " + param3 + "---");
            _loc8_ = 0;
            for each(_loc9_ in param1)
            {
               trace(_loc8_++);
               trace("position: " + param1.indexOf(_loc9_));
               trace("name: " + _loc9_.firstName);
               trace("highscore: " + _loc9_.highScore);
               trace("image: " + _loc9_.image);
               trace("url: " + _loc9_.imageUrl);
            }
         }
         var _loc5_:* = sortScores(param1);
         cachedHiscores[_loc4_] = _loc5_[0];
         cachedHiscoresRank[_loc4_] = _loc5_[1];
         var _loc6_:* = getUserScoreIndex(cachedHiscores[_loc4_]);
         if(_loc6_ != -1)
         {
         }
         var _loc7_:* = centerScores(_loc6_,cachedHiscores[_loc4_],cachedHiscoresRank[_loc4_]);
         if(_loc4_ == (RpcClient.USER_CONTEXT_FRIENDS | RpcClient.TIME_CONTEXT_MONTH))
         {
            friendsHiscores = _loc7_[0];
            friendsHiscoresRank = _loc7_[1];
         }
         if(DEBUG)
         {
            trace("--- SORTED SCORES ---");
            _loc8_ = 0;
            while(_loc8_ < _loc7_[0].length)
            {
               trace(_loc8_);
               trace("position: " + _loc7_[1][_loc8_]);
               trace("name: " + _loc7_[0][_loc8_].firstName);
               trace("highscore: " + _loc7_[0][_loc8_].highScore);
               trace("image: " + _loc7_[0][_loc8_].image);
               _loc8_++;
            }
         }
         if(updateScoreTableAfterRetreivingScores)
         {
            highScorePanel.updateScores(_loc4_,_loc7_[0],_loc7_[1]);
         }
         trace("== end getScoresOK ==");
      }
      
      public static function getUserInfoFail() : *
      {
         setInitCallBackState(INIT_CALLBACK_USER_INFO,false);
      }
      
      public static function addRestartOverlay() : *
      {
         trace("pre load ads ");
         WorldAdvert.loadAd();
         if(restartOverlay == null)
         {
            restartOverlay = new OverlayRestart();
            restartOverlay.x = CANVAS_CENTER_X;
            restartOverlay.y = CANVAS_CENTER_Y;
            restartOverlay.restartButton.addEventListener(MouseEvent.CLICK,restartClickListener,false,0,true);
            setButtonMode(restartOverlay.restartButton,true);
            Engine.instance.addChild(restartOverlay);
         }
      }
      
      public static function startMainMenu() : *
      {
         var _loc1_:* = new MainMenu();
         Engine.resetKeys();
         Engine.setActiveWorld(_loc1_);
      }
      
      public static function startChallengeNewGame(param1:Array) : *
      {
         GameWorld.gameState = GS_CHALLENGE;
         curCategoryMinigameType = param1;
         resetNewGameVars();
         startCategory(curCategory,curCategoryMinigameType[0]);
         GameWorld.rpcClient.resetTimes(getTimer);
         rpcClient.recordGameEvent(RpcClient.GAME_EVENT_START,null,dummy,dummy);
      }
      
      public static function getHighScores(param1:uint, param2:uint, param3:Boolean = true) : *
      {
         var userContext:uint = param1;
         var timeContext:uint = param2;
         var updateScoreTable:Boolean = param3;
         updateScoreTableAfterRetreivingScores = updateScoreTable;
         var context:uint = uint(userContext | timeContext);
         if(!retrievingHiscores[context])
         {
            rpcClient.numResourceCopies = 0;
            rpcClient.getScores(HighScorePanel.NUM_TOP_SCORES,HighScorePanel.NUM_CACHED_SCROLLABLE_FRIEND_SCORES / 2,HighScorePanel.NUM_CACHED_SCROLLABLE_FRIEND_SCORES / 2,true,context,function(param1:Array):*
            {
               getScoresOK(param1,userContext,timeContext);
            },function():*
            {
               getScoresFail(userContext,timeContext);
            });
            retrievingHiscores[context] = true;
            if(highScorePanel.getContext() == context)
            {
               highScorePanel.addLoadingAnimations();
            }
         }
      }
      
      public static function startMinigame(param1:int) : *
      {
         removeGameShowFrame();
         var _loc2_:* = new MinigameBase(param1,MinigameDefines.MINIGAMES[param1].minigameClass);
         if(GameWorld.gameState == GS_CHALLENGE)
         {
            ChallengeWorld.curMinigame = _loc2_;
         }
         Engine.setActiveWorld(_loc2_);
      }
      
      public static function getPendingChallengsFail() : void
      {
      }
      
      public static function sortScores(param1:Array) : Array
      {
         var _loc4_:UserInfo = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:* = undefined;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1)
         {
            _loc5_ = int(param1.indexOf(_loc4_));
            _loc6_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               if(_loc5_ < _loc3_[_loc7_])
               {
                  _loc2_.splice(_loc7_,0,_loc4_);
                  _loc3_.splice(_loc7_,0,_loc5_);
                  _loc6_ = true;
                  break;
               }
               _loc7_++;
            }
            if(!_loc6_)
            {
               _loc2_.push(_loc4_);
               _loc3_.push(_loc5_);
            }
         }
         return new Array(_loc2_,_loc3_);
      }
      
      public static function setProfessorState(param1:String) : *
      {
         if(gameShowFrame != null)
         {
            if(professorState == null || professorState != param1)
            {
               gameShowFrame.professor.gotoAndStop(param1);
               professorState = param1;
            }
         }
      }
      
      public static function goProListener(param1:MouseEvent) : *
      {
         Engine.setActiveWorld(new WorldGoPro(Engine.curWorld));
      }
      
      public static function removeGameShowFrame() : *
      {
         if(gameShowFrame != null)
         {
            Engine.worldContainer.removeChild(gameShowFrame);
            gameShowFrame = null;
         }
      }
      
      public static function addGameShowFrame(param1:String) : *
      {
         gameShowFrame = new FrameGameShow();
         gameShowFrame.x = CANVAS_CENTER_X;
         gameShowFrame.y = CANVAS_CENTER_Y;
         gameShowFrame.logo.gotoAndStop("pro");
         gameShowFrame.goProButton.main_.gotoAndStop("normal");
         gameShowFrame.goProButton.visible = false;
         updateChallengeRequestPage();
         Engine.worldContainer.addChild(gameShowFrame);
         if(Engine.soundVolume == 0)
         {
            setButtonMode(gameShowFrame.soundButton,true,"2");
         }
         else
         {
            setButtonMode(gameShowFrame.soundButton,true);
         }
         if(Engine.instance.stage.quality.toUpperCase() == StageQuality.HIGH.toUpperCase())
         {
            setButtonMode(gameShowFrame.qualityButton,true);
         }
         else
         {
            setButtonMode(gameShowFrame.qualityButton,true,"2");
         }
         gameShowFrame.soundButton.addEventListener(MouseEvent.CLICK,soundButtonClicked);
         gameShowFrame.qualityButton.addEventListener(MouseEvent.CLICK,qualityButtonClicked);
         languageButtonNew = new LanguageButton();
         languageButtonNew.x = gameShowFrame.languageButton.x;
         languageButtonNew.y = gameShowFrame.languageButton.y;
         gameShowFrame.addChild(languageButtonNew);
         languageButtonNew.addEventListener(LanguageButton.LANGUAGE_CHANGED,onLanguageChanged);
         if(gameShowFrame.languageButton && gameShowFrame.languageButton.button && gameShowFrame.languageButton.button.textField)
         {
            gameShowFrame.languageButton.button.textField.text = LanguageButton.currentLanguage;
            Engine.setFontForLang(gameShowFrame.languageButton.button.textField,"Arial Black");
         }
         setButtonMode(gameShowFrame.languageButton,true,"2");
         gameShowFrame.languageButton.addEventListener(MouseEvent.CLICK,languageButtonClicked);
         gameShowFrame.iphoneButton.visible = false;
         setButtonMode(gameShowFrame.iphoneButton,true);
         gameShowFrame.iphoneButton.addEventListener(MouseEvent.CLICK,iphoneListener);
         gameShowFrame.gotoAndPlay(param1);
      }
      
      public static function iphoneListener(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest(mobileUrl);
         navigateToURL(_loc2_,"_blank");
      }
      
      public static function getUserScoreIndex(param1:Array) : int
      {
         var _loc2_:* = undefined;
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(NetworkUid.areEqual(param1[_loc2_].id,currentUserInfo.id))
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         return -1;
      }
      
      public static function startCategory(param1:int, param2:int) : *
      {
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         if(param2 == -1)
         {
            _loc3_ = new Array();
            _loc4_ = 0;
            while(_loc4_ < MinigameDefines.MINIGAMES.length)
            {
               if(!MinigameDefines.MINIGAMES[_loc4_].pro && MinigameDefines.MINIGAMES[_loc4_].category == param1)
               {
                  _loc3_.push(_loc4_);
               }
               _loc4_++;
            }
            param2 = int(_loc3_[Engine.rnd(0,_loc3_.length)]);
         }
         trace("minigameIndex minigameIndex = " + param2);
         Engine.setActiveWorld(new TutorialScreen(param2));
      }
      
      public static function getChallengeFriendsFail() : void
      {
         trace("get challenge Friends fail");
      }
      
      public static function getChallengeScoresOK(param1:Array, param2:uint, param3:uint) : *
      {
         var _loc8_:uint = 0;
         var _loc4_:uint = uint(param2 | param3);
         retrievingChallengeScores[_loc4_] = false;
         var _loc5_:* = sortScores(param1);
         cachedHiscores[_loc4_] = _loc5_[0];
         cachedHiscoresRank[_loc4_] = _loc5_[1];
         var _loc6_:* = getUserScoreIndex(cachedHiscores[_loc4_]);
         var _loc7_:* = centerScores(_loc6_,cachedHiscores[_loc4_],cachedHiscoresRank[_loc4_]);
         if(DEBUG)
         {
            trace("--- SORTED CHALLENGE SCORES ---");
            _loc8_ = 0;
            while(_loc8_ < _loc7_[0].length)
            {
               trace("position: " + _loc7_[1][_loc8_]);
               trace("name: " + _loc7_[0][_loc8_].firstName);
               trace("Challenge Point: " + _loc7_[0][_loc8_].highScore);
               trace("image: " + _loc7_[0][_loc8_].image);
               _loc8_++;
            }
         }
         if(updateScoreTableAfterRetreivingScores)
         {
            highScorePanel.updateChallengeScores(_loc4_,_loc7_[0],_loc7_[1]);
         }
      }
      
      public static function gotoAdsPage() : void
      {
         trace("-----go to ads pages--------------");
         trace("WorldAdvert.ad = " + WorldAdvert.ad);
         if(WorldAdvert.ad != null && WorldAdvert.ad.isReady())
         {
            Engine.setActiveWorld(new WorldAdvert());
         }
         else
         {
            WorldAdvert.destroyAd();
            addGameShowFrame("menu_start");
            startMainMenu();
         }
      }
      
      public static function clearHighscoreCaches() : *
      {
         cachedHiscores = new Array();
         cachedHiscoresRank = new Array();
         highScorePanel.clearHighscoreCaches();
      }
      
      public static function langLoaded() : *
      {
         setInitCallBackState(INIT_CALLBACK_LANG,true);
         highScorePanel.notifyLanguageUpdate();
      }
      
      public static function restartClickListener(param1:MouseEvent) : *
      {
         var e:MouseEvent = param1;
         new OverlayConfirm(Engine.curWorld,LanguageTranslation.getQuitGameText(LanguageButton.currentLanguage),function():*
         {
            Engine.stopSound("IngameMusic");
            GameWorld.removeGameShowFrame();
            removeRestartOverlay();
            gotoAdsPage();
         });
      }
      
      public static function updateChallengeRequest(param1:*) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         trace("_pendingRequests.length = " + param1.length);
         if(param1.length > 1)
         {
            gameShowFrame.challengeRequest.mc.gotoAndStop(1);
            gameShowFrame.challengeRequest.mc.title.challengeNum.text = "(2/" + param1.length + ")";
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               _loc3_ = GameWorld.getFaceImageForUser(param1[_loc2_].challenger);
               removeAllChildren(gameShowFrame.challengeRequest.mc["bar" + _loc2_].portrait.picBG,1);
               if(_loc3_ != null)
               {
                  gameShowFrame.challengeRequest.mc["bar" + _loc2_].portrait.picBG.addChild(_loc3_);
               }
               gameShowFrame.challengeRequest.mc["bar" + _loc2_].challengeRequest = param1[_loc2_];
               gameShowFrame.challengeRequest.mc["bar" + _loc2_].nameText.T_name.text = param1[_loc2_].challenger.firstName;
               setButtonMode(gameShowFrame.challengeRequest.mc["bar" + _loc2_].okButton,true);
               setButtonMode(gameShowFrame.challengeRequest.mc["bar" + _loc2_].cancelButton,true);
               gameShowFrame.challengeRequest.mc["bar" + _loc2_].okButton.faceImage = _loc3_;
               gameShowFrame.challengeRequest.mc["bar" + _loc2_].okButton.addEventListener(MouseEvent.MOUSE_DOWN,acceptChallengeRequest,false,0,true);
               gameShowFrame.challengeRequest.mc["bar" + _loc2_].cancelButton.addEventListener(MouseEvent.MOUSE_DOWN,cancelChallengeRequest,false,0,true);
               _loc2_++;
            }
         }
         else if(param1.length == 1)
         {
            gameShowFrame.challengeRequest.mc.gotoAndStop(2);
            gameShowFrame.challengeRequest.mc.title.challengeNum.text = "(1/" + param1.length + ")";
            _loc3_ = GameWorld.getFaceImageForUser(param1[0].challenger);
            removeAllChildren(gameShowFrame.challengeRequest.mc["bar0"].portrait.picBG,1);
            if(_loc3_ != null)
            {
               gameShowFrame.challengeRequest.mc["bar0"].portrait.picBG.addChild(_loc3_);
            }
            gameShowFrame.challengeRequest.mc["bar" + _loc2_].challengeRequest = param1[0];
            gameShowFrame.challengeRequest.mc["bar0"].nameText.T_name.text = param1[0].challenger.firstName;
            setButtonMode(gameShowFrame.challengeRequest.mc["bar0"].okButton,true);
            setButtonMode(gameShowFrame.challengeRequest.mc["bar0"].cancelButton,true);
            gameShowFrame.challengeRequest.mc["bar0"].okButton.faceImage = _loc3_;
            gameShowFrame.challengeRequest.mc["bar0"].okButton.addEventListener(MouseEvent.MOUSE_DOWN,acceptChallengeRequest,false,0,true);
            gameShowFrame.challengeRequest.mc["bar0"].cancelButton.addEventListener(MouseEvent.MOUSE_DOWN,cancelChallengeRequest,false,0,true);
         }
         else
         {
            gameShowFrame.challengeRequest.visible = false;
         }
      }
      
      public static function getChallengeScoresFail(param1:uint, param2:uint) : *
      {
         retrievingChallengeScores[param1 | param2] = false;
      }
      
      public static function getBrainType(param1:int) : int
      {
         var _loc2_:* = 0;
         while(_loc2_ < BRAIN_TYPE_SCORE_RANGE.length - 1)
         {
            if(param1 >= BRAIN_TYPE_SCORE_RANGE[_loc2_] && param1 < BRAIN_TYPE_SCORE_RANGE[_loc2_ + 1])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return BRAIN_TYPE_SCORE_RANGE.length - 1;
      }
      
      public static function getUserScoreRank(param1:Array, param2:Array) : int
      {
         var _loc3_:* = undefined;
         if(param1 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(NetworkUid.areEqual(param1[_loc3_].id,currentUserInfo.id))
               {
                  return param2[_loc3_];
               }
               _loc3_++;
            }
         }
         return -1;
      }
      
      public static function cropScoreList(param1:Array, param2:Array, param3:int, param4:int, param5:int) : Array
      {
         var _loc8_:* = undefined;
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         if(param1 != null)
         {
            param3 = Math.min(param3,param1.length);
            _loc8_ = 0;
            while(_loc8_ < param3)
            {
               _loc6_.push(param1[_loc8_]);
               _loc7_.push(_loc8_ + 1);
               _loc8_++;
            }
            if(param3 < param1.length)
            {
               if(param4 + param5 > param1.length)
               {
                  param4 = param1.length - param5;
               }
               _loc8_ = param4 = Math.max(param3,param4);
               while(_loc8_ < param4 + param5)
               {
                  if(_loc8_ < param1.length)
                  {
                     _loc6_.push(param1[_loc8_]);
                     _loc7_.push(param2[_loc8_]);
                  }
                  _loc8_++;
               }
            }
         }
         return new Array(_loc6_,_loc7_);
      }
      
      public static function setGameShowFrameBackground(param1:MovieClip, param2:Boolean) : *
      {
         if(gameShowFrameBg != null)
         {
            if(!param2)
            {
               gameShowFrame.bg.removeChild(gameShowFrameBg);
            }
         }
         else if(gameShowFrame.bg.numChildren > 0)
         {
            gameShowFrame.bg.removeChildAt(0);
         }
         gameShowFrameBg = param1;
         gameShowFrame.bg.addChild(param1);
      }
      
      public static function gameShowFrameGotoandPlay(param1:String) : *
      {
         gameShowFrame.gotoAndPlay(param1);
      }
      
      public static function removeAllChildren(param1:DisplayObjectContainer, param2:int = 0) : *
      {
         while(param1.numChildren > param2)
         {
            param1.removeChildAt(param1.numChildren - 1);
         }
      }
      
      public static function getUserWithRank(param1:Array, param2:Array, param3:int) : UserInfo
      {
         var _loc4_:* = 0;
         while(_loc4_ < param2.length)
         {
            if(param2[_loc4_] == param3)
            {
               return param1[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function getChallengeFriendsSuccess(param1:Array) : void
      {
         trace("get challenge Friends Success");
         friendsInfo = new Array();
         friendsInfo = param1;
         trace(param1);
      }
      
      public static function startPractice(param1:int) : *
      {
         GameWorld.gameState = GS_TEST_MINIGAME;
         resetNewGameVars();
         addRestartOverlay();
         GameWorld.rpcClient.resetTimes(getTimer);
         rpcClient.recordGameEvent(RpcClient.GAME_EVENT_START,null,dummy,dummy);
         Engine.setActiveWorld(new TutorialScreen(param1,false,true));
      }
      
      public static function langError() : *
      {
         trace("langError");
         setInitCallBackState(INIT_CALLBACK_LANG,false);
      }
      
      public static function dummy() : *
      {
      }
      
      private static function updateChallengeRequestPage() : void
      {
         gameShowFrame.challengeRequest.visible = false;
      }
      
      public static function getFaceImageForUser(param1:UserInfo) : DisplayObject
      {
         return getFaceImageFromURL(param1.imageUrl);
      }
      
      public static function setInitCallBackState(param1:int, param2:Boolean) : *
      {
         var _loc3_:* = undefined;
         if(initDoneListener != null)
         {
            trace("index =" + param1 + "  success = " + param2);
            if(!param2)
            {
               initDoneListener(false);
               initDoneListener = null;
               return;
            }
            initCallBackDone[param1] = true;
            _loc3_ = 0;
            while(_loc3_ < initCallBackDone.length)
            {
               if(!initCallBackDone[_loc3_])
               {
                  return;
               }
               _loc3_++;
            }
            initDoneListener(true);
            initDoneListener = null;
         }
      }
      
      public static function getPendingChallengsSuccess(param1:Array) : void
      {
         trace("_pendingChallenges = " + param1);
         if(param1 != null)
         {
            pendingChallenges = param1;
            ChallengeWorld.playerFace = getFaceImageForUser(currentUserInfo);
         }
         updateChallengeRequestPage();
      }
      
      public static function soundButtonClicked(param1:MouseEvent) : *
      {
         var _loc2_:Boolean = false;
         if(Engine.soundVolume == 0)
         {
            Engine.setGlobalSoundVolume(1);
            Engine.playSound("ButtonInGame",1);
            setButtonMode(gameShowFrame.soundButton,true,"");
            _loc2_ = true;
         }
         else
         {
            Engine.setGlobalSoundVolume(0);
            setButtonMode(gameShowFrame.soundButton,true,"2");
            _loc2_ = false;
         }
         if(_loc2_ != Preferences.values[Preferences.SOUND])
         {
            Preferences.values[Preferences.SOUND] = _loc2_;
            Preferences.save(Preferences.SOUND);
         }
      }
      
      private static function cancelChallengeFail() : void
      {
         trace("cancel challenge fail");
      }
      
      public static function getUserInfoOK(param1:UserInfo, param2:String) : *
      {
         trace("--- USER INFO ---");
         trace("name: " + param1.firstName);
         trace("high score: " + param1.highScore);
         trace("challenge score : " + param1.challengesScore);
         setCurrentUserInfo(param1);
         highScorePanel.setNetwork(param2);
         setInitCallBackState(INIT_CALLBACK_USER_INFO,true);
      }
      
      public static function FakeUserInfo(param1:UserInfo, param2:String) : *
      {
         var _loc3_:* = new UserInfo();
         _loc3_.bestCategory = 1;
         _loc3_.challengesScore = 0;
         _loc3_.profileUrl = "images/player.png";
         _loc3_.isProUser = true;
         _loc3_.highScore = 0;
         _loc3_.friendCount = 0;
         _loc3_.imageUrl = "images/player.png";
         _loc3_.challengesWon = 0;
         _loc3_.lastChallengeUserScore = 0;
         _loc3_.lastChallengeOtherScore = 0;
         _loc3_.challengesLost = 0;
         _loc3_.fullName = "Player";
         _loc3_.playCount = 0;
         _loc3_.achievementMask = 0;
         _loc3_.lastChallengeOtherName = "";
         _loc3_.firstName = "Player";
         _loc3_.challengesTied = 0;
         _loc3_.friendRank = 1;
         _loc3_.worldRank = 1;
         _loc3_.largeImageUrl = "images/player.png";
         trace("--- USER INFO ---");
         trace("name: " + _loc3_.firstName);
         trace("high score: " + _loc3_.highScore);
         trace("challenge score : " + _loc3_.challengesScore);
         setInitCallBackState(INIT_CALLBACK_USER_INFO,true);
      }
      
      public static function qualityButtonClicked(param1:MouseEvent) : *
      {
         var _loc2_:Boolean = false;
         if(Engine.instance.stage.quality.toUpperCase() == StageQuality.HIGH.toUpperCase())
         {
            Engine.instance.stage.quality = StageQuality.LOW;
            setButtonMode(gameShowFrame.qualityButton,true,"2");
            _loc2_ = false;
         }
         else
         {
            Engine.instance.stage.quality = StageQuality.HIGH;
            setButtonMode(gameShowFrame.qualityButton,true);
            _loc2_ = true;
         }
         if(_loc2_ != Preferences.values[Preferences.QUALITY])
         {
            Preferences.values[Preferences.QUALITY] = _loc2_;
            Preferences.save(Preferences.QUALITY);
         }
      }
      
      public static function getUserAtIndex(param1:int, param2:Array) : UserInfo
      {
         if(param2 != null)
         {
            return param2[param1];
         }
         return null;
      }
      
      public static function getScoresFail(param1:uint, param2:uint) : *
      {
         retrievingHiscores[param1 | param2] = false;
      }
      
      public static function centerScores(param1:int, param2:Array, param3:Array) : *
      {
         var _loc4_:* = (HighScorePanel.NUM_SCORES - HighScorePanel.NUM_TOP_SCORES - 1) / 2;
         return cropScoreList(param2,param3,HighScorePanel.NUM_TOP_SCORES,param1 - _loc4_,HighScorePanel.NUM_SCORES - HighScorePanel.NUM_TOP_SCORES);
      }
      
      private static function cancelChallengeSuccess() : void
      {
         trace("cancel challenge success");
         rpcClient.getPendingChallenges(getPendingChallengsSuccess,getPendingChallengsFail);
      }
      
      public static function removeRestartOverlay() : *
      {
         if(restartOverlay != null)
         {
            restartOverlay.restartButton.removeEventListener(MouseEvent.CLICK,restartClickListener);
            Engine.instance.removeChild(restartOverlay);
            restartOverlay = null;
         }
      }
      
      public static function setCurrentUserInfo(param1:UserInfo) : *
      {
         currentUserInfo = param1;
         trace("GameWorld.setCurrentUserInfo():",currentUserInfo.isProUser);
         if(Debug.FORCE_PRO)
         {
            currentUserInfo.isProUser = true;
         }
         else if(Debug.FORCE_STANDARD)
         {
            currentUserInfo.isProUser = false;
         }
         currentUserInfo.isProUser = true;
      }
      
      private static function onLanguageChanged(e:Event) : void
      {
         if(gameShowFrame && gameShowFrame.languageButton)
         {
            Engine.playSound("ButtonInGame",1);
            gameShowFrame.languageButton.button.textField.text = LanguageButton.currentLanguage;
            Engine.setFontForLang(gameShowFrame.languageButton.button.textField,"Arial Black");
         }
      }
      
      public function loadTextureBitmap(param1:String) : *
      {
         var _loc2_:* = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.INIT,textureInitListener);
         _loc2_.load(new URLRequest(param1));
      }
      
      override public function tick(param1:uint) : *
      {
         if(gameShowFrame == null)
         {
            addGameShowFrame("start");
            setProfessorState("ProfessorHappy");
            Engine.playSound("ThemeMusic",-1);
            Engine.playSound("ApplauseSound",1);
         }
         else if(gameShowFrame.currentLabel == "menu_start")
         {
            startMainMenu();
         }
      }
      
      public function textureInitListener(param1:Event) : *
      {
         textureBitmap = Bitmap(param1.target.content);
      }
   }
}
