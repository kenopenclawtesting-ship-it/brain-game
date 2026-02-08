package com.playfish.games.ad2
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class GoogleAdHandler extends AdHandler
   {
      
      private static const PUBLISHER_CONNECTION:String = "_video_publisher";
      
      private static const AD_HEIGHT:int = 300;
      
      private static const GOOGLE_CONNECTION:String = "_google_video_ads";
      
      private static const AD_WIDTH:int = 400;
      
      private static const TEST_PUBLISHER_ID:String = "ca-games-test";
      
      private static const GOOGLE_AD_TYPE_VIDEO:int = 0;
      
      private static const GOOGLE_AD_TYPE_FULLSCREEN:int = 1;
      
      private static const GOOGLE_ADS_DOMAIN:String = "pagead2.googlesyndication.com";
      
      private static const TEST_CHANNELS:Array = ["testing"];
      
      private static const PUBLISHER_ID:String = "ca-games-pub-7165792463476965";
       
      
      private var config:Object;
      
      private var skipTimer:Timer;
      
      private var videoAdRequestConfig:Object;
      
      private var googleAdType:int = -1;
      
      private var player:MovieClip;
      
      private var textAdRequestConfig:Object;
      
      private var googleAds:Object;
      
      private var debugTextField:TextField;
      
      public function GoogleAdHandler(param1:AdClient, param2:String, param3:int, param4:Object)
      {
         videoAdRequestConfig = {
            "contentId":"test",
            "productType":"4",
            "publisherId":PUBLISHER_ID,
            "maxTotalAdDuration":300000,
            "channels":TEST_CHANNELS,
            "adType":"video"
         };
         textAdRequestConfig = {
            "contentId":"test",
            "productType":"4",
            "adType":"fullscreen",
            "adTimePosition":"0",
            "pubWidth":AD_WIDTH.toString(),
            "pubHeight":AD_HEIGHT.toString(),
            "descriptionUrl":"https://www.playfish.com",
            "publisherId":PUBLISHER_ID,
            "channels":TEST_CHANNELS,
            "numAds":"3"
         };
         super(param1,param2,param3);
         this.config = param4;
         videoAdRequestConfig.contentId = config.contentId;
         videoAdRequestConfig.channels = [config.videoAdChannel];
         textAdRequestConfig.contentId = config.contentId;
         textAdRequestConfig.channels = [config.textAdChannel];
         textAdRequestConfig.descriptionUrl = config.descriptionUrl;
         if(config.test)
         {
            videoAdRequestConfig.channels = TEST_CHANNELS;
            textAdRequestConfig.channels = TEST_CHANNELS;
            videoAdRequestConfig.publisherId = TEST_PUBLISHER_ID;
            textAdRequestConfig.publisherId = TEST_PUBLISHER_ID;
            videoAdRequestConfig.adtest = "on";
            textAdRequestConfig.adtest = "on";
         }
         if(config.debug)
         {
            debugTextField = new TextField();
            debugTextField.width = 500;
            debugTextField.height = 500;
            debugTextField.x = -AD_WIDTH / 2;
            debugTextField.y = -AD_HEIGHT / 2;
            debugTextField.wordWrap = true;
            debugTextField.mouseEnabled = false;
            debugTextField.selectable = false;
            addChild(debugTextField);
         }
      }
      
      public function onFullscreenAdRequestResult(param1:Object) : *
      {
         addDebugString("onFullscreenAdRequestResult, success = " + param1.success);
         if(param1.success)
         {
            player = param1.ads[0].getAdPlayerMovieClip();
            player.setSize(AD_WIDTH,AD_HEIGHT);
            player.load();
            player.onError = onError;
            player.enableContentControls = enableContentControls;
            googleAdType = GOOGLE_AD_TYPE_FULLSCREEN;
            adState = AD_STATE_READY;
            dispatchEvent(new Event(EVENT_READY_TO_PLAY));
         }
         else
         {
            addDebugString("error: " + param1.errorMsg);
            adState = AD_STATE_ERROR;
            end();
            dispatchEvent(new Event(EVENT_LOAD_ERROR));
         }
      }
      
      private function onLoadInit(param1:Event) : *
      {
         addDebugString("onLoadInit");
         googleAds = param1.target.content;
         if(config.forceTextAds)
         {
            requestTextAd();
         }
         else
         {
            requestVideoAd();
         }
      }
      
      public function skipTimerListener(param1:TimerEvent) : *
      {
         skipTimer.stop();
         skipTimer = null;
         dispatchEvent(new Event(EVENT_ENABLE_SKIP));
      }
      
      override public function end() : *
      {
         try
         {
            if(adState == AD_STATE_ERROR)
            {
               adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_FAIL,placementId,"no_ad");
            }
            else if(adState != AD_STATE_READY)
            {
               adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_FAIL,placementId,"no_response");
            }
            if(skipTimer != null)
            {
               skipTimer.stop();
               skipTimer = null;
            }
            if(player != null)
            {
               player.destroy();
            }
         }
         catch(e:Error)
         {
            addDebugString("Error: end() " + e.toString());
         }
      }
      
      private function requestTextAd() : *
      {
         googleAds.requestAds(textAdRequestConfig,onFullscreenAdRequestResult);
      }
      
      public function addDebugString(param1:String) : *
      {
         if(config.debug)
         {
            trace(param1);
            debugTextField.appendText(param1 + "\n");
         }
      }
      
      private function enableContentControls() : void
      {
         addDebugString("enableContentControls");
         end();
         dispatchEvent(new Event(EVENT_COMPLETE));
      }
      
      private function onError() : void
      {
         addDebugString("error");
      }
      
      private function onLoadError(param1:IOErrorEvent) : *
      {
         addDebugString("onLoadError " + param1.toString());
         adState = AD_STATE_ERROR;
         end();
         dispatchEvent(new Event(EVENT_LOAD_ERROR));
      }
      
      override public function load() : *
      {
         var loader:Loader = null;
         var urlReq:URLRequest = null;
         adState = AD_STATE_LOADING;
         Security.allowDomain(GOOGLE_ADS_DOMAIN);
         try
         {
            addDebugString("loading Google ads swf...");
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadInit);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
            addChild(loader);
            urlReq = new URLRequest("http://pagead2.googlesyndication.com/pagead/scache/googlevideoadslibraryas3.swf");
            loader.load(urlReq);
         }
         catch(e:Error)
         {
            addDebugString("Error: load() " + e.toString());
            adState = AD_STATE_ERROR;
            end();
            dispatchEvent(new Event(EVENT_LOAD_ERROR));
         }
      }
      
      private function requestVideoAd() : *
      {
         googleAds.requestAds(videoAdRequestConfig,onVideoAdRequestResult);
      }
      
      override public function play() : *
      {
         if(adState == AD_STATE_READY)
         {
            if(googleAdType == GOOGLE_AD_TYPE_VIDEO)
            {
               player.playAds();
               if(!config.skipDelayMillisVideo || config.skipDelayMillisVideo == 0)
               {
                  dispatchEvent(new Event(EVENT_ENABLE_SKIP));
               }
               else if(config.skipDelayMillisVideo)
               {
                  if(config.skipDelayMillisVideo >= 0)
                  {
                     skipTimer = new Timer(config.skipDelayMillisVideo,1);
                     skipTimer.addEventListener(TimerEvent.TIMER,skipTimerListener);
                     skipTimer.start();
                  }
               }
            }
            else if(googleAdType == GOOGLE_AD_TYPE_FULLSCREEN)
            {
               player.playAds(15);
               if(!config.skipDelayMillisText || config.skipDelayMillisText == 0)
               {
                  dispatchEvent(new Event(EVENT_ENABLE_SKIP));
               }
               else if(config.skipDelayMillisText)
               {
                  if(config.skipDelayMillisText >= 0)
                  {
                     skipTimer = new Timer(config.skipDelayMillisText,1);
                     skipTimer.addEventListener(TimerEvent.TIMER,skipTimerListener);
                     skipTimer.start();
                  }
               }
            }
            x -= AD_WIDTH / 2;
            y -= AD_HEIGHT / 2;
            adClient.recordAdEvent(provider,AdClient.AD_EVENT_RESULT_OK,placementId);
            dispatchEvent(new Event(EVENT_SHOW));
         }
      }
      
      public function onVideoAdRequestResult(param1:Object) : *
      {
         addDebugString("onAdsRequestResult, success = " + param1.success);
         if(param1.success)
         {
            player = param1.ads[0].getAdPlayerMovieClip();
            player.setSize(AD_WIDTH,AD_HEIGHT);
            player.load();
            player.onError = onError;
            player.enableContentControls = enableContentControls;
            googleAdType = GOOGLE_AD_TYPE_VIDEO;
            adState = AD_STATE_READY;
            dispatchEvent(new Event(EVENT_READY_TO_PLAY));
         }
         else
         {
            addDebugString("error: " + param1.errorMsg);
            requestTextAd();
         }
      }
   }
}
