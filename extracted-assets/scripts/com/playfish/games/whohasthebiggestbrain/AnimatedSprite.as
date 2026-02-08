package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class AnimatedSprite extends Sprite
   {
      
      public static const FLIP_HORIZONTAL:int = 1;
      
      public static const FLIP_VERTICAL:int = 2;
      
      public static const ROTATE_90:int = 3;
      
      public static const ROTATE_180:int = 4;
      
      public static const ROTATE_270:int = 5;
       
      
      internal var mcName:String;
      
      internal var nextAnimationsLoop:Array;
      
      internal var drawPriority:int;
      
      public var gameObject:GameObject = null;
      
      public var mc:MovieClip;
      
      internal var frameTimer:int;
      
      internal var nextAnimations:Array;
      
      public var frameDelay:* = 40;
      
      internal var finishAtFirstFrame:Boolean = false;
      
      public var numLoops:int = -1;
      
      internal var pause:Boolean = false;
      
      public function AnimatedSprite(param1:String = null)
      {
         super();
         if(param1 != null)
         {
            setAnimation(param1,-1);
         }
         frameTimer = frameDelay;
      }
      
      public function setAnimation(param1:String, param2:int) : *
      {
         this.numLoops = param2;
         setMovieClip(Engine.getMovieClip(param1));
         mcName = param1;
      }
      
      public function manipulate(param1:int) : *
      {
         var _loc2_:* = undefined;
         if(param1 == FLIP_HORIZONTAL)
         {
            _loc2_ = new Matrix();
            _loc2_.a = -1;
            this.transform.matrix = _loc2_;
         }
         else if(param1 == FLIP_VERTICAL)
         {
            _loc2_ = new Matrix();
            _loc2_.d = -1;
            this.transform.matrix = _loc2_;
         }
         else if(param1 == ROTATE_90)
         {
            this.rotation = 90;
         }
         else if(param1 == ROTATE_180)
         {
            this.rotation = 180;
         }
         else if(param1 == ROTATE_270)
         {
            this.rotation = 270;
         }
      }
      
      public function setMovieClip(param1:MovieClip) : *
      {
         if(mc != null)
         {
            removeChild(mc);
            mc = null;
            mcName = null;
         }
         mc = param1;
         mc.stop();
         mc.mouseEnabled = false;
         addChild(mc);
         mcName = mc.name;
         frameTimer = frameDelay;
         if(mc.totalFrames == 1)
         {
            numLoops = 0;
         }
      }
      
      public function setFrameDelay(param1:int) : *
      {
         this.frameDelay = param1;
      }
      
      public function tickAnimation(param1:int) : *
      {
         if(pause || numLoops == 0)
         {
            return;
         }
         frameTimer -= param1;
         while(numLoops != 0 && frameTimer < 0)
         {
            if(mc.currentFrame >= mc.totalFrames)
            {
               if(numLoops > 0)
               {
                  --numLoops;
               }
               if(numLoops != 0)
               {
                  mc.gotoAndStop(1);
               }
               else if(nextAnimations != null && nextAnimations.length > 0)
               {
                  setAnimation(nextAnimations[0],nextAnimationsLoop[0]);
                  nextAnimations.splice(0,1);
                  nextAnimationsLoop.splice(0,1);
               }
               else if(finishAtFirstFrame)
               {
                  mc.gotoAndStop(1);
               }
            }
            else
            {
               mc.nextFrame();
            }
            frameTimer += frameDelay;
         }
      }
      
      public function setFrame(param1:int) : *
      {
         mc.gotoAndStop(param1);
         frameTimer = frameDelay;
      }
      
      public function setPause(param1:Boolean) : *
      {
         this.pause = param1;
         frameTimer = frameDelay;
      }
      
      public function addNextAnimation(param1:String, param2:int) : *
      {
         if(nextAnimations == null)
         {
            nextAnimations = new Array();
            nextAnimationsLoop = new Array();
         }
         nextAnimations.push(param1);
         nextAnimationsLoop.push(param2);
      }
      
      public function isAnimation(param1:String) : Boolean
      {
         return mcName == param1;
      }
      
      public function getFrame() : int
      {
         return mc.currentFrame;
      }
   }
}
