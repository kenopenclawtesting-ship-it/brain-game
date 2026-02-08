package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   
   public class WeightGame extends Minigame
   {
      
      internal static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(24);
      
      internal static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-16);
      
      internal static const NORMAL_GROUP_INDICES:Array = [0,1,2,3,4,6];
      
      internal static const EASTER_GROUP_INDEX:* = 5;
       
      
      internal var gameScene:Sprite;
      
      internal var itemGroupIndex:int;
      
      internal var itemPanelTypes:Array;
      
      internal var itemPairs:Array;
      
      internal const NUM_CORRECT_ANSWER_BEFORE_ADDING_SCALE:* = 8;
      
      internal var itemPanels:Array;
      
      internal var itemWeights:Array;
      
      internal var scales:Array;
      
      internal var itemImages:Array;
      
      internal var maxItemImages:int;
      
      internal const MAX_ITEMS_PER_SIDE:* = 3;
      
      internal var heaviestItemType:int;
      
      internal const MAX_NUM_SCALES:* = 4;
      
      public function WeightGame(param1:MinigameBase)
      {
         super(param1);
      }
      
      override public function timeup() : *
      {
         removeItemClickListeners();
      }
      
      public function itemClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:* = itemPanels.indexOf(param1.currentTarget);
         if(itemPanelTypes[_loc2_] == heaviestItemType)
         {
            container.addScore(CORRECT_SCORE.value);
            container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
         }
         else
         {
            container.addScore(INCORRECT_SCORE.value);
            container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
         }
         removeItemClickListeners();
      }
      
      override public function restart() : *
      {
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:* = undefined;
         var _loc23_:int = 0;
         var _loc24_:Array = null;
         var _loc25_:* = undefined;
         var _loc26_:AnimatedSprite = null;
         var _loc27_:Array = null;
         var _loc28_:* = undefined;
         var _loc29_:WeightPanel = null;
         var _loc30_:MovieClip = null;
         if(gameScene != null)
         {
            removeChild(gameScene);
            gameScene = null;
         }
         gameScene = new Sprite();
         addChild(gameScene);
         var _loc1_:RandomBasket = new RandomBasket();
         _loc1_.addItemArray(NORMAL_GROUP_INDICES);
         if(GameWorld.ENABLE_EASTER_ITEMS)
         {
            _loc1_.addItems(EASTER_GROUP_INDEX);
         }
         itemGroupIndex = int(_loc1_.getNextItem());
         _loc1_ = null;
         maxItemImages = Engine.getMovieClip("Shapes" + itemGroupIndex).totalFrames;
         var _loc2_:* = container.getTotalCorrect() % NUM_CORRECT_ANSWER_BEFORE_ADDING_SCALE;
         var _loc3_:int = Math.min(1 + Math.floor(container.getTotalCorrect() / NUM_CORRECT_ANSWER_BEFORE_ADDING_SCALE),MAX_NUM_SCALES);
         var _loc4_:* = _loc3_ + 1;
         var _loc5_:* = 0;
         if(_loc2_ >= NUM_CORRECT_ANSWER_BEFORE_ADDING_SCALE / 2)
         {
            _loc5_ = Engine.rnd(0,2);
         }
         _loc4_ += _loc5_;
         itemWeights = generateUniqueRandomItemWeights(_loc4_);
         itemImages = generateUniqueRandomItemImages(_loc4_);
         var _loc6_:* = 0;
         while(_loc6_ < itemWeights.length)
         {
            trace("weight=" + itemWeights[_loc6_] + " image=" + itemImages[_loc6_]);
            _loc6_++;
         }
         heaviestItemType = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            itemWeights[_loc4_ - 1 - _loc6_] = 1;
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < itemWeights.length)
         {
            trace("adjusted weight=" + itemWeights[_loc6_]);
            _loc6_++;
         }
         itemPairs = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc12_ = new Array();
            _loc13_ = _loc6_ + 1;
            _loc14_ = new Array();
            _loc14_.push(_loc13_);
            _loc12_.push(_loc14_);
            _loc15_ = Engine.rnd(0,_loc13_);
            _loc16_ = new Array();
            _loc16_.push(_loc15_);
            _loc12_.push(_loc16_);
            itemPairs.push(_loc12_);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < itemPairs.length)
         {
            trace("pair " + _loc6_ + " item " + itemPairs[_loc6_][0] + " " + itemPairs[_loc6_][1]);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc17_ = _loc4_ - 1 - _loc6_;
            _loc18_ = new Array();
            _loc19_ = 0;
            while(_loc19_ < _loc3_)
            {
               _loc20_ = getWeight(itemPairs[_loc19_][0]);
               _loc21_ = getWeight(itemPairs[_loc19_][1]);
               if(itemWeights[_loc17_] <= _loc21_ - _loc20_)
               {
                  _loc18_.push(_loc19_);
               }
               _loc19_++;
            }
            if(_loc18_.length > 0)
            {
               _loc22_ = _loc18_[Engine.rnd(0,_loc18_.length)];
               itemPairs[_loc22_][0].push(_loc17_);
            }
            _loc6_++;
         }
         if(_loc2_ >= 3)
         {
            _loc6_ = 0;
            while(_loc6_ < itemPairs.length)
            {
               if(Engine.rnd(0,NUM_CORRECT_ANSWER_BEFORE_ADDING_SCALE - _loc2_) == 0)
               {
                  _loc20_ = getWeight(itemPairs[_loc6_][0]);
                  _loc21_ = getWeight(itemPairs[_loc6_][1]);
                  _loc23_ = _loc21_ - _loc20_;
                  _loc24_ = new Array();
                  _loc19_ = 0;
                  while(_loc19_ < itemWeights.length)
                  {
                     if(itemWeights[_loc19_] <= _loc23_)
                     {
                        _loc24_.push(_loc19_);
                     }
                     _loc19_++;
                  }
                  if(_loc24_.length > 0)
                  {
                     itemPairs[_loc6_][0].push(_loc24_[Engine.rnd(0,_loc24_.length)]);
                  }
               }
               else if(itemPairs[_loc6_][0].length < MAX_ITEMS_PER_SIDE && itemPairs[_loc6_][1].length < MAX_ITEMS_PER_SIDE && Engine.rnd(0,2) == 0)
               {
                  _loc25_ = Engine.rnd(0,_loc4_);
                  itemPairs[_loc6_][0].push(_loc25_);
                  itemPairs[_loc6_][1].push(_loc25_);
               }
               _loc6_++;
            }
         }
         var _loc7_:RandomBasket = new RandomBasket(0,itemPairs.length);
         var _loc8_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < itemPairs.length)
         {
            _loc8_.push(itemPairs[_loc7_.getNextItem()]);
            _loc6_++;
         }
         itemPairs = _loc8_;
         _loc8_ = null;
         var _loc9_:* = GameWorld.CANVAS_HEIGHT / (Math.ceil(_loc3_ / 2) + 1);
         scales = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc20_ = getWeight(itemPairs[_loc6_][0]);
            _loc21_ = getWeight(itemPairs[_loc6_][1]);
            if(_loc20_ == _loc21_)
            {
               _loc26_ = new AnimatedSprite("Scale3");
            }
            else
            {
               _loc26_ = new AnimatedSprite("Scale4");
               _loc26_.numLoops = 1;
            }
            _loc27_ = new Array();
            _loc27_.push(_loc26_.mc.item0);
            _loc27_.push(_loc26_.mc.item1);
            _loc27_.push(_loc26_.mc.item2);
            _loc27_.push(_loc26_.mc.item3);
            _loc27_.push(_loc26_.mc.item4);
            _loc27_.push(_loc26_.mc.item5);
            _loc27_.push(_loc26_.mc.item6);
            _loc27_.push(_loc26_.mc.item7);
            _loc19_ = 0;
            while(_loc19_ < _loc27_.length)
            {
               _loc27_[_loc19_].removeChildAt(0);
               _loc19_++;
            }
            if(itemPairs[_loc6_][1].length == 1)
            {
               _loc27_[0].addChild(getItemSprite(itemPairs[_loc6_][1][0]));
            }
            else
            {
               _loc19_ = 0;
               while(_loc19_ < itemPairs[_loc6_][1].length)
               {
                  _loc27_[_loc19_ + 1].addChild(getItemSprite(itemPairs[_loc6_][1][_loc19_]));
                  _loc19_++;
               }
            }
            if(itemPairs[_loc6_][0].length == 1)
            {
               _loc27_[4].addChild(getItemSprite(itemPairs[_loc6_][0][0]));
            }
            else
            {
               _loc19_ = 0;
               while(_loc19_ < itemPairs[_loc6_][0].length)
               {
                  _loc27_[_loc19_ + 5].addChild(getItemSprite(itemPairs[_loc6_][0][_loc19_]));
                  _loc19_++;
               }
            }
            if(Engine.rnd(0,2) == 0)
            {
               _loc26_.manipulate(AnimatedSprite.FLIP_HORIZONTAL);
            }
            if(_loc3_ % 2 != 0 && _loc6_ == _loc3_ - 1)
            {
               _loc26_.x = GameWorld.CANVAS_CENTER_X;
            }
            else
            {
               _loc28_ = _loc6_ % 2;
               _loc26_.x = GameWorld.CANVAS_WIDTH / 4 + _loc28_ * GameWorld.CANVAS_WIDTH / 2;
            }
            _loc26_.y = (Math.floor(_loc6_ / 2) + 1) * _loc9_;
            scales.push(_loc26_);
            gameScene.addChild(_loc26_);
            _loc6_++;
         }
         var _loc10_:* = new Sprite();
         itemPanelTypes = new Array();
         itemPanels = new Array();
         var _loc11_:RandomBasket = new RandomBasket(0,_loc4_);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc29_ = new WeightPanel();
            setButtonMode(_loc29_,true);
            _loc29_.addEventListener(MouseEvent.MOUSE_DOWN,itemClickListener);
            _loc29_.x = _loc6_ * (_loc29_.width + _loc29_.width / 4) + _loc29_.width / 2;
            itemPanelTypes[_loc6_] = _loc11_.getNextItem();
            _loc30_ = getItemSprite(itemPanelTypes[_loc6_]);
            _loc30_.y = _loc30_.height / 2;
            _loc30_.mouseEnabled = false;
            _loc29_.box.addChild(_loc30_);
            itemPanels.push(_loc29_);
            _loc10_.addChild(_loc29_);
            _loc6_++;
         }
         gameScene.addChild(_loc10_);
         _loc10_.y = GameWorld.CANVAS_HEIGHT - _loc10_.height / 2 - _loc10_.height / 4;
         _loc10_.x = (GameWorld.CANVAS_WIDTH - _loc10_.width) / 2;
      }
      
      public function generateUniqueRandomItemImages(param1:int) : Array
      {
         var _loc2_:* = new RandomBasket(0,maxItemImages);
         var _loc3_:* = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < param1)
         {
            _loc3_.push(_loc2_.getNextItem());
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getWeight(param1:Array) : int
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += itemWeights[param1[_loc3_]];
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:* = 0;
         while(_loc2_ < scales.length)
         {
            scales[_loc2_].tickAnimation(param1);
            _loc2_++;
         }
      }
      
      override public function init() : *
      {
         var _loc1_:* = new WeightScene();
         _loc1_.x = GameWorld.CANVAS_CENTER_X;
         _loc1_.y = GameWorld.CANVAS_CENTER_Y;
         _loc1_.cacheAsBitmap = true;
         addChild(_loc1_);
      }
      
      public function getItemSprite(param1:int) : MovieClip
      {
         var _loc2_:* = Engine.getMovieClip("Shapes" + itemGroupIndex);
         _loc2_.gotoAndStop(itemImages[param1] + 1);
         _loc2_.scaleX = 0.75;
         _loc2_.scaleY = 0.75;
         return _loc2_;
      }
      
      public function removeItemClickListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < itemPanels.length)
         {
            setButtonMode(itemPanels[_loc1_],false);
            itemPanels[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,itemClickListener);
            _loc1_++;
         }
      }
      
      public function generateUniqueRandomItemWeights(param1:int) : Array
      {
         var _loc6_:Boolean = false;
         var _loc7_:* = undefined;
         var _loc2_:* = new RandomBasket(1,param1 * 2);
         var _loc3_:* = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < param1)
         {
            _loc3_.push(_loc2_.getNextItem());
            _loc4_++;
         }
         var _loc5_:* = new Array();
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc6_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if(_loc3_[_loc4_] >= _loc5_[_loc7_])
               {
                  _loc5_.splice(_loc7_,0,_loc3_[_loc4_]);
                  _loc6_ = true;
                  break;
               }
               _loc7_++;
            }
            if(!_loc6_)
            {
               _loc5_.push(_loc3_[_loc4_]);
            }
            _loc4_++;
         }
         return _loc5_;
      }
   }
}
