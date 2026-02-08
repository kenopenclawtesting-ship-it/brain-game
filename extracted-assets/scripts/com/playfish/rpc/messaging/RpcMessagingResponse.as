package com.playfish.rpc.messaging
{
   import com.playfish.rpc.share.RpcResponseBase;
   
   public class RpcMessagingResponse extends RpcResponseBase
   {
       
      
      public function RpcMessagingResponse()
      {
         super();
      }
      
      internal function readMessageInfo() : MessageInfo
      {
         var _loc1_:MessageInfo = new MessageInfo();
         _loc1_.messageId = readUintvar32();
         _loc1_.timeSinceLastSeen = readUintvar32();
         _loc1_.lastUserResponse = readUint8();
         return _loc1_;
      }
   }
}
