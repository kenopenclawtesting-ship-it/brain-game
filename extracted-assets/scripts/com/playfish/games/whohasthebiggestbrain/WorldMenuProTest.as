package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   
   public class WorldMenuProTest extends BaseWorld
   {
       
      
      private var sceneGameSelect:MovieClip;
      
      private var okButton:MovieClip;
      
      private var minigameButtons:Array;
      
      private var backButton:MovieClip;
      
      private var selectedMinigameButtons:Array;
      
      public function WorldMenuProTest()
      {
         var _loc1_:* = undefined;
         var _loc3_:MovieClip = null;
         var _loc4_:RandomBasket = null;
         var _loc5_:* = undefined;
         super();
         sceneGameSelect = new GameSelect();
         sceneGameSelect.x = GameWorld.CANVAS_CENTER_X;
         sceneGameSelect.y = GameWorld.CANVAS_CENTER_Y;
         addChild(sceneGameSelect);
         minigameButtons = new Array();
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            if(sceneGameSelect["minigame" + _loc1_] != null)
            {
               _loc3_ = sceneGameSelect["minigame" + _loc1_];
               _loc3_.category = MinigameDefines.MINIGAMES[_loc1_].category;
               _loc3_.minigameIndex = _loc1_;
               minigameButtons[_loc1_] = _loc3_;
               setButtonMode(_loc3_,true);
               _loc3_.addEventListener(MouseEvent.CLICK,minigameSelectListener);
            }
            _loc1_++;
         }
         selectedMinigameButtons = new Array();
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
         {
            selectedMinigameButtons[_loc1_] = null;
            _loc1_++;
         }
         if(Preferences.values[Preferences.PROGAME_SELECTION] == null)
         {
            Preferences.values[Preferences.PROGAME_SELECTION] = new Array(MinigameDefines.NUM_MINIGAME_CAT);
            _loc1_ = 0;
            while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
            {
               _loc4_ = new RandomBasket();
               _loc5_ = 0;
               while(_loc5_ < MinigameDefines.NUM_MINIGAMES)
               {
                  if(MinigameDefines.MINIGAMES[_loc5_].category == _loc1_)
                  {
                     _loc4_.addItems(_loc5_);
                  }
                  _loc5_++;
               }
               Preferences.values[Preferences.PROGAME_SELECTION][_loc1_] = int(_loc4_.getNextItem());
               _loc1_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAME_CAT)
         {
            setSelectedMinigameButton(sceneGameSelect["minigame" + Preferences.values[Preferences.PROGAME_SELECTION][_loc1_]]);
            _loc1_++;
         }
         okButton = new ButtonOk();
         okButton.x = GameWorld.CANVAS_CENTER_X;
         okButton.y = GameWorld.CANVAS_HEIGHT - okButton.height / 2 - 10;
         setButtonMode(okButton,true);
         addChild(okButton);
         okButton.addEventListener(MouseEvent.CLICK,okButtonListener);
         backButton = new ButtonBack();
         backButton.x = WorldGameSelect.BACK_BUTTON_X;
         backButton.y = WorldGameSelect.BACK_BUTTON_Y;
         setButtonMode(backButton,true);
         backButton.addEventListener(MouseEvent.CLICK,backClickListener);
         addChild(backButton);
         var _loc2_:* = new SpeechTextObject(GameWorld.gameShowFrame.tutorialSpeechTextField.speechText,GameWorld.gameShowFrame.tutorialSpeechTextField);
         _loc2_.addString(LanguageTranslation.getProGameText(LanguageButton.currentLanguage));
      }
      
      public function minigameSelectListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         setSelectedMinigameButton(MovieClip(param1.currentTarget));
      }
      
      public function okButtonListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         var _loc2_:* = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < selectedMinigameButtons.length)
         {
            _loc2_[_loc3_] = selectedMinigameButtons[_loc3_].minigameIndex;
            _loc3_++;
         }
         Preferences.save(Preferences.PROGAME_SELECTION);
         GameWorld.startNewFullGame(_loc2_);
      }
      
      public function backClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldGameSelect());
      }
      
      public function setSelectedMinigameButton(param1:MovieClip) : *
      {
         trace("set selected button " + param1);
         if(selectedMinigameButtons[param1.category] != null)
         {
            setButtonMode(selectedMinigameButtons[param1.category],true);
            selectedMinigameButtons[param1.category].addEventListener(MouseEvent.CLICK,minigameSelectListener,false,0,true);
            trace("remove previous button " + selectedMinigameButtons[param1.category]);
         }
         Preferences.values[Preferences.PROGAME_SELECTION][param1.category] = param1.minigameIndex;
         selectedMinigameButtons[param1.category] = param1;
         setButtonMode(param1,false);
         param1.gotoAndStop("selected");
         param1.removeEventListener(MouseEvent.CLICK,minigameSelectListener);
      }
   }
}
