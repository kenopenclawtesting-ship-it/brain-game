package com.playfish.coretech.platform.socialplatform
{
   import flash.events.EventDispatcher;
   
   public class SocialPlatformFeatureCounter extends SocialPlatformFeature
   {
       
      
      protected var previousValue:int;
      
      protected var userBackptr:SocialPlatformUser;
      
      protected var isAvailable:Boolean;
      
      public function SocialPlatformFeatureCounter(param1:Object)
      {
         super(param1);
         userBackptr = param1 as SocialPlatformUser;
         isAvailable = false;
      }
      
      public function decCounter(param1:String = null, param2:Function = null, param3:Object = null) : EventDispatcher
      {
         return null;
      }
      
      public function getCounter(param1:Function = null, param2:Object = null) : EventDispatcher
      {
         return null;
      }
      
      public function isCounterValueAvailable() : Boolean
      {
         return isAvailable;
      }
      
      public function getCounterValue() : int
      {
         return previousValue;
      }
      
      public function setCounter(param1:int, param2:String = null, param3:Function = null, param4:Object = null) : EventDispatcher
      {
         return null;
      }
      
      public function incCounter(param1:String = null, param2:Function = null, param3:Object = null) : EventDispatcher
      {
         return null;
      }
   }
}
