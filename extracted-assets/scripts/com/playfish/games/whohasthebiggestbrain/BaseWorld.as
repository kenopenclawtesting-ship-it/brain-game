package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.*;
   import flash.events.*;
   
   public class BaseWorld extends Sprite
   {
       
      
      public function BaseWorld()
      {
         super();
      }
      
      private static function buttonDownListener(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.currentTarget;
         _loc2_.gotoAndStop("down" + _loc2_["buttonSequence"]);
      }
      
      private static function buttonUpListener(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.currentTarget;
         _loc2_.gotoAndStop("over" + _loc2_["buttonSequence"]);
      }
      
      private static function buttonOverListener(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.currentTarget;
         _loc2_.gotoAndStop("over" + _loc2_["buttonSequence"]);
      }
      
      private static function buttonOutListener(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.currentTarget;
         _loc2_.gotoAndStop("up" + _loc2_["buttonSequence"]);
      }
      
      public static function setButtonMode(param1:MovieClip, param2:Boolean, param3:String = "") : *
      {
         if(param1 != null)
         {
            param1["buttonSequence"] = param3;
            param1.mouseChildren = false;
            if(param2)
            {
               param1.gotoAndStop("up" + param1["buttonSequence"]);
               param1.buttonMode = true;
               param1.addEventListener(MouseEvent.MOUSE_UP,buttonUpListener,false,-1,true);
               param1.addEventListener(MouseEvent.MOUSE_DOWN,buttonDownListener,false,-1,true);
               param1.addEventListener(MouseEvent.MOUSE_OVER,buttonOverListener,false,-1,true);
               param1.addEventListener(MouseEvent.MOUSE_OUT,buttonOutListener,false,-1,true);
            }
            else
            {
               param1.buttonMode = false;
               param1.removeEventListener(MouseEvent.MOUSE_UP,buttonUpListener);
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,buttonDownListener);
               param1.removeEventListener(MouseEvent.MOUSE_OVER,buttonOverListener);
               param1.removeEventListener(MouseEvent.MOUSE_OUT,buttonOutListener);
               delete param1["buttonSequence"];
            }
         }
      }
      
      public function keyDown(param1:int, param2:int) : *
      {
      }
      
      public function keyUp(param1:int, param2:int) : *
      {
      }
      
      public function destroy() : *
      {
      }
      
      public function notifyLanguageUpdate() : *
      {
      }
      
      public function tick(param1:uint) : *
      {
      }
   }
}
