package com.facebook.commands.feed
{
   import com.facebook.net.FacebookCall;
   
   public class GetRegisteredTemplateBundles extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "feed.getRegisteredTemplateBundles";
       
      
      public function GetRegisteredTemplateBundles()
      {
         super(METHOD_NAME);
      }
   }
}
