package com.playfish.rpc.messaging
{
   import com.playfish.rpc.share.RpcClientBase;
   import com.playfish.rpc.share.RpcRequestBase;
   
   public class RpcMessagingClient extends RpcClientBase
   {
       
      
      public function RpcMessagingClient(param1:Object, param2:uint, param3:Function, param4:Function)
      {
         super(param1,param2,param3,param4);
      }
      
      private static function getMessagingInfoResponseHandler(param1:RpcMessagingResponse, param2:Function) : Function
      {
         var messageInfos:Array = null;
         var response:RpcMessagingResponse = param1;
         var successCallback:Function = param2;
         messageInfos = response.readArray(response.readMessageInfo);
         return function():void
         {
            successCallback(messageInfos);
         };
      }
      
      protected function getMessagingInfoWithCallType(param1:uint, param2:Function, param3:Function) : void
      {
         var _loc4_:RpcRequestBase;
         (_loc4_ = newRpcRequest(param1,getMessagingInfoResponseHandler,param2,param3)).perform();
      }
      
      protected function recordMessageSeenWithCallType(param1:uint, param2:int, param3:int, param4:Function, param5:Function) : void
      {
         var _loc6_:RpcRequestBase;
         (_loc6_ = newRpcRequest(param1,emptyResponseHandler,param4,param5)).writeUintvar31(param2);
         _loc6_.writeUint8(param3);
         _loc6_.perform();
      }
   }
}
