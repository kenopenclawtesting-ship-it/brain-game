package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.media.*;
   
   public class TutorialScreen extends BaseWorld
   {
       
      
      internal var minigameIndex:int;
      
      internal var scene:MovieClip;
      
      internal var state:int;
      
      internal var fadeToWhiteLayer:Sprite;
      
      internal const STATE_END:int = 3;
      
      internal var speechText:SpeechTextObject;
      
      internal const PRE_TEXT_TO_TUTORIAL_DELAY:int = 5000;
      
      internal var skipPreText:Boolean;
      
      internal const STATE_LOOP:int = 2;
      
      internal var skipButton:MovieClip;
      
      internal var tutorialMC:MovieClip;
      
      internal const STATE_PRE_TEXT:int = 1;
      
      internal const STATE_FADE_IN:int = 0;
      
      internal var skip:Boolean = false;
      
      public function TutorialScreen(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         super();
         this.skipPreText = param3;
         x = GameWorld.CANVAS_CENTER_X;
         y = GameWorld.CANVAS_CENTER_Y;
         var _loc4_:* = MinigameDefines.MINIGAMES[param1].category;
         this.minigameIndex = param1;
         if(GameWorld.gameShowFrame == null || GameWorld.gameShowFrame.currentLabel != "zoomin1_idle")
         {
            if(_loc4_ == 0)
            {
               if(GameWorld.gameShowFrame.currentLabel == "menu_idle")
               {
                  GameWorld.addGameShowFrame("zoomin1");
               }
            }
            else
            {
               GameWorld.addGameShowFrame("zoomout1");
            }
         }
         GameWorld.gameShowFrame.bg.removeChildAt(0);
         GameWorld.gameShowFrame.bg.addChild(new MinigameDefines.TUTORIAL_SCENE_CLASS.[_loc4_]());
         GameWorld.gameShowFrame.goProButton.visible = false;
         GameWorld.gameShowFrame.iphoneButton.visible = false;
         speechText = new SpeechTextObject(GameWorld.gameShowFrame.tutorialSpeechTextField.speechText,GameWorld.gameShowFrame.tutorialSpeechTextField);
         if(GameWorld.languageButtonNew != null)
         {
            GameWorld.languageButtonNew.visible = false;
         }
         state = STATE_FADE_IN;
         if(!Engine.isSoundPlaying("ThemeMusic"))
         {
            Engine.playSound("ThemeMusic",0);
         }
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:* = undefined;
         if(speechText != null)
         {
            speechText.tick(param1);
         }
         if(state == STATE_END)
         {
            if(GameWorld.gameShowFrame.currentLabel == "zoomout1")
            {
               GameWorld.startMinigame(minigameIndex);
            }
         }
         else if(state == STATE_FADE_IN)
         {
            if(GameWorld.gameShowFrame.currentLabel == "zoomin1_idle" || GameWorld.gameShowFrame.currentLabel == "zoomout1_idle")
            {
               skipButton = new ButtonOk();
               skipButton.x = 0;
               skipButton.y = GameWorld.CANVAS_HEIGHT / 2 - skipButton.height;
               setButtonMode(skipButton,true);
               addChild(skipButton);
               skipButton.addEventListener(MouseEvent.CLICK,skipButtonDownListener);
               if(skipPreText)
               {
                  startTutorial();
               }
               else
               {
                  state = STATE_PRE_TEXT;
                  _loc2_ = MinigameDefines.MINIGAMES[minigameIndex].category;
                  speechText.addString(MinigameDefines.TUTORIAL_PRE_TEXT_FOR_CATEGORY[_loc2_]);
               }
            }
         }
         else if(state == STATE_PRE_TEXT)
         {
            if(skip)
            {
               skip = false;
               startTutorial();
            }
         }
         else if(state == STATE_LOOP)
         {
            if(skip)
            {
               skip = false;
               if(tutorialMC != null)
               {
                  removeChild(tutorialMC);
               }
               GameWorld.gameShowFrame.gotoAndPlay("zoomin2");
               state = STATE_END;
               skipButton.removeEventListener(MouseEvent.CLICK,skipButtonDownListener);
               removeChild(skipButton);
               Engine.stopSound("ThemeMusic");
            }
         }
      }
      
      public function skipButtonDownListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         if(state == STATE_PRE_TEXT)
         {
            skip = true;
         }
         else if(state == STATE_LOOP)
         {
            skip = true;
         }
      }
      
      public function startTutorial() : *
      {
         if(MinigameDefines.MINIGAMES[minigameIndex].tutorial != null)
         {
            tutorialMC = new MinigameDefines.MINIGAMES[minigameIndex].tutorial();
            tutorialMC.mouseChildren = false;
            tutorialMC.mouseEnabled = false;
            addChild(tutorialMC);
         }
         speechText.reset();
         if(MinigameDefines.MINIGAMES[minigameIndex].tutorialText != null)
         {
            speechText.addString(MinigameDefines.MINIGAMES[minigameIndex].tutorialText);
         }
         GameWorld.setProfessorState("ProfessorTalk");
         state = STATE_LOOP;
      }
   }
}
