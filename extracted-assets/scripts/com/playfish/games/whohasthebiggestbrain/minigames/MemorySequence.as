package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class MemorySequence extends Minigame
   {
      
      public static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(13);
      
      public static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-8);
      
      public static const STATE_START_TIMER:int = 0;
      
      public static const STATE_NORMAL:int = 1;
      
      public static const STATE_TIME_UP:int = 2;
       
      
      public var playTimer:Timer;
      
      public var gameScene:MovieClip;
      
      public var sequenceDelay:int;
      
      private const NUM_SWITCH_TYPES:int = 5;
      
      public var curLayout:MovieClip;
      
      private const NUM_LAYOUTS:int = 10;
      
      public var state:int;
      
      public var finalSequence:Array;
      
      public var curSequenceIndex:int;
      
      public var switches:Array;
      
      public function MemorySequence(param1:MinigameBase)
      {
         super(param1);
      }
      
      public function switchClickListener(param1:MouseEvent) : void
      {
         var base:MovieClip = param1.currentTarget as MovieClip;
         bringSwitchToFront(base);
         Engine.playSound("ButtonInGame",1);
         if(finalSequence[curSequenceIndex++] == base.theSwitch)
         {
            base.theSwitch.gotoAndPlay("on");
            container.addScore(CORRECT_SCORE.value);
            if(curSequenceIndex >= finalSequence.length)
            {
               removeMouseListeners();
               container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
            }
         }
         else
         {
            removeMouseListeners();
            container.addScore(INCORRECT_SCORE.value);
            container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
         }
      }
      
      public function onTimerListener(param1:TimerEvent) : *
      {
         addMouseListeners();
         enablePlayerInput();
         param1.currentTarget.stop();
         param1.currentTarget.removeEventListener(TimerEvent.TIMER,onTimerListener);
      }
      
      override public function restart() : *
      {
         var _loc8_:* = undefined;
         var _loc9_:MovieClip = null;
         if(curLayout != null)
         {
            gameScene.removeChild(curLayout);
         }
         var _loc1_:int = int(container.getTotalCorrect());
         var _loc2_:int = Engine.rnd(Math.min(Math.floor(_loc1_ / 2),NUM_LAYOUTS - 2),Math.min(2 + Math.floor(_loc1_ / 2),NUM_LAYOUTS));
         curLayout = Engine.getMovieClip("SwitchLayout" + _loc2_);
         gameScene.addChild(curLayout);
         var _loc3_:int = Engine.rnd(0,NUM_SWITCH_TYPES);
         switches = new Array();
         var _loc4_:int = 0;
         while(true)
         {
            _loc8_ = curLayout["switch" + _loc4_];
            if(_loc8_ == null)
            {
               break;
            }
            _loc8_.gotoAndStop("unactive");
            _loc9_ = Engine.getMovieClip("Switch" + _loc3_);
            _loc8_.theSwitch = _loc9_;
            _loc9_.base = _loc8_;
            curLayout.addChild(_loc9_);
            _loc9_.x = _loc8_.x;
            _loc9_.y = _loc8_.y;
            _loc9_.mouseEnabled = false;
            _loc9_.mouseChildren = false;
            switches.push(_loc9_);
            _loc9_.gotoAndPlay("off");
            _loc9_.gotoAndPlay(Engine.rnd(0,getFrameCount("off",_loc9_)));
            _loc4_++;
         }
         var _loc5_:int = 3 + Math.floor((_loc1_ + 1) / 3);
         var _loc6_:int = 0;
         finalSequence = new Array();
         var _loc7_:* = 0;
         while(_loc7_ < _loc5_)
         {
            do
            {
               finalSequence[_loc7_] = switches[Engine.rnd(0,_loc4_)];
               if(_loc7_ > 0 && finalSequence[_loc7_] == finalSequence[_loc7_ - 1])
               {
                  _loc6_++;
               }
               else
               {
                  _loc6_ = 0;
               }
            }
            while(_loc6_ >= 2);
            
            _loc7_++;
         }
         sequenceDelay = Math.max(500 - _loc1_ * 15,300);
         playTimer = new Timer(sequenceDelay,_loc5_);
         curSequenceIndex = 0;
         state = STATE_START_TIMER;
      }
      
      public function getFrameCount(param1:String, param2:MovieClip) : int
      {
         var _loc3_:* = 0;
         while(_loc3_ < param2.currentLabels.length)
         {
            if(param2.currentLabels[_loc3_].name == param1)
            {
               if(_loc3_ == param2.currentLabels.length - 1)
               {
                  return param2.totalFrames - param2.currentLabels[_loc3_].frame;
               }
               if(_loc3_ < param2.currentLabels.length - 1)
               {
                  return param2.currentLabels[_loc3_ + 1].frame - param2.currentLabels[_loc3_].frame;
               }
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function addMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < switches.length)
         {
            setButtonMode(switches[_loc1_].base,true);
            switches[_loc1_].base.addEventListener(MouseEvent.MOUSE_DOWN,switchClickListener,false,0,true);
            _loc1_++;
         }
      }
      
      override public function tick(param1:uint) : *
      {
         if(state == STATE_START_TIMER)
         {
            state = STATE_NORMAL;
            playTimer.addEventListener(TimerEvent.TIMER,switchTimer);
            playTimer.start();
         }
      }
      
      override public function init() : *
      {
         gameScene = new MemorySequenceScene();
         gameScene.x = GameWorld.CANVAS_CENTER_X;
         gameScene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(gameScene);
      }
      
      override public function timeup() : *
      {
         state = STATE_TIME_UP;
         var _loc1_:* = 0;
         while(_loc1_ < switches.length)
         {
            switches[_loc1_].stop();
            _loc1_++;
         }
         playTimer.stop();
         removeMouseListeners();
      }
      
      public function switchTimer(param1:TimerEvent) : *
      {
         var _loc2_:Timer = null;
         Engine.playSound("ButtonInGame",1);
         finalSequence[curSequenceIndex++].gotoAndPlay("on");
         if(curSequenceIndex >= finalSequence.length)
         {
            curSequenceIndex = 0;
            param1.currentTarget.stop();
            _loc2_ = new Timer(sequenceDelay,1);
            _loc2_.addEventListener(TimerEvent.TIMER,onTimerListener);
            _loc2_.start();
         }
      }
      
      public function removeMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < switches.length)
         {
            switches[_loc1_].base.removeEventListener(MouseEvent.MOUSE_DOWN,switchClickListener);
            _loc1_++;
         }
      }
      
      private function bringSwitchToFront(base:MovieClip) : void
      {
         if(base.theSwitch && base.theSwitch.parent)
         {
            var p:DisplayObjectContainer = base.theSwitch.parent;
            p.setChildIndex(base.theSwitch,p.numChildren - 1);
         }
      }
      
      private function enablePlayerInput() : void
      {
         for each(var sw in switches)
         {
            sw.base.gotoAndStop("active");
            bringSwitchToFront(sw.base);
         }
         addMouseListeners();
      }
   }
}
