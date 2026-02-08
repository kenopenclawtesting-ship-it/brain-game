package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.data.StringResultData;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.natural.facebook.FBFacebookCall;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFeatureCounter;
   import flash.events.EventDispatcher;
   
   public class SocialPlatformFeatureCounter_Facebook extends SocialPlatformFeatureCounter
   {
       
      
      public function SocialPlatformFeatureCounter_Facebook(param1:Object)
      {
         super(param1);
      }
      
      private function handleGetCounterResult(param1:SocialEventResult, param2:Object) : void
      {
         var ev:StringResultData = null;
         var e:SocialEventResult = param1;
         var param:Object = param2;
         try
         {
            if(e.platformEvent is StringResultData)
            {
               ev = e.platformEvent as StringResultData;
               isAvailable = true;
               previousValue = parseInt(ev.value);
               if(param is Function)
               {
                  param(e,previousValue);
               }
            }
         }
         catch(error:Error)
         {
            PFDebug.trace(null,"Exception with handleGetCounterResult:" + error.message);
         }
      }
      
      override public function decCounter(param1:String = null, param2:Function = null, param3:Object = null) : EventDispatcher
      {
         var _loc4_:FBFacebookCall;
         (_loc4_ = new FBFacebookCall("dashboard.decrementCount")).setArg("uid",userBackptr.getID());
         _loc4_.setCallback(param2,param3);
         SocialPlatform_Facebook.facebook.post(_loc4_);
         return _loc4_;
      }
      
      override public function setCounter(param1:int, param2:String = null, param3:Function = null, param4:Object = null) : EventDispatcher
      {
         var _loc5_:FBFacebookCall;
         (_loc5_ = new FBFacebookCall("dashboard.setCount")).setArg("uid",userBackptr.getID());
         _loc5_.setArg("count",param1);
         _loc5_.setCallback(param3,param4);
         SocialPlatform_Facebook.facebook.post(_loc5_);
         return _loc5_;
      }
      
      override public function getCounter(param1:Function = null, param2:Object = null) : EventDispatcher
      {
         var _loc3_:FBFacebookCall = new FBFacebookCall("dashboard.getCount",null,handleGetCounterResult,param1);
         _loc3_.setArg("uid",userBackptr.getID());
         _loc3_.userObject1 = param1;
         _loc3_.userObject2 = param2;
         SocialPlatform_Facebook.facebook.post(_loc3_);
         return _loc3_;
      }
      
      override public function incCounter(param1:String = null, param2:Function = null, param3:Object = null) : EventDispatcher
      {
         var _loc4_:FBFacebookCall;
         (_loc4_ = new FBFacebookCall("dashboard.incrementCount")).setArg("uid",userBackptr.getID());
         _loc4_.setCallback(param2,param3);
         SocialPlatform_Facebook.facebook.post(_loc4_);
         return _loc4_;
      }
   }
}
