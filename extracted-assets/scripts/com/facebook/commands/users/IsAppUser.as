package com.facebook.commands.users
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class IsAppUser extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid"];
      
      public static const METHOD_NAME:String = "users.isAppUser";
       
      
      public var uid:String;
      
      public function IsAppUser(param1:String = null)
      {
         super(METHOD_NAME);
         this.uid = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
