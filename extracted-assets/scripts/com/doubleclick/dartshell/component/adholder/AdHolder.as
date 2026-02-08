package com.doubleclick.dartshell.component.adholder
{
   import com.doubleclick.dartshell.ad.Ad;
   import com.doubleclick.dartshell.ad.CustomAd;
   import com.doubleclick.dartshell.ad.events.CustomAdLoadedEvent;
   import com.doubleclick.dartshell.ad.instream.DartInStreamAd;
   import com.doubleclick.dartshell.ad.instream.events.DartInStreamAdLoadedEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoClickEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoCompleteEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoMidpointEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoPauseEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoReStartEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoSoundMuteEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoStartEvent;
   import com.doubleclick.dartshell.ad.instream.monitoring.events.VideoStopEvent;
   import com.doubleclick.dartshell.ad.instream.playback.NetStreamPlayback;
   import com.doubleclick.dartshell.ad.instream.playback.VideoPlayback;
   import com.doubleclick.dartshell.ad.instream.playback.events.VideoPlaybackReadyEvent;
   import com.doubleclick.dartshell.common.events.LogEvent;
   import com.doubleclick.dartshell.errors.DartShellError;
   import com.doubleclick.dartshell.errors.events.DartShellErrorEvent;
   import com.doubleclick.dartshell.events.DartShellLoadedEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.NetStream;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1575")]
   public class AdHolder extends Sprite
   {
       
      
      private var dartAd:DartInStreamAd;
      
      public var adSite:String;
      
      public var autoLoad:Boolean = false;
      
      private var clickTrackingMC:Sprite;
      
      private var shell:DartShell;
      
      private var playbackObject:Object;
      
      public var adKeyVal:String;
      
      private var dartShellLoader:DartShellSWFLoader;
      
      public var adZone:String;
      
      private var customAd:CustomAd;
      
      public var adTagURL:String = "";
      
      public var autoPlay:Boolean = true;
      
      public var currentAdTag:String = null;
      
      public var protocol:String = "http://";
      
      private var videoDurationLogger:Timer;
      
      public var host:String = "ad.doubleclick.net";
      
      public var videoBuffer:Number = 5;
      
      public var dartShellParameters:String = "";
      
      private var videoPlayback:VideoPlayback;
      
      public var dartShellVersion:Number = 7;
      
      public var playbackInstance:String = "";
      
      public var adSize:String;
      
      private var adIsWaiting:Boolean = false;
      
      private var ord:String;
      
      private var shellHasLoaded:Boolean = false;
      
      public function AdHolder()
      {
         protocol = "http://";
         host = "ad.doubleclick.net";
         adTagURL = "";
         playbackInstance = "";
         videoBuffer = 5;
         autoLoad = false;
         autoPlay = true;
         dartShellVersion = 7;
         dartShellParameters = "";
         currentAdTag = null;
         shellHasLoaded = false;
         adIsWaiting = false;
         super();
         addEventListener(Event.ENTER_FRAME,initialize);
      }
      
      private function onVideoStop(param1:VideoStopEvent) : void
      {
         var _loc2_:VideoStopEvent = null;
         log(param1.type);
         _loc2_ = new VideoStopEvent("onVideoStop");
         dispatchEvent(_loc2_);
      }
      
      private function onVideoClick(param1:VideoClickEvent) : void
      {
         var _loc2_:VideoClickEvent = null;
         log(param1.type);
         _loc2_ = new VideoClickEvent("onVideoClick");
         dispatchEvent(_loc2_);
      }
      
      private function onVideoMute(param1:VideoSoundMuteEvent) : void
      {
         var _loc2_:VideoSoundMuteEvent = null;
         log(param1.type);
         _loc2_ = new VideoSoundMuteEvent("onVideoSoundMute");
         dispatchEvent(_loc2_);
      }
      
      public function setOrd(param1:String) : void
      {
         this.ord = param1;
      }
      
      public function jsRoadblock(param1:String) : void
      {
         param1 += ";ord=" + getOrd() + ";";
         this.log("Launching companion ad in browser with tag : " + param1);
         navigateToURL(new URLRequest("javascript: syncRoadBlock(\'" + param1 + "\')"),"_self");
      }
      
      public function assignVideoObject(param1:Object) : void
      {
         this.playbackObject = param1;
      }
      
      public function getRoadblockURL(param1:String, param2:String, param3:String = null) : String
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(param3 == null)
         {
            if(currentAdTag == null)
            {
               log("No ad tag requested, roadblock cannot be generated");
               return null;
            }
            param3 = currentAdTag;
         }
         _loc4_ = 0;
         if(param1.length > 0)
         {
            _loc4_ = int(param3.lastIndexOf("sz"));
            _loc6_ = int(param3.indexOf(";",_loc4_));
            if(_loc4_ > 0 && _loc6_ > 0)
            {
               param3 = param3.slice(0,_loc4_) + "sz=" + param1 + param3.slice(_loc6_);
            }
         }
         if(param2.length > 0)
         {
            if((_loc4_ = int(param3.lastIndexOf("pfadx"))) > 0)
            {
               param3 = param3.slice(0,_loc4_) + param2 + param3.slice(_loc4_ + 5);
            }
         }
         _loc5_ = dartAd.getRoadblockURL(param3);
         this.log("getRoadblockURL returning ad tag: " + _loc5_);
         return _loc5_;
      }
      
      public function getDartShell() : DartShell
      {
         return shell;
      }
      
      private function onVideoComplete(param1:VideoCompleteEvent) : void
      {
         var _loc2_:VideoCompleteEvent = null;
         log(param1.type);
         _loc2_ = new VideoCompleteEvent("onVideoComplete");
         dispatchEvent(_loc2_);
      }
      
      private function onVideoPlay(param1:VideoStartEvent) : void
      {
         var _loc2_:VideoStartEvent = null;
         log(param1.type);
         _loc2_ = new VideoStartEvent("onVideoPlay");
         dispatchEvent(_loc2_);
      }
      
      private function onDartInStreamAdLoaded(param1:DartInStreamAdLoadedEvent) : void
      {
         var clonedEvent:DartInStreamAdLoadedEvent = null;
         var event:DartInStreamAdLoadedEvent = param1;
         log("Streaming ad returned");
         dartAd = null;
         videoPlayback = null;
         try
         {
            dartAd = event.getDartInStreamAd();
            dartAd.addEventListener(DartShellErrorEvent.TYPE,onDartShellError);
            dartAd.addEventListener(VideoStartEvent.TYPE,onVideoPlay);
            dartAd.addEventListener(VideoSoundMuteEvent.TYPE,onVideoMute);
            dartAd.addEventListener(VideoPauseEvent.TYPE,onVideoPause);
            dartAd.addEventListener(VideoCompleteEvent.TYPE,onVideoComplete);
            dartAd.addEventListener(VideoMidpointEvent.TYPE,onVideoMidpoint);
            dartAd.addEventListener(VideoReStartEvent.TYPE,onVideoRestart);
            dartAd.addEventListener(VideoClickEvent.TYPE,onVideoClick);
            dartAd.addEventListener(VideoStopEvent.TYPE,onVideoStop);
            if(clickTrackingMC)
            {
               dartAd.setClickTrackingMC(clickTrackingMC);
            }
            if(autoPlay)
            {
               log("Auto Play");
               playStream();
            }
            clonedEvent = new DartInStreamAdLoadedEvent("onDartInStreamAdLoaded");
            clonedEvent.setAd(event.getDartInStreamAd());
            dispatchEvent(clonedEvent);
         }
         catch(error:Error)
         {
            log("Error: " + error);
         }
      }
      
      private function onCustomAdLoaded(param1:CustomAdLoadedEvent) : void
      {
         var _loc2_:CustomAdLoadedEvent = null;
         log(param1.type);
         _loc2_ = new CustomAdLoadedEvent("onCustomAdLoaded");
         _loc2_.setAd(param1.getCustomAd());
         dispatchEvent(_loc2_);
      }
      
      private function onVideoMidpoint(param1:VideoMidpointEvent) : void
      {
         var _loc2_:VideoMidpointEvent = null;
         log(param1.type);
         _loc2_ = new VideoMidpointEvent("onVideoMidpoint");
         dispatchEvent(_loc2_);
      }
      
      private function onDartShellError(param1:DartShellErrorEvent) : void
      {
         var _loc2_:DartShellError = null;
         var _loc3_:DartShellErrorEvent = null;
         _loc2_ = param1.getError();
         log("ERROR: " + _loc2_.message + ", errorID=" + _loc2_.errorID);
         _loc3_ = new DartShellErrorEvent("onDartShellError");
         _loc3_.setError(param1.getError());
         dispatchEvent(_loc3_);
      }
      
      private function onDartShellLoaded(param1:DartShellLoadedEvent) : void
      {
         var _loc2_:DartShellLoadedEvent = null;
         log("DARTShell Loaded");
         shellHasLoaded = true;
         shell = param1.getDartShell();
         shell.addEventListener(DartInStreamAdLoadedEvent.TYPE,onDartInStreamAdLoaded);
         shell.addEventListener(CustomAdLoadedEvent.TYPE,onCustomAdLoaded);
         shell.addEventListener(DartShellErrorEvent.TYPE,onDartShellError);
         if(autoLoad || adIsWaiting)
         {
            this.log("Auto load = true or ad already requested, let\'s get an ad!");
            this.loadNewAd();
         }
         _loc2_ = new DartShellLoadedEvent("onDartShellLoaded");
         _loc2_.setDartShell(param1.getDartShell());
         dispatchEvent(_loc2_);
      }
      
      public function setClickTrackingMC(param1:Sprite) : void
      {
         clickTrackingMC = param1;
         if(dartAd)
         {
            dartAd.setClickTrackingMC(clickTrackingMC);
         }
      }
      
      private function initialize(param1:Event) : void
      {
         var _loc2_:String = null;
         log("DartAdHolder initialize");
         removeEventListener(Event.ENTER_FRAME,initialize);
         if(playbackInstance.length > 0)
         {
            playbackObject = parent.getChildByName(playbackInstance);
         }
         if(dartShellParameters.length > 0)
         {
            dartShellParameters = "&" + dartShellParameters;
         }
         _loc2_ = protocol + host + "/879366/DartShell9_" + dartShellVersion + ".swf?adServerHost=" + this.protocol + this.host + dartShellParameters;
         log("dartShell " + _loc2_);
         dartShellLoader = new DartShellSWFLoader(_loc2_);
         dartShellLoader.addEventListener(DartShellLoadedEvent.TYPE,onDartShellLoaded);
         dartShellLoader.addEventListener(DartShellErrorEvent.TYPE,onDartShellError);
         dartShellLoader.load();
      }
      
      private function onVideoRestart(param1:VideoReStartEvent) : void
      {
         var _loc2_:VideoReStartEvent = null;
         log(param1.type);
         _loc2_ = new VideoReStartEvent("onVideoRestart");
         dispatchEvent(_loc2_);
      }
      
      public function loadNewAd() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(!shellHasLoaded)
         {
            log("Ad requested before Shell loaded, waiting...");
            adIsWaiting = true;
         }
         else if(adTagURL.length > 0)
         {
            _loc1_ = adTagURL + ";ord=" + getOrd();
            currentAdTag = adTagURL;
            log("Load ad by URL: " + _loc1_);
            shell.loadAdByURL(_loc1_);
         }
         else
         {
            if(adKeyVal != "")
            {
               _loc2_ = new Array();
               _loc3_ = this.adKeyVal.split(";");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc7_ = (_loc6_ = (_loc5_ = _loc3_[_loc4_]).split("="))[0];
                  _loc8_ = _loc6_[1];
                  _loc2_[_loc7_] = _loc8_;
                  _loc4_++;
               }
            }
            shell.loadAd(adSite,adZone,adSize,_loc2_,protocol,host,"pfadx");
            currentAdTag = this.protocol + this.host + "/pfadx/" + this.adSite + "/" + this.adZone + ";dcmt=text/html;sz=" + this.adSize + ";" + _loc2_;
            this.log("Load ad by Parameters: " + currentAdTag);
         }
      }
      
      private function onPlaybackReady(param1:VideoPlaybackReadyEvent) : void
      {
         var _loc2_:NetStream = null;
         var _loc3_:VideoPlaybackReadyEvent = null;
         videoPlayback = param1.getVideoPlayback();
         log("Playback ready: " + (videoPlayback.isFLVPlayback() ? "progressive FLV" : "streaming flv"));
         _loc2_ = getNetStream();
         if(_loc2_)
         {
            _loc2_.bufferTime = videoBuffer;
            log("set ad buffer time: " + _loc2_.bufferTime);
         }
         videoPlayback.play(null);
         _loc3_ = new VideoPlaybackReadyEvent("onVideoPlaybackReady");
         _loc3_.setVideoPlayback(param1.getVideoPlayback());
         dispatchEvent(_loc3_);
      }
      
      private function log(param1:String) : void
      {
         dispatchEvent(new LogEvent(LogEvent.TYPE,false,false,param1));
      }
      
      public function getOrd() : String
      {
         if(ord == null)
         {
            ord = String(new Date().getTime());
         }
         return ord;
      }
      
      private function onVideoPause(param1:VideoPauseEvent) : void
      {
         var _loc2_:VideoPauseEvent = null;
         log(param1.type);
         _loc2_ = new VideoPauseEvent("onVideoPause");
         dispatchEvent(_loc2_);
      }
      
      public function playStream() : void
      {
         log("playStream() invoked");
         dartAd.usePlayback(playbackObject,onPlaybackReady);
      }
      
      public function getNetStream() : NetStream
      {
         var _loc1_:NetStreamPlayback = null;
         if(videoPlayback == null)
         {
            log("Tried to retrieve NetStream before playback is ready, getNetStream() will return null");
            return null;
         }
         _loc1_ = videoPlayback as NetStreamPlayback;
         if(_loc1_ == null && videoPlayback.isNetStreamPlayback() == true)
         {
            log("Bug in shell: videoPlayback.isNetStreamPlayback() == " + videoPlayback.isNetStreamPlayback() + ", but casting it to NetStreamPlayback returned a null");
            return null;
         }
         if(_loc1_ != null)
         {
            return _loc1_.getNetStream();
         }
         return null;
      }
      
      public function getDartAd() : Ad
      {
         return dartAd;
      }
   }
}
