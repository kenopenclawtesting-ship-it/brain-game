package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.games.whohasthebiggestbrain.minigames.*;
   import flash.events.*;
   
   public class DebugIntermissionScreen extends BaseWorld
   {
       
      
      internal var curMinigameBase:MinigameBase;
      
      public function DebugIntermissionScreen(param1:MinigameBase)
      {
         super();
         this.curMinigameBase = param1;
         x = GameWorld.CANVAS_CENTER_X;
         y = GameWorld.CANVAS_CENTER_Y;
         var _loc2_:* = new Intermission();
         addChild(_loc2_);
         _loc2_.score.text += GameWorld.protectedValues.getValue(GameWorld.PROTECTED_VALUE_CATEGORY_SCORE_1 + GameWorld.curCategory);
         _loc2_.correct.text += param1.getTotalCorrect();
         _loc2_.incorrect.text += param1.getTotalIncorrect();
         var _loc3_:* = Debug.minigameScoreHistory[param1.minigameIndex].length;
         var _loc4_:Number = 0;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ += Debug.minigameScoreHistory[param1.minigameIndex][_loc5_];
            _loc5_++;
         }
         _loc4_ /= _loc3_;
         _loc2_.games.text += _loc3_;
         _loc2_.average.text += _loc4_;
         _loc2_.okButton.addEventListener(MouseEvent.CLICK,okClickListener);
      }
      
      public function okClickListener(param1:MouseEvent) : *
      {
         trace(curMinigameBase);
         curMinigameBase.finish();
      }
   }
}
