package com.playfish.rpc.brain
{
   public class AggregateScore
   {
      
      public static const COMBINED_SCORE:uint = 255;
       
      
      public var bestScore:uint;
      
      public var type:uint;
      
      public var playCount:uint;
      
      public var totalScore:uint;
      
      public function AggregateScore()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[type=" + type + " total=" + totalScore + " plays=" + playCount + " best=" + bestScore + "]";
      }
   }
}
