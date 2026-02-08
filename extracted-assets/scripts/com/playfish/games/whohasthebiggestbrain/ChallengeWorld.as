package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.games.whohasthebiggestbrain.minigames.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import com.playfish.rpc.brain.*;
   import flash.display.*;
   import flash.events.*;
   
   public class ChallengeWorld extends BaseWorld
   {
      
      public static var gameIndex:uint = 5;
      
      public static var miniGameID:Array;
      
      private static var minigameIndex:int = 0;
      
      public static var _selectGameType:uint = 0;
      
      public static const SELECT_GAME_FULL:uint = 1;
      
      public static const CHALLENGE_MODE_SELECT:uint = 1;
      
      public static var playerFace:DisplayObject;
      
      public static var challengerScore:uint = 0;
      
      public static var challengePlayer:UserInfo;
      
      public static var challengeMode:uint;
      
      public static var minigameCategory:uint;
      
      public static var miniGameScore:Array = new Array();
      
      public static var miniGames:Array;
      
      public static var speechText:SpeechTextObject;
      
      public static var curMinigame:MinigameBase;
      
      public static const CHALLENGE_MODE_RANDOM:uint = 0;
      
      public static var challengerFace:DisplayObject;
      
      public static var firendsPage:ChallengeFriendsPage;
      
      public static const SELECT_GAME_SINGLE:uint = 0;
       
      
      private var _challengeModePage:MovieClip;
      
      private var _gameSelectPage:MovieClip;
      
      private var selectedMinigameButtons:Array;
      
      private var minigameButtons:Array;
      
      public function ChallengeWorld()
      {
         super();
         GameWorld.isBeChallenged = false;
         resetVar();
         init();
      }
      
      public static function resetVar() : void
      {
         miniGameID = null;
         miniGameScore = null;
         challengerScore = 0;
         miniGameID = new Array();
         miniGameScore = new Array();
      }
      
      public static function sortMiniGame(param1:*) : void
      {
         miniGames = param1;
         miniGames.sort(sortOnCategory);
         var _loc2_:uint = 0;
         while(_loc2_ < miniGames.length)
         {
            ChallengeWorld.miniGameID.push(miniGames[_loc2_]);
            _loc2_++;
         }
      }
      
      public static function getTotalChallengeScore(param1:Array) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += param1[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function sortOnCategory(param1:uint, param2:uint) : Number
      {
         var _loc3_:* = MinigameDefines.MINIGAMES[param1].category;
         var _loc4_:* = MinigameDefines.MINIGAMES[param2].category;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function gotoGameScreen(param1:Event) : void
      {
         Engine.playSound("ButtonInGame",1);
         speechText.reset();
         speechText.addString(Engine.getText("MiniGameSelect"));
         switch(param1.currentTarget)
         {
            case _gameSelectPage.singleButton:
               _selectGameType = SELECT_GAME_SINGLE;
               break;
            case _gameSelectPage.fullButton:
               _selectGameType = SELECT_GAME_FULL;
         }
         checkInitMinigame();
         updatePanelButton();
         if(_gameSelectPage.currentLabel == "Idle")
         {
            _gameSelectPage.gotoAndPlay("showMiniGame");
         }
      }
      
      public function showChallengeModeSelect() : void
      {
         _challengeModePage = new ChallengeModeSelect();
         setButtonMode(_challengeModePage.selectMode,true);
         setButtonMode(_challengeModePage.randomMode,true);
         _challengeModePage.selectMode.button.textField.mouseEnabled = false;
         _challengeModePage.randomMode.button.textField.mouseEnabled = false;
         Engine.setFontForLang(_challengeModePage.selectMode.button.textField,"Baveuse");
         Engine.setFontForLang(_challengeModePage.randomMode.button.textField,"Baveuse");
         _challengeModePage.selectMode.button.textField.text = Engine.getText("ChallengeSelect");
         _challengeModePage.randomMode.button.textField.text = Engine.getText("ChallengeRandom");
         _challengeModePage.selectMode.addEventListener(MouseEvent.MOUSE_DOWN,enterGameSelect,false,0,true);
         _challengeModePage.randomMode.addEventListener(MouseEvent.MOUSE_DOWN,enterGameSelect,false,0,true);
         setButtonMode(_challengeModePage.backButton,true);
         _challengeModePage.backButton.addEventListener(MouseEvent.MOUSE_DOWN,backClickListener);
         _challengeModePage.backButton.visible = false;
         GameWorld.gameShowFrame.bg.addChild(_challengeModePage);
         speechText = new SpeechTextObject(GameWorld.gameShowFrame.tutorialSpeechTextField.speechText,GameWorld.gameShowFrame.tutorialSpeechTextField);
         speechText.addString(Engine.getText("ChallengeModeSelect"));
      }
      
      public function enterGameSelect(param1:Event) : void
      {
         Engine.playSound("ButtonInGame",1);
         speechText.reset();
         speechText.addString(Engine.getText("ChallengeTypeSelect"));
         switch(param1.currentTarget)
         {
            case _challengeModePage.selectMode:
               challengeMode = CHALLENGE_MODE_SELECT;
               enterSelectGame();
               break;
            case _challengeModePage.randomMode:
               challengeMode = CHALLENGE_MODE_RANDOM;
               enterRandomGame();
         }
      }
      
      public function createRandomGameType() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:RandomBasket = null;
         var _loc3_:* = undefined;
         if(Preferences.values[Preferences.PROGAME_SELECTION] == null)
         {
            Preferences.values[Preferences.PROGAME_SELECTION] = new Array(MinigameDefines.NUM_MINIGAME_CAT);
            _loc1_ = 0;
            while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
            {
               _loc2_ = new RandomBasket();
               _loc3_ = 0;
               while(_loc3_ < MinigameDefines.NUM_MINIGAMES)
               {
                  if(GameWorld.currentUserInfo.isProUser)
                  {
                     if(MinigameDefines.MINIGAMES[_loc3_].category == _loc1_)
                     {
                        _loc2_.addItems(_loc3_);
                     }
                  }
                  else if(MinigameDefines.MINIGAMES[_loc3_].category == _loc1_ && !MinigameDefines.MINIGAMES[_loc3_].pro)
                  {
                     _loc2_.addItems(_loc3_);
                  }
                  _loc3_++;
               }
               Preferences.values[Preferences.PROGAME_SELECTION][_loc1_] = int(_loc2_.getNextItem());
               _loc1_++;
            }
         }
      }
      
      public function enterFriendPage() : void
      {
         var _loc1_:uint = 0;
         if(challengeMode == CHALLENGE_MODE_RANDOM)
         {
            Preferences.values[Preferences.PROGAME_SELECTION] = null;
            createRandomGameType();
            miniGameID = new Array();
            _loc1_ = 0;
            while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
            {
               miniGameID.push(Preferences.values[Preferences.PROGAME_SELECTION][_loc1_]);
               _loc1_++;
            }
            trace("miniGameID   == " + miniGameID);
         }
         else
         {
            switch(_selectGameType)
            {
               case SELECT_GAME_SINGLE:
                  miniGameID = new Array();
                  miniGameID.push(gameIndex);
                  break;
               case SELECT_GAME_FULL:
                  miniGameID = new Array();
                  _loc1_ = 0;
                  while(_loc1_ < Preferences.values[Preferences.PROGAME_SELECTION].length)
                  {
                     miniGameID.push(Preferences.values[Preferences.PROGAME_SELECTION][_loc1_]);
                     _loc1_++;
                  }
            }
         }
         trace("miniGameID  = " + miniGameID);
         firendsPage = null;
         firendsPage = new ChallengeFriendsPage();
         this.addChild(firendsPage);
      }
      
      public function updatePanelButton() : void
      {
         resetPlaneButton();
         switch(_selectGameType)
         {
            case SELECT_GAME_SINGLE:
               minigameCategory = minigameButtons[gameIndex].category;
               setButtonMode(minigameButtons[gameIndex],false);
               minigameButtons[gameIndex].gotoAndStop("selected");
               break;
            case SELECT_GAME_FULL:
               setSelectGame();
         }
      }
      
      public function setSelectGame() : void
      {
         createRandomGameType();
         var _loc1_:* = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
         {
            setSelectedMinigameButton(_gameSelectPage.gamePanel["minigame" + Preferences.values[Preferences.PROGAME_SELECTION][_loc1_]]);
            _loc1_++;
         }
      }
      
      private function backToModeScreen(param1:Event) : void
      {
         Engine.playSound("ButtonMenu",1);
         speechText.reset();
         speechText.addString(Engine.getText("ChallengeModeSelect"));
         setButtonMode(_challengeModePage.selectMode,true);
         setButtonMode(_challengeModePage.randomMode,true);
         _challengeModePage.selectMode.button.textField.mouseEnabled = false;
         _challengeModePage.randomMode.button.textField.mouseEnabled = false;
         _challengeModePage.selectMode.addEventListener(MouseEvent.MOUSE_DOWN,enterGameSelect,false,0,true);
         _challengeModePage.randomMode.addEventListener(MouseEvent.MOUSE_DOWN,enterGameSelect,false,0,true);
         setButtonMode(_challengeModePage.backButton,true);
         _challengeModePage.backButton.addEventListener(MouseEvent.MOUSE_DOWN,backClickListener);
         _challengeModePage.backButton.visible = false;
         param1.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN,backToModeScreen);
         _challengeModePage.removeChild(_gameSelectPage);
         _gameSelectPage = null;
         _challengeModePage.gotoAndPlay(1);
      }
      
      public function enterRandomGame() : void
      {
         closeChallengeModeSelect();
      }
      
      public function enterSelectGame() : void
      {
         _challengeModePage.gotoAndPlay("close");
      }
      
      public function init() : void
      {
         if(GameWorld.gameShowFrame == null || GameWorld.gameShowFrame.currentLabel != "zoomin1_idle")
         {
            GameWorld.addGameShowFrame("zoomin1");
         }
         showChallengeModeSelect();
      }
      
      public function setSelectedMinigameButton(param1:MovieClip) : *
      {
         if(selectedMinigameButtons[param1.category] != null)
         {
            setButtonMode(selectedMinigameButtons[param1.category],true);
            selectedMinigameButtons[param1.category].addEventListener(MouseEvent.CLICK,minigameSelectListener,false,0,true);
         }
         Preferences.values[Preferences.PROGAME_SELECTION][param1.category] = param1.minigameIndex;
         selectedMinigameButtons[param1.category] = param1;
         setButtonMode(param1,false);
         param1.gotoAndStop("selected");
      }
      
      public function resetPlaneButton() : void
      {
         var _loc1_:* = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            if(_gameSelectPage.gamePanel["minigame" + _loc1_] != null)
            {
               setButtonMode(_gameSelectPage.gamePanel["minigame" + _loc1_],true);
            }
            _loc1_++;
         }
      }
      
      public function checkInitMinigame() : void
      {
         var _loc1_:* = undefined;
         switch(_selectGameType)
         {
            case SELECT_GAME_SINGLE:
               break;
            case SELECT_GAME_FULL:
               selectedMinigameButtons = new Array();
               _loc1_ = 0;
               while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
               {
                  selectedMinigameButtons[_loc1_] = null;
                  _loc1_++;
               }
         }
      }
      
      override public function tick(param1:uint) : *
      {
         if(_challengeModePage != null && !_challengeModePage.backButton.visible)
         {
            if(GameWorld.gameShowFrame.currentLabel == "zoomin1_idle")
            {
               _challengeModePage.backButton.visible = true;
            }
         }
         if(_gameSelectPage != null && !_gameSelectPage.okButton.visible)
         {
            if(_gameSelectPage.currentLabel == "gameSelectEnd")
            {
               _gameSelectPage.okButton.visible = true;
            }
         }
         if(_challengeModePage.currentFrame == _challengeModePage.totalFrames)
         {
            _gameSelectPage = new ChallengeGameSelect();
            _challengeModePage.addChild(_gameSelectPage);
            initSelectGamePage();
            initMiniGameButton();
         }
         if(GameWorld.gameShowFrame != null && GameWorld.gameShowFrame.currentLabel == "zoomout1")
         {
            enterFriendPage();
            GameWorld.addGameShowFrame("zoomin1_idle");
         }
         if(firendsPage != null)
         {
            firendsPage.tick(0);
         }
      }
      
      public function closeChallengeModeSelect() : void
      {
         GameWorld.addGameShowFrame("zoomin2");
         GameWorld.gameShowFrame.iphoneButton.visible = false;
      }
      
      private function initMiniGameButton() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         minigameButtons = new Array();
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            if(_gameSelectPage.gamePanel["minigame" + _loc1_] != null)
            {
               _loc2_ = _gameSelectPage.gamePanel["minigame" + _loc1_];
               _loc2_.category = MinigameDefines.MINIGAMES[_loc1_].category;
               _loc2_.minigameIndex = _loc1_;
               _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,minigameSelectListener);
               minigameButtons.push(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
         {
            if(GameWorld.currentUserInfo.isProUser)
            {
               _gameSelectPage.gamePanel["proLock" + _loc1_].visible = false;
            }
            else
            {
               _gameSelectPage.gamePanel["proLock" + _loc1_].visible = true;
            }
            _loc1_++;
         }
      }
      
      public function initSelectGamePage() : void
      {
         setButtonMode(_gameSelectPage.singleButton,true);
         setButtonMode(_gameSelectPage.fullButton,true);
         Engine.setFontForLang(_gameSelectPage.singleButton.button.textfield,"Baveuse");
         Engine.setFontForLang(_gameSelectPage.fullButton.button.textfield,"Baveuse");
         _gameSelectPage.singleButton.button.textfield.text = Engine.getText("ChallengeSingle");
         _gameSelectPage.fullButton.button.textfield.text = Engine.getText("ChallengeFull");
         _gameSelectPage.singleButton.addEventListener(MouseEvent.MOUSE_DOWN,gotoGameScreen,false,0,true);
         _gameSelectPage.fullButton.addEventListener(MouseEvent.MOUSE_DOWN,gotoGameScreen,false,0,true);
         setButtonMode(_gameSelectPage.backButton,true);
         _gameSelectPage.backButton.addEventListener(MouseEvent.MOUSE_DOWN,backToModeScreen,false,0,true);
         setButtonMode(_gameSelectPage.okButton,true);
         _gameSelectPage.okButton.addEventListener(MouseEvent.MOUSE_DOWN,okListener,false,0,true);
         _gameSelectPage.okButton.visible = false;
      }
      
      public function backClickListener(param1:Event) : void
      {
         GameWorld.gameShowFrame.bg.removeChild(_challengeModePage);
         _challengeModePage = null;
         Engine.playSound("ButtonMenu",1);
         GameWorld.removeGameShowFrame();
         GameWorld.startMainMenu();
      }
      
      public function okListener(param1:Event) : void
      {
         Engine.playSound("ButtonInGame",1);
         enterFriendPage();
      }
      
      public function minigameSelectListener(param1:MouseEvent) : *
      {
         switch(_selectGameType)
         {
            case SELECT_GAME_SINGLE:
               Engine.playSound("ButtonInGame",1);
               gameIndex = minigameButtons.indexOf(param1.currentTarget);
               updatePanelButton();
               break;
            case SELECT_GAME_FULL:
               Engine.playSound("ButtonInGame",1);
               setSelectedMinigameButton(MovieClip(param1.currentTarget));
         }
      }
   }
}
