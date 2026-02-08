package com.doubleclick.dartshell.ad.instream.events
{
   import com.doubleclick.dartshell.ad.events.AdLoadedEvent;
   import com.doubleclick.dartshell.ad.instream.DartInStreamAd;
   
   public class DartInStreamAdLoadedEvent extends AdLoadedEvent
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.ad.instream.events.onDartInStreamAdLoaded";
       
      
      public function DartInStreamAdLoadedEvent(param1:String = "com.doubleclick.dartshell.ad.instream.events.onDartInStreamAdLoaded", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function getDartInStreamAd() : DartInStreamAd
      {
         return getAd() as DartInStreamAd;
      }
   }
}
