package com.playfish.games.ad2
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public dynamic class MochiAdHandler extends AdHandler
   {
       
      
      private var AD_HEIGHT:int = 250;
      
      private var timeoutTimer:Timer;
      
      private var AD_WIDTH:int = 300;
      
      private var id:String;
      
      private var unloaded:Boolean = false;
      
      public function MochiAdHandler(param1:AdClient, param2:String, param3:int, param4:Object)
      {
         super(param1,param2,param3);
         this.id = param4.mochiadId;
         trace("mochiad id=" + this.id);
      }
      
      public function adFailed() : *
      {
         trace("adFailed");
         end();
         adState = AD_STATE_ERROR;
         dispatchEvent(new Event(EVENT_LOAD_ERROR));
      }
      
      private function timeout(param1:TimerEvent) : *
      {
         timeoutTimer.stop();
         timeoutTimer = null;
         end();
         dispatchEvent(new Event(EVENT_LOAD_ERROR));
      }
      
      override public function end() : *
      {
         trace("end");
         if(!unloaded)
         {
            if(adState != AD_STATE_READY)
            {
               adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_FAIL,placementId);
            }
            MochiAd.unload(this);
            unloaded = true;
         }
      }
      
      public function adSkipped() : *
      {
         trace("adSkipped");
         end();
         adState = AD_STATE_ERROR;
         dispatchEvent(new Event(EVENT_LOAD_ERROR));
      }
      
      override public function load() : *
      {
         adState = AD_STATE_READY;
         dispatchEvent(new Event(EVENT_READY_TO_PLAY));
      }
      
      override public function play() : *
      {
         this.x = -AD_WIDTH / 2;
         this.y = -AD_HEIGHT / 2;
         var _loc1_:Object = {
            "clip":this,
            "id":this.id,
            "ad_loaded":adLoaded,
            "ad_finished":adFinished,
            "ad_failed":adFailed,
            "ad_skipped":adSkipped
         };
         trace("mochiad play");
         MochiAd.showClickAwayAd(_loc1_);
         timeoutTimer = new Timer(10000,1);
         timeoutTimer.addEventListener(TimerEvent.TIMER,timeout);
         timeoutTimer.start();
      }
      
      public function adLoaded(param1:Number, param2:Number) : *
      {
         trace("adLoaded");
         timeoutTimer.stop();
         timeoutTimer = null;
         adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_OK,placementId);
         dispatchEvent(new Event(EVENT_ENABLE_SKIP));
         dispatchEvent(new Event(EVENT_SHOW));
      }
      
      public function adFinished() : *
      {
         trace("adFinished");
         end();
         dispatchEvent(new Event(EVENT_COMPLETE));
      }
   }
}
