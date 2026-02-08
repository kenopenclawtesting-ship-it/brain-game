package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.commands.auth.RevokeAuthorization;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.engine.core.PFTimer;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformApp;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformAppSettings;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFeatureBookmark;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformModuleSettings;
   import com.playfish.external.*;
   
   public class SocialPlatformApp_Facebook extends SocialPlatformApp
   {
       
      
      private var firstPrepareAttempt:Boolean;
      
      public function SocialPlatformApp_Facebook(param1:SocialPlatformAppSettings)
      {
         super(param1);
         firstPrepareAttempt = true;
      }
      
      override public function isSupported() : Boolean
      {
         return true;
      }
      
      override public function getPermission(param1:int) : String
      {
         switch(param1)
         {
            case PERMISSION_PHOTOS_UPLOAD:
               return "photo_upload";
            case PERMISSION_BOOKMARKED:
               return "bookmark";
            case PERMISSION_EVENTS_CREATE:
            case PERMISSION_EVENTS_UPDATE:
            case PERMISSION_EVENTS_DELETE:
               return "create_event";
            case PERMISSION_PUBLISH_STREAM:
               return "publish_stream";
            case PERMISSION_EMAIL_ACCESS:
               return "email";
            default:
               return null;
         }
      }
      
      override public function prepare(param1:SocialPlatform, param2:SocialPlatformModuleSettings) : Boolean
      {
         super.prepare(param1,param2);
         if(platformBackRef.isPreparing(PREPARATION_MASK) || !param2.enable || isAvailable())
         {
            return true;
         }
         platformBackRef.onPrepareBegin(PREPARATION_MASK);
         return triggerRequest();
      }
      
      override public function sendDashboardUserStatus(param1:String, param2:String, param3:String) : Boolean
      {
         return false;
      }
      
      override public function grantPermission(param1:String, param2:Function = null) : Boolean
      {
         var _loc3_:ExternalPage = null;
         if(param1 == null)
         {
            return false;
         }
         if(param1 == "email")
         {
            _loc3_ = new ExternalPage(ExternalConstant.PERMISSION_JS);
            _loc3_.show();
         }
         else if(param1 == "bookmark")
         {
            getFeatureBookmark().addBookmark();
         }
         else
         {
            SocialPlatform_Facebook.facebook.grantExtendedPermission(param1);
         }
         PFTimer.startAlarm(20000,recheckPermissions);
         return true;
      }
      
      private function recheckPermissions(param1:Object = null) : Boolean
      {
         triggerRequest();
         return false;
      }
      
      override public function revokePermission(param1:String, param2:Function = null) : Boolean
      {
         var _loc3_:RevokeAuthorization = new RevokeAuthorization(SocialPlatform.instance.user.getID());
         SocialPlatform_Facebook.facebook.post(_loc3_);
         recheckPermissions();
         return true;
      }
      
      private function triggerRequest() : Boolean
      {
         var _loc1_:String = platformBackRef.user.getID();
         var _loc2_:String = "SELECT bookmarked,status_update,photo_upload,create_event,email,publish_stream FROM permissions WHERE uid=" + _loc1_;
         return SocialPlatform_Facebook.instance.makeQuery(_loc2_,onGetAppPermissions);
      }
      
      private function onGetAppPermissions(param1:SocialEventResult) : void
      {
         var alreadyAvailable:Boolean = false;
         var appInfo:Object = null;
         var e:SocialEventResult = param1;
         try
         {
            alreadyAvailable = available;
            if(SocialPlatform_Facebook.isValidEventSuccess(e) && e.resultData.length > 0)
            {
               appInfo = e.resultData[0];
               permissionsSet[PERMISSION_BOOKMARKED] = appInfo.bookmarked;
               permissionsSet[PERMISSION_STATUS_UPDATE] = appInfo.status_update;
               permissionsSet[PERMISSION_PHOTOS_UPLOAD] = appInfo.photo_upload;
               permissionsSet[PERMISSION_EVENTS_CREATE] = appInfo.create_event;
               permissionsSet[PERMISSION_EMAIL_ACCESS] = appInfo.email;
               permissionsSet[PERMISSION_PUBLISH_STREAM] = appInfo.publish_stream;
               available = true;
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
            PFDebug.trace(null,"Exception (app):" + (error == null ? "Unknown" : error.message));
         }
      }
      
      override public function getFeatureBookmark() : SocialPlatformFeatureBookmark
      {
         return new SocialPlatformFeatureBookmark_Facebook(this);
      }
   }
}
