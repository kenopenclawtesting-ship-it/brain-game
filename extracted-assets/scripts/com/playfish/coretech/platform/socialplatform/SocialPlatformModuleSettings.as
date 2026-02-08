package com.playfish.coretech.platform.socialplatform
{
   public class SocialPlatformModuleSettings
   {
       
      
      public var enable:Boolean;
      
      public var immediateRetry:Boolean;
      
      public function SocialPlatformModuleSettings(param1:Boolean = false, param2:Boolean = false)
      {
         super();
         enable = param1;
         immediateRetry = param2;
      }
   }
}
