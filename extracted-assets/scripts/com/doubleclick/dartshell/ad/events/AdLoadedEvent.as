package com.doubleclick.dartshell.ad.events
{
   import com.doubleclick.dartshell.ad.Ad;
   import flash.events.Event;
   
   public class AdLoadedEvent extends Event
   {
       
      
      private var ad:Ad;
      
      public function AdLoadedEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function setAd(param1:Ad) : void
      {
         this.ad = param1;
      }
      
      public function getAd() : Ad
      {
         return ad;
      }
   }
}
