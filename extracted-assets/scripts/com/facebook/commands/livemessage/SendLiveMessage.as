package com.facebook.commands.livemessage
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SendLiveMessage extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["recipient","event_name","message"];
      
      public static const METHOD_NAME:String = "liveMessage.send";
       
      
      public var event_name:String;
      
      public var message:String;
      
      public var recipient:String;
      
      public function SendLiveMessage(param1:String, param2:String, param3:String)
      {
         super(METHOD_NAME);
         this.recipient = param1;
         this.event_name = param2;
         this.message = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.recipient,this.event_name,this.message);
         super.facebook_internal::initialize();
      }
   }
}
