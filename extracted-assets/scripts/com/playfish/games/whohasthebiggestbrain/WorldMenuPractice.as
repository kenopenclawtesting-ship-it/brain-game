package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.*;
   import flash.events.*;
   
   public class WorldMenuPractice extends BaseWorld
   {
       
      
      private var backButton:MovieClip;
      
      private var scene:MovieClip;
      
      private var minigameButtons:Array;
      
      public function WorldMenuPractice()
      {
         var _loc3_:MovieClip = null;
         super();
         GameWorld.gameShowFrameGotoandPlay("zoomin1_idle");
         GameWorld.setProfessorState("ProfessorTalk");
         scene = new GameSelectPractice();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         minigameButtons = new Array();
         var _loc1_:* = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            if(scene["minigame" + _loc1_] != null)
            {
               _loc3_ = scene["minigame" + _loc1_];
               minigameButtons[_loc1_] = _loc3_;
               setButtonMode(_loc3_,true);
               _loc3_.addEventListener(MouseEvent.CLICK,minigameSelectListener);
            }
            _loc1_++;
         }
         backButton = new ButtonBack();
         backButton.x = WorldGameSelect.BACK_BUTTON_X;
         backButton.y = WorldGameSelect.BACK_BUTTON_Y;
         setButtonMode(backButton,true);
         backButton.addEventListener(MouseEvent.CLICK,backClickListener);
         addChild(backButton);
         var _loc2_:* = new SpeechTextObject(GameWorld.gameShowFrame.tutorialSpeechTextField.speechText,GameWorld.gameShowFrame.tutorialSpeechTextField);
         _loc2_.addString(LanguageTranslation.getPracticeText1(LanguageButton.currentLanguage));
      }
      
      public function minigameSelectListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:int = int(minigameButtons.indexOf(param1.currentTarget));
         GameWorld.startPractice(_loc2_);
      }
      
      public function backClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldGameSelect());
      }
   }
}
