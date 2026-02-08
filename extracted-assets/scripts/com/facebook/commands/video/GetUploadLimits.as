package com.facebook.commands.video
{
   import com.facebook.net.FacebookCall;
   
   public class GetUploadLimits extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "video.getUploadLimits";
       
      
      public function GetUploadLimits()
      {
         super(METHOD_NAME);
      }
   }
}
