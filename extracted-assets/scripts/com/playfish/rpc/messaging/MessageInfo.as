package com.playfish.rpc.messaging
{
   public class MessageInfo
   {
      
      public static const USER_RESPONSE_UNKNOWN:uint = 1;
      
      public static const USER_RESPONSE_NO:uint = 3;
      
      public static const USER_RESPONSE_YES:uint = 2;
       
      
      public var lastUserResponse:int;
      
      public var messageId:int;
      
      public var timeSinceLastSeen:int;
      
      public function MessageInfo()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[MessageInfo: messageId=" + messageId + " timeSinceLastSeen=" + timeSinceLastSeen + " lastUserResponse=" + lastUserResponse + "]";
      }
   }
}
