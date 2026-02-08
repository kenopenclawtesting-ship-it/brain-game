package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class SetCookie extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","name","value","expires","path"];
      
      public static const METHOD_NAME:String = "data.setCookie";
       
      
      public var uid:String;
      
      public var value:String;
      
      public var expires:Date;
      
      public var path:String;
      
      public var name:String;
      
      public function SetCookie(param1:String, param2:String, param3:String, param4:Date = null, param5:String = "/")
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.name = param2;
         this.value = param3;
         this.expires = param4;
         this.path = param5;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,this.name,this.value,FacebookDataUtils.toDateString(this.expires),this.path);
         super.facebook_internal::initialize();
      }
   }
}
