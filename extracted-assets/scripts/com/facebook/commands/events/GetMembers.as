package com.facebook.commands.events
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetMembers extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["eid"];
      
      public static const METHOD_NAME:String = "events.getMembers";
       
      
      public var eid:String;
      
      public function GetMembers(param1:String)
      {
         super(METHOD_NAME);
         this.eid = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.eid);
         super.facebook_internal::initialize();
      }
   }
}
