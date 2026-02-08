package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.commands.events.GetEvents;
   import com.facebook.events.FacebookEvent;
   import com.facebook.net.FacebookCall;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformEvent;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformEvents;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformEventsSettings;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformUser;
   import flash.events.EventDispatcher;
   
   public class SocialPlatformEvents_Facebook extends SocialPlatformEvents
   {
       
      
      public function SocialPlatformEvents_Facebook(param1:SocialPlatformEventsSettings)
      {
         super(param1);
         available = true;
      }
      
      private function handleGetEventsResponse(param1:FacebookEvent) : void
      {
         var _loc2_:SocialEventResult = SocialPlatform_Facebook.getSocialEventSuccess(param1);
         if(_loc2_.success)
         {
            _loc2_.applyResult(param1.data.rawResult);
            parseEventData(_loc2_.resultData);
         }
         dispatchEvent(param1);
      }
      
      override public function prepareEventList() : EventDispatcher
      {
         var user:SocialPlatformUser = null;
         var call:FacebookCall = null;
         try
         {
            user = SocialPlatform.instance.user;
            call = SocialPlatform_Facebook.facebook.post(new GetEvents(user.getID()));
            call.addEventListener(FacebookEvent.COMPLETE,handleGetEventsResponse);
            return call;
         }
         catch(error:Error)
         {
            PFDebug.trace(null,"Error in event preparation: " + error.message);
         }
         return null;
      }
      
      protected function parseEventData(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:SocialPlatformEvent = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = createEvent(_loc2_.name,_loc2_.host,_loc2_.location,_loc2_.description,_loc2_.eid);
            eventList.push(_loc3_);
         }
      }
      
      override public function isSupported() : Boolean
      {
         return true;
      }
      
      override public function createEvent(param1:String, param2:String, param3:String = "", param4:String = "", param5:Object = null) : SocialPlatformEvent
      {
         return new SocialPlatformEvent_Facebook(param1,param2,param3,param4,param5);
      }
   }
}
