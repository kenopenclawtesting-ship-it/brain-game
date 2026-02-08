package com.doubleclick.dartshell.ad.instream.playback.events
{
   import com.doubleclick.dartshell.ad.instream.playback.VideoPlayback;
   import flash.events.Event;
   
   public class VideoPlaybackReadyEvent extends Event
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.ad.instream.playback.events.onVideoPlaybackReady";
       
      
      private var videoPlayback:VideoPlayback;
      
      public function VideoPlaybackReadyEvent(param1:String = "com.doubleclick.dartshell.ad.instream.playback.events.onVideoPlaybackReady", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function getVideoPlayback() : VideoPlayback
      {
         return videoPlayback;
      }
      
      public function setVideoPlayback(param1:VideoPlayback) : void
      {
         this.videoPlayback = param1;
      }
   }
}
