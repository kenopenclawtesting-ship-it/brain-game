package com.playfish.rpc.brain
{
   public class PendingChallenge
   {
       
      
      public var games:Array;
      
      public var score:uint;
      
      public var id:uint;
      
      public var challenger:UserInfo;
      
      public function PendingChallenge()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[PendingChallenge: id=" + id + " challenger=" + challenger + " game=" + games + " score=" + score + "]";
      }
   }
}
