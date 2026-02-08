package com.playfish.coretech.platform.socialplatform
{
   import flash.events.EventDispatcher;
   
   public class SocialPlatformEvents extends SocialPlatformModule
   {
       
      
      public var eventList:Array;
      
      public function SocialPlatformEvents(param1:SocialPlatformModuleSettings)
      {
         super(param1);
         eventList = new Array();
      }
      
      public function prepareEventList() : EventDispatcher
      {
         return null;
      }
      
      override public function toString() : String
      {
         var _loc2_:SocialPlatformEvent = null;
         var _loc1_:String = "";
         for each(_loc2_ in eventList)
         {
            _loc1_ += _loc2_.toString() + "\n";
         }
         return _loc1_;
      }
      
      public function createEvent(param1:String, param2:String, param3:String = "", param4:String = "", param5:Object = null) : SocialPlatformEvent
      {
         return new SocialPlatformEvent(param1,param2,param3,param4);
      }
   }
}
