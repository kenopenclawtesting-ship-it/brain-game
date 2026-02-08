package com.facebook.commands.fbml
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class DeleteCustomTags extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["names"];
      
      public static const METHOD_NAME:String = "fbml.deleteCustomTags";
       
      
      public var names:Array;
      
      public function DeleteCustomTags(param1:Array = null)
      {
         super(METHOD_NAME);
         this.names = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toJSONValuesArray(this.names));
         super.facebook_internal::initialize();
      }
   }
}
