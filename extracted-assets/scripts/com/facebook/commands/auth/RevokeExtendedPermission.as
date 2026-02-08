package com.facebook.commands.auth
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RevokeExtendedPermission extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["perm","uid"];
      
      public static const METHOD_NAME:String = "auth.revokeExtendedPermission";
       
      
      public var perm:String;
      
      public var uid:String;
      
      public function RevokeExtendedPermission(param1:String, param2:String = null)
      {
         super(METHOD_NAME);
         this.perm = param1;
         this.uid = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.perm,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
