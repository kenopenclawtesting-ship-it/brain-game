package com.facebook.utils
{
   import com.facebook.data.FacebookData;
   import com.facebook.errors.FacebookError;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import flash.display.LoaderInfo;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   
   public class FacebookConnectUtil extends EventDispatcher
   {
      
      protected static var externalInterfaceCallId:Number = 0;
      
      protected static var externalInterfaceCalls:Object = {};
      
      protected static var hasCallback:Boolean = false;
       
      
      protected var _loaderInfo:LoaderInfo;
      
      public function FacebookConnectUtil(param1:LoaderInfo)
      {
         super();
         if(hasCallback == false)
         {
            ExternalInterface.addCallback("handleConnectCallback",handleConnectCallback);
            hasCallback = true;
         }
         this._loaderInfo = param1;
      }
      
      protected static function handleConnectCallback(param1:Object, param2:Object, param3:String) : void
      {
         var _loc5_:FacebookData = null;
         var _loc6_:FacebookError = null;
         var _loc4_:FacebookCall = externalInterfaceCalls[param3];
         if(param1)
         {
            (_loc5_ = new FacebookData()).rawResult = param1 as String;
            _loc4_.facebook_internal::handelResult(_loc5_);
         }
         else
         {
            (_loc6_ = new FacebookError()).rawResult = param2 as String;
            _loc4_.facebook_internal::handleError(_loc6_);
         }
         delete externalInterfaceCalls[param3];
      }
      
      public function getLoggedInUser() : String
      {
         return ExternalInterface.call("FB.Connect.get_loggedInUser");
      }
      
      public function callMethod(param1:String, ... rest) : FacebookCall
      {
         var _loc3_:String = "bridgeFacebookCall_" + externalInterfaceCallId;
         var _loc4_:* = "function " + _loc3_ + "() { " + "FB.Connect." + param1 + "(" + JavascriptRequestHelper.formatParams(rest) + ", " + "function(result, exception) {" + "document." + this._loaderInfo.parameters.as_swf_name + ".handleConnectCallback(result, exception, " + externalInterfaceCallId + ")" + "}" + ");" + "}";
         ExternalInterface.call(_loc4_);
         var _loc5_:FacebookCall = new FacebookCall(param1);
         externalInterfaceCalls[externalInterfaceCallId] = _loc5_;
         return _loc5_;
      }
   }
}
