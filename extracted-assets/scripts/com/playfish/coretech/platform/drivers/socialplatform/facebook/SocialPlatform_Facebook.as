package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.Facebook;
   import com.facebook.events.FacebookEvent;
   import com.facebook.net.FacebookCall;
   import com.facebook.session.IFacebookSession;
   import com.facebook.utils.FacebookSessionUtil;
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.coretech.engine.core.*;
   import com.playfish.coretech.platform.drivers.socialstats.*;
   import com.playfish.coretech.platform.natural.facebook.*;
   import com.playfish.coretech.platform.socialplatform.*;
   import com.playfish.coretech.platform.socialstats.*;
   import com.playfish.rpc.share.NetworkUid;
   import flash.events.TimerEvent;
   import flash.utils.*;
   
   public class SocialPlatform_Facebook extends SocialPlatform
   {
      
      public static const FQL_DEFAULT_PRIORITY:int = 16;
      
      public static var facebook:Facebook;
      
      public static var runningQueue:Boolean;
      
      public static var instance:SocialPlatform_Facebook;
      
      public static var session:IFacebookSession;
      
      public static var fb_namespace:Namespace;
      
      public static var queueQueryList:Array;
       
      
      public function SocialPlatform_Facebook(param1:String, param2:Function, param3:Object, param4:SocialPlatformSettings)
      {
         var _loc6_:FacebookSessionUtil = null;
         var _loc7_:FacebookConnectObject = null;
         var _loc8_:* = null;
         var _loc5_:String = "0";
         instance = this;
         if(param3 is IFacebookSession)
         {
            session = param3 as IFacebookSession;
            facebook = new Facebook();
            facebook.startSession(session);
            _loc5_ = facebook.uid == null ? "0" : facebook.uid;
         }
         else if(param3 is FacebookSessionUtil)
         {
            _loc6_ = param3 as FacebookSessionUtil;
            session = _loc6_.activeSession;
            facebook = _loc6_.facebook;
            _loc5_ = facebook.uid == null ? "0" : facebook.uid;
         }
         else if(param3 is FacebookConnectObject)
         {
            _loc7_ = param3 as FacebookConnectObject;
            session = _loc7_.fldJsSession;
            facebook = _loc7_.fldFacebook;
            facebook.startSession(session);
            _loc5_ = PFEngine.instance.getParameterString("fb_sig_user");
            _loc8_ = "SELECT sex,uid, name, first_name, last_name, birthday_date, pic_square, pic_big, online_presence, is_app_user FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=" + _loc5_ + ")";
         }
         runningQueue = false;
         queueQueryList = new Array();
         players = new Array();
         fb_namespace = new Namespace("http://api.facebook.com/1.0/");
         application = new SocialPlatformApp_Facebook(param4.application);
         user = createUser(_loc5_);
         feeds = new SocialPlatformFeeds_Facebook(param4.feeds);
         fans = new SocialPlatformFans_Facebook(param4.fans);
         friends = new SocialPlatformFriends_Facebook(param4.friends);
         if(photos == null)
         {
            photos = new SocialPlatformPhotos_Facebook(param4.photos);
         }
         if(events == null)
         {
            events = new SocialPlatformEvents_Facebook(param4.events);
         }
         if(livechat == null)
         {
            livechat = new SocialPlatformLiveChat_Facebook(param4.livechat);
         }
         super(param2,param4);
         registerInternalFriendshipEvaluationFunction([new FriendshipEvaluatorRandomize(),100],FriendshipMetric.DEFAULT);
         registerInternalFriendshipEvaluationFunction([new FriendshipEvaluatorPhotographicSubjects(),100],FriendshipMetric.PHOTOGRAPHIC_SUBJECT);
         registerInternalFriendshipEvaluationFunction([new FriendshipEvaluatorPhotographicCaptions(),100],FriendshipMetric.PHOTOGRAPHIC_CAPTION);
         registerInternalFriendshipEvaluationFunction([new FriendshipEvaluatorPhotographicSubjects(),30,new FriendshipEvaluatorRandomize(),60],FriendshipMetric.META_TEST_1);
      }
      
      public static function isValidEvent(param1:SocialEventResult) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return true;
      }
      
      public static function endQuery(param1:Function, param2:Object = null) : Boolean
      {
         return false;
      }
      
      public static function addQuery(param1:Function, param2:Object = null) : Boolean
      {
         return false;
      }
      
      public static function getSocialEventResult(param1:FacebookEvent) : SocialEventResult
      {
         var _loc2_:SocialEventResult = getSocialEventSuccess(param1);
         if(_loc2_.success)
         {
            _loc2_.applyResult(param1.data.rawResult);
         }
         else
         {
            _loc2_.errorMessage += !!param1.error ? param1.error.errorMsg : "";
         }
         return _loc2_;
      }
      
      public static function toString() : String
      {
         return instance.getQueueString();
      }
      
      public static function getSocialEventSuccess(param1:FacebookEvent) : SocialEventResult
      {
         var _loc2_:SocialEventResult = new SocialEventResult(param1.currentTarget,param1);
         if(param1 == null)
         {
            _loc2_.errorMessage = "FB-ERR: Event returned was null";
         }
         else if(!param1.success)
         {
            _loc2_.errorMessage = "FB-ERR: Basic fail.";
            if(param1.error != null && param1.error.error != null)
            {
               _loc2_.errorMessage += param1.error.error;
            }
            if(param1.error != null && param1.error.reason != null)
            {
               _loc2_.errorMessage += param1.error.reason;
            }
         }
         else if(param1.data == null)
         {
            _loc2_.errorMessage = "FB-ERR: Data returned was null";
         }
         else if(param1.success && param1.data.rawResult == null)
         {
            _loc2_.errorMessage = "FB-ERR: Success Data returned was null";
         }
         else if(param1.success)
         {
            _loc2_.errorMessage = "Success!";
            _loc2_.success = true;
         }
         return _loc2_;
      }
      
      public static function isValidEventSuccess(param1:SocialEventResult) : Boolean
      {
         if(!isValidEvent(param1))
         {
            return false;
         }
         return param1.success;
      }
      
      public static function beginQuery(param1:Function, param2:Object = null) : Boolean
      {
         return true;
      }
      
      override public function getSession() : Object
      {
         return session as Object;
      }
      
      private function retryQueryTimeout(param1:TimerEvent) : void
      {
         var _loc2_:PFTimer = param1.target as PFTimer;
         var _loc3_:Object = _loc2_.objParam;
         var _loc4_:int;
         if((_loc4_ = int(queueQueryList.indexOf(_loc3_))) != -1)
         {
            _loc3_["active"] = false;
            PFDebug.warning("Re-sending query: " + _loc3_["fql"]);
            queueQuery(_loc3_["fql"],_loc3_["cbfn"],_loc3_["prm"],_loc3_["prm2"]);
         }
      }
      
      public function acquirePlayer(param1:String, param2:Function = null) : Boolean
      {
         var _loc3_:String = "SELECT  first_name, last_name , name,significant_other_id, family, birthday_date, pic_square, pic_big, online_presence, is_app_user, sex FROM user WHERE uid = " + param1;
         return queueQuery(_loc3_,onGetUserData,param1,param2);
      }
      
      override public function createUser(param1:String) : SocialPlatformUser
      {
         return registerUser(new SocialPlatformUser_Facebook(param1));
      }
      
      protected function onFQLQueueComplete(param1:SocialEventResult) : void
      {
         var _loc2_:FBFqlQuery = (param1.platformEvent as FacebookEvent).target as FBFqlQuery;
         onFQLQueueCompleteFQL(param1,_loc2_);
      }
      
      override public function getNativeSession() : Object
      {
         return facebook as Object;
      }
      
      public function triggerQueuedQueryIfPossible() : Boolean
      {
         var _loc1_:PFTimer = null;
         if(runningQueue)
         {
            return false;
         }
         if(queueQueryList.length > 0)
         {
            if(makeQuery(queueQueryList[0]["fql"],onFQLQueueComplete,queueQueryList[0]))
            {
               if(current.retryTimeout != -1)
               {
                  _loc1_ = new PFTimer(current.retryTimeout * 1000,1,queueQueryList[0]);
                  _loc1_.addEventListener(TimerEvent.TIMER_COMPLETE,retryQueryTimeout);
                  _loc1_.start();
               }
               runningQueue = true;
               return true;
            }
         }
         return false;
      }
      
      public function getQueueString() : String
      {
         var _loc2_:Object = null;
         var _loc1_:String = "";
         _loc1_ += runningQueue ? "Queue is awaiting return\n" : "Nothing waiting";
         for each(_loc2_ in queueQueryList)
         {
            _loc1_ += "Q:" + _loc2_["fql"] + " prm:" + _loc2_["prm"] + " cbfn:" + _loc2_["cbfn"] + "\n";
         }
         return _loc1_;
      }
      
      override public function preparePlayer(param1:String, param2:Function = null) : Boolean
      {
         super.preparePlayer(param1,param2);
         return acquirePlayer(param1,param2);
      }
      
      override public function isSessionActive() : Boolean
      {
         return session != null && session.is_connected;
      }
      
      public function queueQuery(param1:String, param2:Function, param3:Object, param4:Object, param5:int = 16) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc6_:Object;
         (_loc6_ = new Object())["fql"] = param1;
         _loc6_["prm"] = param3;
         _loc6_["prm2"] = param4;
         _loc6_["cbfn"] = param2;
         _loc6_["active"] = true;
         queueQueryList.push(_loc6_);
         triggerQueuedQueryIfPossible();
         return true;
      }
      
      protected function onFQLQueueCompleteFQL(param1:SocialEventResult, param2:FBFqlQuery) : void
      {
         var _loc3_:Object = param2.queuedObjectRef;
         PFArray.removeFromArray(queueQueryList,_loc3_);
         if(_loc3_["active"])
         {
            _loc3_["cbfn"](param1,_loc3_["prm"],_loc3_["prm2"]);
         }
         runningQueue = false;
         triggerQueuedQueryIfPossible();
      }
      
      override public function getRPCNetworkID() : uint
      {
         return NetworkUid.FACEBOOK;
      }
      
      public function onGetUserData(param1:SocialEventResult, param2:Object, param3:Object) : void
      {
         var fn:Function = null;
         var uid:String = null;
         var player:SocialPlatformUser_Facebook = null;
         var event:SocialEventResult = param1;
         var param:Object = param2;
         param2 = param3;
         if(isValidEventSuccess(event))
         {
            try
            {
               uid = param as String;
               player = SocialPlatform.current.getPlayer(uid) as SocialPlatformUser_Facebook;
               if(player == null)
               {
                  player = SocialPlatform.current.createUser(uid) as SocialPlatformUser_Facebook;
               }
               player.setFromData(event.resultData[0]);
            }
            catch(error:Error)
            {
               PFDebug.trace(null,"Exception (getUserData):" + (error == null ? "Unknown" : error.message));
            }
            fn = param2 as Function;
            if(fn != null)
            {
               fn(event,uid);
            }
         }
      }
      
      public function makeQuery(param1:String, param2:Function, param3:Object = null) : Boolean
      {
         var _loc7_:SocialEventResult = null;
         var _loc4_:IFacebookSession;
         if((_loc4_ = SocialPlatform_Facebook.session) == null || facebook == null)
         {
            _loc7_ = new SocialEventResult(param1);
            param2(_loc7_);
            return false;
         }
         var _loc5_:FBFqlQuery = new FBFqlQuery(param1,param3,param2);
         var _loc6_:FacebookCall;
         (_loc6_ = facebook.post(_loc5_)).addEventListener(FacebookEvent.COMPLETE,processQueryCallback);
         return true;
      }
      
      public function processQueryCallback(param1:FacebookEvent) : void
      {
         var _loc3_:SocialEventResult = null;
         var _loc2_:FBFqlQuery = param1.currentTarget as FBFqlQuery;
         if(_loc2_.callbackFunctionRef != null)
         {
            _loc3_ = getSocialEventResult(param1);
            _loc2_.callbackFunctionRef(_loc3_);
         }
      }
   }
}
