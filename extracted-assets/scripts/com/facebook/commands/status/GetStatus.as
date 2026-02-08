package com.facebook.commands.status
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetStatus extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","limit"];
      
      public static const METHOD_NAME:String = "status.get";
       
      
      public var uid:String;
      
      public var limit:uint;
      
      public function GetStatus(param1:String, param2:uint = 100)
      {
         this.uid = param1;
         this.limit = param2;
         super(METHOD_NAME);
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,this.limit);
         super.facebook_internal::initialize();
      }
   }
}
