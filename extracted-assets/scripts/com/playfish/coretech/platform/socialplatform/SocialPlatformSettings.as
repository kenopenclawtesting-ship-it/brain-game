package com.playfish.coretech.platform.socialplatform
{
   import com.playfish.coretech.engine.PFEngine;
   
   public class SocialPlatformSettings
   {
       
      
      public var fans:SocialPlatformFansSettings;
      
      public var photos:SocialPlatformPhotosSettings;
      
      public var livechat:SocialPlatformLiveChatSettings;
      
      public var user:SocialPlatformUserSettings;
      
      public var application:SocialPlatformAppSettings;
      
      public var friends:SocialPlatformFriendsSettings;
      
      public var events:SocialPlatformEventsSettings;
      
      public var feeds:SocialPlatformFeedsSettings;
      
      public function SocialPlatformSettings()
      {
         super();
         feeds = new SocialPlatformFeedsSettings();
         friends = new SocialPlatformFriendsSettings();
         fans = new SocialPlatformFansSettings();
         user = new SocialPlatformUserSettings();
         photos = new SocialPlatformPhotosSettings(PFEngine.instance.getParameterString("pf_photo_album_name"));
         application = new SocialPlatformAppSettings();
         events = new SocialPlatformEventsSettings();
         livechat = new SocialPlatformLiveChatSettings();
      }
      
      public static function createEmpty() : SocialPlatformSettings
      {
         return new SocialPlatformSettings();
      }
      
      public static function createFull() : SocialPlatformSettings
      {
         var _loc1_:SocialPlatformSettings = new SocialPlatformSettings();
         _loc1_.feeds = new SocialPlatformFeedsSettings(true);
         _loc1_.friends = new SocialPlatformFriendsSettings(true);
         _loc1_.fans = new SocialPlatformFansSettings(false,false);
         _loc1_.user = new SocialPlatformUserSettings(true);
         _loc1_.photos = new SocialPlatformPhotosSettings(null,true,true);
         _loc1_.application = new SocialPlatformAppSettings(true);
         _loc1_.events = new SocialPlatformEventsSettings(true);
         return _loc1_;
      }
      
      public static function createFullWithRetry() : SocialPlatformSettings
      {
         var _loc1_:SocialPlatformSettings = new SocialPlatformSettings();
         _loc1_.feeds = new SocialPlatformFeedsSettings(true,true);
         _loc1_.friends = new SocialPlatformFriendsSettings(true,true);
         _loc1_.fans = new SocialPlatformFansSettings(false,true,true);
         _loc1_.user = new SocialPlatformUserSettings(true,true);
         _loc1_.photos = new SocialPlatformPhotosSettings(null,true,true);
         _loc1_.application = new SocialPlatformAppSettings(true,true);
         _loc1_.events = new SocialPlatformEventsSettings(true,true);
         return _loc1_;
      }
   }
}
