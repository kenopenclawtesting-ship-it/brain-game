package com.facebook.commands.friends
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetMutualFriends extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["target_uid","source_uid"];
      
      public static const METHOD_NAME:String = "friends.getMutualFriends";
       
      
      public var target_uid:String;
      
      public var source_uid:String;
      
      public function GetMutualFriends(param1:String, param2:String = null)
      {
         super(METHOD_NAME);
         this.target_uid = param1;
         this.source_uid = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.target_uid,this.source_uid);
         super.facebook_internal::initialize();
      }
   }
}
