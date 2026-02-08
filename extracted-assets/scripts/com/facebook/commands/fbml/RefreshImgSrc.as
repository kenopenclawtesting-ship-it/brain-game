package com.facebook.commands.fbml
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RefreshImgSrc extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["url"];
      
      public static const METHOD_NAME:String = "fbml.refreshImgSrc";
       
      
      public var url:String;
      
      public function RefreshImgSrc(param1:String)
      {
         super(METHOD_NAME);
         this.url = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         this.applySchema(SCHEMA,this.url);
         super.facebook_internal::initialize();
      }
   }
}
