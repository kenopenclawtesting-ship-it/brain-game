package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.text.*;
   
   public class SpeechTextObject
   {
       
      
      internal var stringSwitchTimer:int = 0;
      
      internal var curStringIndex:int = -1;
      
      internal var strings:Array;
      
      internal var loop:Boolean = false;
      
      internal var textField:TextField;
      
      internal var alphaLayer:Sprite;
      
      internal var textFieldContainer:DisplayObjectContainer;
      
      public var stringSwitchDelay:int = 4000;
      
      public function SpeechTextObject(param1:TextField, param2:DisplayObjectContainer = null)
      {
         super();
         param2 = null;
         this.textField = param1;
         this.textFieldContainer = param2;
         Engine.setFontForLang(param1,"Arial Black");
         if(param2 != null)
         {
            alphaLayer = Sprite(param2.getChildByName("AlphaLayer"));
            if(alphaLayer == null)
            {
               alphaLayer = new Sprite();
               alphaLayer.name = "AlphaLayer";
               param2.addChild(alphaLayer);
            }
            alphaLayer.graphics.beginFill(16777215);
            alphaLayer.graphics.drawRect(0,0,param1.width,param1.height);
            alphaLayer.x = param1.x;
            alphaLayer.y = param1.y;
         }
         reset();
      }
      
      public function addString(... rest) : *
      {
         var _loc2_:* = undefined;
         if(rest != null && rest.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < rest.length)
            {
               strings.push(rest[_loc2_]);
               _loc2_++;
            }
            if(curStringIndex == -1)
            {
               curStringIndex = 0;
               setCurrentString(strings[curStringIndex]);
            }
         }
      }
      
      public function reset() : *
      {
         strings = new Array();
         stringSwitchTimer = 0;
         curStringIndex = -1;
      }
      
      public function setCurrentString(param1:String) : *
      {
         textField.htmlText = param1;
         stringSwitchTimer = stringSwitchDelay;
         textField.y = -textField.textHeight / 2;
         if(alphaLayer != null)
         {
            alphaLayer.y = textField.y;
            alphaLayer.alpha = 1;
         }
      }
      
      public function close() : *
      {
         if(textFieldContainer != null)
         {
            textFieldContainer.removeChild(alphaLayer);
         }
      }
      
      public function tick(param1:int) : *
      {
         if(strings.length > 0)
         {
            stringSwitchTimer -= param1;
            if(stringSwitchTimer <= 0)
            {
               if(curStringIndex < strings.length - 1)
               {
                  ++curStringIndex;
               }
               else if(loop)
               {
                  curStringIndex = 0;
               }
               setCurrentString(strings[curStringIndex]);
            }
         }
         if(textFieldContainer != null && textFieldContainer.alpha > 0)
         {
            textFieldContainer.alpha -= 0.1;
         }
      }
   }
}
