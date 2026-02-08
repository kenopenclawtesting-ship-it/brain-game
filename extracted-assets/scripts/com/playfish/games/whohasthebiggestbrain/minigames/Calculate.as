package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Calculate extends Minigame
   {
      
      internal static const ASCII_TO_FONT_MAP:Array = new Array(48,0,49,1,50,2,51,3,52,4,53,5,54,6,55,7,56,8,57,9,43,10,45,11,42,12,47,13,61,14);
       
      
      internal var numberDisplayCanvas:Bitmap;
      
      internal var fonts:MovieClip;
      
      internal const LEGIT_MIN_AVERAGE_ANSWERING_TIME:Number = 1;
      
      internal const PROTECTED_ANSWER:int = 0;
      
      internal var incorrectTimer:int;
      
      internal var totalAnsweringTimer:int;
      
      internal var equationHistory:Array;
      
      internal var numberField:Sprite;
      
      internal var fontWidth:int;
      
      internal const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-18);
      
      internal var gameScene:CalculateScene;
      
      internal const NUM_PROTECTED_VALUES:int = 1;
      
      internal const CORRECT_SCORE:ProtectedInt = new ProtectedInt(27);
      
      internal var answeringTimer:int;
      
      internal var curAnswerString:String;
      
      internal var fontHeight:int;
      
      internal var answerString:String;
      
      internal var numberButtons:Array;
      
      internal var fontSpacing:int = 5;
      
      internal var equationString:String;
      
      public function Calculate(param1:MinigameBase)
      {
         this.equationHistory = new Array();
         super(param1,NUM_PROTECTED_VALUES);
      }
      
      public static function getEquation(param1:int, param2:Boolean, param3:Array) : CalculateElement
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:CalculateElement = null;
         var _loc9_:Boolean = false;
         var _loc10_:RandomBasket = null;
         var _loc11_:* = undefined;
         do
         {
            _loc4_ = Engine.rnd(0,CalculateElement.NUM_SIGNS);
            if(_loc4_ == CalculateElement.SIGN_DIVIDE)
            {
               param1 = Math.max(0,param1 / 2);
            }
            else if(_loc4_ == CalculateElement.SIGN_MULTIPLY)
            {
               param1 += 2;
            }
            _loc5_ = Math.min(10 + 10 * param1,100);
            _loc6_ = Math.max(1,_loc5_ - 10);
            _loc7_ = Engine.rnd(_loc5_,_loc6_);
            _loc8_ = new CalculateElement(_loc7_);
            _loc8_.setSign(_loc4_);
            if(param2)
            {
               if(Engine.rnd(0,2) == 0)
               {
                  if(_loc8_.sign == CalculateElement.SIGN_DIVIDE)
                  {
                     _loc8_.element1.setSign(Engine.rnd(0,CalculateElement.NUM_SIGNS - 2));
                  }
                  else
                  {
                     _loc8_.element1.setSign(Engine.rnd(0,CalculateElement.NUM_SIGNS - 1));
                  }
               }
               else if(_loc8_.sign == CalculateElement.SIGN_DIVIDE)
               {
                  _loc10_ = new RandomBasket();
                  _loc10_.addItems(CalculateElement.SIGN_PLUS,CalculateElement.SIGN_MINUS,CalculateElement.SIGN_DIVIDE);
                  _loc8_.element2.setSign(int(_loc10_.getNextItem()));
               }
               else
               {
                  _loc8_.element2.setSign(Engine.rnd(0,CalculateElement.NUM_SIGNS));
               }
            }
            _loc9_ = true;
            if(param3 != null)
            {
               _loc11_ = 0;
               while(_loc11_ < param3.length)
               {
                  if(_loc8_.isIdentical(param3[_loc11_]))
                  {
                     _loc9_ = false;
                     break;
                  }
                  _loc11_++;
               }
            }
         }
         while(!_loc9_);
         
         return _loc8_;
      }
      
      public function updateNumberDisplayCanvas() : *
      {
         numberDisplayCanvas.bitmapData.fillRect(new Rectangle(0,0,numberDisplayCanvas.width,numberDisplayCanvas.height),0);
         var _loc1_:* = numberDisplayCanvas.width - (equationString.length + 3) * (fontWidth + fontSpacing);
         drawString(numberDisplayCanvas.bitmapData,equationString + curAnswerString,_loc1_,numberDisplayCanvas.height / 2);
      }
      
      public function getFontIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < ASCII_TO_FONT_MAP.length)
         {
            if(param1 == ASCII_TO_FONT_MAP[_loc2_])
            {
               return ASCII_TO_FONT_MAP[_loc2_ + 1];
            }
            _loc2_ += 2;
         }
         return -1;
      }
      
      override public function init() : *
      {
         gameScene = new CalculateScene();
         addChild(gameScene);
         numberButtons = new Array();
         numberButtons.push(gameScene.num0);
         numberButtons.push(gameScene.num1);
         numberButtons.push(gameScene.num2);
         numberButtons.push(gameScene.num3);
         numberButtons.push(gameScene.num4);
         numberButtons.push(gameScene.num5);
         numberButtons.push(gameScene.num6);
         numberButtons.push(gameScene.num7);
         numberButtons.push(gameScene.num8);
         numberButtons.push(gameScene.num9);
         numberButtons.push(gameScene.clear);
      }
      
      override public function restart() : *
      {
         var _loc3_:CalculateElement = null;
         curAnswerString = new String();
         var _loc1_:Matrix = gameScene.numberField1.transform.matrix.clone();
         _loc1_.a = Engine.rndFloat(0.95,1.05);
         _loc1_.d = Engine.rndFloat(0.95,1.05);
         _loc1_.c = Math.tan(Number(Engine.rnd(-8,9)) * Math.PI / 180);
         gameScene.numberField1.transform.matrix = _loc1_;
         if(numberDisplayCanvas != null)
         {
            numberField.removeChild(numberDisplayCanvas);
            numberDisplayCanvas = null;
         }
         var _loc2_:int = Math.floor(container.getTotalCorrect() / 3.5);
         if(_loc2_ > 1 && _loc2_ % 2 == 1)
         {
            _loc3_ = getEquation(_loc2_ - 2,true,equationHistory);
         }
         else
         {
            _loc3_ = getEquation(_loc2_,false,equationHistory);
         }
         equationHistory.push(_loc3_);
         equationString = _loc3_.getString(false);
         var _loc4_:* = _loc3_.getResult();
         protectedValues.setValue(PROTECTED_ANSWER,_loc4_);
         answerString = "" + _loc4_;
         gameScene.numberField1.textField.text = equationString;
         gameScene.numberField2.text = curAnswerString;
         enableNumberButtons();
         answeringTimer = 0;
      }
      
      public function delPressed() : *
      {
         Engine.playSound("ButtonInGame",1);
         if(curAnswerString.length > 0)
         {
            curAnswerString = curAnswerString.substr(0,curAnswerString.length - 1);
            incorrectTimer = 0;
            gameScene.numberField2.text = curAnswerString;
         }
      }
      
      override public function tick(param1:uint) : *
      {
         answeringTimer += param1;
         if(incorrectTimer > 0)
         {
            incorrectTimer -= param1;
            if(incorrectTimer <= 0)
            {
               container.addScore(INCORRECT_SCORE.value);
               container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               container.gameTimerEnabled = true;
               disableNumberButtons();
            }
         }
      }
      
      override public function keyDown(param1:int, param2:int) : *
      {
         var _loc3_:int = 0;
         if(container.state == MinigameBase.STATE_NORMAL)
         {
            if(param2 >= 48 && param2 <= 57)
            {
               _loc3_ = param2 - 48;
               numPressed(_loc3_);
               numberButtons[_loc3_].gotoAndStop("down");
            }
            else if(param1 == Engine.KEY_DEL)
            {
               delPressed();
               numberButtons[10].gotoAndStop("down");
            }
         }
      }
      
      override public function timeup() : *
      {
         disableNumberButtons();
         var _loc1_:* = totalAnsweringTimer / container.getTotalCorrect();
         if(_loc1_ <= LEGIT_MIN_AVERAGE_ANSWERING_TIME)
         {
            GameWorld.calculateCheatDetect = true;
            GameWorld.calculateAverageAnsweringTime = _loc1_;
         }
      }
      
      public function enableNumberButtons() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < numberButtons.length)
         {
            setButtonMode(numberButtons[_loc1_],true);
            numberButtons[_loc1_].addEventListener(MouseEvent.MOUSE_DOWN,numberButtonDownListener);
            _loc1_++;
         }
      }
      
      public function numPressed(param1:int) : *
      {
         var _loc2_:* = undefined;
         Engine.playSound("ButtonInGame",1);
         if(curAnswerString.length < 3)
         {
            curAnswerString += param1;
            if(curAnswerString.length == answerString.length)
            {
               if(isAnswerCorrect())
               {
                  _loc2_ = "" + protectedValues.getValue(PROTECTED_ANSWER);
                  if(curAnswerString.length >= 0 && curAnswerString.length == _loc2_.length)
                  {
                     container.addScore(CORRECT_SCORE.value);
                     container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
                     container.gameTimerEnabled = true;
                     disableNumberButtons();
                  }
                  totalAnsweringTimer += answeringTimer;
               }
               else
               {
                  incorrectTimer = 500;
               }
            }
            gameScene.numberField2.text = curAnswerString;
         }
      }
      
      public function getNumber(param1:Object) : int
      {
         var _loc2_:* = 0;
         while(_loc2_ < numberButtons.length)
         {
            if(numberButtons[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function isAnswerCorrect() : Boolean
      {
         var _loc1_:Boolean = true;
         var _loc2_:* = 0;
         while(_loc2_ < curAnswerString.length)
         {
            if(curAnswerString.charAt(_loc2_) != answerString.charAt(_loc2_))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      override public function keyUp(param1:int, param2:int) : *
      {
         var _loc3_:int = 0;
         if(param2 >= 48 && param2 <= 57)
         {
            _loc3_ = param2 - 48;
            numberButtons[_loc3_].gotoAndStop("up");
         }
         else if(param1 == Engine.KEY_DEL)
         {
            numberButtons[10].gotoAndStop("up");
         }
      }
      
      public function disableNumberButtons() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < numberButtons.length)
         {
            setButtonMode(numberButtons[_loc1_],false);
            numberButtons[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,numberButtonDownListener);
            _loc1_++;
         }
      }
      
      public function numberButtonDownListener(param1:MouseEvent) : *
      {
         if(param1.currentTarget == gameScene.clear)
         {
            delPressed();
         }
         else
         {
            numPressed(numberButtons.indexOf(param1.currentTarget));
         }
      }
      
      public function drawString(param1:BitmapData, param2:String, param3:int, param4:int) : *
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Matrix = null;
         param3 += fontWidth / 2;
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = int(param2.charCodeAt(_loc5_));
            _loc7_ = getFontIndex(_loc6_);
            if(_loc7_ >= 0)
            {
               fonts.gotoAndStop(_loc7_ + 1);
               _loc8_ = new Matrix();
               _loc8_.translate(param3,param4);
               param1.draw(fonts,_loc8_);
               param3 += fontSpacing;
            }
            param3 += fontWidth;
            _loc5_++;
         }
      }
   }
}
