package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.Facebook;
   import com.facebook.events.FacebookEvent;
   import com.facebook.session.JSSession;
   import com.facebook.utils.FacebookConnectUtil;
   import com.playfish.coretech.engine.core.PFDebug;
   import flash.display.LoaderInfo;
   import flash.external.ExternalInterface;
   
   public class FacebookConnectObject extends FacebookConnectUtil
   {
       
      
      private var fldApiKey:String;
      
      public var fldFacebook:Facebook;
      
      public var fldJsSession:JSSession;
      
      private var fldLoaderInfo:LoaderInfo;
      
      public function FacebookConnectObject(param1:Facebook, param2:String, param3:LoaderInfo)
      {
         super(param3);
         this.fldFacebook = param1;
         this.fldApiKey = param2;
         this.fldLoaderInfo = param3;
         this.initialize();
      }
      
      public function onLogInCallBack() : void
      {
         PFDebug.trace(null,"FBC:onLogInCallBack");
         this.initSession();
      }
      
      public function login() : void
      {
         PFDebug.trace(null,"FBC:login");
         ExternalInterface.call("login");
      }
      
      private function initSession() : void
      {
         this.fldJsSession = new JSSession(this.fldApiKey,this.fldLoaderInfo.parameters.as_swf_name);
         this.fldJsSession.addEventListener(FacebookEvent.CONNECT,onConnectHandler);
         this.fldFacebook.startSession(this.fldJsSession);
         this.fldJsSession.verifySession();
      }
      
      private function onConnectHandler(param1:FacebookEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function initialize() : void
      {
         this.initCallBacks();
      }
      
      private function initCallBacks() : void
      {
         ExternalInterface.addCallback("onLogIn",this.onLogInCallBack);
      }
   }
}
