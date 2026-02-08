package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CarPath extends Minigame
   {
       
      
      internal var crossPathWidth:Array;
      
      internal var allEndPoints:Array;
      
      private const DIFFICULTY_LEVEL_PARAMS:Array = [{
         "numCars":1,
         "numPath":2,
         "numCrossPath":2,
         "maxCrossPathWidth":2,
         "pathSegments":2
      },{
         "numCars":1,
         "numPath":3,
         "numCrossPath":2,
         "maxCrossPathWidth":1,
         "pathSegments":2
      },{
         "numCars":1,
         "numPath":3,
         "numCrossPath":3,
         "maxCrossPathWidth":2,
         "pathSegments":2
      },{
         "numCars":1,
         "numPath":3,
         "numCrossPath":3,
         "maxCrossPathWidth":1,
         "pathSegments":2
      },{
         "numCars":1,
         "numPath":4,
         "numCrossPath":4,
         "maxCrossPathWidth":2,
         "pathSegments":2
      },{
         "numCars":1,
         "numPath":4,
         "numCrossPath":5,
         "maxCrossPathWidth":1,
         "pathSegments":2
      },{
         "numCars":1,
         "numPath":4,
         "numCrossPath":5,
         "maxCrossPathWidth":2,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":4,
         "numCrossPath":5,
         "maxCrossPathWidth":1,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":4,
         "numCrossPath":5,
         "maxCrossPathWidth":2,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":5,
         "numCrossPath":6,
         "maxCrossPathWidth":1,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":5,
         "numCrossPath":7,
         "maxCrossPathWidth":2,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":5,
         "numCrossPath":8,
         "maxCrossPathWidth":1,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":5,
         "numCrossPath":9,
         "maxCrossPathWidth":3,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":5,
         "numCrossPath":9,
         "maxCrossPathWidth":2,
         "pathSegments":2
      },{
         "numCars":2,
         "numPath":6,
         "numCrossPath":9,
         "maxCrossPathWidth":3,
         "pathSegments":3
      },{
         "numCars":3,
         "numPath":6,
         "numCrossPath":9,
         "maxCrossPathWidth":2,
         "pathSegments":3
      },{
         "numCars":3,
         "numPath":6,
         "numCrossPath":10,
         "maxCrossPathWidth":3,
         "pathSegments":3
      },{
         "numCars":3,
         "numPath":6,
         "numCrossPath":10,
         "maxCrossPathWidth":2,
         "pathSegments":3
      },{
         "numCars":3,
         "numPath":7,
         "numCrossPath":10,
         "maxCrossPathWidth":3,
         "pathSegments":3
      },{
         "numCars":3,
         "numPath":7,
         "numCrossPath":11,
         "maxCrossPathWidth":2,
         "pathSegments":3
      },{
         "numCars":3,
         "numPath":7,
         "numCrossPath":11,
         "maxCrossPathWidth":3,
         "pathSegments":4
      },{
         "numCars":3,
         "numPath":7,
         "numCrossPath":12,
         "maxCrossPathWidth":2,
         "pathSegments":4
      },{
         "numCars":3,
         "numPath":7,
         "numCrossPath":12,
         "maxCrossPathWidth":3,
         "pathSegments":4
      },{
         "numCars":4,
         "numPath":8,
         "numCrossPath":12,
         "maxCrossPathWidth":2,
         "pathSegments":4
      },{
         "numCars":4,
         "numPath":8,
         "numCrossPath":13,
         "maxCrossPathWidth":4,
         "pathSegments":4
      },{
         "numCars":4,
         "numPath":8,
         "numCrossPath":14,
         "maxCrossPathWidth":3,
         "pathSegments":4
      },{
         "numCars":4,
         "numPath":8,
         "numCrossPath":15,
         "maxCrossPathWidth":4,
         "pathSegments":4
      },{
         "numCars":4,
         "numPath":8,
         "numCrossPath":16,
         "maxCrossPathWidth":3,
         "pathSegments":4
      }];
      
      internal var numSegments:int;
      
      internal var numPath:int;
      
      internal var crossPath:Array;
      
      internal var correctEndPoint:Array;
      
      internal var roadLayer:Sprite;
      
      internal var pathSegmentLength:int = 5;
      
      internal var cars:Array;
      
      internal var carPath:Array;
      
      internal var driveCar:Array;
      
      internal var tileHeight:int = 25;
      
      internal const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-17);
      
      internal var carPathIndex:Array;
      
      internal var gameScene:MovieClip;
      
      internal const CORRECT_SCORE:ProtectedInt = new ProtectedInt(26);
      
      internal var tileWidth:int = 50;
      
      public function CarPath(param1:MinigameBase)
      {
         super(param1);
      }
      
      public function getY(param1:int, param2:int) : *
      {
         return (param1 + param2) * tileHeight / 2;
      }
      
      public function getPath(param1:int) : Array
      {
         var _loc6_:* = undefined;
         var _loc2_:Array = new Array();
         var _loc3_:int = getRowOfPath(param1);
         var _loc4_:int = 0;
         var _loc5_:int = param1;
         do
         {
            _loc2_.push({
               "row":_loc3_,
               "colume":_loc4_
            });
            if(_loc5_ > 0 && crossPath[_loc5_ - 1][_loc4_] == 1)
            {
               _loc6_ = 0;
               while(_loc6_ < crossPathWidth[_loc5_ - 1] + 1)
               {
                  _loc3_--;
                  _loc2_.push({
                     "row":_loc3_,
                     "colume":_loc4_
                  });
                  _loc6_++;
               }
               _loc4_ += 1;
               _loc5_--;
            }
            else if(_loc5_ < crossPath.length && crossPath[_loc5_][_loc4_] == 1)
            {
               _loc6_ = 0;
               while(_loc6_ < crossPathWidth[_loc5_] + 1)
               {
                  _loc3_++;
                  _loc2_.push({
                     "row":_loc3_,
                     "colume":_loc4_
                  });
                  _loc6_++;
               }
               _loc4_ += 1;
               _loc5_++;
            }
            else
            {
               _loc4_ += 1;
            }
         }
         while(_loc4_ < numSegments * pathSegmentLength);
         
         return _loc2_;
      }
      
      override public function restart() : *
      {
         var _loc6_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:RandomBasket = null;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:MovieClip = null;
         var _loc18_:int = 0;
         var _loc19_:MovieClip = null;
         var _loc20_:int = 0;
         var _loc21_:* = undefined;
         var _loc22_:MovieClip = null;
         var _loc23_:MovieClip = null;
         var _loc24_:RandomBasket = null;
         var _loc25_:int = 0;
         var _loc26_:Array = null;
         var _loc27_:Boolean = false;
         if(roadLayer != null)
         {
            gameScene.removeChild(roadLayer);
         }
         roadLayer = new Sprite();
         roadLayer.cacheAsBitmap = true;
         gameScene.addChild(roadLayer);
         var _loc1_:Object = DIFFICULTY_LEVEL_PARAMS[Math.min(container.getTotalCorrect(),DIFFICULTY_LEVEL_PARAMS.length - 1)];
         var _loc2_:int = int(_loc1_.numCars);
         var _loc3_:int = int(_loc1_.maxCrossPathWidth);
         var _loc4_:int = int(_loc1_.numPath);
         numSegments = _loc1_.pathSegments;
         var _loc5_:int = int(_loc1_.numCrossPath);
         crossPath = new Array();
         crossPathWidth = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc4_ - 1)
         {
            crossPath[_loc6_] = new Array();
            crossPath[_loc6_].count = 0;
            _loc10_ = 0;
            while(_loc10_ < numSegments * pathSegmentLength)
            {
               crossPath[_loc6_][_loc10_] = 0;
               _loc10_++;
            }
            crossPathWidth[_loc6_] = Engine.rnd(1,_loc3_ + 1);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc12_ = new RandomBasket();
            _loc10_ = 0;
            while(_loc10_ < _loc4_ - 1)
            {
               if(crossPath[_loc10_].count == 0)
               {
                  _loc12_.addItems(_loc10_);
               }
               _loc10_++;
            }
            if(_loc12_.length() > 0)
            {
               _loc11_ = int(_loc12_.getNextItem());
            }
            else
            {
               _loc11_ = Engine.rnd(0,_loc4_ - 1);
            }
            _loc13_ = Engine.rnd(1,numSegments * pathSegmentLength - 1);
            _loc14_ = _loc11_ == 0 || crossPath[_loc11_ - 1][_loc13_] != 1;
            _loc15_ = _loc11_ == crossPath.length - 1 || crossPath[_loc11_ + 1][_loc13_] != 1;
            _loc16_ = crossPath[_loc11_][_loc13_] == 0 && (_loc13_ == 0 || crossPath[_loc11_][_loc13_ - 1] == 0) && (_loc13_ == crossPath[_loc11_].length - 1 || crossPath[_loc11_][_loc13_ + 1] == 0);
            if(_loc14_ && _loc15_ && _loc16_)
            {
               crossPath[_loc11_][_loc13_] = 1;
               ++crossPath[_loc11_].count;
            }
            else
            {
               _loc6_--;
            }
            _loc6_++;
         }
         allEndPoints = new Array();
         var _loc7_:Array = new Array();
         var _loc8_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc10_ = 0;
            while(_loc10_ < numSegments)
            {
               _loc19_ = new RoadLong();
               _loc20_ = _loc10_ * pathSegmentLength;
               _loc19_.x = getX(_loc8_,_loc20_);
               _loc19_.y = getY(_loc8_,_loc20_);
               roadLayer.addChild(_loc19_);
               _loc10_++;
            }
            _loc17_ = new EndUp();
            _loc18_ = numSegments * pathSegmentLength;
            _loc17_.content.numTextField.text = _loc4_ - _loc6_;
            _loc17_.content.numTextField.mouseEnabled = false;
            _loc17_.x = getX(_loc8_,_loc18_) + tileWidth / 2;
            _loc17_.y = getY(_loc8_,_loc18_) + tileHeight / 2;
            setButtonMode(_loc17_,true);
            roadLayer.addChild(_loc17_);
            _loc7_[_loc8_] = _loc17_;
            allEndPoints.push(_loc17_);
            _loc17_.addEventListener(MouseEvent.MOUSE_DOWN,endPointClickListener,false,0,true);
            _loc8_++;
            if(crossPath[_loc6_] != null)
            {
               _loc21_ = 0;
               while(_loc21_ < crossPathWidth[_loc6_])
               {
                  _loc10_ = 0;
                  while(_loc10_ < crossPath[_loc6_].length)
                  {
                     if(crossPath[_loc6_][_loc10_] == 1)
                     {
                        _loc22_ = new RoadShort();
                        _loc22_.x = getX(_loc8_,_loc10_);
                        _loc22_.y = getY(_loc8_,_loc10_);
                        roadLayer.addChild(_loc22_);
                     }
                     _loc10_++;
                  }
                  _loc8_++;
                  _loc21_++;
               }
            }
            _loc6_++;
         }
         if(roadLayer.width > GameWorld.CANVAS_WIDTH)
         {
            roadLayer.width = GameWorld.CANVAS_WIDTH;
            roadLayer.scaleY = roadLayer.scaleX;
         }
         var _loc9_:Rectangle = roadLayer.getBounds(gameScene);
         roadLayer.x = -_loc9_.left - roadLayer.width / 2;
         roadLayer.y = -_loc9_.top - roadLayer.height / 2;
         driveCar = new Array();
         carPath = new Array();
         carPathIndex = new Array();
         cars = new Array();
         correctEndPoint = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc23_ = new Car();
            _loc23_.stop();
            roadLayer.addChild(_loc23_);
            cars.push(_loc23_);
            driveCar[_loc6_] = false;
            carPathIndex[_loc6_] = 0;
            _loc24_ = new RandomBasket(0,_loc4_);
            do
            {
               _loc25_ = int(_loc24_.getNextItem());
               _loc26_ = getPath(_loc25_);
               _loc27_ = false;
               _loc10_ = 0;
               while(_loc10_ < carPath.length)
               {
                  if(carPath[_loc10_][carPath[_loc10_].length - 1].row == _loc26_[_loc26_.length - 1].row)
                  {
                     _loc27_ = true;
                     break;
                  }
                  _loc10_++;
               }
            }
            while(_loc27_);
            
            carPath.push(_loc26_);
            correctEndPoint.push(_loc7_[_loc26_[_loc26_.length - 1].row]);
            _loc23_.x = getX(_loc26_[0].row,_loc26_[0].colume) + tileWidth / 2;
            _loc23_.y = getY(_loc26_[0].row,_loc26_[0].colume) + tileHeight / 2;
            _loc6_++;
         }
      }
      
      override public function init() : *
      {
         gameScene = new CarPathScene();
         gameScene.x = GameWorld.CANVAS_CENTER_X;
         gameScene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(gameScene);
      }
      
      public function getX(param1:int, param2:int) : *
      {
         return (-param1 + param2) * tileWidth / 2;
      }
      
      public function clickEndPoint(param1:MovieClip) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:int = int(correctEndPoint.indexOf(param1));
         if(_loc2_ != -1)
         {
            if(!driveCar[_loc2_])
            {
               driveCar[_loc2_] = true;
               container.addScore(CORRECT_SCORE.value);
               if(driveCar.indexOf(false) == -1)
               {
                  removeAllMouseListeners();
                  container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               }
               else
               {
                  param1.removeEventListener(MouseEvent.MOUSE_DOWN,endPointClickListener);
               }
               setButtonMode(param1,false);
               param1.content.visible = false;
               var icon:* = new EndUpCorrect();
               icon.x = param1.width / 2 - icon.width / 2;
               icon.y = param1.height / 2 - icon.height / 2;
               icon.mouseEnabled = false;
               icon.mouseChildren = false;
               param1.addChild(icon);
            }
         }
         else
         {
            removeAllMouseListeners();
            container.addScore(INCORRECT_SCORE.value);
            container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
            setButtonMode(param1,false);
            icon = new EndUpWrong();
            icon.x = param1.width / 2 - icon.width / 2;
            icon.y = param1.height / 2 - icon.height / 2;
            icon.mouseEnabled = false;
            icon.mouseChildren = false;
            param1.addChild(icon);
         }
      }
      
      override public function keyDown(param1:int, param2:int) : *
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(container.state == MinigameBase.STATE_NORMAL)
         {
            _loc3_ = param2 - "0".charCodeAt(0);
            _loc4_ = allEndPoints.length - _loc3_;
            if(_loc4_ >= 0 && _loc4_ < allEndPoints.length)
            {
               clickEndPoint(allEndPoints[_loc4_]);
            }
         }
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = 0;
         while(_loc2_ < driveCar.length)
         {
            if(Boolean(driveCar[_loc2_]) && carPathIndex[_loc2_] < carPath[_loc2_].length - 1)
            {
               _loc3_ = carPathIndex[_loc2_];
               ++carPathIndex[_loc2_];
               _loc4_ = int(carPath[_loc2_][carPathIndex[_loc2_]].row);
               _loc5_ = int(carPath[_loc2_][carPathIndex[_loc2_]].colume);
               cars[_loc2_].x = getX(_loc4_,_loc5_) + tileWidth / 2;
               cars[_loc2_].y = getY(_loc4_,_loc5_) + tileHeight / 2;
               if(carPath[_loc2_][_loc3_].row < _loc4_)
               {
                  cars[_loc2_].gotoAndStop(2);
               }
               else if(carPath[_loc2_][_loc3_].row > _loc4_)
               {
                  cars[_loc2_].gotoAndStop(3);
               }
               else
               {
                  cars[_loc2_].gotoAndStop(1);
               }
            }
            _loc2_++;
         }
      }
      
      public function getRowOfPath(param1:int) : int
      {
         var _loc2_:int = param1;
         var _loc3_:* = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += crossPathWidth[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function endPointClickListener(param1:MouseEvent) : *
      {
         if(container.state == MinigameBase.STATE_NORMAL)
         {
            clickEndPoint(MovieClip(param1.currentTarget));
         }
         stage.focus = container;
      }
      
      override public function timeup() : *
      {
         removeAllMouseListeners();
      }
      
      public function removeAllMouseListeners() : *
      {
         var _loc1_:* = undefined;
         if(allEndPoints != null)
         {
            _loc1_ = 0;
            while(_loc1_ < allEndPoints.length)
            {
               setButtonMode(allEndPoints[_loc1_],false);
               allEndPoints[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,endPointClickListener);
               _loc1_++;
            }
         }
      }
   }
}
