package com.doubleclick.dartshell.ad
{
   import flash.events.IEventDispatcher;
   
   public interface Ad extends IEventDispatcher
   {
       
      
      function isDartInFlashAd() : Boolean;
      
      function getXMLAdResponse() : XML;
      
      function isDartInStreamAd() : Boolean;
      
      function isInStreamAd() : Boolean;
      
      function getAdType() : String;
      
      function isVideoAd() : Boolean;
      
      function isCustomAd() : Boolean;
   }
}
