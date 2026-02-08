package com.playfish.games.ad
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class AdHandler extends Sprite
   {
      
      public static const EVENT_SHOW:String = "SHOW";
      
      public static const AD_STATE_ERROR:int = 3;
      
      public static const AD_STATE_LOADING:int = 1;
      
      public static const AD_STATE_UNDETERMINED:int = 0;
      
      public static const EVENT_ENABLE_SKIP:String = "ENABLE_SKIP";
      
      public static const EVENT_READY_TO_PLAY:String = "READY_TO_PLAY";
      
      public static const AD_STATE_READY:int = 2;
      
      public static const EVENT_LOAD_ERROR:String = "LOAD_ERROR";
      
      public static const EVENT_COMPLETE:String = "COMPLETE";
       
      
      public var adState:int = 0;
      
      public function AdHandler()
      {
         super();
      }
      
      public function play() : *
      {
      }
      
      public function playTicker(param1:DisplayObjectContainer) : *
      {
      }
      
      public function load() : *
      {
      }
      
      public function isReady() : Boolean
      {
         return adState == AD_STATE_READY;
      }
      
      public function end() : *
      {
      }
      
      public function endTicker() : *
      {
      }
   }
}
