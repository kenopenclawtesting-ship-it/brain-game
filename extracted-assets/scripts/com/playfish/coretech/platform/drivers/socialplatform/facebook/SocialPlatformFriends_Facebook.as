package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.playfish.coretech.engine.core.*;
   import com.playfish.coretech.engine.debug.*;
   import com.playfish.coretech.platform.socialplatform.*;
   
   public class SocialPlatformFriends_Facebook extends SocialPlatformFriends
   {
       
      
      private var firstPrepareAttempt:Boolean;
      
      public function SocialPlatformFriends_Facebook(param1:SocialPlatformFriendsSettings)
      {
         super(param1);
         firstPrepareAttempt = true;
      }
      
      override public function isSupported() : Boolean
      {
         return true;
      }
      
      private function triggerRequest() : Boolean
      {
         var _loc1_:String = platformBackRef.user.getID();
         var _loc2_:* = "SELECT sex,uid, name, first_name, last_name, birthday_date, pic_square, pic_big, online_presence, is_app_user FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=" + _loc1_ + ")";
         return SocialPlatform_Facebook.instance.makeQuery(_loc2_,onGetFriendList);
      }
      
      private function onGetFriendList(param1:SocialEventResult) : void
      {
         var user:Object = null;
         var uid:String = null;
         var friendUser:SocialPlatformUser_Facebook = null;
         var e:SocialEventResult = param1;
         try
         {
            if(SocialPlatform_Facebook.isValidEventSuccess(e))
            {
               if(e.resultData != null)
               {
                  for each(user in e.resultData)
                  {
                     uid = user.uid.toString();
                     friendUser = SocialPlatform.current.createUser(uid) as SocialPlatformUser_Facebook;
                     friendUser.setFromData(user);
                     SocialPlatform.current.user.addFriend(friendUser);
                     SocialPlatform.current.user.applyFriendStats(uid);
                  }
                  available = true;
               }
            }
            if(!available && firstPrepareAttempt && settings.immediateRetry)
            {
               firstPrepareAttempt = false;
               triggerRequest();
            }
            else
            {
               platformBackRef.onPrepareComplete(PREPARATION_MASK,this);
            }
         }
         catch(error:Error)
         {
            platformBackRef.onPrepareComplete(PREPARATION_MASK,this);
            PFDebug.trace(null,"Exception (friends):" + (error == null ? "Unknown" : error.message));
         }
      }
      
      override public function prepare(param1:SocialPlatform, param2:SocialPlatformModuleSettings) : Boolean
      {
         super.prepare(param1,param2);
         if(platformBackRef.isPreparing(PREPARATION_MASK) || !param2.enable || isAvailable())
         {
            return true;
         }
         if(triggerRequest())
         {
            platformBackRef.onPrepareBegin(PREPARATION_MASK);
            return true;
         }
         return false;
      }
   }
}
