package com.doubleclick.dartshell.ad.instream
{
   public interface DartInStreamAd extends InStreamAd
   {
       
      
      function getThirdPartyClickURL() : String;
      
      function getThirdPartyVideoCompleteURL() : String;
      
      function getRenderingId() : Number;
      
      function getCustomParameterValue(param1:String) : String;
      
      function getThirdPartyMidpointURL() : String;
      
      function getRoadblockURL(param1:String) : String;
      
      function getClickString() : String;
      
      function getThirdPartyImpURL() : String;
      
      function getTitle() : String;
      
      function getAuthor() : String;
      
      function getISCI() : String;
      
      function getClickThroughURL() : String;
      
      function getDartId() : String;
      
      function getCustomParameters() : Array;
      
      function getFLVDownloadType() : String;
      
      function getSurveyURL() : String;
   }
}
