package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetCookies extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","name"];
      
      public static const METHOD_NAME:String = "data.getCookies";
       
      
      public var uid:String;
      
      public var name:String;
      
      public function GetCookies(param1:String, param2:String = null)
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.name = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,this.name);
         super.facebook_internal::initialize();
      }
   }
}
