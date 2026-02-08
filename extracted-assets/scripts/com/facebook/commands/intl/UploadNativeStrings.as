package com.facebook.commands.intl
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class UploadNativeStrings extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["native_strings"];
      
      public static const METHOD_NAME:String = "intl.uploadNativeStrings";
       
      
      public var native_strings:Array;
      
      public function UploadNativeStrings(param1:Array)
      {
         super(METHOD_NAME);
         this.native_strings = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,com.adobe.serialization.json.JSON.encode(this.native_strings));
         super.facebook_internal::initialize();
      }
   }
}
