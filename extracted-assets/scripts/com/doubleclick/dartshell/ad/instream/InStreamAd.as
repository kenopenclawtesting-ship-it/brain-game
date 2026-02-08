package com.doubleclick.dartshell.ad.instream
{
   import com.doubleclick.dartshell.ad.Ad;
   import flash.display.Sprite;
   
   public interface InStreamAd extends Ad
   {
       
      
      function usePlayback(param1:Object, param2:Function) : void;
      
      function getStreamingHost() : String;
      
      function isProgressive() : Boolean;
      
      function getFlvURL(param1:String) : String;
      
      function isStreaming() : Boolean;
      
      function setClickTrackingMC(param1:Sprite) : void;
      
      function enableClickTracking(param1:Boolean) : void;
   }
}
