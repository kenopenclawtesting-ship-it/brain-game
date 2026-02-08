package com.facebook.commands.feed
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetRegisteredTemplateBundleByID extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["template_bundle_id"];
      
      public static const METHOD_NAME:String = "feed.getRegisteredTemplateBundleByID";
       
      
      public var template_bundle_id:String;
      
      public function GetRegisteredTemplateBundleByID(param1:String)
      {
         super(METHOD_NAME);
         this.template_bundle_id = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.template_bundle_id);
         super.facebook_internal::initialize();
      }
   }
}
