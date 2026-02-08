package com.facebook.commands.fbml
{
   import com.facebook.data.fbml.TagCollection;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class RegisterCustomTags extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["tags"];
      
      public static const METHOD_NAME:String = "fbml.registerCustomTags";
       
      
      public var tags:TagCollection;
      
      public function RegisterCustomTags(param1:TagCollection)
      {
         super(METHOD_NAME);
         this.tags = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.facebookCollectionToJSONArray(this.tags));
         super.facebook_internal::initialize();
      }
   }
}
