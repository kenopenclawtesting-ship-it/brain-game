package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.whohasthebiggestbrain.BaseWorld;
   import com.playfish.games.whohasthebiggestbrain.ChecksumProtectedValues;
   
   public class Minigame extends BaseWorld
   {
       
      
      internal var protectedValues:ChecksumProtectedValues;
      
      internal var container:MinigameBase;
      
      public function Minigame(param1:MinigameBase, param2:int = 0)
      {
         super();
         this.container = param1;
         if(param2 > 0)
         {
            protectedValues = new ChecksumProtectedValues(param2);
         }
      }
      
      public function show() : *
      {
      }
      
      public function restart() : *
      {
      }
      
      public function timeup() : *
      {
      }
      
      override public function keyDown(param1:int, param2:int) : *
      {
      }
      
      override public function keyUp(param1:int, param2:int) : *
      {
      }
      
      override public function tick(param1:uint) : *
      {
      }
      
      public function init() : *
      {
      }
   }
}
