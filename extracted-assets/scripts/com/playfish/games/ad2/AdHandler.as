package com.playfish.games.ad2
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class AdHandler extends Sprite
   {
      
      public static const EVENT_SHOW:String = "SHOW";
      
      public static const AD_STATE_ERROR:int = 3;
      
      public static const AD_STATE_TIMEOUT:int = 4;
      
      public static const AD_STATE_LOADING:int = 1;
      
      public static const AD_STATE_UNDETERMINED:int = 0;
      
      public static const EVENT_ENABLE_SKIP:String = "ENABLE_SKIP";
      
      public static const EVENT_READY_TO_PLAY:String = "READY_TO_PLAY";
      
      public static const AD_STATE_READY:int = 2;
      
      public static const EVENT_LOAD_ERROR:String = "LOAD_ERROR";
      
      public static const EVENT_COMPLETE:String = "COMPLETE";
       
      
      public var placementId:int;
      
      public var adState:int = 0;
      
      public var provider:String;
      
      public var adClient:AdClient;
      
      public function AdHandler(param1:AdClient, param2:String, param3:int)
      {
         super();
         this.adClient = param1;
         this.provider = param2;
         this.placementId = param3;
      }
      
      public function endTicker() : *
      {
      }
      
      public function load() : *
      {
      }
      
      public function play() : *
      {
      }
      
      public function isReady() : Boolean
      {
         return adState == AD_STATE_READY;
      }
      
      public function end() : *
      {
      }
      
      public function playTicker(param1:DisplayObjectContainer) : *
      {
      }
   }
}
