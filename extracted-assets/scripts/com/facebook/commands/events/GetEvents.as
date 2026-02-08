package com.facebook.commands.events
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetEvents extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","eids","start_time","end_time","rsvp_status"];
      
      public static const METHOD_NAME:String = "events.get";
       
      
      public var uid:String;
      
      public var end_time:Date;
      
      public var eids:Array;
      
      public var start_time:Date;
      
      public var rsvp_status:String;
      
      public function GetEvents(param1:String = null, param2:Array = null, param3:Date = null, param4:Date = null, param5:String = null)
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.eids = param2;
         this.start_time = param3;
         this.end_time = param4;
         this.rsvp_status = param5;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,FacebookDataUtils.toArrayString(this.eids),FacebookDataUtils.toDateString(this.start_time),FacebookDataUtils.toDateString(this.end_time),this.rsvp_status);
         super.facebook_internal::initialize();
      }
   }
}
