package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class WorldGameSelect extends BaseWorld
   {
      
      public static const BACK_BUTTON_X:int = 40;
      
      public static const BACK_BUTTON_Y:int = 40;
       
      
      private var sceneMenu:MovieClip;
      
      private var speechText:SpeechTextObject;
      
      private var backButton:MovieClip;
      
      public function WorldGameSelect()
      {
         super();
         if(GameWorld.gameShowFrame == null || GameWorld.gameShowFrame.currentLabel != "zoomin1_idle")
         {
            GameWorld.gameShowFrameGotoandPlay("zoomin1");
         }
         sceneMenu = new PlayMenu();
         GameWorld.gameShowFrame.bg.addChild(sceneMenu);
         sceneMenu.practiceButton.content.textField.mouseEnabled = false;
         sceneMenu.normalTestButton.content.textField.mouseEnabled = false;
         sceneMenu.proTestButton.content.textField.mouseEnabled = false;
         Engine.setFontForLang(sceneMenu.practiceButton.content.textField,"Baveuse");
         Engine.setFontForLang(sceneMenu.normalTestButton.content.textField,"Baveuse");
         Engine.setFontForLang(sceneMenu.proTestButton.content.textField,"Baveuse");
         sceneMenu.practiceButton.content.textField.text = LanguageTranslation.getPracticeButtonText(LanguageButton.currentLanguage);
         sceneMenu.normalTestButton.content.textField.text = LanguageTranslation.getClassicButtonText(LanguageButton.currentLanguage);
         sceneMenu.proTestButton.content.textField.text = LanguageTranslation.getProButtonText(LanguageButton.currentLanguage);
         sceneMenu.normalTestButton.addEventListener(MouseEvent.CLICK,normalTestClickListener);
         setButtonMode(sceneMenu.normalTestButton,true);
         setButtonMode(sceneMenu.practiceButton,true);
         sceneMenu.practiceButton.addEventListener(MouseEvent.CLICK,practiceClickListener);
         setButtonMode(sceneMenu.proTestButton,true);
         sceneMenu.proTestButton.addEventListener(MouseEvent.CLICK,proTestClickListener);
         backButton = new ButtonBack();
         backButton.x = BACK_BUTTON_X;
         backButton.y = BACK_BUTTON_Y;
         setButtonMode(backButton,true);
         backButton.addEventListener(MouseEvent.CLICK,backClickListener);
         addChild(backButton);
         backButton.visible = false;
         speechText = new SpeechTextObject(GameWorld.gameShowFrame.tutorialSpeechTextField.speechText,GameWorld.gameShowFrame.tutorialSpeechTextField);
         speechText.addString(LanguageTranslation.getGameSelectText(LanguageButton.currentLanguage));
      }
      
      public function practiceRollOverListener(param1:MouseEvent) : *
      {
         speechText.reset();
         speechText.setCurrentString(Engine.getText("PracticeSelectUpSell"));
      }
      
      public function practiceClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         GameWorld.gameShowFrame.bg.removeChild(sceneMenu);
         Engine.setActiveWorld(new WorldMenuPractice());
      }
      
      public function normalTestClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         GameWorld.gameState = GameWorld.GS_FULL_GAME;
         GameWorld.startNewFullGame();
      }
      
      public function proTestRollOverListener(param1:MouseEvent) : *
      {
         speechText.reset();
         speechText.setCurrentString(Engine.getText("ProGameSelectUpSell"));
      }
      
      override public function tick(param1:uint) : *
      {
         if(!backButton.visible)
         {
            if(GameWorld.gameShowFrame.currentLabel == "zoomin1_idle")
            {
               backButton.visible = true;
            }
         }
      }
      
      public function backClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         GameWorld.removeGameShowFrame();
         GameWorld.addGameShowFrame("menu_start");
         GameWorld.startMainMenu();
      }
      
      public function upsellRollOutListener(param1:MouseEvent) : *
      {
         speechText.reset();
         speechText.setCurrentString(Engine.getText("GameSelectMainMenu"));
      }
      
      public function proTestClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         GameWorld.gameShowFrame.bg.removeChild(sceneMenu);
         Engine.setActiveWorld(new WorldMenuProTest());
      }
   }
}
