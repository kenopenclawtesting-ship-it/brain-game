package com.playfish.coretech.skeleton.platform.facebook
{
   import com.facebook.Facebook;
   import com.facebook.errors.FacebookError;
   import com.facebook.events.FacebookEvent;
   import com.facebook.facebook_internal;
   import com.facebook.session.WebSession;
   import com.facebook.utils.FacebookSessionUtil;
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.coretech.engine.core.PFCallbackEvent;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.drivers.socialplatform.facebook.FacebookConnectObject;
   import com.playfish.coretech.platform.socialnetwork.SocialNetwork;
   import flash.display.LoaderInfo;
   
   public class SessionManagement
   {
      
      public static const LOCAL_TESTING:uint = 1;
      
      public static const FACEBOOK_LIVE:uint = 3;
      
      public static const INTEGRATION_SERVER:uint = 2;
      
      private static var sessionCallback:Function = null;
      
      public static const OFFLINE_DEVELOPMENT:uint = 0;
       
      
      public function SessionManagement()
      {
         super();
      }
      
      private static function onSessionError(param1:FacebookError) : void
      {
         PFDebug.trace(null,"FB session error");
         if(param1 != null && param1.error != null)
         {
            PFDebug.trace(null,"FB error:" + param1.error.toString() + "  (from " + param1.requestArgs.toString());
         }
      }
      
      public static function onSessionConnect(param1:FacebookEvent) : void
      {
         PFDebug.trace(null,"FB: onSessionConnect (" + param1.success + ")");
         sessionCallback(new PFCallbackEvent(param1.success,param1,param1.currentTarget));
      }
      
      public static function createSession(param1:uint, param2:Function, param3:Object) : Boolean
      {
         var apiKey:String = null;
         var sigSecretSession:String = null;
         var sigSession:String = null;
         var sigUser:String = null;
         var session:WebSession = null;
         var fldConnect:FacebookConnectObject = null;
         var session2:FacebookSessionUtil = null;
         var type:uint = param1;
         var callbackHandler:Function = param2;
         var loaderInfo:Object = param3;
         if(!SocialNetwork.isFacebook())
         {
            PFDebug.assert(false,"SessionManagement.createSession is not available outside of Facebook. Please encourage CoreTech management to do so.");
            return false;
         }
         PFDebug.assert(sessionCallback == null,"You can not create two sessions with createSession");
         apiKey = PFEngine.instance.getParameterString("fb_sig_api_key");
         try
         {
            switch(type)
            {
               case OFFLINE_DEVELOPMENT:
                  break;
               case LOCAL_TESTING:
                  sessionCallback = callbackHandler;
                  sigSecretSession = PFEngine.instance.getParameterString("fb_sig_ss");
                  sigSession = PFEngine.instance.getParameterString("fb_sig_session_key");
                  sigUser = PFEngine.instance.getParameterString("fb_sig_user");
                  session = new WebSession(apiKey,sigSecretSession,sigSession);
                  session.facebook_internal::_uid = sigUser;
                  session.addEventListener(FacebookEvent.CONNECT,onSessionConnect);
                  session.verifySession();
                  break;
               case FACEBOOK_LIVE:
               case INTEGRATION_SERVER:
                  sessionCallback = callbackHandler;
                  if(SocialNetwork.isFacebookConnect())
                  {
                     fldConnect = new FacebookConnectObject(new Facebook(),apiKey,loaderInfo as LoaderInfo);
                     fldConnect.addEventListener(FacebookEvent.CONNECT,onSessionConnect);
                     fldConnect.addEventListener(FacebookEvent.ERROR,onSessionError);
                     fldConnect.login();
                  }
                  else
                  {
                     session2 = new FacebookSessionUtil(apiKey,null,loaderInfo as LoaderInfo);
                     session2.addEventListener(FacebookEvent.CONNECT,onSessionConnect);
                     session2.addEventListener(FacebookEvent.ERROR,onSessionError);
                     session2.verifySession();
                  }
            }
         }
         catch(error:Error)
         {
            PFDebug.trace(null,"Exception (SessionManagement.createSession):" + (error == null ? "Unknown" : error.message));
            return false;
         }
         return true;
      }
   }
}
