package com.doubleclick.dartshell.ad.instream.playback
{
   import flash.media.Video;
   import flash.net.NetStream;
   
   public interface NetStreamPlayback extends VideoPlayback
   {
       
      
      function getVideo() : Video;
      
      function getNetStream() : NetStream;
   }
}
