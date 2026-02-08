package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MatchCard extends Minigame
   {
      
      public static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(26);
      
      public static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-18);
      
      public static const CARD_TYPE_NAMES:Array = new Array("red","blue","green","yellow","grey","circle","square","star","triangle","dots");
      
      public static const CARD_TYPE_EASY:Array = new Array(0,1,2,3,4);
      
      public static const CARD_TYPE_HARD:Array = new Array(5,6,7,8,9);
      
      public static const MAX_PAIRS:* = 5;
      
      public static const MINIMUN_START_REVEAL_DELAY:* = 800;
       
      
      internal var gameObjectLayer:GameObjectLayer;
      
      internal var round:int = 0;
      
      internal var state:uint;
      
      internal var cardReadyMessage:MovieClip;
      
      internal const STATE_START_UNREVEAL:* = 2;
      
      internal const STATE_RESTART:* = 8;
      
      internal var cardsFalling:GameObject;
      
      internal const STATE_TIMEUP:* = 6;
      
      internal var swapNow:Boolean;
      
      internal var cardsClicked:Array;
      
      internal var timer:int;
      
      internal const STATE_PLAY:* = 3;
      
      internal const STATE_WRONG_IDLE:* = 5;
      
      internal var revealScanline:int;
      
      internal var numSwaps:int;
      
      internal var cards:Array;
      
      internal var cardJustClicked:CardObject;
      
      internal const STATE_END:* = 7;
      
      internal const STATE_START:* = 0;
      
      internal const STATE_START_REVEAL:* = 1;
      
      internal var startRevealDelay:int;
      
      public function MatchCard(param1:MinigameBase)
      {
         super(param1);
      }
      
      public function addMouseListenersToCards() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < cards.length)
         {
            if(!cards[_loc1_].cardCorrect)
            {
               cards[_loc1_].mainSprite.buttonMode = true;
               cards[_loc1_].mainSprite.addEventListener(MouseEvent.MOUSE_DOWN,cardClickListener);
            }
            _loc1_++;
         }
      }
      
      override public function restart() : *
      {
         var _loc1_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:CardObject = null;
         var _loc8_:CardObject = null;
         if(gameObjectLayer != null)
         {
            removeChild(gameObjectLayer);
            gameObjectLayer = null;
         }
         gameObjectLayer = new GameObjectLayer();
         addChild(gameObjectLayer);
         cards = new Array();
         cardsClicked = new Array();
         var _loc2_:* = 2 + Math.floor(round / 2);
         if(_loc2_ > MAX_PAIRS)
         {
            _loc2_ = MAX_PAIRS;
            _loc1_ = CARD_TYPE_HARD;
         }
         else
         {
            _loc1_ = CARD_TYPE_EASY;
            if(round % 2 == 1)
            {
            }
         }
         numSwaps = Math.floor(round / 3);
         startRevealDelay = 2000;
         var _loc3_:Array = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_.push(_loc4_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = Engine.rnd(0,_loc3_.length);
            _loc6_ = _loc1_[_loc3_[_loc5_]];
            _loc3_.splice(_loc5_,1);
            _loc7_ = new CardObject(gameObjectLayer,_loc6_);
            _loc8_ = new CardObject(gameObjectLayer,_loc6_);
            gameObjectLayer.addGameObject(_loc7_);
            gameObjectLayer.addGameObject(_loc8_);
            cards.push(_loc7_);
            cards.push(_loc8_);
            _loc7_.x = GameWorld.CANVAS_CENTER_X;
            _loc7_.y = GameWorld.CANVAS_CENTER_Y;
            _loc7_.mainSprite.visible = false;
            _loc8_.x = _loc7_.x;
            _loc8_.y = _loc7_.y;
            _loc8_.mainSprite.visible = false;
            _loc4_++;
         }
         cardsFalling = new GameObject(gameObjectLayer,new AnimatedSprite("Cardsfalling"),0,1);
         cardsFalling.mainSprite.numLoops = 1;
         cardsFalling.x = GameWorld.CANVAS_CENTER_X;
         cardsFalling.y = GameWorld.CANVAS_CENTER_Y;
         gameObjectLayer.addGameObject(cardsFalling);
         revealScanline = 0;
         timer = 750;
         ++round;
         state = STATE_START;
      }
      
      override public function init() : *
      {
         var _loc1_:MovieClip = null;
         _loc1_ = new CardGameScene();
         _loc1_.x = GameWorld.CANVAS_CENTER_X;
         _loc1_.y = GameWorld.CANVAS_CENTER_Y;
         _loc1_.cacheAsBitmap = true;
         addChild(_loc1_);
      }
      
      public function removeMouseListenersToCards() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < cards.length)
         {
            cards[_loc1_].mainSprite.buttonMode = false;
            cards[_loc1_].mainSprite.removeEventListener(MouseEvent.MOUSE_DOWN,cardClickListener);
            _loc1_++;
         }
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:Array = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:CardObject = null;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:Array = null;
         var _loc20_:* = undefined;
         var _loc21_:Array = null;
         gameObjectLayer.tick(param1);
         if(timer > 0)
         {
            timer -= param1;
         }
         if(cardJustClicked != null)
         {
            cardsClicked.push(cardJustClicked);
            cardJustClicked.reveal();
            Engine.playSound("ButtonInGame",1);
            if(cardsClicked.length >= 2)
            {
               if(cardsClicked[0].cardType == cardsClicked[1].cardType)
               {
                  cardsClicked[0].cardCorrect = true;
                  cardsClicked[1].cardCorrect = true;
                  cardsClicked = new Array();
                  container.addScore(CORRECT_SCORE.value);
                  container.correct(false,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
                  _loc2_ = getCardsleft();
                  if(_loc2_.length <= 2)
                  {
                     _loc3_ = 0;
                     while(_loc3_ < _loc2_.length)
                     {
                        _loc2_[_loc3_].reveal();
                        _loc2_[_loc3_].cardCorrect = true;
                        _loc3_++;
                     }
                  }
                  if(allCardsCorrect())
                  {
                     removeMouseListenersToCards();
                     timer = 500;
                     state = STATE_END;
                  }
                  else
                  {
                     if(numSwaps > 0 && (Engine.rnd(0,2) == 0 || pairsLeft() - 1 <= numSwaps))
                     {
                        swapNow = true;
                        --numSwaps;
                     }
                     state = STATE_PLAY;
                  }
               }
               else
               {
                  container.addScore(INCORRECT_SCORE.value);
                  container.fail(false,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
                  timer = 800;
                  removeMouseListenersToCards();
                  state = STATE_WRONG_IDLE;
               }
            }
            cardJustClicked = null;
         }
         if(state == STATE_START)
         {
            if(timer <= 0)
            {
               gameObjectLayer.removeGameObject(cardsFalling);
               cardsFalling = null;
               _loc4_ = cards[0].getWidth();
               _loc5_ = cards[0].getHeight();
               _loc6_ = 4;
               _loc7_ = 3;
               _loc8_ = GameWorld.CANVAS_HEIGHT / 20;
               _loc9_ = GameWorld.CANVAS_WIDTH / 20;
               _loc10_ = (GameWorld.CANVAS_WIDTH - _loc8_ - _loc8_) / _loc6_;
               _loc11_ = (GameWorld.CANVAS_HEIGHT - _loc9_ - _loc9_) / _loc7_;
               _loc12_ = _loc6_ * _loc7_;
               _loc13_ = new Array();
               _loc3_ = 1;
               while(_loc3_ < _loc12_)
               {
                  _loc13_.push(_loc3_);
                  _loc3_++;
               }
               _loc3_ = 0;
               while(_loc3_ < cards.length)
               {
                  _loc14_ = CardObject(cards[_loc3_]);
                  _loc15_ = Engine.rnd(0,_loc13_.length);
                  _loc16_ = _loc13_[_loc15_];
                  _loc13_.splice(_loc15_,1);
                  _loc17_ = _loc4_ / 2;
                  _loc18_ = _loc5_ / 2;
                  _loc14_.tweenMotionSpeed(_loc16_ % _loc6_ * _loc10_ + Engine.rnd(0,_loc10_ - _loc4_) + _loc17_ + _loc9_,Math.floor(_loc16_ / _loc6_) * _loc11_ + Engine.rnd(0,_loc11_ - _loc5_) + _loc18_ + _loc8_,1000,0.4);
                  _loc14_.mainSprite.visible = true;
                  _loc3_++;
               }
               timer = 0;
               state = STATE_START_REVEAL;
            }
         }
         else if(state == STATE_START_REVEAL || state == STATE_START_UNREVEAL)
         {
            if(timer <= 0)
            {
               _loc3_ = 0;
               while(_loc3_ < cards.length)
               {
                  _loc14_ = CardObject(cards[_loc3_]);
                  if((_loc14_.cardState == CardObject.CARD_STATE_REVEALED || _loc14_.cardState == CardObject.CARD_STATE_UNREVEALED) && _loc14_.x <= revealScanline)
                  {
                     if(state == STATE_START_REVEAL)
                     {
                        _loc14_.reveal();
                     }
                     else if(state == STATE_START_UNREVEAL)
                     {
                        _loc14_.unreveal();
                     }
                  }
                  _loc3_++;
               }
               if(revealScanline < GameWorld.CANVAS_WIDTH)
               {
                  revealScanline += param1 * 2;
               }
               else if(state == STATE_START_REVEAL)
               {
                  revealScanline = 0;
                  timer = startRevealDelay;
                  cardReadyMessage = new CardReady();
                  Engine.setFontForLang(cardReadyMessage.pressAnyKeyText.textField,"Baveuse");
                  cardReadyMessage.pressAnyKeyText.textField.text = "PRESS ANY KEY";
                  cardReadyMessage.x = GameWorld.CANVAS_CENTER_X;
                  cardReadyMessage.y = GameWorld.CANVAS_CENTER_Y + (GameWorld.CANVAS_HEIGHT - cardReadyMessage.height) / 2;
                  addChild(cardReadyMessage);
                  addEventListener(MouseEvent.MOUSE_DOWN,mouseDownListener);
                  buttonMode = true;
                  state = STATE_START_UNREVEAL;
               }
               else if(state == STATE_START_UNREVEAL)
               {
                  removeCardReady();
                  container.gameTimerEnabled = true;
                  addMouseListenersToCards();
                  state = STATE_PLAY;
               }
            }
         }
         else if(state == STATE_WRONG_IDLE)
         {
            if(timer <= 0)
            {
               cardsClicked[0].unreveal();
               cardsClicked[1].unreveal();
               cardsClicked = new Array();
               addMouseListenersToCards();
               state = STATE_PLAY;
            }
         }
         else if(state == STATE_END)
         {
            if(timer <= 0)
            {
               _loc3_ = 0;
               while(_loc3_ < cards.length)
               {
                  cards[_loc3_].disappear();
                  _loc3_++;
               }
               timer = 500;
               state = STATE_RESTART;
            }
         }
         else if(state == STATE_RESTART)
         {
            if(timer <= 0)
            {
               restart();
               return;
            }
         }
         else if(state == STATE_PLAY)
         {
            if(swapNow)
            {
               _loc19_ = new Array();
               _loc3_ = 0;
               while(_loc3_ < cards.length / 2)
               {
                  _loc20_ = _loc3_ * 2;
                  if(!cards[_loc20_].cardCorrect)
                  {
                     _loc19_.push(_loc20_);
                  }
                  _loc3_++;
               }
               if(_loc19_.length >= 2)
               {
                  _loc21_ = new Array();
                  _loc3_ = 0;
                  while(_loc3_ < 2)
                  {
                     _loc20_ = Engine.rnd(0,_loc19_.length);
                     _loc21_.push(cards[_loc19_[_loc20_]]);
                     _loc19_.splice(_loc20_,1);
                     _loc3_++;
                  }
                  _loc21_[0].tweenMotionSpeed(_loc21_[1].x,_loc21_[1].y,500,0.4);
                  _loc21_[1].tweenMotionSpeed(_loc21_[0].x,_loc21_[0].y,500,0.4);
               }
               swapNow = false;
            }
         }
         gameObjectLayer.updateSpritePosition(0,0);
      }
      
      public function cardClickListener(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         if(cardJustClicked == null)
         {
            _loc2_ = 0;
            while(_loc2_ < cards.length)
            {
               if(cards[_loc2_].mainSprite == param1.currentTarget)
               {
                  if(cards[_loc2_].cardState == CardObject.CARD_STATE_UNREVEALED)
                  {
                     cardJustClicked = cards[_loc2_];
                  }
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public function pairsLeft() : int
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         while(_loc2_ < cards.length)
         {
            if(!cards[_loc2_].cardCorrect)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return int(_loc1_ / 2);
      }
      
      override public function timeup() : *
      {
         removeCardReady();
         removeMouseListenersToCards();
         state = STATE_TIMEUP;
      }
      
      public function mouseDownListener(param1:MouseEvent) : *
      {
         timer = 0;
         removeCardReady();
      }
      
      public function getCardsleft() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:* = 0;
         while(_loc2_ < cards.length)
         {
            if(!cards[_loc2_].cardCorrect)
            {
               _loc1_.push(cards[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function allCardsCorrect() : Boolean
      {
         var _loc1_:* = 0;
         while(_loc1_ < cards.length)
         {
            if(!cards[_loc1_].cardCorrect)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function removeCardReady() : *
      {
         if(cardReadyMessage != null)
         {
            removeChild(cardReadyMessage);
            cardReadyMessage = null;
         }
         buttonMode = false;
         removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownListener);
      }
   }
}
