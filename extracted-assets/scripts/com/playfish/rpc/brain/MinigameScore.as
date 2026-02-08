package com.playfish.rpc.brain
{
   public class MinigameScore
   {
       
      
      public var score:uint;
      
      public var id:uint;
      
      public function MinigameScore(param1:uint, param2:uint)
      {
         super();
         this.id = param1;
         this.score = param2;
      }
      
      public function toString() : String
      {
         return "[MinigameScore: id=" + id + " score=" + score + "]";
      }
   }
}
