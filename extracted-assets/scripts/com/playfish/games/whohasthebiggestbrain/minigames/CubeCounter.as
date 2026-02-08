package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   
   public class CubeCounter extends Minigame
   {
      
      internal static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(49);
      
      internal static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-33);
       
      
      internal var gameObjectLayer:GameObjectLayer;
      
      internal const MAX_HEIGHT:int = 4;
      
      internal const PROTECTED_BLOCK_DROP_INDEX:int = 1;
      
      internal var blocks:Array;
      
      internal var blockMap:Array;
      
      internal const MAX_BASE_WIDTH:int = 6;
      
      internal const STATE_FINISH:int = 2;
      
      internal var acceptInput:Boolean = false;
      
      internal const STATE_RESTART:int = 3;
      
      internal var blockMapX:int;
      
      internal var numButtons:Array;
      
      internal var maxHeight:int;
      
      internal const NUM_PROTECTED_VALUES:int = 2;
      
      internal var blockMapY:int;
      
      internal var gameState:uint;
      
      internal var gameScene:CubeLayout;
      
      internal const STATE_PLAY:int = 1;
      
      internal var acceptInputTimer:int;
      
      internal var timer:int;
      
      internal const PROTECTED_NUM_BLOCKS:int = 0;
      
      internal var debugLayout:Sprite;
      
      internal var prevBlockMap:Array;
      
      internal var baseWidth:uint;
      
      internal const STATE_START:int = 0;
      
      public function CubeCounter(param1:MinigameBase)
      {
         super(param1,NUM_PROTECTED_VALUES);
      }
      
      override public function init() : *
      {
         gameScene = new CubeLayout();
         gameScene.x = GameWorld.CANVAS_CENTER_X;
         gameScene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(gameScene);
         numButtons = new Array();
         numButtons.push(gameScene.num0);
         numButtons.push(gameScene.num1);
         numButtons.push(gameScene.num2);
         numButtons.push(gameScene.num3);
         numButtons.push(gameScene.num4);
         numButtons.push(gameScene.num5);
         numButtons.push(gameScene.num6);
         numButtons.push(gameScene.num7);
         numButtons.push(gameScene.num8);
         numButtons.push(gameScene.num9);
         var _loc1_:* = 0;
         while(_loc1_ < numButtons.length)
         {
            numButtons[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
         blockMapX = gameScene.num1.x / 2 - GameWorld.CANVAS_WIDTH / 4;
         blockMapY = 0;
      }
      
      override public function restart() : *
      {
         var _loc8_:RandomBasket = null;
         var _loc9_:* = undefined;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:CubeBlock = null;
         var _loc13_:* = undefined;
         blocks = new Array();
         gameScene.input.text = "";
         if(gameObjectLayer == null)
         {
            gameObjectLayer = new GameObjectLayer();
            gameScene.addChild(gameObjectLayer);
         }
         else
         {
            gameObjectLayer.reset();
         }
         var _loc1_:int = Math.floor(container.getTotalCorrect() / 1.5);
         baseWidth = Math.floor(_loc1_ / 8);
         baseWidth = Engine.rnd(2,5 + baseWidth);
         var _loc2_:* = Math.max(Math.floor(_loc1_ / 8) + 1,3);
         maxHeight = Engine.rnd(_loc2_,MAX_HEIGHT + 1);
         var _loc3_:* = baseWidth * baseWidth * maxHeight;
         var _loc4_:int = Math.min(Engine.rnd(2,6) + _loc1_,_loc3_);
         protectedValues.setValue(PROTECTED_NUM_BLOCKS,_loc4_);
         trace("numBlocks=" + _loc4_ + " baseWidth=" + baseWidth + " maxHeight=" + maxHeight);
         gameScene.addChild(gameScene.input);
         prevBlockMap = blockMap;
         blockMap = new Array();
         var _loc5_:* = 0;
         while(_loc5_ < baseWidth * baseWidth)
         {
            blockMap[_loc5_] = 0;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc8_ = new RandomBasket();
            _loc9_ = 0;
            while(_loc9_ < baseWidth * baseWidth)
            {
               if(isValidCellForBlock(_loc9_))
               {
                  _loc8_.addItems(_loc9_);
               }
               _loc9_++;
            }
            ++blockMap[int(_loc8_.getNextItem())];
            _loc5_++;
         }
         var _loc6_:* = Engine.rnd(2,5);
         var _loc7_:* = Engine.rnd(0,3);
         _loc5_ = 0;
         while(_loc5_ < blockMap.length)
         {
            _loc9_ = 0;
            while(_loc9_ < blockMap[_loc5_])
            {
               _loc10_ = _loc5_ % baseWidth;
               _loc11_ = Math.floor(_loc5_ / baseWidth);
               _loc12_ = null;
               _loc13_ = 0;
               switch(_loc7_)
               {
                  case 0:
                     if(_loc9_ % 2 == 1)
                     {
                        _loc13_ = 1;
                     }
                     break;
                  case 1:
                     if(_loc11_ % 2 == 1)
                     {
                        _loc13_ = 1;
                     }
                     break;
                  case 2:
                     if(_loc10_ % 2 == 1)
                     {
                        _loc13_ = 1;
                     }
               }
               if(_loc13_ == 0)
               {
                  _loc12_ = new CubeBlock(gameObjectLayer,1);
               }
               else
               {
                  _loc12_ = new CubeBlock(gameObjectLayer,_loc6_);
               }
               _loc12_.x = _loc12_.getWidth() / 2 * (_loc10_ - _loc11_);
               _loc12_.y = (_loc12_.getHeight() / 4 - 1) * (_loc10_ + _loc11_) - _loc9_ * (_loc12_.getHeight() / 2);
               _loc12_.y -= Engine.stageHeight;
               _loc12_.row = _loc11_;
               _loc12_.colume = _loc10_;
               _loc12_.blockHeight = _loc9_;
               blocks.push(_loc12_);
               gameObjectLayer.addGameObject(_loc12_);
               _loc9_++;
            }
            _loc5_++;
         }
         gameScene.input.x = blockMapX - gameScene.input.width / 2;
         gameScene.input.y = blockMapY - gameScene.input.height / 2;
         gameObjectLayer.updateSpritePosition(-blockMapX,-blockMapY);
         addMouseListeners();
         protectedValues.setValue(PROTECTED_BLOCK_DROP_INDEX,0);
         timer = 0;
         acceptInputTimer = 1000;
         container.gameTimerEnabled = true;
         gameState = STATE_START;
      }
      
      public function addMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < numButtons.length)
         {
            setButtonMode(numButtons[_loc1_],true);
            numButtons[_loc1_].addEventListener(MouseEvent.MOUSE_DOWN,numClickListener);
            _loc1_++;
         }
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         gameObjectLayer.tick(param1);
         if(gameState == STATE_START)
         {
            timer -= param1;
            if(timer <= 0)
            {
               _loc2_ = int(protectedValues.getValue(PROTECTED_BLOCK_DROP_INDEX));
               blocks[_loc2_].tweenMotionSpeed(blocks[_loc2_].x,blocks[_loc2_].y + Engine.stageHeight,2000,0);
               if(blocks[_loc2_].blockHeight == 0)
               {
                  blocks[_loc2_].createShadow();
               }
               _loc2_++;
               protectedValues.setValue(PROTECTED_BLOCK_DROP_INDEX,_loc2_);
               if(_loc2_ >= blocks.length)
               {
                  gameState = STATE_PLAY;
               }
               timer += 50;
            }
         }
         else if(gameState == STATE_FINISH)
         {
            if(container.state == MinigameBase.STATE_NORMAL)
            {
               _loc3_ = 0;
               while(_loc3_ < blocks.length)
               {
                  blocks[_loc3_].disappear();
                  _loc3_++;
               }
               gameScene.input.text = "";
               timer = 250;
               removeMouseListeners();
               gameState = STATE_RESTART;
            }
         }
         else if(gameState == STATE_RESTART)
         {
            timer -= param1;
            if(timer <= 0)
            {
               restart();
            }
         }
      }
      
      public function isSameMap(param1:Array, param2:Array) : Boolean
      {
         if(param1 == null || param2 == null || param1.length != param2.length)
         {
            return false;
         }
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != param2[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      override public function timeup() : *
      {
         removeMouseListeners();
      }
      
      override public function keyDown(param1:int, param2:int) : *
      {
         var _loc3_:int = 0;
         if(param2 >= 48 && param2 <= 57)
         {
            _loc3_ = param2 - 48;
            numPressed(_loc3_);
            numButtons[_loc3_].gotoAndStop("down");
         }
      }
      
      public function numPressed(param1:int) : *
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:* = undefined;
         if(gameState == STATE_PLAY && container.state == MinigameBase.STATE_NORMAL)
         {
            Engine.playSound("ButtonInGame",1);
            gameScene.input.appendText("" + param1);
            _loc2_ = protectedValues.getValue(PROTECTED_NUM_BLOCKS).toString();
            _loc3_ = true;
            _loc4_ = 0;
            while(_loc4_ < gameScene.input.text.length)
            {
               if(gameScene.input.text.charAt(_loc4_) != _loc2_.charAt(_loc4_))
               {
                  _loc3_ = false;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               container.addScore(INCORRECT_SCORE.value);
               container.fail(false,blockMapX + GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               gameState = STATE_FINISH;
            }
            else if(gameScene.input.text.length > 0 && gameScene.input.text.length == _loc2_.length)
            {
               container.addScore(CORRECT_SCORE.value);
               container.correct(false,blockMapX + GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               gameState = STATE_FINISH;
            }
         }
      }
      
      public function removeMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < numButtons.length)
         {
            setButtonMode(numButtons[_loc1_],false);
            numButtons[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,numClickListener);
            _loc1_++;
         }
      }
      
      public function isValidCellForBlock(param1:int) : *
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(blockMap[param1] >= maxHeight)
         {
            return false;
         }
         var _loc2_:* = param1 % baseWidth;
         var _loc3_:* = Math.floor(param1 / baseWidth);
         var _loc4_:* = baseWidth * baseWidth;
         if(_loc2_ > 0 && _loc3_ > 0)
         {
            _loc5_ = param1 - baseWidth - 1;
            if(blockMap[_loc5_] <= blockMap[param1])
            {
               return false;
            }
         }
         if(_loc2_ > 0)
         {
            _loc6_ = param1 + baseWidth - 1;
            _loc7_ = int(blockMap[param1 - 1]);
            if(_loc6_ < _loc4_ && blockMap[_loc6_] > _loc7_ && blockMap[param1] >= _loc7_)
            {
               return false;
            }
         }
         if(_loc3_ > 0)
         {
            _loc8_ = param1 - baseWidth + 1;
            _loc9_ = int(blockMap[param1 - baseWidth]);
            if(_loc8_ >= 0 && blockMap[_loc8_] > _loc9_ && blockMap[param1] >= _loc9_)
            {
               return false;
            }
         }
         return true;
      }
      
      public function insertBlockTo(param1:int) : *
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:* = param1 % baseWidth;
         var _loc3_:* = Math.floor(param1 / baseWidth);
         var _loc4_:* = false;
         var _loc5_:* = _loc2_ - 2;
         while(_loc5_ <= _loc2_)
         {
            if(x >= 0)
            {
               _loc6_ = _loc3_ - 2;
               while(_loc6_ <= _loc3_)
               {
                  if(y >= 0)
                  {
                     if(_loc5_ != _loc2_ || _loc6_ != _loc3_)
                     {
                        _loc7_ = _loc5_ + _loc6_ * baseWidth;
                        if(blockMap[param1] > blockMap[_loc7_] || blockMap[param1] > 0 && blockMap[param1] >= blockMap[_loc7_])
                        {
                           insertBlockTo(_loc7_);
                           return;
                        }
                     }
                  }
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         ++blockMap[param1];
      }
      
      public function numClickListener(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.target);
         numPressed(numButtons.indexOf(_loc2_));
      }
   }
}
