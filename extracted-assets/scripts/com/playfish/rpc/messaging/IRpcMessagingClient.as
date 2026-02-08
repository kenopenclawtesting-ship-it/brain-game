package com.playfish.rpc.messaging
{
   public interface IRpcMessagingClient
   {
       
      
      function recordMessageSeen(param1:int, param2:int, param3:Function, param4:Function) : void;
      
      function getMessagingInfo(param1:Function, param2:Function) : void;
   }
}
