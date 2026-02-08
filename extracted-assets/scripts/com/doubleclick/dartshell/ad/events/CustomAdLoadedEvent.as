package com.doubleclick.dartshell.ad.events
{
   import com.doubleclick.dartshell.ad.CustomAd;
   
   public class CustomAdLoadedEvent extends AdLoadedEvent
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.ad.events.onCustomAdLoaded";
       
      
      public function CustomAdLoadedEvent(param1:String = "com.doubleclick.dartshell.ad.events.onCustomAdLoaded", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function getCustomAd() : CustomAd
      {
         return getAd() as CustomAd;
      }
   }
}
