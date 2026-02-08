package com.playfish.coretech.messaging
{
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.rpc.messaging.MessageInfo;
   
   public final class Messaging
   {
      
      private static const ONE_DAY:uint = PFDebug.DEBUG ? 60 : uint(60 * 60 * 24);
      
      public static const cConfig:Object = {"requestEmailPermission":{
         "messageId":1,
         "repeatDelay":14 * ONE_DAY
      }};
       
      
      public function Messaging()
      {
         super();
      }
      
      public static function getInfoFail() : void
      {
         PFDebug.trace("SOCIAL","getMessagingInfoFailed");
      }
      
      public static function hasMessageBeenSeenRecently(param1:Array, param2:Object) : Boolean
      {
         var _loc3_:MessageInfo = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_.messageId == param2.messageId && _loc3_.timeSinceLastSeen <= param2.repeatDelay)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getInfoSuccess(param1:Array) : void
      {
         var _loc3_:MessageInfo = null;
         PFDebug.trace("SOCIAL","getMessagingInfoSucceeded with " + param1.length + " results");
         var _loc2_:Boolean = true;
         for each(_loc3_ in param1)
         {
            PFDebug.trace("SOCIAL","\t" + _loc3_);
         }
         if(!hasMessageBeenSeenRecently(param1,cConfig.requestEmailPermission))
         {
            EmailPermissions.scheduleEmailPrompt();
         }
      }
   }
}
