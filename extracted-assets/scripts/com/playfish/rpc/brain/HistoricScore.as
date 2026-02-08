package com.playfish.rpc.brain
{
   public class HistoricScore
   {
       
      
      public var scores:Array;
      
      public var date:Date;
      
      public function HistoricScore(param1:Date = null, param2:Array = null)
      {
         super();
         this.date = param1;
         this.scores = param2;
      }
      
      public function toString() : String
      {
         var _loc2_:AggregateScore = null;
         var _loc1_:* = "[date=" + date + " scores={";
         for each(_loc2_ in scores)
         {
            _loc1_ += " " + _loc2_;
         }
         return _loc1_ + " }";
      }
   }
}
