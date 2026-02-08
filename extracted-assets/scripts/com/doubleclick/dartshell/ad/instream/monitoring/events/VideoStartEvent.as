package com.doubleclick.dartshell.ad.instream.monitoring.events
{
   import flash.events.Event;
   
   public class VideoStartEvent extends Event
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.ad.instream.monitoring.events.onVideoStart";
       
      
      public function VideoStartEvent(param1:String = "com.doubleclick.dartshell.ad.instream.monitoring.events.onVideoStart", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
