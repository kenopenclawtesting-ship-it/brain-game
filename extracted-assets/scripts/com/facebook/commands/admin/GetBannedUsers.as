package com.facebook.commands.admin
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetBannedUsers extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uids"];
      
      public static const METHOD_NAME:String = "admin.getBannedUsers";
       
      
      public var uids:Array;
      
      public function GetBannedUsers(param1:Array = null)
      {
         super(METHOD_NAME);
         this.uids = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,com.adobe.serialization.json.JSON.encode(this.uids));
         super.facebook_internal::initialize();
      }
   }
}
