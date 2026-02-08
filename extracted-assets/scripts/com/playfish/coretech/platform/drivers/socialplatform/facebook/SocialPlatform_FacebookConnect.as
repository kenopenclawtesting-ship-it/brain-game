package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.playfish.coretech.engine.*;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.natural.facebook.FBFqlQuery;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformEvents;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformLiveChat;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformPhotos;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformSettings;
   import flash.external.ExternalInterface;
   
   public class SocialPlatform_FacebookConnect extends SocialPlatform_Facebook
   {
       
      
      private var fbcID:uint;
      
      private var fbcResponseMapping:Object;
      
      public function SocialPlatform_FacebookConnect(param1:String, param2:Function, param3:Object, param4:SocialPlatformSettings)
      {
         PFDebug.trace(null,"SocialPlatform_FacebookConnect ctor");
         ExternalInterface.addCallback("onFQLResult",onFQLCallBack);
         photos = new SocialPlatformPhotos(param4.photos);
         events = new SocialPlatformEvents(param4.events);
         livechat = new SocialPlatformLiveChat(param4.livechat);
         fbcID = 1;
         fbcResponseMapping = new Object();
         super(param1,param2,param3,param4);
      }
      
      private function onFQLCallBack(param1:Object, param2:Object) : void
      {
         var _loc3_:FBFqlQuery = null;
         var _loc4_:SocialEventResult = null;
         if(!(param2 is Array))
         {
            PFDebug.trace(null,"WARNING: result is not an arraay!?!?!?");
         }
         _loc3_ = fbcResponseMapping[param1];
         if(_loc3_ == null)
         {
            PFDebug.trace(null,"No query found in response mapping");
         }
         else
         {
            (_loc4_ = new SocialEventResult()).success = true;
            _loc4_.platformQuery = _loc3_;
            _loc4_.errorMessage = "Success from FBConnect";
            _loc4_.applyResultData(param2 as Array);
            if(_loc3_.callbackFunctionRef != null)
            {
               _loc3_.callbackFunctionRef(_loc4_);
            }
            delete fbcResponseMapping[param1];
         }
         PFDebug.trace(null,"repsonses (post):" + PFDebug.dumpToString(fbcResponseMapping));
      }
      
      override protected function onFQLQueueComplete(param1:SocialEventResult) : void
      {
         var _loc2_:FBFqlQuery = param1.platformQuery as FBFqlQuery;
         onFQLQueueCompleteFQL(param1,_loc2_);
      }
      
      override public function makeQuery(param1:String, param2:Function, param3:Object = null) : Boolean
      {
         fbcResponseMapping[fbcID] = new FBFqlQuery(param1,param3,param2);
         PFDebug.trace(null,"FBC: makequery : " + param1);
         ExternalInterface.call("fbcql",param1,fbcID);
         ++fbcID;
         return true;
      }
      
      override public function getRetryURL() : String
      {
         return PFEngine.instance.getParameter("pf_facebook_connect_retry_url") as String;
      }
   }
}
