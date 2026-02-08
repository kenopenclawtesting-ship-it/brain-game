package com.facebook.commands.events
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class CancelEvent extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["eid","cancel_message"];
      
      public static const METHOD_NAME:String = "events.cancel";
       
      
      public var eid:String;
      
      public var cancel_message:String;
      
      public function CancelEvent(param1:String, param2:String = null)
      {
         super(METHOD_NAME);
         this.eid = param1;
         this.cancel_message = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.eid,this.cancel_message);
         super.facebook_internal::initialize();
      }
   }
}
