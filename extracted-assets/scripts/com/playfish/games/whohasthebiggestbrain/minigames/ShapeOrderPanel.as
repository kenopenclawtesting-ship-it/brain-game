package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.whohasthebiggestbrain.*;
   
   public class ShapeOrderPanel extends GameObject
   {
      
      public static const TYPE_TOP_PANEL:* = 0;
      
      public static const TYPE_BOTTOM_PANEL:* = 1;
      
      public static const STATE_APPEAR:* = 0;
      
      public static const STATE_WAIT_IN_MIDDLE:* = 1;
      
      public static const STATE_MOVE_TO_TOP:* = 2;
      
      public static const STATE_OFF:* = 3;
      
      public static const STATE_IDLE:* = 4;
       
      
      internal var timer:int;
      
      internal var shapeSprite:AnimatedSprite;
      
      internal var panelState:int;
      
      internal var panelIndex:int;
      
      internal var shapeIndex:int;
      
      internal var parentGame:ShapeOrder;
      
      internal var shapeSpriteTimer:int;
      
      public function ShapeOrderPanel(param1:GameObjectLayer, param2:ShapeOrder, param3:int, param4:int, param5:int)
      {
         super(param1,param3 == TYPE_TOP_PANEL ? new AnimatedSprite("ShapeBoxScale") : new AnimatedSprite("ShapeBoxSelection"),GameObject.TYPE_NONE,0);
         this.parentGame = param2;
         this.shapeIndex = param5;
         this.panelIndex = param4;
         shapeSprite = param2.getShapeSprite(0,param5);
         if(param3 == TYPE_TOP_PANEL)
         {
            mainSprite.numLoops = 1;
            mainSprite.mc.panel.addChild(shapeSprite);
            panelState = STATE_APPEAR;
         }
         else if(param3 == TYPE_BOTTOM_PANEL)
         {
            mainSprite.numLoops = 0;
            mainSprite.addChild(shapeSprite);
            panelState = STATE_IDLE;
         }
      }
      
      public function endScale() : *
      {
         mainSprite.scaleX = 0.5;
         mainSprite.scaleY = mainSprite.scaleX;
      }
      
      public function off() : *
      {
         mainSprite.removeChild(shapeSprite);
         shapeSprite = null;
         mainSprite.setAnimation("ShapeBoxOff",-1);
         panelState = STATE_OFF;
      }
      
      public function on(param1:int) : *
      {
         if(panelState == STATE_OFF)
         {
            mainSprite.setAnimation("ShapeBox",-1);
            mainSprite.addChild(parentGame.getShapeSprite(0,param1));
         }
      }
      
      override public function tick(param1:uint) : *
      {
         param1 *= parentGame.speedMutiplyer;
         super.tick(param1);
         if(panelState == STATE_APPEAR)
         {
            if(mainSprite.numLoops == 0)
            {
               mainSprite.setAnimation("ShapeBox",-1);
               mainSprite.addChild(shapeSprite);
               panelState = STATE_WAIT_IN_MIDDLE;
            }
         }
         else if(panelState == STATE_WAIT_IN_MIDDLE)
         {
            timer += param1;
            tweenMotionSpeed(parentGame.getPanelX(panelIndex,parentGame.numIcons),parentGame.getTopPanelY(),800,0);
            panelState = STATE_MOVE_TO_TOP;
         }
         else if(panelState == STATE_MOVE_TO_TOP)
         {
            if(mainSprite.scaleX > 0.5)
            {
               mainSprite.scaleX = Math.max(mainSprite.scaleX - 0.1,0.5);
               mainSprite.scaleY = mainSprite.scaleX;
            }
         }
      }
   }
}
