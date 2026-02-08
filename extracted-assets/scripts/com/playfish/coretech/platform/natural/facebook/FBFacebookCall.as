package com.playfish.coretech.platform.natural.facebook
{
   import com.adobe.serialization.json.JSONEncoder;
   import com.facebook.data.FacebookData;
   import com.facebook.errors.FacebookError;
   import com.facebook.events.FacebookEvent;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import flash.net.URLVariables;
   
   use namespace facebook_internal;
   
   public class FBFacebookCall extends FacebookCall
   {
       
      
      private var callbackResultObject:Object;
      
      private var callbackResult:Function;
      
      private var callbackError:Function;
      
      public var userObject1:Object;
      
      public var userObject2:Object;
      
      private var callbackErrorObject:Object;
      
      public function FBFacebookCall(param1:String, param2:URLVariables = null, param3:Function = null, param4:Object = null, param5:Function = null, param6:Object = null)
      {
         super(param1,param2);
         this.callbackResult = param3;
         this.callbackResultObject = param4;
         this.callbackError = param5;
         this.callbackErrorObject = param6;
      }
      
      override facebook_internal function handleError(param1:FacebookError) : void
      {
         if(param1 != null && param1.error != null)
         {
            PFDebug.trace(null,"FB error:" + param1.error.toString() + "  (from " + param1.requestArgs.toString());
         }
         if(param1 != null && param1.errorMsg != null)
         {
            PFDebug.trace(null,"FB errorMsg:" + param1.errorMsg.toString());
         }
         if(callbackError != null)
         {
            callbackError(result,callbackErrorObject);
         }
         dispatchEvent(new FacebookEvent(FacebookEvent.COMPLETE,false,false,false,null,param1));
      }
      
      override facebook_internal function handleResult(param1:FacebookData) : void
      {
         var _loc2_:SocialEventResult = null;
         PFDebug.trace(null,"FB result:" + param1.toString());
         PFDebug.trace(null,"FB result.raw:" + (param1.rawResult == null ? "" : param1.rawResult.toString()));
         if(callbackResult != null)
         {
            _loc2_ = new SocialEventResult(this,param1);
            _loc2_.success = true;
            callbackResult(_loc2_,callbackResultObject);
         }
         dispatchEvent(new FacebookEvent(FacebookEvent.COMPLETE,false,false,true,param1));
      }
      
      public function setArg(param1:String, param2:Object) : void
      {
         var _loc3_:JSONEncoder = new JSONEncoder(param2);
         var _loc4_:String = _loc3_.getString();
         super.facebook_internal::setRequestArgument(param1,_loc4_);
      }
      
      public function setCallback(param1:Function, param2:Object = null) : void
      {
         callbackResult = param1;
         callbackResultObject = param2;
      }
   }
}
