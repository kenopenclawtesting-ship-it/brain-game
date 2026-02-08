package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LanguageButton extends MovieClip
   {
      
      public static var currentLanguage:String = "ENGLISH";
      
      public static const LANGUAGE_CHANGED:String = "LANGUAGE_CHANGED";
       
      
      internal var buttonSkin:LangButtonDown;
      
      internal var labelContainer:Sprite;
      
      internal var tf:TextField;
      
      internal var bg:Shape;
      
      internal var availableLanguages:Array;
      
      internal var currentIndex:int = 0;
      
      public function LanguageButton()
      {
         this.availableLanguages = ["ENGLISH","ESPAÑOL","FRANÇAIS","ITALIANO","PORTUGUÊS","DEUTSCH","NEDERLANDS","SVENSKA","NORSK","SUOMI","POLSKI","ΕΛΛΗΝΙΚΑ"];
         super();
         var so:SharedObject = SharedObject.getLocal("gameSettings");
         if(so.data.selectedLanguageIndex != undefined)
         {
            currentIndex = so.data.selectedLanguageIndex;
         }
         buttonSkin = new LangButtonDown();
         buttonSkin.stop();
         addChild(buttonSkin);
         buttonSkin.alpha = 0;
         labelContainer = new Sprite();
         addChild(labelContainer);
         bg = new Shape();
         labelContainer.addChild(bg);
         tf = new TextField();
         tf.defaultTextFormat = new TextFormat("Arial",9,16777215,true);
         tf.mouseEnabled = false;
         tf.autoSize = "center";
         tf.text = availableLanguages[currentIndex];
         tf.alpha = 0;
         bg.alpha = 0;
         currentLanguage = availableLanguages[currentIndex];
         labelContainer.addChild(tf);
         redrawBackground();
         repositionLabel();
         buttonMode = true;
         mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_OVER,onOver);
         addEventListener(MouseEvent.MOUSE_OUT,onOut);
         addEventListener(MouseEvent.MOUSE_DOWN,onDown);
         addEventListener(MouseEvent.MOUSE_UP,onUp);
         addEventListener(MouseEvent.CLICK,onClick);
      }
      
      private function redrawBackground() : void
      {
         var bgWidth:Number = buttonSkin.width - 4;
         var bgHeight:Number = tf.textHeight + 2;
         bg.graphics.clear();
         bg.graphics.beginFill(0);
         bg.graphics.drawRect(0,0,bgWidth,bgHeight);
         bg.graphics.endFill();
         tf.x = buttonSkin.x - buttonSkin.x / 2;
         tf.y = buttonSkin.y;
      }
      
      private function repositionLabel() : void
      {
         labelContainer.x = buttonSkin.x - buttonSkin.x / 2 - 25;
         labelContainer.y = buttonSkin.y + 4;
      }
      
      private function onOver(e:MouseEvent) : void
      {
         buttonSkin.gotoAndStop("over");
         repositionLabel();
         if(parent && parent.hasOwnProperty("languageButton"))
         {
            var originalBtn:Object = parent["languageButton"];
            if(originalBtn)
            {
               originalBtn.gotoAndStop("over");
            }
         }
      }
      
      private function onOut(e:MouseEvent) : void
      {
         buttonSkin.gotoAndStop("up");
         repositionLabel();
         if(parent && parent.hasOwnProperty("languageButton"))
         {
            var originalBtn:Object = parent["languageButton"];
            if(originalBtn)
            {
               originalBtn.gotoAndStop("up");
            }
         }
      }
      
      private function onDown(e:MouseEvent) : void
      {
         buttonSkin.gotoAndStop("down");
         repositionLabel();
         if(parent && parent.hasOwnProperty("languageButton"))
         {
            var originalBtn:Object = parent["languageButton"];
            if(originalBtn)
            {
               originalBtn.gotoAndStop("down");
            }
         }
      }
      
      private function onUp(e:MouseEvent) : void
      {
         buttonSkin.gotoAndStop("up");
         repositionLabel();
         if(parent && parent.hasOwnProperty("languageButton"))
         {
            var originalBtn:Object = parent["languageButton"];
            if(originalBtn)
            {
               originalBtn.gotoAndStop("up");
            }
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         ++currentIndex;
         if(currentIndex >= availableLanguages.length)
         {
            currentIndex = 0;
         }
         currentLanguage = availableLanguages[currentIndex];
         tf.text = currentLanguage;
         tf.alpha = 0;
         redrawBackground();
         repositionLabel();
         var so:SharedObject = SharedObject.getLocal("gameSettings");
         so.data.selectedLanguageIndex = currentIndex;
         so.flush();
         dispatchEvent(new Event(LANGUAGE_CHANGED,true));
         MinigameDefines.refreshMinigameTexts();
      }
   }
}
