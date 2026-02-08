package com.playfish.games.ad2
{
   import com.doubleclick.dartshell.common.events.LogEvent;
   import com.doubleclick.dartshell.component.adholder.AdHolder;
   import fl.video.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class DoubleClickHandler extends AdHandler
   {
       
      
      private var config:Object;
      
      private var videoPlayer:FLVPlayback;
      
      private var skipTimer:Timer;
      
      private var videoAdHolder:AdHolder;
      
      private var debugTextField:TextField;
      
      private var unloaded:Boolean = false;
      
      public function DoubleClickHandler(param1:AdClient, param2:String, param3:int, param4:Object)
      {
         var adClient:AdClient = param1;
         var provider:String = param2;
         var placementId:int = param3;
         var config:Object = param4;
         this.config = config;
         super(adClient,provider,placementId);
         if(config.debug)
         {
            debugTextField = new TextField();
            debugTextField.width = 400;
            debugTextField.height = 300;
            debugTextField.y = -150;
            debugTextField.x = -200;
            debugTextField.mouseEnabled = false;
            debugTextField.selectable = false;
         }
         addDebugString("config.adTag=" + config.adTag);
         addDebugString("config.debug=" + config.debug);
         try
         {
            XML.ignoreWhitespace = true;
            XML.prettyPrinting = true;
            videoPlayer = new FLVPlayback();
            addChild(videoPlayer);
            videoAdHolder = new AdHolder();
            videoAdHolder.adTagURL = config.adTag;
            videoAdHolder.autoPlay = false;
            addDebugString("dartShellVersion=" + videoAdHolder.dartShellVersion);
            videoAdHolder.setClickTrackingMC(this);
            videoAdHolder.assignVideoObject(videoPlayer);
         }
         catch(e:Error)
         {
            addDebugString(e.getStackTrace());
            if(config.debug)
            {
               adState = AD_STATE_READY;
            }
         }
         if(debugTextField != null)
         {
            addChild(debugTextField);
         }
      }
      
      public function onSkipTimer(param1:TimerEvent) : *
      {
         skipTimer.stop();
         skipTimer = null;
         dispatchEvent(new Event(EVENT_ENABLE_SKIP));
      }
      
      internal function onLogEvent(param1:LogEvent) : void
      {
         addDebugString("Log: " + param1.message);
         if(param1.message.indexOf("onVideoStart") != -1)
         {
            dispatchEvent(new Event(EVENT_SHOW));
            adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_OK,placementId);
            if(!config.skipDelayMillis || config.skipDelayMillis == 0)
            {
               dispatchEvent(new Event(EVENT_ENABLE_SKIP));
            }
            else if(config.skipDelayMillis)
            {
               if(config.skipDelayMillis >= 0)
               {
                  skipTimer = new Timer(config.skipDelayMillis,1);
                  skipTimer.addEventListener(TimerEvent.TIMER,onSkipTimer);
                  skipTimer.start();
               }
            }
         }
      }
      
      internal function onDartInStreamAdLoaded(param1:Event) : void
      {
         addDebugString("onDartInStreamAdLoaded");
         adState = AD_STATE_READY;
         dispatchEvent(new Event(EVENT_READY_TO_PLAY));
      }
      
      override public function load() : *
      {
         videoAdHolder.addEventListener("onLogEvent",onLogEvent);
         videoAdHolder.addEventListener("onVideoComplete",onVideoComplete);
         videoAdHolder.addEventListener("onDartInStreamAdLoaded",onDartInStreamAdLoaded);
         videoAdHolder.addEventListener("onVideoPlaybackReady",onVideoPlaybackReady);
         videoAdHolder.addEventListener(StatusEvent.STATUS,onStatus);
         videoAdHolder.loadNewAd();
      }
      
      internal function onVideoPlaybackReady(param1:Event) : void
      {
         addDebugString("onVideoPlaybackReady");
      }
      
      private function onStatus(param1:StatusEvent) : *
      {
      }
      
      public function addDebugString(param1:String) : *
      {
         if(config.debug)
         {
            trace(param1);
            debugTextField.appendText(param1 + "\n");
         }
      }
      
      internal function onVideoStart(param1:Event) : void
      {
         addDebugString("onVideoStart");
      }
      
      override public function play() : *
      {
         try
         {
            videoPlayer.width = 400;
            videoPlayer.height = 300;
            videoPlayer.x = -videoPlayer.width / 2;
            videoPlayer.y = -videoPlayer.height / 2;
            videoAdHolder.playStream();
         }
         catch(e:Error)
         {
            addDebugString(e.getStackTrace());
         }
      }
      
      internal function onVideoComplete(param1:Event) : void
      {
         addDebugString("onVideoComplete");
         end();
         dispatchEvent(new Event(EVENT_COMPLETE));
      }
      
      override public function end() : *
      {
         addDebugString("end");
         if(!unloaded)
         {
            try
            {
               if(adState != AD_STATE_READY)
               {
                  adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_FAIL,placementId);
               }
               videoAdHolder.removeEventListener("onLogEvent",onLogEvent);
               videoAdHolder.removeEventListener("onVideoComplete",onVideoComplete);
               videoAdHolder.removeEventListener("onDartInStreamAdLoaded",onDartInStreamAdLoaded);
               videoAdHolder.removeEventListener("onVideoPlaybackReady",onVideoPlaybackReady);
               videoPlayer.stop();
               unloaded = true;
            }
            catch(e:Error)
            {
               addDebugString(e.getStackTrace());
            }
         }
      }
   }
}
