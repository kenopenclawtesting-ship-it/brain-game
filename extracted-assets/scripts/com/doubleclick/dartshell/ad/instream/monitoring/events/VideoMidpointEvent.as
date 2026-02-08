package com.doubleclick.dartshell.ad.instream.monitoring.events
{
   import flash.events.Event;
   
   public class VideoMidpointEvent extends Event
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.ad.instream.monitoring.events.onVideoMidpoint";
       
      
      public function VideoMidpointEvent(param1:String = "com.doubleclick.dartshell.ad.instream.monitoring.events.onVideoMidpoint", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
