package com.facebook.commands.fbml
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetCustomTags extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["app_id"];
      
      public static const METHOD_NAME:String = "fbml.getCustomTags";
       
      
      protected var app_id:String;
      
      public function GetCustomTags(param1:String = "")
      {
         super(METHOD_NAME);
         this.app_id = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         this.applySchema(SCHEMA,this.app_id);
         super.facebook_internal::initialize();
      }
   }
}
