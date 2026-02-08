package com.facebook.commands.events
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RSVP extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["eid","rsvp_status"];
      
      public static const METHOD_NAME:String = "events.rsvp";
       
      
      public var eid:String;
      
      public var rsvp_status:String;
      
      public function RSVP(param1:String, param2:String)
      {
         super(METHOD_NAME);
         this.eid = param1;
         this.rsvp_status = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.eid,this.rsvp_status);
         super.facebook_internal::initialize();
      }
   }
}
