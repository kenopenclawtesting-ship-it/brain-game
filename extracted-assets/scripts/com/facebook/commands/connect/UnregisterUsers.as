package com.facebook.commands.connect
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class UnregisterUsers extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["email_hashes"];
      
      public static const METHOD_NAME:String = "connect.unregisterUsers";
       
      
      public var email_hashes:Array;
      
      public function UnregisterUsers(param1:Array)
      {
         super(METHOD_NAME);
         this.email_hashes = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,com.adobe.serialization.json.JSON.encode(this.email_hashes));
         super.facebook_internal::initialize();
      }
   }
}
