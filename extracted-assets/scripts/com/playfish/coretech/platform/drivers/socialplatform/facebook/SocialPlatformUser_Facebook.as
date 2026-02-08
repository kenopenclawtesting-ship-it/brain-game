package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.drivers.socialstats.*;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFeatureCounter;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFeatureStatus;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformModuleSettings;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformUser;
   import com.playfish.coretech.platform.socialstats.*;
   
   public class SocialPlatformUser_Facebook extends SocialPlatformUser
   {
       
      
      private var firstPrepareAttempt:Boolean;
      
      public function SocialPlatformUser_Facebook(param1:String = null)
      {
         super(param1);
         firstPrepareAttempt = true;
      }
      
      override public function getFeatureStatus() : SocialPlatformFeatureStatus
      {
         return new SocialPlatformFeatureStatus_Facebook(this);
      }
      
      public function onPlayerReady(param1:SocialEventResult, param2:String) : void
      {
         triggerRequest();
      }
      
      override public function isSupported() : Boolean
      {
         return true;
      }
      
      public function onGetFanStatus(param1:SocialEventResult) : void
      {
         var page:Object = null;
         var event:SocialEventResult = param1;
         try
         {
            if(SocialPlatform_Facebook.isValidEventSuccess(event))
            {
               if(event.resultData != null)
               {
                  for each(page in event.resultData)
                  {
                     fanpageList.push(page.page_id);
                  }
                  fanpageListAvailable = true;
               }
            }
            available = true;
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
            PFDebug.trace(null,"Exception (user):" + (error == null ? "Unknown" : error.message));
         }
      }
      
      override public function prepare(param1:SocialPlatform, param2:SocialPlatformModuleSettings) : Boolean
      {
         super.prepare(param1,param2);
         if(!param2.enable || isAvailable())
         {
            return true;
         }
         platformBackRef.onPrepareBegin(PREPARATION_MASK);
         var _loc3_:String = SocialPlatform.current.user.getID();
         return (platformBackRef as SocialPlatform_Facebook).acquirePlayer(_loc3_,onPlayerReady);
      }
      
      override public function getFeatureCounter() : SocialPlatformFeatureCounter
      {
         return new SocialPlatformFeatureCounter_Facebook(this);
      }
      
      public function setFromXML(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Namespace = SocialPlatform_Facebook.fb_namespace;
         firstName = param1.._loc2_::first_name.toString();
         lastName = param1.._loc2_::last_name.toString();
         fullName = param1.._loc2_::name.toString();
         gender = param1.._loc2_::sex.toString();
         var _loc3_:String = param1.._loc2_::birthday_date.toString();
         setProfileEntry(SocialPlatformUser.PROFILE_BIRTHDAY,_loc3_.toString());
         var _loc4_:String = param1.._loc2_::pic_square.toString();
         setProfileEntry(SocialPlatformUser.PROFILE_SMALL_PORTRAIT_URL,_loc4_.toString());
         var _loc5_:String = param1.._loc2_::pic_big.toString();
         setProfileEntry(SocialPlatformUser.PROFILE_LARGE_PORTRAIT_URL,_loc5_.toString());
         var _loc6_:String = param1.._loc2_::online_presence.toString();
         setProfileEntry(SocialPlatformUser.PROFILE_LOGGED_IN,(_loc6_ == "active" || _loc6_ == "idle").toString());
         var _loc7_:String = param1.._loc2_::is_app_user.toString();
         setProfileEntry(SocialPlatformUser.PROFILE_APPLICATION_USER,_loc7_);
      }
      
      public function setFromData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         firstName = param1.first_name;
         lastName = param1.last_name;
         fullName = param1.name;
         gender = param1.sex;
         setProfileEntry(SocialPlatformUser.PROFILE_BIRTHDAY,param1.birthday_date);
         setProfileEntry(SocialPlatformUser.PROFILE_SMALL_PORTRAIT_URL,param1.pic_square);
         setProfileEntry(SocialPlatformUser.PROFILE_LARGE_PORTRAIT_URL,param1.pic_big);
         setProfileEntry(SocialPlatformUser.PROFILE_LOGGED_IN,(param1.online_presence == "active" || param1.online_presence == "idle").toString());
         setProfileEntry(SocialPlatformUser.PROFILE_APPLICATION_USER,param1.is_app_user);
      }
      
      private function triggerRequest() : void
      {
         SocialPlatform_Facebook.instance.makeQuery("SELECT uid,page_id FROM page_fan WHERE uid = " + getID(),onGetFanStatus);
      }
   }
}
