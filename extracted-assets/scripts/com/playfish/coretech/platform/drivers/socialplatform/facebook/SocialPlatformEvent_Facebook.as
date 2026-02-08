package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.commands.events.CancelEvent;
   import com.facebook.data.StringResultData;
   import com.facebook.data.events.CreateEventData;
   import com.facebook.data.events.EventPrivacyTypeValues;
   import com.facebook.events.FacebookEvent;
   import com.facebook.net.FacebookCall;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.natural.facebook.FBCreateEvent;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformEvent;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformUser;
   import flash.events.EventDispatcher;
   
   public class SocialPlatformEvent_Facebook extends SocialPlatformEvent
   {
       
      
      public function SocialPlatformEvent_Facebook(param1:String, param2:String, param3:String, param4:String, param5:Object = null)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      private function handleCancelEventResponse(param1:FacebookEvent) : void
      {
         var _loc2_:SocialEventResult = SocialPlatform_Facebook.getSocialEventSuccess(param1);
         dispatchEvent(param1);
      }
      
      override public function cancel() : EventDispatcher
      {
         var event:CancelEvent = null;
         var call:FacebookCall = null;
         try
         {
            event = new CancelEvent(eid as String);
            call = SocialPlatform_Facebook.facebook.post(event);
            call.addEventListener(FacebookEvent.COMPLETE,handleCancelEventResponse);
            return call;
         }
         catch(error:Error)
         {
            PFDebug.trace(null,"Error in event cancel: " + error.message);
         }
         return null;
      }
      
      private function handlePublishEventResponse(param1:FacebookEvent) : void
      {
         var _loc2_:SocialEventResult = SocialPlatform_Facebook.getSocialEventSuccess(param1);
         if(_loc2_.success)
         {
            _loc2_.applyResult(param1.data.rawResult);
            eid = param1.data as StringResultData;
            if(eid != null)
            {
               eid = eid.value;
            }
         }
         dispatchEvent(param1);
      }
      
      override public function inviteUser(param1:*) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:SocialPlatformUser = null;
         var _loc4_:SocialPlatformUser = null;
         if(param1 is Array)
         {
            _loc2_ = true;
            for each(_loc3_ in param1)
            {
               if(!inviteUser(_loc3_))
               {
                  _loc2_ = false;
               }
            }
            return _loc2_;
         }
         if(param1 is SocialPlatformUser)
         {
            _loc4_ = param1 as SocialPlatformUser;
         }
         return false;
      }
      
      override public function publish() : EventDispatcher
      {
         var data:CreateEventData = null;
         var event:FBCreateEvent = null;
         var call:FacebookCall = null;
         try
         {
            data = new CreateEventData(name,category,subcategory,host,location,city,startTime,endTime);
            data.description = description;
            data.privacy_type = EventPrivacyTypeValues.OPEN;
            event = new FBCreateEvent(data);
            call = SocialPlatform_Facebook.facebook.post(event);
            call.addEventListener(FacebookEvent.COMPLETE,handlePublishEventResponse);
            return call;
         }
         catch(error:Error)
         {
            PFDebug.trace(null,"Error in event publish: " + error.message);
         }
         return null;
      }
   }
}
