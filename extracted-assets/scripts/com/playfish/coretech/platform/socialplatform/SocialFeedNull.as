package com.playfish.coretech.platform.socialplatform
{
   import com.playfish.coretech.engine.core.PFCallbackEvent;
   import flash.events.EventDispatcher;
   
   public class SocialFeedNull extends SocialFeed
   {
       
      
      public function SocialFeedNull(param1:Boolean)
      {
         super(param1);
      }
      
      override public function isValid() : Boolean
      {
         return false;
      }
      
      override public function publish(param1:Function = null) : EventDispatcher
      {
         if(param1 != null)
         {
            param1(new PFCallbackEvent(false,this));
         }
         return this;
      }
   }
}
