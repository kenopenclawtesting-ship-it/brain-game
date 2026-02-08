package com.doubleclick.dartshell.ad.instream.playback
{
   import flash.events.IEventDispatcher;
   
   public interface VideoPlayback extends IEventDispatcher
   {
       
      
      function getPercentLoaded() : Number;
      
      function isFLVPlayback() : Boolean;
      
      function getVideoLength() : Number;
      
      function play(param1:String) : void;
      
      function isNetStreamPlayback() : Boolean;
      
      function getTimeProgressed() : Number;
      
      function getPercentProgressed() : Number;
   }
}
