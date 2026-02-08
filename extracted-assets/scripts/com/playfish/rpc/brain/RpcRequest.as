package com.playfish.rpc.brain
{
   import com.playfish.rpc.share.RpcRequestBase;
   
   internal class RpcRequest extends RpcRequestBase
   {
       
      
      public function RpcRequest()
      {
         super();
      }
      
      internal function writeAggregateScore(param1:AggregateScore) : void
      {
         writeUint8(param1.type);
         writeUintvar31(param1.totalScore);
         writeUintvar31(param1.playCount);
         writeUintvar31(param1.bestScore);
      }
      
      internal function writeMinigameScore(param1:MinigameScore) : void
      {
         writeUintvar32(param1.id);
         writeUintvar32(param1.score);
      }
      
      internal function writeHistoricScore(param1:HistoricScore) : void
      {
         writeDate(param1.date);
         writeArray(param1.scores,writeAggregateScore);
      }
   }
}
