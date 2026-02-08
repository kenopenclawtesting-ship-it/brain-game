package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.text.TextField;
   
   public class MathCombination extends Minigame
   {
      
      internal static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(44);
      
      internal static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-29);
       
      
      internal var selectionSignCards:Array;
      
      internal var answerNumberCards:Array;
      
      internal var equationString:String;
      
      internal var answerSignCards:Array;
      
      internal const PROTECTED_ANSWER:int = 0;
      
      internal var charCodePlus:int;
      
      internal const MAX_EXTRA_NUMBERS:int = 8;
      
      internal var charCodeTimes:int;
      
      internal var equationHistory:Array;
      
      internal var charCode1:int;
      
      internal const EQUATION_SPLIT_START_LEVEL:int = 6;
      
      internal var curSignElements:Array;
      
      internal var charCode9:int;
      
      internal var curEquation:CalculateElement;
      
      internal var charCodeDivide:int;
      
      internal var answer:int;
      
      internal var curNumberElements:Array;
      
      internal var gameScene:MovieClip;
      
      internal const NUM_PROTECTED_VALUES:int = 1;
      
      internal var charCodeMinus:int;
      
      internal var answerPanel:Sprite;
      
      internal var selectionNumberCards:Array;
      
      public function MathCombination(param1:MinigameBase)
      {
         this.charCodePlus = "+".charCodeAt(0);
         this.charCodeTimes = "*".charCodeAt(0);
         this.equationHistory = new Array();
         this.charCode1 = "0".charCodeAt(0);
         this.charCode9 = "9".charCodeAt(0);
         this.charCodeDivide = "/".charCodeAt(0);
         this.charCodeMinus = "-".charCodeAt(0);
         super(param1);
      }
      
      public static function getEquation(param1:int, param2:Boolean, param3:Array) : CalculateElement
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:CalculateElement = null;
         var _loc9_:Boolean = false;
         var _loc10_:* = undefined;
         do
         {
            _loc4_ = Engine.rnd(0,CalculateElement.NUM_SIGNS);
            if(_loc4_ == CalculateElement.SIGN_DIVIDE)
            {
               param1 = Math.floor(param1 / 2);
            }
            else if(_loc4_ == CalculateElement.SIGN_MULTIPLY)
            {
               param1 += 2;
            }
            _loc5_ = Math.min(10 + 3 * param1,99);
            _loc6_ = Math.max(1,_loc5_ - 10);
            _loc7_ = Engine.rnd(_loc5_,_loc6_);
            _loc8_ = new CalculateElement(_loc7_);
            _loc8_.setSign(_loc4_);
            if(param2)
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
            _loc9_ = true;
            if(param3 != null)
            {
               _loc10_ = 0;
               while(_loc10_ < param3.length)
               {
                  if(_loc8_.isIdentical(param3[_loc10_]))
                  {
                     _loc9_ = false;
                     break;
                  }
                  _loc10_++;
               }
            }
         }
         while(!_loc9_);
         
         return _loc8_;
      }
      
      public function symbolCancelListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         _loc2_.selectionCard.visible = true;
         _loc2_.gotoAndStop("none");
         _loc2_.buttonMode = false;
         _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN,symbolCancelListener);
         _loc2_.removeEventListener(MouseEvent.ROLL_OVER,symbolRollOverListener);
         _loc2_.removeEventListener(MouseEvent.ROLL_OUT,symbolRollOutListener);
         if(_loc2_ is SymbolCard)
         {
            _loc2_.symbolTextField.visible = false;
         }
      }
      
      public function selectionCardClickListener(param1:MouseEvent) : *
      {
         selectCard(MovieClip(param1.currentTarget));
      }
      
      public function createSignCard(param1:String) : MovieClip
      {
         var _loc2_:* = new SignCard();
         _loc2_.symbolString = param1;
         _loc2_.gotoAndStop(1 + CalculateElement.SIGN_STRING.indexOf(param1));
         return _loc2_;
      }
      
      public function createNumberCard(param1:String) : MovieClip
      {
         var _loc2_:* = new SymbolCard();
         _loc2_.symbolString = param1;
         _loc2_.symbolTextField.text = param1;
         _loc2_.symbolTextField.mouseEnabled = false;
         _loc2_.gotoAndStop("symbol");
         return _loc2_;
      }
      
      override public function restart() : *
      {
         var _loc6_:* = undefined;
         var _loc10_:* = undefined;
         var _loc18_:String = null;
         var _loc19_:TextField = null;
         var _loc20_:MovieClip = null;
         var _loc21_:MovieClip = null;
         var _loc22_:Boolean = false;
         var _loc23_:RandomBasket = null;
         var _loc24_:String = null;
         var _loc25_:MovieClip = null;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         if(answerPanel != null)
         {
            gameScene.removeChild(answerPanel);
            answerPanel = null;
         }
         if(selectionNumberCards != null)
         {
            _loc6_ = 0;
            while(_loc6_ < selectionNumberCards.length)
            {
               gameScene.selectionPanel.removeChild(selectionNumberCards[_loc6_]);
               _loc6_++;
            }
         }
         if(selectionSignCards != null)
         {
            _loc6_ = 0;
            while(_loc6_ < selectionSignCards.length)
            {
               gameScene.selectionPanel.removeChild(selectionSignCards[_loc6_]);
               _loc6_++;
            }
         }
         var _loc1_:int = int(container.getTotalCorrect());
         var _loc2_:Boolean = false;
         if(_loc1_ >= EQUATION_SPLIT_START_LEVEL && _loc1_ % 2 == 1)
         {
            _loc2_ = true;
            _loc1_ -= EQUATION_SPLIT_START_LEVEL;
            curEquation = getEquation(_loc1_,true,equationHistory);
         }
         else
         {
            curEquation = getEquation(_loc1_,false,equationHistory);
         }
         equationHistory.push(curEquation);
         equationString = curEquation.getString(false);
         answer = curEquation.getResult();
         gameScene.resultTextField.text = "" + answer;
         gameScene.inputTextField.text = "";
         curNumberElements = curEquation.getNumberElements();
         curSignElements = curEquation.getSignElements();
         trace("equation is " + equationString);
         answerSignCards = new Array();
         answerNumberCards = new Array();
         selectionNumberCards = new Array();
         selectionSignCards = new Array();
         var _loc3_:Array = curEquation.getSymbols();
         answerPanel = new Sprite();
         var _loc4_:Number = 0;
         var _loc5_:Array = ["(",")"];
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc18_ = _loc3_[_loc6_];
            if(_loc5_.indexOf(_loc18_) != -1)
            {
               _loc19_ = new TextField();
               _loc19_.text = _loc18_;
               _loc19_.setTextFormat(gameScene.resultTextField.getTextFormat());
               _loc19_.x = _loc4_;
               _loc19_.y = -_loc19_.textHeight / 2;
               _loc19_.width = _loc19_.textWidth;
               answerPanel.addChild(_loc19_);
            }
            else if(CalculateElement.SIGN_STRING.indexOf(_loc18_) != -1)
            {
               _loc20_ = new SignCard();
               _loc20_.x = _loc4_ + _loc20_.width / 2;
               _loc20_.gotoAndStop("none");
               answerPanel.addChild(_loc20_);
               _loc20_.symbolString = _loc18_;
               answerSignCards.push(_loc20_);
               selectionSignCards.push(createSignCard(_loc18_));
            }
            else
            {
               _loc21_ = new SymbolCard();
               _loc21_.x = _loc4_ + _loc21_.width / 2;
               _loc21_.gotoAndStop("none");
               answerPanel.addChild(_loc21_);
               _loc21_.symbolString = _loc18_;
               _loc21_.symbolTextField.mouseEnabled = false;
               answerNumberCards.push(_loc21_);
               selectionNumberCards.push(createNumberCard(_loc18_));
            }
            _loc4_ = answerPanel.width + 20;
            _loc6_++;
         }
         answerPanel.x = -answerPanel.width / 2;
         answerPanel.y = gameScene.inputTextField.y + gameScene.inputTextField.height / 2;
         gameScene.addChild(answerPanel);
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(!_loc2_)
         {
            _loc7_ = Math.floor(_loc1_ / 5);
            _loc7_ = Math.min(_loc7_,3);
            _loc8_ = 1 + Math.floor(_loc1_ / 2.5) - _loc7_;
         }
         else
         {
            _loc7_ = Math.floor((_loc1_ - EQUATION_SPLIT_START_LEVEL) / 5);
            _loc7_ = Math.min(_loc7_,6);
            _loc8_ = Math.floor((_loc1_ - EQUATION_SPLIT_START_LEVEL) / 3) - _loc7_;
            _loc22_ = true;
            _loc6_ = 0;
            while(_loc6_ < selectionSignCards.length)
            {
               if(selectionSignCards[_loc6_].symbolString != selectionSignCards[0].symbolString)
               {
                  _loc22_ = false;
                  break;
               }
               _loc6_++;
            }
            if(_loc22_)
            {
               _loc8_++;
            }
         }
         _loc8_ = Math.min(_loc8_,MAX_EXTRA_NUMBERS);
         trace("extraSigns=" + _loc7_);
         trace("extraNumbers=" + _loc8_);
         var _loc9_:Array = new Array();
         _loc10_ = 0;
         while(_loc10_ < CalculateElement.SIGN_STRING.length)
         {
            _loc9_[_loc10_] = 0;
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < selectionSignCards.length)
         {
            ++_loc9_[CalculateElement.SIGN_STRING.indexOf(selectionSignCards[_loc10_].symbolString)];
            trace("add sign " + CalculateElement.SIGN_STRING.indexOf(selectionSignCards[_loc10_].symbolString) + " count=" + _loc9_[CalculateElement.SIGN_STRING.indexOf(selectionSignCards[_loc10_].symbolString)]);
            _loc10_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc23_ = new RandomBasket();
            _loc10_ = 0;
            while(_loc10_ < CalculateElement.SIGN_STRING.length)
            {
               if(_loc9_[_loc10_] < answerSignCards.length)
               {
                  _loc23_.addItems(CalculateElement.SIGN_STRING[_loc10_]);
               }
               _loc10_++;
            }
            _loc24_ = String(_loc23_.getNextItem());
            if(_loc24_ == null)
            {
               break;
            }
            selectionSignCards.push(createSignCard(_loc24_));
            ++_loc9_[CalculateElement.SIGN_STRING.indexOf(_loc24_)];
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            selectionNumberCards.push(createNumberCard(Engine.rnd(0,10 + _loc1_ * 1.5).toString()));
            _loc6_++;
         }
         var _loc11_:int = int(selectionSignCards.length + selectionNumberCards.length);
         var _loc12_:int = 75;
         var _loc13_:int = 70;
         var _loc14_:int = Math.floor(gameScene.selectionPanel.width / _loc12_);
         var _loc15_:int = Math.ceil(_loc11_ / _loc14_);
         var _loc16_:int = (gameScene.selectionPanel.height - _loc15_ * _loc13_) / 2;
         var _loc17_:RandomBasket = new RandomBasket(0,_loc15_ * _loc14_);
         _loc6_ = 0;
         while(_loc6_ < _loc11_)
         {
            _loc25_ = _loc6_ < selectionSignCards.length ? selectionSignCards[_loc6_] : selectionNumberCards[_loc6_ - selectionSignCards.length];
            gameScene.selectionPanel.addChild(_loc25_);
            _loc26_ = int(_loc17_.getNextItem());
            _loc27_ = Math.floor(_loc26_ / _loc14_);
            _loc28_ = _loc26_ % _loc14_;
            _loc25_.x = _loc12_ * _loc28_ + _loc12_ / 2;
            _loc25_.y = _loc13_ * _loc27_ + _loc13_ / 2 + _loc16_;
            if(_loc25_.symbolTextField != null)
            {
               _loc25_.symbolTextField.mouseEnabled = false;
            }
            _loc25_.buttonMode = true;
            if(_loc25_ is SymbolCard)
            {
               _loc25_.rotation = Engine.rnd(-15,15);
            }
            _loc25_.addEventListener(MouseEvent.MOUSE_DOWN,selectionCardClickListener,false,0,true);
            _loc25_.addEventListener(MouseEvent.ROLL_OVER,symbolRollOverListener,false,0,true);
            _loc25_.addEventListener(MouseEvent.ROLL_OUT,symbolRollOutListener,false,0,true);
            _loc6_++;
         }
      }
      
      override public function init() : *
      {
         gameScene = new MathCombinationScene();
         gameScene.x = GameWorld.CANVAS_CENTER_X;
         gameScene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(gameScene);
      }
      
      override public function keyDown(param1:int, param2:int) : *
      {
         if(param2 == charCodeTimes)
         {
            param2 = int("x".charCodeAt(0));
         }
         var _loc3_:Array = selectionSignCards.concat(selectionNumberCards);
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(Boolean(_loc3_[_loc4_].visible) && _loc3_[_loc4_].symbolString.charCodeAt(0) == param2)
            {
               selectCard(_loc3_[_loc4_]);
               break;
            }
            _loc4_++;
         }
      }
      
      public function selectCard(param1:MovieClip) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         Engine.playSound("ButtonInGame",1);
         var _loc2_:Boolean = false;
         if(param1 is SignCard)
         {
            _loc3_ = 0;
            while(_loc3_ < answerSignCards.length)
            {
               if(answerSignCards[_loc3_].currentLabel == "none")
               {
                  answerSignCards[_loc3_].gotoAndStop(param1.currentFrame);
                  answerSignCards[_loc3_].buttonMode = true;
                  answerSignCards[_loc3_].addEventListener(MouseEvent.MOUSE_DOWN,symbolCancelListener);
                  answerSignCards[_loc3_].addEventListener(MouseEvent.ROLL_OVER,symbolRollOverListener);
                  answerSignCards[_loc3_].addEventListener(MouseEvent.ROLL_OUT,symbolRollOutListener);
                  answerSignCards[_loc3_].selectionCard = param1;
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < answerNumberCards.length)
            {
               if(answerNumberCards[_loc3_].currentLabel == "none")
               {
                  answerNumberCards[_loc3_].symbolTextField.visible = true;
                  answerNumberCards[_loc3_].symbolTextField.text = param1.symbolTextField.text;
                  answerNumberCards[_loc3_].gotoAndStop("symbol");
                  answerNumberCards[_loc3_].buttonMode = true;
                  answerNumberCards[_loc3_].addEventListener(MouseEvent.MOUSE_DOWN,symbolCancelListener);
                  answerNumberCards[_loc3_].addEventListener(MouseEvent.ROLL_OVER,symbolRollOverListener);
                  answerNumberCards[_loc3_].addEventListener(MouseEvent.ROLL_OUT,symbolRollOutListener);
                  answerNumberCards[_loc3_].selectionCard = param1;
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
         }
         if(_loc2_)
         {
            param1.visible = false;
            _loc4_ = true;
            _loc3_ = 0;
            while(_loc3_ < answerSignCards.length)
            {
               if(answerSignCards[_loc3_].currentLabel == "none")
               {
                  _loc4_ = false;
                  break;
               }
               _loc3_++;
            }
            if(_loc4_)
            {
               _loc3_ = 0;
               while(_loc3_ < answerNumberCards.length)
               {
                  if(answerNumberCards[_loc3_].currentLabel == "none")
                  {
                     _loc4_ = false;
                     break;
                  }
                  _loc3_++;
               }
            }
            if(_loc4_)
            {
               removeAllMouseListeners();
               _loc3_ = 0;
               while(_loc3_ < answerSignCards.length)
               {
                  curSignElements[_loc3_].sign = answerSignCards[_loc3_].currentFrame - 1;
                  _loc3_++;
               }
               _loc3_ = 0;
               while(_loc3_ < answerNumberCards.length)
               {
                  curNumberElements[_loc3_].number = answerNumberCards[_loc3_].symbolTextField.text;
                  _loc3_++;
               }
               _loc5_ = curEquation.getResult();
               trace("curAnswer=" + _loc5_);
               if(_loc5_ == answer)
               {
                  container.addScore(CORRECT_SCORE.value);
                  container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               }
               else
               {
                  container.addScore(INCORRECT_SCORE.value);
                  container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               }
            }
         }
      }
      
      public function symbolRollOutListener(param1:MouseEvent) : *
      {
         param1.currentTarget.scaleX = 1;
         param1.currentTarget.scaleY = 1;
      }
      
      override public function timeup() : *
      {
         removeAllMouseListeners();
      }
      
      public function removeAllMouseListeners() : *
      {
         var _loc1_:Array = new Array();
         _loc1_ = _loc1_.concat(answerSignCards);
         _loc1_ = _loc1_.concat(answerNumberCards);
         _loc1_ = _loc1_.concat(selectionSignCards);
         _loc1_ = _loc1_.concat(selectionNumberCards);
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc1_[_loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,selectionCardClickListener);
            _loc1_[_loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,symbolCancelListener);
            _loc1_[_loc2_].removeEventListener(MouseEvent.ROLL_OVER,symbolRollOverListener);
            _loc1_[_loc2_].removeEventListener(MouseEvent.ROLL_OUT,symbolRollOutListener);
            _loc1_[_loc2_].buttonMode = false;
            _loc2_++;
         }
      }
      
      public function symbolRollOverListener(param1:MouseEvent) : *
      {
         param1.currentTarget.scaleX = 1.1;
         param1.currentTarget.scaleY = 1.1;
      }
   }
}
