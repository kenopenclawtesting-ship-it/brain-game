package com.playfish.coretech.platform.socialplatform
{
   import flash.events.EventDispatcher;
   
   public class SocialPlatformEvent extends EventDispatcher
   {
       
      
      protected var eid:Object;
      
      protected var category:String;
      
      protected var endTime:Date;
      
      protected var name:String;
      
      protected var startTime:Date;
      
      protected var host:String;
      
      protected var city:String;
      
      protected var location:String;
      
      protected var description:String;
      
      protected var subcategory:String;
      
      public function SocialPlatformEvent(param1:String, param2:String, param3:String, param4:String, param5:Object = null)
      {
         super();
         name = param1;
         category = "";
         subcategory = "";
         host = param2;
         location = param3;
         city = "";
         description = param4;
         eid = param5;
         setStartTime(null);
      }
      
      public function cancel() : EventDispatcher
      {
         return null;
      }
      
      public function setEndTime(param1:Date) : void
      {
         endTime = param1;
      }
      
      public function setStartTime(param1:Date) : void
      {
         startTime = new Date(param1);
         endTime = new Date(param1);
      }
      
      public function get id() : Object
      {
         return eid;
      }
      
      public function publish() : EventDispatcher
      {
         return null;
      }
      
      override public function toString() : String
      {
         return "Event (name):" + name + " (" + eid + ")\n" + "      (cat)  " + category + "\n" + "      (sub)  " + subcategory + "\n" + "      (host) " + host + "\n" + "      (loc)  " + location + "\n" + "      (city) " + city + "\n" + "      (desc) " + description;
      }
      
      public function inviteUser(param1:*) : Boolean
      {
         return false;
      }
      
      public function setDescription(param1:String) : void
      {
         description = param1;
      }
   }
}
