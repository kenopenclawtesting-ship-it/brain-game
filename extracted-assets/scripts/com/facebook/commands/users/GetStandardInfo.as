package com.facebook.commands.users
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetStandardInfo extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uids","fields","format"];
      
      public static const METHOD_NAME:String = "users.getStandardInfo";
       
      
      public var uids:Array;
      
      public var format:String;
      
      public var fields:Array;
      
      public function GetStandardInfo(param1:Array, param2:Array, param3:String = "")
      {
         super(METHOD_NAME);
         this.uids = param1;
         this.fields = param2;
         this.format = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         this.applySchema(SCHEMA,this.uids,FacebookDataUtils.toArrayString(this.fields),this.format);
         super.facebook_internal::initialize();
      }
   }
}
