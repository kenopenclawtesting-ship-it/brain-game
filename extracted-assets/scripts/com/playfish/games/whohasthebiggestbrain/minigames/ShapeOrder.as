package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   
   public class ShapeOrder extends Minigame
   {
      
      internal static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(18);
      
      internal static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-12);
      
      internal static const MAX_PANELS_PER_ROW:int = 7;
      
      internal static const NORMAL_GROUP_INDICES:Array = [0,1,2,3,6];
      
      internal static const SUSHI_GROUP_INDEX:int = 4;
      
      internal static const EASTER_GROUP_INDEX:int = 5;
      
      public static const REVEAL:* = 0;
      
      public static const FULLY_REVEALED:* = 1;
      
      public static const GUESS:* = 2;
       
      
      internal var gameObjectLayer:GameObjectLayer;
      
      internal var revealIndex:int;
      
      internal var skipMessage:MovieClip;
      
      internal var shapeGroupIndex:int;
      
      internal var lastShapeGroupIndex:int = -1;
      
      internal var topPanels:Array;
      
      internal var guessShapes:Array;
      
      internal var numIcons:int;
      
      internal var gameState:int = -1;
      
      internal var numGuessPanels:int;
      
      private const DIFFICULTY_LEVEL_PARAMS:Array = [{
         "numIcons":3,
         "difficultShapes":false,
         "extraChoosePanels":1,
         "speedMutiplyer":1.2
      },{
         "numIcons":3,
         "difficultShapes":false,
         "extraChoosePanels":2,
         "speedMutiplyer":1.4
      },{
         "numIcons":4,
         "difficultShapes":false,
         "extraChoosePanels":1,
         "speedMutiplyer":1.4
      },{
         "numIcons":4,
         "difficultShapes":false,
         "extraChoosePanels":2,
         "speedMutiplyer":1.6
      },{
         "numIcons":5,
         "difficultShapes":false,
         "extraChoosePanels":1,
         "speedMutiplyer":1.6
      },{
         "numIcons":5,
         "difficultShapes":true,
         "extraChoosePanels":2,
         "speedMutiplyer":1.8
      },{
         "numIcons":6,
         "difficultShapes":false,
         "extraChoosePanels":1,
         "speedMutiplyer":1.8
      },{
         "numIcons":6,
         "difficultShapes":false,
         "extraChoosePanels":2,
         "speedMutiplyer":2
      },{
         "numIcons":6,
         "difficultShapes":true,
         "extraChoosePanels":2,
         "speedMutiplyer":2.2
      },{
         "numIcons":7,
         "difficultShapes":false,
         "extraChoosePanels":1,
         "speedMutiplyer":2
      },{
         "numIcons":7,
         "difficultShapes":false,
         "extraChoosePanels":2,
         "speedMutiplyer":2.2
      },{
         "numIcons":7,
         "difficultShapes":true,
         "extraChoosePanels":2,
         "speedMutiplyer":2.4
      },{
         "numIcons":8,
         "difficultShapes":false,
         "extraChoosePanels":1,
         "speedMutiplyer":2.2
      },{
         "numIcons":8,
         "difficultShapes":false,
         "extraChoosePanels":2,
         "speedMutiplyer":2.4
      },{
         "numIcons":8,
         "difficultShapes":true,
         "extraChoosePanels":2,
         "speedMutiplyer":2.6
      }];
      
      internal var totalShapes:int;
      
      internal var curRevealPanel:ShapeOrderPanel;
      
      internal var topPanelWidth:int;
      
      internal var speedMutiplyer:Number = 1;
      
      internal var bottomPanelShapes:Array;
      
      internal var revealTimer:int;
      
      internal var bottomPanels:Array;
      
      internal var correctShapes:Array;
      
      private const HIDE_DELAY_MILLIS:int = 3000;
      
      public function ShapeOrder(param1:MinigameBase)
      {
         super(param1);
         this.container = param1;
         init();
      }
      
      override public function restart() : *
      {
         var _loc8_:* = undefined;
         var _loc11_:int = 0;
         if(gameObjectLayer != null)
         {
            removeChild(gameObjectLayer);
            gameObjectLayer = null;
         }
         gameObjectLayer = new GameObjectLayer();
         addChild(gameObjectLayer);
         curRevealPanel = null;
         topPanels = new Array();
         bottomPanels = new Array();
         bottomPanelShapes = new Array();
         var _loc1_:Object = DIFFICULTY_LEVEL_PARAMS[Math.min(container.getTotalCorrect(),DIFFICULTY_LEVEL_PARAMS.length - 1)];
         var _loc2_:Boolean = Boolean(_loc1_.difficultShapes);
         numIcons = _loc1_.numIcons;
         speedMutiplyer = _loc1_.speedMutiplyer;
         var _loc3_:* = _loc1_.extraChoosePanels;
         var _loc4_:* = new ShapeBox();
         topPanelWidth = _loc4_.width / 2;
         var _loc5_:RandomBasket = new RandomBasket();
         _loc5_.addItemArray(NORMAL_GROUP_INDICES);
         if(GameWorld.ENABLE_EASTER_ITEMS)
         {
            _loc5_.addItems(EASTER_GROUP_INDEX);
         }
         if(_loc2_)
         {
            shapeGroupIndex = SUSHI_GROUP_INDEX;
         }
         else
         {
            _loc5_.removeItems(lastShapeGroupIndex);
            shapeGroupIndex = int(_loc5_.getNextItem());
         }
         lastShapeGroupIndex = shapeGroupIndex;
         var _loc6_:* = Engine.getMovieClip("Shapes" + shapeGroupIndex);
         totalShapes = _loc6_.totalFrames;
         correctShapes = new Array();
         guessShapes = new Array();
         var _loc7_:RandomBasket = new RandomBasket(0,totalShapes);
         if(numIcons > 2)
         {
            _loc8_ = 0;
            while(_loc8_ < totalShapes)
            {
               _loc7_.addItems(_loc8_);
               _loc8_++;
            }
         }
         _loc8_ = 0;
         while(_loc8_ < numIcons)
         {
            _loc11_ = int(_loc7_.getNextItem());
            correctShapes.push(_loc11_);
            if(guessShapes.indexOf(_loc11_) == -1)
            {
               guessShapes.push(_loc11_);
            }
            _loc8_++;
         }
         numGuessPanels = Math.min(MAX_PANELS_PER_ROW,Math.min(totalShapes,correctShapes.length + _loc3_));
         var _loc9_:RandomBasket = new RandomBasket();
         _loc8_ = 0;
         while(_loc8_ < totalShapes)
         {
            if(guessShapes.indexOf(_loc8_) == -1)
            {
               _loc9_.addItems(_loc8_);
            }
            _loc8_++;
         }
         var _loc10_:* = numGuessPanels - guessShapes.length;
         _loc8_ = 0;
         while(_loc8_ < _loc10_)
         {
            guessShapes.push(_loc9_.getNextItem());
            _loc8_++;
         }
         revealTimer = 0;
         revealIndex = 0;
         gameState = REVEAL;
      }
      
      override public function init() : *
      {
         var _loc1_:* = new ShapeScene();
         _loc1_.x = GameWorld.CANVAS_CENTER_X;
         _loc1_.y = GameWorld.CANVAS_CENTER_Y;
         _loc1_.cacheAsBitmap = true;
         addChild(_loc1_);
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:RandomBasket = null;
         var _loc5_:int = 0;
         var _loc6_:ShapeOrderPanel = null;
         if(container.state == MinigameBase.STATE_TIMEUP)
         {
            return;
         }
         if(gameState == REVEAL)
         {
            if(curRevealPanel == null || curRevealPanel.panelState == ShapeOrderPanel.STATE_MOVE_TO_TOP)
            {
               if(revealIndex >= numIcons)
               {
                  revealIndex = 0;
                  revealTimer = HIDE_DELAY_MILLIS;
                  skipMessage = new CardReady();
                  Engine.setFontForLang(skipMessage.pressAnyKeyText.textField,"Baveuse");
                  skipMessage.pressAnyKeyText.textField.text = "PRESS ANY KEY";
                  skipMessage.pressAnyKeyText.textField.mouseEnabled = false;
                  skipMessage.x = GameWorld.CANVAS_CENTER_X;
                  skipMessage.y = GameWorld.CANVAS_CENTER_Y + (GameWorld.CANVAS_HEIGHT - skipMessage.height) / 2;
                  addChild(skipMessage);
                  addEventListener(MouseEvent.MOUSE_DOWN,skipListener,false,0,true);
                  buttonMode = true;
                  gameState = FULLY_REVEALED;
               }
               else
               {
                  revealNextShape(revealIndex,correctShapes[revealIndex]);
                  ++revealIndex;
               }
            }
         }
         else if(gameState == FULLY_REVEALED)
         {
            revealTimer -= param1;
            if(revealTimer <= 0)
            {
               _loc2_ = 0;
               while(_loc2_ < topPanels.length)
               {
                  topPanels[_loc2_].off();
                  _loc2_++;
               }
               _loc3_ = getBottomPanelY();
               trace("num guess shapes=" + guessShapes.length + " numGuessPanels=" + numGuessPanels);
               _loc4_ = new RandomBasket(0,numGuessPanels);
               _loc2_ = 0;
               while(_loc2_ < numGuessPanels)
               {
                  _loc5_ = int(_loc4_.getNextItem());
                  trace("guessShapeIndex=" + _loc5_ + " shapeIndex=" + guessShapes[_loc5_]);
                  _loc6_ = new ShapeOrderPanel(gameObjectLayer,this,ShapeOrderPanel.TYPE_BOTTOM_PANEL,_loc2_,guessShapes[_loc5_]);
                  _loc6_.x = getPanelX(_loc2_,numGuessPanels);
                  _loc6_.y = _loc3_;
                  _loc6_.mainSprite.scaleX = 0.5;
                  _loc6_.mainSprite.scaleY = _loc6_.mainSprite.scaleX;
                  _loc6_.mainSprite.buttonMode = true;
                  setButtonMode(_loc6_.mainSprite.mc,true);
                  _loc6_.mainSprite.addEventListener(MouseEvent.MOUSE_DOWN,guessMouseClickListener);
                  bottomPanelShapes.push(_loc6_.mainSprite);
                  bottomPanels.push(_loc6_);
                  gameObjectLayer.addGameObject(_loc6_);
                  _loc2_++;
               }
               removeEventListener(MouseEvent.MOUSE_DOWN,skipListener);
               buttonMode = false;
               removeChild(skipMessage);
               gameState = GUESS;
            }
         }
         else if(gameState == GUESS)
         {
         }
         gameObjectLayer.tick(param1);
         gameObjectLayer.updateSpritePosition(0,0);
      }
      
      public function getShapeSprite(param1:int, param2:int) : AnimatedSprite
      {
         var _loc3_:AnimatedSprite = new AnimatedSprite("Shapes" + shapeGroupIndex);
         _loc3_.setFrame(param2 + 1);
         _loc3_.numLoops = 0;
         _loc3_.mouseEnabled = false;
         _loc3_.y += _loc3_.height / 2;
         return _loc3_;
      }
      
      public function revealNextShape(param1:int, param2:int) : *
      {
         curRevealPanel = new ShapeOrderPanel(gameObjectLayer,this,ShapeOrderPanel.TYPE_TOP_PANEL,param1,param2);
         curRevealPanel.x = GameWorld.CANVAS_CENTER_X;
         curRevealPanel.y = GameWorld.CANVAS_CENTER_Y + GameWorld.CANVAS_HEIGHT / 10;
         topPanels.push(curRevealPanel);
         gameObjectLayer.addGameObject(curRevealPanel);
      }
      
      override public function timeup() : *
      {
         removeMouseListeners();
      }
      
      public function removeMouseListeners() : *
      {
         var _loc1_:* = undefined;
         if(bottomPanels != null)
         {
            _loc1_ = 0;
            while(_loc1_ < bottomPanels.length)
            {
               setButtonMode(bottomPanels[_loc1_].mainSprite.mc,false);
               bottomPanels[_loc1_].mainSprite.removeEventListener(MouseEvent.MOUSE_DOWN,guessMouseClickListener);
               _loc1_++;
            }
         }
      }
      
      public function getPanelX(param1:int, param2:int) : int
      {
         var _loc3_:* = Math.min((GameWorld.CANVAS_WIDTH - topPanelWidth * param2) / (param2 + 1),topPanelWidth / 4);
         var _loc4_:* = (GameWorld.CANVAS_WIDTH - (topPanelWidth + _loc3_) * param2 + _loc3_) / 2;
         _loc4_ += topPanelWidth / 2;
         return _loc4_ + param1 * (topPanelWidth + _loc3_);
      }
      
      public function skipListener(param1:MouseEvent) : *
      {
         revealTimer = 0;
         if(curRevealPanel != null)
         {
            curRevealPanel.endScale();
         }
      }
      
      public function getTopPanelY() : int
      {
         return GameWorld.CANVAS_CENTER_Y / 2;
      }
      
      public function getBottomPanelY() : int
      {
         return GameWorld.CANVAS_CENTER_Y + GameWorld.CANVAS_HEIGHT / 4;
      }
      
      public function guessMouseClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:* = bottomPanels[bottomPanelShapes.indexOf(param1.currentTarget)].shapeIndex;
         topPanels[revealIndex].on(_loc2_);
         if(!Debug.CHEAT && _loc2_ != correctShapes[revealIndex])
         {
            container.addScore(INCORRECT_SCORE.value);
            container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
            removeMouseListeners();
         }
         else
         {
            container.addScore(CORRECT_SCORE.value);
            ++revealIndex;
            if(revealIndex == numIcons)
            {
               container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               removeMouseListeners();
            }
         }
      }
   }
}
