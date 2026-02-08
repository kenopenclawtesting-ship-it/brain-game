package com.playfish.coretech.platform.socialplatform
{
   import flash.events.EventDispatcher;
   
   public class SocialPlatformModule extends EventDispatcher
   {
       
      
      protected var platformBackRef:SocialPlatform;
      
      protected var settings:SocialPlatformModuleSettings;
      
      protected var available:Boolean;
      
      public var PREPARATION_MASK:uint;
      
      public function SocialPlatformModule(param1:SocialPlatformModuleSettings)
      {
         super();
         PREPARATION_MASK = 0;
         available = false;
         settings = param1;
      }
      
      public function isSupported() : Boolean
      {
         return false;
      }
      
      public function prepare(param1:SocialPlatform, param2:SocialPlatformModuleSettings) : Boolean
      {
         platformBackRef = param1;
         settings = param2;
         return true;
      }
      
      public function getFeatureHandler(param1:String) : SocialPlatformFeature
      {
         return null;
      }
      
      public function isStartupComplete() : Boolean
      {
         if(isDefective())
         {
            return true;
         }
         return !wasEnabled() || !isSupported() || isAvailable();
      }
      
      public function wasEnabled() : Boolean
      {
         return settings.enable;
      }
      
      override public function toString() : String
      {
         return "(unknown module)";
      }
      
      public function isDefective() : Boolean
      {
         return wasEnabled() && !isAvailable() && !SocialPlatform.current.isPreparing(PREPARATION_MASK);
      }
      
      public function isAvailable() : Boolean
      {
         return available;
      }
   }
}
