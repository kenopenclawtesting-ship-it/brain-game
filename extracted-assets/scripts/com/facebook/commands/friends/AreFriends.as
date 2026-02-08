package com.facebook.commands.friends
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class AreFriends extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uids1","uids2","format"];
      
      public static const METHOD_NAME:String = "friends.areFriends";
       
      
      public var format:String;
      
      public var uids1:Array;
      
      public var uids2:Array;
      
      public function AreFriends(param1:Array, param2:Array, param3:String)
      {
         super(METHOD_NAME);
         this.uids1 = param1;
         this.uids2 = param2;
         this.format = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.uids1),FacebookDataUtils.toArrayString(this.uids2),this.format);
         super.facebook_internal::initialize();
      }
   }
}
