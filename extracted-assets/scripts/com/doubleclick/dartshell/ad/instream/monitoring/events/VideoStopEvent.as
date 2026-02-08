package com.doubleclick.dartshell.ad.instream.monitoring.events
{
   import flash.events.Event;
   
   public class VideoStopEvent extends Event
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.ad.instream.monitoring.events.onVideoStop";
       
      
      public function VideoStopEvent(param1:String = "com.doubleclick.dartshell.ad.instream.monitoring.events.onVideoStop", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
