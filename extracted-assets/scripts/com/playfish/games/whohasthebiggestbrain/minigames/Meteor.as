package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.whohasthebiggestbrain.*;
   import flash.display.*;
   import flash.text.TextField;
   
   public class Meteor extends GameObject
   {
      
      public static const STATE_NORMAL:* = 0;
      
      public static const STATE_DYING:* = 1;
      
      public static const STATE_DEAD:* = 2;
       
      
      internal var speedTextField:TextField;
      
      internal var number:int;
      
      internal var rotateSpeed:Number;
      
      internal const MAX_METEOR_SPEED:Number = 1.5;
      
      public var state:int = 0;
      
      internal const NUM_METEOR_TYPE:int = 5;
      
      internal var radius:int;
      
      internal var stationary:Boolean = false;
      
      public function Meteor(param1:GameObjectLayer, param2:int, param3:String, param4:int = -1)
      {
         super(param1,new AnimatedSprite("Meteor" + (Engine.rnd(0,NUM_METEOR_TYPE) + 1)),TYPE_NONE,1);
         this.number = param2;
         mainSprite.mc.textField.text = param3;
         mainSprite.mc.textField.selectable = false;
         mainSprite.mc.textField.mouseEnabled = false;
         if(param4 == -1)
         {
            scaleX = Engine.rnd(75,150) / 100;
            scaleY = scaleX;
            this.radius = Math.max(width,height) / 2;
         }
         else
         {
            this.radius = param4;
            width = param4 * 2;
            height = width;
         }
         rotation = Engine.rnd(0,360);
         setSpeed(Engine.rnd(0,20) / 500,Engine.rnd(0,360));
         trace(speedX + " " + speedY);
      }
      
      public function isColliding(param1:Meteor) : Boolean
      {
         return getDistance(param1) <= radius + param1.radius;
      }
      
      public function getSpeed() : Number
      {
         return Math.sqrt(speedX * speedX + speedY * speedY);
      }
      
      public function getDistance(param1:Meteor) : Number
      {
         var _loc2_:* = x - param1.x;
         var _loc3_:* = y - param1.y;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function collisionResponse(param1:Meteor) : *
      {
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc2_:Number = Engine.getAngle(x,y,param1.x,param1.y);
         var _loc3_:* = scaleX / (scaleX + param1.scaleX);
         if(stationary)
         {
            _loc3_ = 0;
         }
         else if(param1.stationary)
         {
            _loc3_ = 1;
         }
         var _loc4_:Number = radius + param1.radius - getDistance(param1);
         _loc5_ = _loc4_ * _loc3_;
         _loc6_ = _loc4_ - _loc5_;
         x -= _loc5_ * Math.cos(_loc2_);
         y += _loc5_ * Math.sin(_loc2_);
         param1.x += _loc6_ * Math.cos(_loc2_);
         param1.y -= _loc6_ * Math.sin(_loc2_);
         var _loc7_:* = speedX * Math.cos(_loc2_) - speedY * Math.cos(Math.PI / 2 - _loc2_);
         var _loc8_:* = scaleX * _loc7_;
         var _loc9_:* = _loc8_ * Math.cos(_loc2_);
         var _loc10_:* = -_loc8_ * Math.sin(_loc2_);
         var _loc11_:* = param1.speedX * Math.cos(_loc2_) - param1.speedY * Math.cos(Math.PI / 2 - _loc2_);
         var _loc12_:* = param1.scaleX * _loc11_;
         var _loc13_:* = _loc12_ * Math.cos(_loc2_);
         var _loc14_:* = -_loc12_ * Math.sin(_loc2_);
         if(_loc9_ >= 0 && _loc13_ <= 0 || _loc9_ <= 0 && _loc13_ >= 0)
         {
            this.speedX += _loc13_ / this.scaleX;
            param1.speedX -= _loc13_ / param1.scaleX;
            param1.speedX += _loc9_ / param1.scaleX;
            this.speedX -= _loc9_ / this.scaleX;
         }
         else if(Math.abs(_loc9_) < Math.abs(_loc13_))
         {
            this.speedX += _loc13_ / this.scaleX;
            param1.speedX -= _loc13_ / param1.scaleX;
         }
         else
         {
            param1.speedX += _loc9_ / param1.scaleX;
            this.speedX -= _loc9_ / this.scaleX;
         }
         if(_loc10_ >= 0 && _loc14_ <= 0 || _loc10_ <= 0 && _loc14_ >= 0)
         {
            this.speedY += _loc14_ / this.scaleX;
            param1.speedY -= _loc14_ / param1.scaleX;
            param1.speedY += _loc10_ / param1.scaleX;
            this.speedY -= _loc10_ / this.scaleX;
         }
         else if(Math.abs(_loc10_) < Math.abs(_loc14_))
         {
            this.speedY += _loc14_ / this.scaleX;
            param1.speedY -= _loc14_ / param1.scaleX;
         }
         else
         {
            param1.speedY += _loc10_ / param1.scaleX;
            this.speedY -= _loc10_ / this.scaleX;
         }
         var _loc15_:Number = getSpeed();
         if(_loc15_ > MAX_METEOR_SPEED)
         {
            _loc17_ = MAX_METEOR_SPEED / _loc15_;
            speedX *= _loc17_;
            speedY *= _loc17_;
         }
         var _loc16_:Number = param1.getSpeed();
         if(_loc15_ > MAX_METEOR_SPEED)
         {
            _loc17_ = MAX_METEOR_SPEED / _loc16_;
            param1.speedX *= _loc17_;
            param1.speedY *= _loc17_;
         }
         if(stationary)
         {
            speedX = 0;
            speedY = 0;
         }
         if(param1.stationary)
         {
            param1.speedX = 0;
            param1.speedY = 0;
         }
      }
      
      override public function tick(param1:uint) : *
      {
         if(state == STATE_DYING)
         {
            scaleX -= 0.1;
            if(scaleX <= 0)
            {
               scaleX = 0;
               state = STATE_DEAD;
            }
            scaleY = scaleX;
            alpha = Math.min(scaleX,1);
         }
         else
         {
            super.tick(param1);
            rotation += rotateSpeed;
            if(x <= radius)
            {
               trace(x + " radius=" + radius);
               x = radius;
               speedX = -speedX;
            }
            else if(x >= GameWorld.CANVAS_WIDTH - radius)
            {
               x = GameWorld.CANVAS_WIDTH - radius;
               speedX = -speedX;
            }
            else if(y <= radius)
            {
               y = radius;
               speedY = -speedY;
            }
            else if(y >= GameWorld.CANVAS_HEIGHT - radius)
            {
               y = GameWorld.CANVAS_HEIGHT - radius;
               speedY = -speedY;
            }
         }
      }
   }
}
