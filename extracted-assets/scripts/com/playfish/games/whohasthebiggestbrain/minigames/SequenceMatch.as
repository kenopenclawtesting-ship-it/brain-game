package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.GlowFilter;
   import flash.geom.*;
   
   public class SequenceMatch extends Minigame
   {
      
      public static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(40);
      
      public static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-26);
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_CORRECT:int = 1;
      
      public static const SHAPE_GROUP_INDICES:Array = [0,1,2,3,4,6];
      
      private static const SELECTED_FILTER:GlowFilter = new GlowFilter(7386204,1,12,12,16,true,false);
       
      
      public const DIFFICULTY_LEVEL_PARAMS:Array = [{
         "numRows":3,
         "numColumes":2,
         "numSequences":1,
         "sequenceLength":2
      },{
         "numRows":3,
         "numColumes":3,
         "numSequences":1,
         "sequenceLength":2
      },{
         "numRows":3,
         "numColumes":3,
         "numSequences":1,
         "sequenceLength":3
      },{
         "numRows":3,
         "numColumes":3,
         "numSequences":1,
         "sequenceLength":3
      },{
         "numRows":3,
         "numColumes":4,
         "numSequences":1,
         "sequenceLength":3
      },{
         "numRows":3,
         "numColumes":4,
         "numSequences":1,
         "sequenceLength":3
      },{
         "numRows":5,
         "numColumes":4,
         "numSequences":1,
         "sequenceLength":3
      },{
         "numRows":5,
         "numColumes":4,
         "numSequences":1,
         "sequenceLength":3
      },{
         "numRows":5,
         "numColumes":4,
         "numSequences":1,
         "sequenceLength":4
      },{
         "numRows":5,
         "numColumes":4,
         "numSequences":1,
         "sequenceLength":4
      },{
         "numRows":5,
         "numColumes":5,
         "numSequences":2,
         "sequenceLength":3
      },{
         "numRows":5,
         "numColumes":5,
         "numSequences":2,
         "sequenceLength":3
      },{
         "numRows":5,
         "numColumes":6,
         "numSequences":2,
         "sequenceLength":3
      },{
         "numRows":5,
         "numColumes":6,
         "numSequences":2,
         "sequenceLength":3
      },{
         "numRows":5,
         "numColumes":6,
         "numSequences":2,
         "sequenceLength":4
      },{
         "numRows":5,
         "numColumes":6,
         "numSequences":2,
         "sequenceLength":4
      },{
         "numRows":5,
         "numColumes":7,
         "numSequences":2,
         "sequenceLength":4
      },{
         "numRows":5,
         "numColumes":7,
         "numSequences":2,
         "sequenceLength":4
      },{
         "numRows":5,
         "numColumes":7,
         "numSequences":2,
         "sequenceLength":5
      },{
         "numRows":5,
         "numColumes":7,
         "numSequences":2,
         "sequenceLength":5
      },{
         "numRows":5,
         "numColumes":7,
         "numSequences":3,
         "sequenceLength":4
      },{
         "numRows":7,
         "numColumes":7,
         "numSequences":3,
         "sequenceLength":4
      },{
         "numRows":7,
         "numColumes":7,
         "numSequences":3,
         "sequenceLength":4
      },{
         "numRows":7,
         "numColumes":8,
         "numSequences":3,
         "sequenceLength":4
      },{
         "numRows":7,
         "numColumes":8,
         "numSequences":3,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":8,
         "numSequences":3,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":9,
         "numSequences":3,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":9,
         "numSequences":3,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":3,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":3,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":4,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":4,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":4,
         "sequenceLength":5
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":4,
         "sequenceLength":6
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":4,
         "sequenceLength":6
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":4,
         "sequenceLength":6
      },{
         "numRows":7,
         "numColumes":10,
         "numSequences":4,
         "sequenceLength":6
      }];
      
      public var arrows:Array;
      
      public var sequenceLayer:Sprite;
      
      public var hexagonLayer:Sprite;
      
      public var paintLayer:Sprite;
      
      public var sequencePanels:Array;
      
      public var state:int = 0;
      
      public var hexagons:Array;
      
      public var curSequence:Array;
      
      public var completeSequencePanels:Array;
      
      public var hexYOffset:int = 49;
      
      public var gameScene:MovieClip;
      
      public var finalSequences:Array;
      
      public function SequenceMatch(param1:MinigameBase)
      {
         this.curSequence = new Array();
         super(param1);
      }
      
      public function hexClickListener(e:MouseEvent) : void
      {
         var target:MovieClip = MovieClip(e.currentTarget);
         Engine.playSound("ButtonInGame",1);
         if(curSequence.length > 0 && target == curSequence[curSequence.length - 1])
         {
            curSequence.pop();
            target.gotoAndStop(1);
            target.hexagon.gotoAndStop(target.shapeIndex + 1);
            target.hexagon.addChild(target.shape);
            target.filters = [];
            target.mouseEnabled = true;
            updateLines();
            return;
         }
         if(curSequence.length > 1 && target == curSequence[0])
         {
            resetCurSequence();
            updateLines();
            return;
         }
         if(curSequence.length == 0)
         {
            curSequence = [];
            addHexagonToCurSequence(target);
            return;
         }
         if(curSequence.length >= 2 && target == curSequence[curSequence.length - 2])
         {
            var last:MovieClip = curSequence.pop();
            last.gotoAndStop(1);
            last.hexagon.gotoAndStop(last.shapeIndex + 1);
            last.hexagon.addChild(last.shape);
            last.filters = [];
            last.mouseEnabled = true;
            updateLines();
            return;
         }
         if(curSequence.indexOf(target) == -1 && isAdjacent(curSequence[curSequence.length - 1],target))
         {
            addHexagonToCurSequence(target);
            updateLines();
            if(targetSequenceLengthReached())
            {
               if(checkForMatch())
               {
                  return;
               }
               container.addScore(INCORRECT_SCORE.value);
               container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
               resetCurSequence();
               updateLines();
               return;
            }
         }
         else if(curSequence.indexOf(target) == -1 && !isAdjacent(curSequence[curSequence.length - 1],target))
         {
            resetCurSequence();
            addHexagonToCurSequence(target);
            updateLines();
         }
      }
      
      private function targetSequenceLengthReached() : Boolean
      {
         for each(var seq in finalSequences)
         {
            if(seq.length == curSequence.length)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isAdjacent(a:MovieClip, b:MovieClip) : Boolean
      {
         var dx:Number = Math.abs(b.x - a.x);
         var dy:Number = Math.abs(b.y - a.y);
         var maxDX:Number = a.width * 1.1;
         var maxDY:Number = hexYOffset * 1.1;
         if(dx > maxDX || dy > maxDY)
         {
            return false;
         }
         var distance:Number = Math.sqrt(dx * dx + dy * dy);
         var minDist:Number = a.width * 0.5;
         var maxDist:Number = a.width * 1.5;
         return distance >= minDist && distance <= maxDist;
      }
      
      override public function restart() : *
      {
         var _loc9_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:* = undefined;
         var _loc18_:int = 0;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:MovieClip = null;
         var _loc23_:* = undefined;
         var _loc24_:Array = null;
         var _loc25_:* = undefined;
         var _loc26_:Array = null;
         var _loc27_:int = 0;
         if(hexagonLayer != null)
         {
            gameScene.removeChild(hexagonLayer);
         }
         hexagonLayer = new Sprite();
         gameScene.addChild(hexagonLayer);
         arrows = new Array();
         var _loc1_:Object = DIFFICULTY_LEVEL_PARAMS[Math.min(container.getTotalCorrect(),DIFFICULTY_LEVEL_PARAMS.length - 1)];
         var _loc2_:int = int(_loc1_.numRows);
         var _loc3_:int = _loc1_.numColumes - Math.floor(_loc2_ / 2);
         var _loc4_:int = int(_loc1_.numSequences);
         var _loc5_:int = int(_loc1_.sequenceLength);
         var _loc6_:MovieClip = new HexagonPieces();
         var _loc7_:* = _loc6_.width;
         var _loc8_:* = _loc6_.height;
         _loc6_ = null;
         hexagons = new Array();
         _loc9_ = new Array();
         var _loc10_:int = 0;
         _loc11_ = 0;
         _loc12_ = 0;
         while(_loc12_ < _loc2_)
         {
            _loc18_ = Math.floor(_loc2_ / 2);
            _loc19_ = _loc12_;
            _loc20_ = 0;
            if(_loc12_ > _loc18_)
            {
               _loc19_ = _loc2_ - 1 - _loc12_;
               _loc20_ = _loc12_ - _loc18_;
            }
            _loc10_ = -_loc19_ * _loc7_ / 2;
            _loc9_[_loc12_] = new Array();
            _loc21_ = 0;
            while(_loc21_ < _loc20_ + _loc3_ + _loc19_)
            {
               if(_loc21_ < _loc20_)
               {
                  _loc9_[_loc12_][_loc21_] = null;
               }
               else
               {
                  _loc6_ = new HexagonButton();
                  _loc6_.stop();
                  _loc6_.x = _loc10_;
                  _loc6_.y = _loc11_;
                  _loc6_.row = _loc12_;
                  _loc6_.colume = _loc21_;
                  _loc10_ += _loc7_;
                  hexagonLayer.addChild(_loc6_);
                  hexagons.push(_loc6_);
                  _loc9_[_loc12_][_loc21_] = _loc6_;
               }
               _loc21_++;
            }
            _loc11_ += hexYOffset;
            _loc12_++;
         }
         var _loc13_:* = SHAPE_GROUP_INDICES[Engine.rnd(0,SHAPE_GROUP_INDICES.length)];
         _loc12_ = 0;
         while(_loc12_ < hexagons.length)
         {
            setButtonMode(hexagons[_loc12_],true);
            _loc22_ = Engine.getMovieClip("Shapes" + _loc13_);
            _loc23_ = Engine.rnd(0,_loc22_.totalFrames);
            _loc22_.gotoAndStop(_loc23_ + 1);
            _loc22_.scaleY = 0.5;
            _loc22_.scaleX = _loc22_.scaleY;
            _loc22_.y = _loc22_.height / 2;
            hexagons[_loc12_].shape = _loc22_;
            hexagons[_loc12_].hexagon.gotoAndStop(_loc23_ + 1);
            hexagons[_loc12_].shapeIndex = _loc23_;
            hexagons[_loc12_].addEventListener(MouseEvent.MOUSE_DOWN,hexClickListener,false,0,true);
            hexagons[_loc12_].hexagon.addChild(_loc22_);
            _loc12_++;
         }
         finalSequences = new Array();
         var _loc14_:* = 0;
         while(_loc14_ < _loc4_)
         {
            finalSequences[_loc14_] = new Array();
            _loc24_ = new Array();
            _loc24_[0] = new RandomBasket();
            _loc24_[0].addItemArray(hexagons);
            _loc12_ = 0;
            while(_loc12_ < _loc5_)
            {
               _loc25_ = _loc24_[_loc12_].getNextItem();
               finalSequences[_loc14_].push(_loc25_);
               _loc26_ = getAdjacentHexagons(_loc25_,_loc9_,finalSequences[_loc14_]);
               if(_loc26_.length == 0)
               {
                  finalSequences[_loc14_].splice(finalSequences[_loc14_].length - 1,1);
                  _loc12_--;
               }
               else
               {
                  _loc24_[_loc12_ + 1] = new RandomBasket();
                  _loc24_[_loc12_ + 1].addItemArray(_loc26_);
               }
               _loc12_++;
            }
            _loc14_++;
         }
         if(sequenceLayer != null)
         {
            gameScene.removeChild(sequenceLayer);
         }
         sequenceLayer = new Sprite();
         gameScene.addChild(sequenceLayer);
         completeSequencePanels = new Array();
         sequencePanels = new Array();
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         _loc12_ = 0;
         while(_loc12_ < finalSequences.length)
         {
            if(_loc12_ % 2 == 0)
            {
               _loc15_ = 0;
            }
            sequencePanels[_loc12_] = new Sprite();
            sequencePanels[_loc12_].x = _loc15_;
            sequencePanels[_loc12_].y = Math.floor(_loc12_ / 2) * (_loc8_ + 10);
            sequenceLayer.addChild(sequencePanels[_loc12_]);
            _loc27_ = 0;
            _loc21_ = 0;
            while(_loc21_ < finalSequences[_loc12_].length)
            {
               _loc6_ = new HexagonPieces();
               _loc6_.stop();
               _loc6_.gotoAndStop(finalSequences[_loc12_][_loc21_].shapeIndex + 1);
               _loc22_ = Engine.getMovieClip("Shapes" + _loc13_);
               _loc22_.gotoAndStop(finalSequences[_loc12_][_loc21_].shapeIndex + 1);
               _loc22_.scaleY = 0.5;
               _loc22_.scaleX = _loc22_.scaleY;
               _loc22_.y = _loc22_.height / 2;
               _loc6_.addChild(_loc22_);
               _loc6_.x = _loc27_;
               sequencePanels[_loc12_].addChild(_loc6_);
               _loc27_ += _loc6_.width;
               _loc21_++;
            }
            _loc15_ += sequencePanels[_loc12_].width + 30;
            _loc12_++;
         }
         if(sequenceLayer.width > GameWorld.CANVAS_WIDTH)
         {
            sequenceLayer.width = GameWorld.CANVAS_WIDTH;
         }
         sequenceLayer.scaleY = sequenceLayer.scaleX;
         var _loc17_:Rectangle = sequenceLayer.getBounds(gameScene);
         sequenceLayer.x = -sequenceLayer.width / 2 - _loc17_.left;
         sequenceLayer.y = GameWorld.CANVAS_HEIGHT / 2 - sequenceLayer.height - _loc17_.top;
         _loc17_ = hexagonLayer.getBounds(gameScene);
         hexagonLayer.x = -_loc17_.left - hexagonLayer.width / 2;
         hexagonLayer.y = -_loc17_.top - GameWorld.CANVAS_HEIGHT / 2 + (GameWorld.CANVAS_HEIGHT - sequenceLayer.height - hexagonLayer.height) / 2;
         paintLayer = new Sprite();
         hexagonLayer.addChild(paintLayer);
         hexagonLayer.alpha = 0.1;
         sequenceLayer.alpha = 0.1;
      }
      
      override public function tick(param1:uint) : *
      {
         if(hexagonLayer.alpha < 1)
         {
            hexagonLayer.alpha = Math.min(1,hexagonLayer.alpha + 0.1);
            sequenceLayer.alpha = Math.min(1,sequenceLayer.alpha + 0.1);
         }
         var _loc2_:* = 0;
         while(_loc2_ < completeSequencePanels.length)
         {
            completeSequencePanels[_loc2_].alpha = Math.max(0,completeSequencePanels[_loc2_].alpha - 0.1);
            _loc2_++;
         }
      }
      
      override public function init() : *
      {
         gameScene = new SequenceMatchScene();
         gameScene.x = GameWorld.CANVAS_CENTER_X;
         gameScene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(gameScene);
      }
      
      public function hexOverListener(param1:MouseEvent) : *
      {
         var _loc2_:* = false;
         if(param1.buttonDown)
         {
            if(curSequence.length >= 2 && param1.currentTarget == curSequence[curSequence.length - 2])
            {
               curSequence[curSequence.length - 1].gotoAndStop(1);
               curSequence[curSequence.length - 1].hexagon.gotoAndStop(curSequence[curSequence.length - 1].shapeIndex + 1);
               curSequence[curSequence.length - 1].hexagon.addChild(curSequence[curSequence.length - 1].shape);
               curSequence.pop();
               hexagonLayer.removeChild(MovieClip(param1.currentTarget));
               hexagonLayer.addChild(MovieClip(param1.currentTarget));
               updateLines();
            }
            else if(curSequence.length > 0)
            {
               _loc2_ = curSequence.indexOf(param1.currentTarget) != -1;
               if(!_loc2_ && isAdjacent(curSequence[curSequence.length - 1],MovieClip(param1.currentTarget)))
               {
                  Engine.playSound("ButtonInGame",1);
                  addHexagonToCurSequence(MovieClip(param1.currentTarget));
                  updateLines();
                  checkForMatch();
               }
            }
         }
      }
      
      public function checkForMatch() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:Boolean = false;
         var _loc4_:* = undefined;
         var _loc5_:Boolean = false;
         var _loc6_:Rectangle = null;
         var _loc1_:* = 0;
         while(true)
         {
            if(_loc1_ >= finalSequences.length)
            {
               return false;
            }
            _loc2_ = finalSequences[_loc1_];
            if(_loc2_.length == curSequence.length)
            {
               _loc3_ = true;
               _loc4_ = 0;
               while(_loc4_ < curSequence.length)
               {
                  if(curSequence[_loc4_].shapeIndex != _loc2_[_loc4_].shapeIndex)
                  {
                     _loc3_ = false;
                     break;
                  }
                  _loc4_++;
               }
               if(!_loc3_)
               {
                  _loc3_ = true;
                  _loc4_ = 0;
                  while(_loc4_ < curSequence.length)
                  {
                     if(curSequence[curSequence.length - 1 - _loc4_].shapeIndex != _loc2_[_loc4_].shapeIndex)
                     {
                        _loc3_ = false;
                        break;
                     }
                     _loc4_++;
                  }
               }
               if(_loc3_)
               {
                  break;
               }
            }
            _loc1_++;
         }
         state = STATE_CORRECT;
         _loc5_ = false;
         if(finalSequences.length <= 1)
         {
            _loc5_ = true;
            removeAllMosueListeners();
         }
         _loc6_ = sequencePanels[_loc1_].getBounds(this);
         container.addScore(CORRECT_SCORE.value);
         container.correct(_loc5_,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
         completeSequencePanels.push(sequencePanels[_loc1_]);
         finalSequences.splice(_loc1_,1);
         sequencePanels.splice(_loc1_,1);
         resetCurSequence();
         updateLines();
         return true;
      }
      
      public function hexMouseUpListener(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         if(curSequence.length != finalSequences[0].length)
         {
            _loc2_ = 0;
            while(_loc2_ < curSequence.length)
            {
               curSequence[_loc2_].gotoAndStop(1);
               _loc2_++;
            }
            resetCurSequence();
            updateLines();
         }
         else
         {
            if(curSequence.length == finalSequences[0].length)
            {
               if(checkForMatch())
               {
                  return;
               }
            }
            container.addScore(INCORRECT_SCORE.value);
            container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
            resetCurSequence();
            updateLines();
         }
      }
      
      public function resetCurSequence() : void
      {
         var i:int = 0;
         while(i < curSequence.length)
         {
            var h:MovieClip = curSequence[i];
            h.gotoAndStop(1);
            h.hexagon.gotoAndStop(h.shapeIndex + 1);
            h.hexagon.addChild(h.shape);
            h.filters = [];
            h.mouseEnabled = true;
            i++;
         }
         curSequence = new Array();
      }
      
      public function getAdjacentHexagons(param1:MovieClip, param2:Array, param3:Array) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:Array = new Array();
         if(param1.row > 0)
         {
            if(param2[param1.row - 1][param1.colume - 1] != null)
            {
               trace("add top left");
               _loc4_.push(param2[param1.row - 1][param1.colume - 1]);
            }
            if(param2[param1.row - 1][param1.colume] != null)
            {
               trace("add top right");
               _loc4_.push(param2[param1.row - 1][param1.colume]);
            }
         }
         if(param1.row < param2.length - 1)
         {
            if(param2[param1.row + 1][param1.colume] != null)
            {
               trace("add bottom left");
               _loc4_.push(param2[param1.row + 1][param1.colume]);
            }
            if(param2[param1.row + 1][param1.colume + 1] != null)
            {
               trace("add bottom right");
               _loc4_.push(param2[param1.row + 1][param1.colume + 1]);
            }
         }
         if(param2[param1.row][param1.colume - 1] != null)
         {
            trace("add left");
            _loc4_.push(param2[param1.row][param1.colume - 1]);
         }
         if(param2[param1.row][param1.colume + 1] != null)
         {
            trace("add right");
            _loc4_.push(param2[param1.row][param1.colume + 1]);
         }
         var _loc5_:* = 0;
         while(_loc5_ < param3.length)
         {
            _loc6_ = int(_loc4_.indexOf(param3[_loc5_]));
            if(_loc6_ != -1)
            {
               _loc4_.splice(_loc6_,1);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function addHexagonToCurSequence(param1:MovieClip) : *
      {
         curSequence.push(param1);
         param1.gotoAndStop(2);
         param1.hexagon.gotoAndStop("selected");
         param1.filters = [SELECTED_FILTER];
         param1.hexagon.addChild(param1.shape);
         hexagonLayer.removeChild(param1);
         hexagonLayer.addChild(param1);
      }
      
      override public function timeup() : *
      {
         removeAllMosueListeners();
         curSequence = new Array();
         updateLines();
      }
      
      public function updateLines() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         _loc1_ = 0;
         while(_loc1_ < arrows.length)
         {
            hexagonLayer.removeChild(arrows[_loc1_]);
            _loc1_++;
         }
         arrows = new Array();
         if(curSequence.length > 0)
         {
            _loc1_ = 1;
            while(_loc1_ < curSequence.length)
            {
               _loc2_ = new SequenceArrow();
               _loc2_.x = curSequence[_loc1_ - 1].x;
               _loc2_.y = curSequence[_loc1_ - 1].y;
               _loc3_ = -Engine.getAngle(curSequence[_loc1_ - 1].x,curSequence[_loc1_ - 1].y,curSequence[_loc1_].x,curSequence[_loc1_].y) * 180 / Math.PI;
               _loc2_.rotation = _loc3_;
               _loc2_.mouseEnabled = false;
               _loc2_.mouseChildren = false;
               hexagonLayer.addChild(_loc2_);
               arrows.push(_loc2_);
               _loc1_++;
            }
         }
      }
      
      public function removeAllMosueListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < hexagons.length)
         {
            setButtonMode(hexagons[_loc1_],false);
            hexagons[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,hexClickListener);
            hexagons[_loc1_].removeEventListener(MouseEvent.MOUSE_OVER,hexOverListener);
            _loc1_++;
         }
         removeEventListener(MouseEvent.MOUSE_UP,hexMouseUpListener);
      }
   }
}
