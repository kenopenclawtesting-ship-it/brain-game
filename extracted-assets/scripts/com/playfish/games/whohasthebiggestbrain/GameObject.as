package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.Sprite;
   
   public class GameObject extends Sprite
   {
      
      public static const TYPE_NONE:* = 0;
      
      public static const TYPE_EFFECT:* = 1;
      
      public static const TWEEN_NONE:* = 0;
      
      public static const TWEEN_MOTION_TIME:* = 1;
      
      public static const TWEEN_MOTION_SPEED:* = 2;
      
      public static const TWEEN_ALPHA:* = 3;
      
      public static const TWEEN_SHAPE:* = 4;
       
      
      public var gameObjectLayer:GameObjectLayer;
      
      public var tweenStartX:Number;
      
      public var tweenType:uint;
      
      public var tweenStartY:Number;
      
      public var tweenDestX:Number;
      
      public var tweenDestY:Number;
      
      public var tweenDeccel:Boolean = false;
      
      public var tweenEaseDeccelX:Number;
      
      internal var tweenTimer:int;
      
      public var mainSprite:AnimatedSprite;
      
      public var tweenEaseDeccelY:Number;
      
      internal var tweenEaseTime:int;
      
      public var speedX:Number = 0;
      
      public var speedY:Number = 0;
      
      public var removeWhenComplete:Boolean = false;
      
      public var tweenEaseMarkX:Number;
      
      internal var type:int = 0;
      
      public var targetX:Number;
      
      public var targetY:Number;
      
      public var resumeTweenAfterReveal:Boolean = false;
      
      public function GameObject(param1:GameObjectLayer, param2:AnimatedSprite, param3:int, param4:int)
      {
         super();
         this.gameObjectLayer = param1;
         this.mainSprite = param2;
         this.type = param3;
         param2.drawPriority = param4;
         param2.gameObject = this;
         addChild(param2);
         if(param3 == TYPE_EFFECT)
         {
            param2.numLoops = 1;
         }
      }
      
      public function setPosition(param1:int, param2:int) : *
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function tweenMotionSpeed(param1:Number, param2:Number, param3:Number, param4:Number) : *
      {
         var _loc5_:* = Engine.getAngle(x,y,param1,param2);
         speedX = param3 * Math.cos(_loc5_) / 1000;
         speedY = -param3 * Math.sin(_loc5_) / 1000;
         tweenStartX = x;
         tweenStartY = y;
         tweenDestX = param1;
         tweenDestY = param2;
         tweenEaseDeccelX = param4 * Math.cos(_loc5_) / 1000;
         tweenEaseDeccelY = -param4 * Math.sin(_loc5_) / 1000;
         var _loc6_:* = Math.abs(speedX / tweenEaseDeccelX);
         var _loc7_:* = Math.abs(speedX) * _loc6_ - 0.5 * Math.abs(tweenEaseDeccelX) * _loc6_ * _loc6_;
         if(param4 != 0)
         {
            tweenDeccel = true;
         }
         tweenEaseMarkX = _loc7_;
         tweenType = TWEEN_MOTION_SPEED;
      }
      
      public function tween(param1:Number, param2:Number, param3:uint, param4:Boolean) : *
      {
         speedX = (param1 - x) / param3;
         speedY = (param2 - y) / param3;
         tweenDestX = param1;
         tweenDestY = param2;
         tweenType = TWEEN_MOTION_TIME;
      }
      
      public function getWidth() : int
      {
         return width;
      }
      
      public function setSpeed(param1:Number, param2:Number) : *
      {
         var _loc3_:Number = param2 * Math.PI / 180;
         speedX = param1 * Math.sin(_loc3_);
         speedY = -param1 * Math.cos(_loc3_);
      }
      
      public function getHeight() : int
      {
         return height;
      }
      
      public function tick(param1:uint) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(removeWhenComplete)
         {
            if(mainSprite.numLoops == 0)
            {
               gameObjectLayer.removeGameObject(this);
               return;
            }
         }
         mainSprite.tickAnimation(param1);
         var _loc2_:* = speedX * param1;
         _loc3_ = speedY * param1;
         x += _loc2_;
         y += _loc3_;
         if(tweenType == TWEEN_MOTION_SPEED)
         {
            if(speedX >= 0 && x >= tweenDestX || speedX < 0 && x < tweenDestX || Math.abs(x - tweenDestX) < 0.5)
            {
               speedX = 0;
               x = tweenDestX;
            }
            if(speedY >= 0 && y >= tweenDestY || speedY < 0 && y < tweenDestY || Math.abs(y - tweenDestY) < 0.5)
            {
               speedY = 0;
               y = tweenDestY;
            }
            if(x == tweenDestX && y == tweenDestY)
            {
               tweenType = TWEEN_NONE;
            }
            if(tweenType != TWEEN_NONE && tweenDeccel)
            {
               _loc4_ = (tweenDestX - x) / 160;
               _loc5_ = (tweenDestY - y) / 160;
               if(Math.abs(_loc4_) < Math.abs(speedX))
               {
                  speedX = _loc4_;
               }
               if(Math.abs(_loc5_) < Math.abs(speedY))
               {
                  speedY = _loc5_;
               }
               if(Math.abs(speedX) <= 0.01 && Math.abs(speedY) <= 0.01)
               {
                  x = tweenDestX;
                  y = tweenDestY;
                  speedX = 0;
                  speedY = 0;
                  tweenType = TWEEN_NONE;
               }
            }
         }
         else if(tweenType != TWEEN_NONE)
         {
            if(speedX > 0)
            {
               if(x >= tweenDestX)
               {
                  speedX = 0;
               }
            }
            else if(speedX < 0)
            {
               if(x <= tweenDestX)
               {
                  speedX = 0;
               }
            }
            if(speedX == 0)
            {
               x = tweenDestX;
               y = tweenDestY;
               speedX = 0;
               speedY = 0;
               tweenType = TWEEN_NONE;
            }
         }
      }
   }
}
