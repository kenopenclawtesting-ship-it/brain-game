package com.facebook.commands.sms
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SendSMS extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","message","session_id","req_session"];
      
      public static const METHOD_NAME:String = "sms.send";
       
      
      public var uid:String;
      
      public var session_id:Number;
      
      public var req_session:Boolean;
      
      public var message:String;
      
      public function SendSMS(param1:String, param2:String = null, param3:Number = NaN, param4:Boolean = false)
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.message = param2;
         this.session_id = param3;
         this.req_session = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,this.message,this.session_id,this.req_session);
         super.facebook_internal::initialize();
      }
   }
}
