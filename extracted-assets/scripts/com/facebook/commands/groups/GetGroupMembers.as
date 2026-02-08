package com.facebook.commands.groups
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetGroupMembers extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["gid"];
      
      public static const METHOD_NAME:String = "groups.getMembers";
       
      
      public var gid:String;
      
      public function GetGroupMembers(param1:String)
      {
         super(METHOD_NAME);
         this.gid = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.gid);
         super.facebook_internal::initialize();
      }
   }
}
