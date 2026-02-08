package com.playfish.coretech.contrib
{
   import com.facebook.session.IFacebookSession;
   import com.playfish.coretech.engine.core.PFCallbackEvent;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.socialnetwork.SocialNetwork;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFeedsSettings;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFriendsSettings;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformSettings;
   import com.playfish.coretech.platform.socialstats.InviteRecommendations;
   import com.playfish.coretech.skeleton.platform.facebook.SessionManagement;
   
   public class ChallengeGamesSocialInitialiser
   {
      
      private static var sAppName:String;
       
      
      public function ChallengeGamesSocialInitialiser()
      {
         super();
      }
      
      private static function onFacebookSessionConnect(param1:PFCallbackEvent) : void
      {
         var _loc2_:IFacebookSession = null;
         var _loc3_:SocialPlatformSettings = null;
         if(param1.success)
         {
            PFDebug.trace("SOCIAL","Facebook session validated");
            _loc2_ = param1.param as IFacebookSession;
            _loc3_ = new SocialPlatformSettings();
            _loc3_.friends = new SocialPlatformFriendsSettings(true);
            _loc3_.feeds = new SocialPlatformFeedsSettings(true);
            SocialPlatform.setCurrent(SocialPlatform.createSocialPlatform(sAppName,onSocialPlatformCreated,_loc2_,_loc3_));
         }
         else
         {
            PFDebug.warning("Facebook session creation failed");
         }
      }
      
      private static function onSocialPlatformCreated() : Boolean
      {
         PFDebug.trace("SOCIAL","Social platform created");
         new InviteRecommendations(sAppName);
         InviteRecommendations.instance.prepare();
         return true;
      }
      
      public static function initialise(param1:String) : void
      {
         var _loc2_:Boolean = false;
         sAppName = param1;
         SocialNetwork.initialize();
         SocialPlatform.initialize();
         if(SocialNetwork.isFacebook())
         {
            _loc2_ = SessionManagement.createSession(SessionManagement.LOCAL_TESTING,onFacebookSessionConnect,null);
            PFDebug.assert(_loc2_,"Facebook session creation failed");
         }
      }
   }
}
