package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MeteorSequence extends Minigame
   {
      
      internal static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(11);
      
      internal static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-11);
       
      
      internal var speedTextField:TextField;
      
      internal var gameObjectLayer:GameObjectLayer;
      
      internal var meteorObjects:Array;
      
      internal var numbers:Array;
      
      internal var NUM_TO_STRING_BKP:Array;
      
      internal var NUM_TO_STRING:Array;
      
      public function MeteorSequence(param1:MinigameBase)
      {
         this.NUM_TO_STRING_BKP = new Array("ZERO","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE","TEN");
         super(param1);
         var currentLang:String = LanguageButton.currentLanguage;
         NUM_TO_STRING = LanguageTranslation.getNumbersText(currentLang);
      }
      
      override public function restart() : *
      {
         var _loc4_:RandomBasket = null;
         var _loc14_:int = 0;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:TextFormat = null;
         var _loc19_:int = 0;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:int = 0;
         gameObjectLayer.reset();
         var _loc1_:* = Math.min(3 + Math.floor(container.getTotalCorrect() / 4),6);
         var _loc2_:* = Math.min(15 + container.getTotalCorrect() * 5,100);
         var _loc3_:* = Math.min(Math.floor(1 + container.getTotalCorrect() / 4),5);
         var _loc5_:Boolean = container.getTotalCorrect() % 4 == 2 && Engine.rnd(0,2) == 0;
         if(_loc5_)
         {
            _loc4_ = new RandomBasket(0,26);
         }
         else if(container.getTotalCorrect() >= 6)
         {
            _loc4_ = new RandomBasket(-50,_loc2_);
         }
         else
         {
            _loc4_ = new RandomBasket(0,_loc2_);
         }
         numbers = new Array();
         var _loc6_:* = 0;
         while(_loc6_ < _loc1_)
         {
            do
            {
               _loc14_ = int(_loc4_.getNextItem());
               _loc16_ = _loc14_.toString();
            }
            while(!(_loc16_.indexOf("6") == -1 && _loc16_.indexOf("9") == -1));
            
            _loc15_ = 0;
            while(_loc15_ < numbers.length)
            {
               if(_loc14_ <= numbers[_loc15_])
               {
                  numbers.splice(_loc15_,0,_loc14_);
                  break;
               }
               _loc15_++;
            }
            if(_loc15_ == numbers.length)
            {
               numbers.push(_loc14_);
            }
            _loc6_++;
         }
         meteorObjects = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc1_)
         {
            _loc17_ = null;
            if(_loc5_)
            {
               _loc17_ = new Meteor(gameObjectLayer,numbers[_loc6_],String.fromCharCode(65 + numbers[_loc6_]));
               _loc18_ = new TextFormat();
               _loc18_.underline = true;
               _loc17_.mainSprite.mc.textField.setTextFormat(_loc18_);
            }
            else if(container.getTotalCorrect() >= 5 && numbers[_loc6_] < NUM_TO_STRING.length && numbers[_loc6_] >= 0 && Engine.rnd(0,2) == 0)
            {
               _loc17_ = new Meteor(gameObjectLayer,numbers[_loc6_],NUM_TO_STRING[numbers[_loc6_]]);
            }
            else
            {
               _loc17_ = new Meteor(gameObjectLayer,numbers[_loc6_],"" + numbers[_loc6_]);
            }
            _loc17_.rotateSpeed = Engine.rnd(-_loc3_ * 10,_loc3_ * 10) / 10;
            _loc17_.mainSprite.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownListener);
            _loc17_.mainSprite.buttonMode = true;
            gameObjectLayer.addGameObject(_loc17_);
            meteorObjects.push(_loc17_);
            _loc6_++;
         }
         var _loc7_:* = 0;
         _loc6_ = 0;
         while(_loc6_ < meteorObjects.length)
         {
            if(meteorObjects[_loc6_].radius > _loc7_)
            {
               _loc7_ = meteorObjects[_loc6_].radius;
            }
            _loc6_++;
         }
         _loc7_ *= 2;
         var _loc8_:* = Math.floor(GameWorld.CANVAS_HEIGHT / _loc7_);
         var _loc9_:* = Math.floor(GameWorld.CANVAS_WIDTH / _loc7_);
         trace("parWidth=" + _loc7_ + " numParRows=" + _loc8_ + " numParColumes=" + _loc9_);
         var _loc10_:* = (GameWorld.CANVAS_WIDTH - _loc9_ * _loc7_) / 2;
         var _loc11_:* = (GameWorld.CANVAS_HEIGHT - _loc8_ * _loc7_) / 2;
         var _loc12_:RandomBasket = new RandomBasket(0,_loc8_ * _loc9_);
         _loc6_ = 0;
         while(_loc6_ < meteorObjects.length)
         {
            _loc19_ = int(_loc12_.getNextItem());
            trace("parIndex=" + _loc19_);
            _loc20_ = _loc19_ % _loc9_;
            _loc21_ = Math.floor(_loc19_ / _loc9_);
            meteorObjects[_loc6_].x = _loc20_ * _loc7_ + _loc10_ + _loc7_ / 2;
            meteorObjects[_loc6_].y = _loc21_ * _loc7_ + _loc11_ + _loc7_ / 2;
            _loc22_ = _loc7_ / 2 - meteorObjects[_loc6_].radius;
            meteorObjects[_loc6_].x += Engine.rnd(-_loc22_,_loc22_);
            meteorObjects[_loc6_].y += Engine.rnd(-_loc22_,_loc22_);
            _loc6_++;
         }
         var _loc13_:Meteor = new Meteor(gameObjectLayer,0,"",40);
         _loc13_.stationary = true;
         _loc13_.x = GameWorld.CANVAS_CENTER_X - GameWorld.CANVAS_WIDTH / 2 + 40;
         _loc13_.y = GameWorld.CANVAS_CENTER_Y - GameWorld.CANVAS_HEIGHT / 2 + 40;
         _loc13_.rotateSpeed = 0;
         _loc13_.setSpeed(0,0);
         _loc13_.visible = false;
         meteorObjects.push(_loc13_);
         gameObjectLayer.addGameObject(_loc13_);
         gameObjectLayer.updateSpritePosition(0,0);
      }
      
      override public function timeup() : *
      {
         removeAllMouseListeners();
      }
      
      override public function init() : *
      {
         var _loc1_:* = new MeteorScene();
         _loc1_.x = GameWorld.CANVAS_CENTER_X;
         _loc1_.y = GameWorld.CANVAS_CENTER_Y;
         _loc1_.cacheAsBitmap = true;
         addChild(_loc1_);
         gameObjectLayer = new GameObjectLayer();
         addChild(gameObjectLayer);
      }
      
      public function mouseDownListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:Meteor = Meteor(AnimatedSprite(param1.target).gameObject);
         if(_loc2_.number == numbers[0] || Debug.CHEAT)
         {
            container.addScore(CORRECT_SCORE.value);
            _loc2_.mainSprite.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownListener);
            _loc2_.state = Meteor.STATE_DYING;
            numbers.shift();
            if(numbers.length == 0)
            {
               container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
            }
         }
         else
         {
            container.addScore(INCORRECT_SCORE.value);
            removeAllMouseListeners();
            container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
         }
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Number = Number(NaN);
         var _loc4_:* = undefined;
         if(GameWorld.DEBUG)
         {
            _loc3_ = 0;
            _loc2_ = meteorObjects.length - 1;
            while(_loc2_ >= 0)
            {
               _loc3_ += Math.sqrt(meteorObjects[_loc2_].speedX * meteorObjects[_loc2_].speedX + meteorObjects[_loc2_].speedY * meteorObjects[_loc2_].speedY);
               _loc2_--;
            }
         }
         gameObjectLayer.tick(param1);
         _loc2_ = meteorObjects.length - 1;
         while(_loc2_ >= 0)
         {
            if(meteorObjects[_loc2_].state == Meteor.STATE_DEAD)
            {
               gameObjectLayer.removeGameObject(meteorObjects[_loc2_]);
               meteorObjects.splice(meteorObjects.indexOf(meteorObjects[_loc2_]),1);
            }
            _loc2_--;
         }
         _loc2_ = 0;
         while(_loc2_ < meteorObjects.length)
         {
            if(meteorObjects[_loc2_].state == Meteor.STATE_NORMAL)
            {
               _loc4_ = _loc2_ + 1;
               while(_loc4_ < meteorObjects.length)
               {
                  if(meteorObjects[_loc2_].isColliding(meteorObjects[_loc4_]))
                  {
                     trace(_loc2_ + " and " + _loc4_ + " collide---------");
                     meteorObjects[_loc2_].collisionResponse(meteorObjects[_loc4_]);
                  }
                  _loc4_++;
               }
            }
            _loc2_++;
         }
         gameObjectLayer.updateSpritePosition(0,0);
      }
      
      public function removeAllMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < meteorObjects.length)
         {
            meteorObjects[_loc1_].mainSprite.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownListener);
            meteorObjects[_loc1_].mainSprite.buttonMode = false;
            _loc1_++;
         }
      }
   }
}
