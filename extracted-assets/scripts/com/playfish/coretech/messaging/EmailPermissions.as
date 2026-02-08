package com.playfish.coretech.messaging
{
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.engine.ui.PFPopUp;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformApp;
   import com.playfish.rpc.messaging.IRpcMessagingClient;
   import com.playfish.rpc.messaging.MessageInfo;
   import flash.events.Event;
   
   public class EmailPermissions
   {
      
      private static var sIsEmailPromptScheduled:Boolean = false;
       
      
      public function EmailPermissions()
      {
         super();
      }
      
      public static function scheduleEmailPrompt() : void
      {
         sIsEmailPromptScheduled = true;
      }
      
      private static function promptAccepted(param1:IRpcMessagingClient) : void
      {
         var rpcClient:IRpcMessagingClient = param1;
         rpcClient.recordMessageSeen(Messaging.cConfig.requestEmailPermission.messageId,MessageInfo.USER_RESPONSE_YES,function():void
         {
            PFDebug.trace("SOCIAL","recordMessageSeenSuccess");
         },function():void
         {
            PFDebug.trace("SOCIAL","recordMessageSeenFailed");
         });
         SocialPlatform.instance.application.grantPermissionTag(SocialPlatformApp.PERMISSION_EMAIL_ACCESS);
      }
      
      private static function promptCancelled(param1:IRpcMessagingClient) : void
      {
         var rpcClient:IRpcMessagingClient = param1;
         rpcClient.recordMessageSeen(Messaging.cConfig.requestEmailPermission.messageId,MessageInfo.USER_RESPONSE_NO,function():void
         {
            PFDebug.trace("SOCIAL","recordMessageSeenSuccess");
         },function():void
         {
            PFDebug.trace("SOCIAL","recordMessageSeenFailed");
         });
      }
      
      public static function promptIfNecessary(param1:Class, param2:IRpcMessagingClient) : void
      {
         var popup:PFPopUp = null;
         var promptClass:Class = param1;
         var rpcClient:IRpcMessagingClient = param2;
         if(sIsEmailPromptScheduled && !SocialPlatform.current.application.isPermissionSet(SocialPlatformApp.PERMISSION_EMAIL_ACCESS))
         {
            popup = new promptClass();
            popup.show();
            popup.addEventListener(Event.COMPLETE,function(param1:Event):void
            {
               promptAccepted(rpcClient);
            });
            popup.addEventListener(Event.CANCEL,function(param1:Event):void
            {
               promptCancelled(rpcClient);
            });
            sIsEmailPromptScheduled = false;
         }
      }
   }
}
