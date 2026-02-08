package com.playfish.games.ad2
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.URLRequest;
   import flash.system.*;
   import flash.utils.*;
   
   public class YumeAdHandler extends AdHandler
   {
       
      
      private var YUME_SWF_LIBRARY_URL:String = "yume_ad_library.swf";
      
      private var AD_HEIGHT:int = 300;
      
      private var skipTimer:Timer;
      
      private var yumeAdContainer:MovieClip;
      
      private var playlist:String;
      
      private var AD_WIDTH:int = 400;
      
      private var unloaded:Boolean = false;
      
      private var libPath:String = "";
      
      private var YUME_SWF_URL:String = "yume_player_4x3.swf";
      
      private var skipDelayMillis:int = 10000;
      
      private var yumeAd:MovieClip;
      
      private var adType:String;
      
      public function YumeAdHandler(param1:AdClient, param2:String, param3:int, param4:Object)
      {
         super(param1,param2,param3);
         this.playlist = param4.playlist;
         this.adType = param4.adType;
         if(param4.skipDelayMillis)
         {
            this.skipDelayMillis = param4.skipDelayMillis;
         }
         if(param4.libPath != null)
         {
            this.libPath = param4.libPath;
         }
         trace("playlist=" + playlist + " adType=" + adType + " libPath=" + libPath + " skipDelayMillis=" + skipDelayMillis);
      }
      
      private function onLibraryLoaded(param1:Event) : void
      {
         trace("onLibraryLoaded");
         yumeAd = param1.currentTarget.content;
         adState = AD_STATE_READY;
         dispatchEvent(new Event(EVENT_READY_TO_PLAY));
      }
      
      private function onAdPlaying(param1:Event) : void
      {
         trace("onAdPlaying");
         adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_OK,placementId);
         dispatchEvent(new Event(EVENT_SHOW));
         yumeAd.yume_ad.removeEventListener("ad_playing",onAdPlaying);
      }
      
      override public function end() : *
      {
         trace("end");
         if(!unloaded)
         {
            if(adState == AD_STATE_ERROR)
            {
               adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_FAIL,placementId,"no_ad");
            }
            if(yumeAdContainer != null)
            {
               removeChild(yumeAdContainer);
            }
            if(yumeAd != null)
            {
               yumeAd.yume_ad.remove_ad();
               yumeAd = null;
            }
            destroySkipTimer();
            yumeAdContainer = null;
            unloaded = true;
         }
      }
      
      private function onAdCompleted(param1:Event) : void
      {
         trace("onAdCompleted");
         end();
         dispatchEvent(new Event(EVENT_COMPLETE));
      }
      
      private function destroySkipTimer() : void
      {
         if(skipTimer != null)
         {
            skipTimer.removeEventListener(TimerEvent.TIMER,onSkipTimer);
            skipTimer.stop();
            skipTimer = null;
         }
      }
      
      override public function load() : *
      {
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         var _loc1_:Loader = new Loader();
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLibraryLoaded);
         _loc1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLibraryFailed);
         _loc1_.load(new URLRequest(libPath + YUME_SWF_LIBRARY_URL));
      }
      
      override public function play() : *
      {
         yumeAdContainer = new MovieClip();
         yumeAdContainer.x = -AD_WIDTH / 2;
         yumeAdContainer.y = -AD_HEIGHT / 2;
         addChild(yumeAdContainer);
         var _loc1_:Object = new Object();
         _loc1_.parent_mc = yumeAdContainer;
         _loc1_.ad_type = adType;
         _loc1_.yume_url = libPath + YUME_SWF_URL;
         _loc1_.playlist = playlist;
         _loc1_.update_interval = 1;
         _loc1_.ad_volume = 100;
         _loc1_.normalscreen_x = 0;
         _loc1_.normalscreen_y = 0;
         _loc1_.normalscreen_width = AD_WIDTH;
         _loc1_.normalscreen_height = AD_HEIGHT;
         _loc1_.fullscreen_x = 0;
         _loc1_.fullscreen_y = 0;
         _loc1_.fullscreen_width = 640;
         _loc1_.fullscreen_height = 480;
         yumeAd.yume_ad.addEventListener("ad_completed",onAdCompleted);
         yumeAd.yume_ad.addEventListener("ad_closed",onAdClosed);
         yumeAd.yume_ad.addEventListener("ad_absent",onAdAbsent);
         yumeAd.yume_ad.addEventListener("ad_playing",onAdPlaying);
         yumeAd.yume_ad.start_ad(_loc1_);
         if(skipDelayMillis == 0)
         {
            dispatchEvent(new Event(EVENT_ENABLE_SKIP));
         }
         else if(skipDelayMillis > 0)
         {
            skipTimer = new Timer(skipDelayMillis,1);
            skipTimer.addEventListener(TimerEvent.TIMER,onSkipTimer);
            skipTimer.start();
         }
      }
      
      private function onAdClosed(param1:Event) : void
      {
         trace("onAdClosed");
         end();
         dispatchEvent(new Event(EVENT_COMPLETE));
      }
      
      private function onSkipTimer(param1:TimerEvent) : void
      {
         destroySkipTimer();
         dispatchEvent(new Event(EVENT_ENABLE_SKIP));
      }
      
      private function onLibraryFailed(param1:IOErrorEvent) : void
      {
         trace("onLibraryFailed");
         adState = AD_STATE_ERROR;
         end();
         dispatchEvent(new Event(EVENT_LOAD_ERROR));
      }
      
      private function onAdAbsent(param1:Event) : void
      {
         trace("onAdAbsent");
         adState = AD_STATE_ERROR;
         end();
         dispatchEvent(new Event(EVENT_LOAD_ERROR));
      }
   }
}
