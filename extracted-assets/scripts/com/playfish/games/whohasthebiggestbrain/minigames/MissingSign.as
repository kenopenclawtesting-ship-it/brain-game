package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class MissingSign extends Minigame
   {
      
      internal static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(20);
      
      internal static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-12);
      
      internal static const SIGN_CLASS:Array = new Array(Class(Plus),Class(Minus),Class(Times),Class(Divide));
      
      internal static const SIGN_CHAR_CODE:Array = new Array(43,45,42,47);
      
      internal static const SIGN_NUM_CODE:Array = new Array(2,1,3,4);
       
      
      internal var answeringTimer:int;
      
      internal var signButtons:Array;
      
      internal var scene:GameScene;
      
      internal var totalAnsweringTimer:int;
      
      internal var equationHistory:Array;
      
      internal const NUM_PROTECTED_VALUES:int = 1;
      
      internal const PROTECTED_ANSWER_SIGN:int = 0;
      
      internal const LEGIT_MIN_AVERAGE_ANSWERING_TIME:Number = 1;
      
      public function MissingSign(param1:MinigameBase)
      {
         super(param1,NUM_PROTECTED_VALUES);
      }
      
      override public function timeup() : *
      {
         removeAllMouseListeners();
         var _loc1_:* = totalAnsweringTimer / container.getTotalCorrect();
         if(_loc1_ <= LEGIT_MIN_AVERAGE_ANSWERING_TIME)
         {
            GameWorld.calculateCheatDetect = true;
            GameWorld.calculateAverageAnsweringTime = _loc1_;
         }
      }
      
      override public function restart() : *
      {
         var _loc6_:CalculateElement = null;
         if(scene != null)
         {
            removeChild(scene);
         }
         scene = new GameScene();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         var _loc1_:Matrix = scene.number1.transform.matrix.clone();
         _loc1_.a = Engine.rndFloat(0.9,1.1);
         _loc1_.d = Engine.rndFloat(0.9,1.1);
         _loc1_.c = Math.tan(Number(Engine.rnd(-8,9)) * Math.PI / 180);
         scene.number1.transform.matrix = _loc1_;
         signButtons = new Array();
         signButtons.push(scene.plus);
         signButtons.push(scene.minus);
         signButtons.push(scene.times);
         signButtons.push(scene.divide);
         var _loc2_:int = Math.floor(container.getTotalCorrect() / 3.5);
         do
         {
            if(_loc2_ >= 3)
            {
               _loc6_ = Calculate.getEquation(_loc2_ - 3,true,equationHistory);
            }
            else
            {
               _loc6_ = Calculate.getEquation(_loc2_,false,equationHistory);
            }
         }
         while(hasAmbiguousSign(_loc6_));
         
         equationHistory.push(_loc6_);
         var _loc3_:int = _loc6_.getResult();
         var _loc4_:int = 0;
         if(_loc6_.element1.isRoot && _loc6_.element2.isRoot || !_loc6_.element1.isRoot)
         {
            protectedValues.setValue(PROTECTED_ANSWER_SIGN,_loc6_.sign);
            scene.number1.textField.text = _loc6_.element1.getString();
            scene.number2.text = _loc6_.element2.getString();
         }
         else
         {
            protectedValues.setValue(PROTECTED_ANSWER_SIGN,_loc6_.element2.sign);
            scene.number1.textField.text = _loc6_.element1.getString() + " " + CalculateElement.SIGN_STRING[_loc6_.sign] + " (" + _loc6_.element2.element1.getString();
            scene.number2.text = _loc6_.element2.element2.getString() + ")";
         }
         scene.number2.appendText(" = " + _loc3_);
         trace(_loc6_.getString(false) + " = " + _loc3_);
         trace(scene.number1.text);
         trace(scene.number2.text);
         var _loc5_:* = 0;
         while(_loc5_ < signButtons.length)
         {
            setButtonMode(signButtons[_loc5_],true);
            signButtons[_loc5_].addEventListener(MouseEvent.MOUSE_DOWN,signButtonClicked);
            _loc5_++;
         }
         answeringTimer = 0;
      }
      
      override public function init() : *
      {
         equationHistory = new Array();
      }
      
      public function signButtonClicked(param1:MouseEvent) : *
      {
         signSelected(signButtons.indexOf(param1.currentTarget));
         stage.focus = container;
      }
      
      override public function tick(param1:uint) : *
      {
         answeringTimer += param1;
      }
      
      override public function keyUp(param1:int, param2:int) : *
      {
         var _loc3_:* = undefined;
         if(container.state == MinigameBase.STATE_NORMAL)
         {
            _loc3_ = 0;
            while(_loc3_ < SIGN_CHAR_CODE.length)
            {
               if(param2 == SIGN_CHAR_CODE[_loc3_] || param2 == SIGN_NUM_CODE[_loc3_] + 48)
               {
                  signButtons[_loc3_].gotoAndStop("up");
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      public function hasAmbiguousSign(param1:CalculateElement) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         param1 = param1.clone();
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < CalculateElement.NUM_SIGNS)
         {
            if(param1.element2.isRoot)
            {
               param1.sign = _loc3_;
            }
            else
            {
               param1.element2.sign = _loc3_;
            }
            _loc4_ = param1.getResult();
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               if(_loc4_ == _loc2_[_loc5_])
               {
                  return true;
               }
               _loc5_++;
            }
            _loc2_.push(_loc4_);
            _loc3_++;
         }
         return false;
      }
      
      override public function keyDown(param1:int, param2:int) : *
      {
         var _loc3_:* = undefined;
         if(container.state == MinigameBase.STATE_NORMAL)
         {
            _loc3_ = 0;
            while(_loc3_ < SIGN_CHAR_CODE.length)
            {
               if(param2 == SIGN_CHAR_CODE[_loc3_] || param2 == SIGN_NUM_CODE[_loc3_] + 48)
               {
                  signSelected(_loc3_);
                  signButtons[_loc3_].gotoAndStop("down");
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      public function removeAllMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < signButtons.length)
         {
            setButtonMode(signButtons[_loc1_],false);
            signButtons[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,signButtonClicked);
            _loc1_++;
         }
      }
      
      public function signSelected(param1:int) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:* = new SIGN_CLASS.[param1]();
         scene.sign.addChild(_loc2_);
         _loc2_.gotoAndStop(1);
         if(param1 == protectedValues.getValue(PROTECTED_ANSWER_SIGN))
         {
            container.addScore(CORRECT_SCORE.value);
            container.correct(true,scene.sign.x + GameWorld.CANVAS_CENTER_X,scene.sign.y + GameWorld.CANVAS_CENTER_Y);
            removeAllMouseListeners();
            totalAnsweringTimer += answeringTimer;
         }
         else
         {
            container.addScore(INCORRECT_SCORE.value);
            container.fail(true,scene.sign.x + GameWorld.CANVAS_CENTER_X,scene.sign.y + GameWorld.CANVAS_CENTER_Y);
            removeAllMouseListeners();
         }
      }
   }
}
