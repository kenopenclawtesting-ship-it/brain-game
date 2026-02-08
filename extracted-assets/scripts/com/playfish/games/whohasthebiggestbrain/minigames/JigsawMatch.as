package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class JigsawMatch extends Minigame
   {
      
      public static const CORRECT_SCORE:ProtectedInt = new ProtectedInt(19);
      
      public static const INCORRECT_SCORE:ProtectedInt = new ProtectedInt(-13);
       
      
      internal var numGamesPlayed:int;
      
      internal var puzzlePieceSides:Array;
      
      internal const PUZZLE_PIECE_HEIGHT:int = 60;
      
      internal var puzzlePieces:Array;
      
      internal const ROTATION_180:int = 2;
      
      internal var correctPuzzlePieces:Array;
      
      internal var puzzlePiecesToChoose:Array;
      
      internal var correctPuzzlePiecesMask:Array;
      
      internal const JIGSAW_PIECE_SIDE:Array = new Array(new Array(0,1,1,0),new Array(0,-1,-1,0),new Array(0,-1,1,0),new Array(1,1,1,0),new Array(-1,-1,-1,0),new Array(-1,1,-1,0),new Array(1,-1,1,0),new Array(1,-1,-1,0),new Array(1,1,-1,0),new Array(1,1,1,1),new Array(1,-1,1,1),new Array(1,-1,-1,1),new Array(-1,-1,-1,1),new Array(-1,1,-1,1),new Array(-1,-1,-1,-1));
      
      internal var puzzleBoard:Sprite;
      
      internal var totalBorderTypes:int;
      
      internal var curPuzzleBoardIndex:int;
      
      internal const ROTATION_270:int = 3;
      
      internal var numPuzzleBoards:int;
      
      internal var numColumes:int;
      
      internal var puzzlePieceLayer:Sprite;
      
      internal const PUZZLE_PIECE_WIDTH:int = 60;
      
      internal const ROTATION_90:int = 1;
      
      internal var numRows:int;
      
      public function JigsawMatch(param1:MinigameBase)
      {
         super(param1);
      }
      
      private function getSideIndex(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param2 == ROTATION_90)
         {
            _loc3_ = 1;
         }
         else if(param2 == ROTATION_180)
         {
            _loc3_ = 2;
         }
         else if(param2 == ROTATION_270)
         {
            _loc3_ = 3;
         }
         return (param1 + _loc3_) % 4;
      }
      
      override public function restart() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Sprite = null;
         var _loc15_:Array = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:Array = null;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:* = undefined;
         var _loc29_:int = 0;
         var _loc30_:Sprite = null;
         _loc1_ = 1 + container.getTotalCorrect() / 4;
         _loc2_ = Math.min(2 + container.getTotalCorrect() / 8,3);
         if(_loc1_ <= 4 && _loc1_ > 2)
         {
            if(Engine.rnd(0,4) < 3)
            {
               _loc1_--;
               _loc3_ = true;
            }
         }
         trace("numPieces=" + (_loc1_ + _loc2_));
         curPuzzleBoardIndex = numGamesPlayed / 4 % numPuzzleBoards;
         ++numGamesPlayed;
         if(puzzleBoard != null)
         {
            removeChild(puzzleBoard);
         }
         if(puzzlePieceLayer != null)
         {
            removeChild(puzzlePieceLayer);
            puzzlePieceLayer = null;
         }
         puzzleBoard = getPuzzleBoard();
         puzzleBoard.x = GameWorld.CANVAS_CENTER_X - puzzleBoard.width / 2;
         puzzleBoard.y = 20;
         puzzleBoard.cacheAsBitmap = true;
         _loc4_ = new Sprite();
         _loc4_.graphics.beginFill(0);
         _loc4_.graphics.drawRect(0,0,puzzleBoard.width,puzzleBoard.height);
         _loc4_.x = puzzleBoard.x + 3;
         _loc4_.y = puzzleBoard.y + 3;
         addChild(_loc4_);
         addChild(puzzleBoard);
         numColumes = Math.floor(puzzleBoard.width / PUZZLE_PIECE_WIDTH);
         numRows = Math.floor(puzzleBoard.height / PUZZLE_PIECE_HEIGHT);
         trace("numRows=" + numRows + " numColumes=" + numColumes);
         puzzlePieces = new Array();
         correctPuzzlePieces = new Array();
         correctPuzzlePiecesMask = new Array();
         puzzlePieceSides = new Array();
         puzzlePiecesToChoose = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         puzzlePieces = new Array(numColumes * numRows);
         var _loc7_:RandomBasket = new RandomBasket(0,numColumes * numRows);
         var _loc8_:RandomBasket = new RandomBasket(0,JIGSAW_PIECE_SIDE.length);
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         while(_loc10_ < _loc1_)
         {
            _loc15_ = getNextValidRandomPiece(_loc7_,_loc8_,_loc10_ > 0 && _loc3_);
            _loc16_ = int(_loc15_[0]);
            _loc17_ = int(_loc15_[1]);
            _loc18_ = int(_loc15_[2]);
            if(_loc16_ == -1)
            {
               break;
            }
            trace("jigsawPieceRotation=" + _loc18_ + " jigsawPieceType=" + _loc17_ + " cellIndex=" + _loc16_);
            _loc19_ = getJigsawPieceSideMap(_loc17_,_loc18_);
            trace("jigsawPieceRotation=" + _loc18_ + " jigsawPieceType=" + _loc17_ + " jigsawPieceSideMap=" + _loc19_ + " cellIndex=" + _loc16_);
            _loc20_ = getJigsawPieceMask(_loc17_,_loc18_,_loc16_);
            _loc21_ = getJigsawPieceMask(_loc17_,_loc18_);
            _loc22_ = getJigsawPieceMask(_loc17_,_loc18_);
            _loc23_ = getJigsawPiece(_loc17_,_loc18_,_loc16_);
            puzzlePieces[_loc16_] = _loc23_;
            puzzlePieceSides[_loc16_] = _loc19_;
            puzzlePiecesToChoose.push(_loc23_);
            _loc5_.push(_loc21_);
            _loc6_.push(_loc22_);
            correctPuzzlePieces.push(_loc23_);
            correctPuzzlePiecesMask.push(_loc20_);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc2_)
         {
            if(_loc8_.length() == 0)
            {
               break;
            }
            _loc15_ = getNextValidRandomPiece(_loc7_,_loc8_,false);
            _loc24_ = int(_loc15_[0]);
            _loc25_ = int(_loc15_[1]);
            _loc26_ = int(_loc15_[2]);
            if(_loc24_ == -1)
            {
               break;
            }
            _loc23_ = getJigsawPiece(_loc25_,_loc26_,_loc24_);
            _loc27_ = Engine.rnd(0,puzzlePiecesToChoose.length + 1);
            puzzlePiecesToChoose.splice(_loc27_,0,_loc23_);
            _loc21_ = getJigsawPieceMask(_loc25_,_loc26_);
            _loc22_ = getJigsawPieceMask(_loc25_,_loc26_);
            _loc5_.splice(_loc27_,0,_loc21_);
            _loc6_.splice(_loc27_,0,_loc22_);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < correctPuzzlePiecesMask.length)
         {
            puzzleBoard.addChild(correctPuzzlePiecesMask[_loc10_]);
            _loc10_++;
         }
         puzzlePieceLayer = new Sprite();
         addChild(puzzlePieceLayer);
         var _loc11_:* = 1;
         if(GameWorld.CANVAS_WIDTH / puzzlePiecesToChoose.length < PUZZLE_PIECE_WIDTH * 1.5)
         {
            _loc11_ = GameWorld.CANVAS_WIDTH / puzzlePiecesToChoose.length / (PUZZLE_PIECE_WIDTH * 1.5);
         }
         var _loc12_:* = PUZZLE_PIECE_WIDTH * _loc11_;
         var _loc13_:int = Math.max(_loc12_ * 1.5,Math.min(_loc12_ * 2,GameWorld.CANVAS_WIDTH / puzzlePiecesToChoose.length));
         var _loc14_:* = (GameWorld.CANVAS_WIDTH - puzzlePiecesToChoose.length * _loc13_) / 2;
         _loc10_ = 0;
         while(_loc10_ < puzzlePiecesToChoose.length)
         {
            _loc28_ = new Sprite();
            _loc29_ = Engine.rnd(0,360);
            _loc6_[_loc10_].rotation += _loc29_;
            _loc6_[_loc10_].width += 2;
            _loc6_[_loc10_].height += 2;
            _loc28_.addChild(_loc6_[_loc10_]);
            _loc5_[_loc10_].rotation += _loc29_;
            _loc5_[_loc10_].x = 3;
            _loc5_[_loc10_].y = 3;
            _loc28_.addChild(_loc5_[_loc10_]);
            puzzlePiecesToChoose[_loc10_].rotation = _loc29_;
            _loc28_.addChild(puzzlePiecesToChoose[_loc10_]);
            _loc30_ = new Sprite();
            _loc30_.graphics.beginFill(0,0);
            _loc30_.graphics.drawRect(-PUZZLE_PIECE_WIDTH / 2,-PUZZLE_PIECE_HEIGHT / 2,PUZZLE_PIECE_WIDTH,PUZZLE_PIECE_HEIGHT);
            _loc30_.graphics.endFill();
            puzzlePiecesToChoose[_loc10_].addChild(_loc30_);
            _loc28_.scaleX = _loc11_;
            _loc28_.scaleY = _loc11_;
            _loc28_.x = _loc13_ / 2 + _loc10_ * _loc13_ + _loc14_;
            _loc28_.y = Engine.rnd(GameWorld.CANVAS_HEIGHT - _loc12_ * 2,GameWorld.CANVAS_HEIGHT - _loc12_);
            puzzlePieceLayer.addChild(_loc28_);
            puzzlePiecesToChoose[_loc10_].buttonMode = true;
            puzzlePiecesToChoose[_loc10_].addEventListener(MouseEvent.MOUSE_DOWN,pieceMouseDownListener);
            _loc10_++;
         }
      }
      
      public function getPuzzleBoard() : Sprite
      {
         var _loc1_:MovieClip = new JigsawPics();
         _loc1_.gotoAndStop(curPuzzleBoardIndex + 1);
         return _loc1_;
      }
      
      override public function init() : *
      {
         var _loc1_:* = new JigsawPics();
         numPuzzleBoards = _loc1_.totalFrames;
         _loc1_ = null;
         var _loc2_:* = new JigsawScene();
         _loc2_.x = GameWorld.CANVAS_CENTER_X;
         _loc2_.y = GameWorld.CANVAS_CENTER_Y;
         _loc2_.cacheAsBitmap = true;
         addChild(_loc2_);
      }
      
      public function getConnectedEmptyCellBasket() : RandomBasket
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:RandomBasket = new RandomBasket();
         var _loc2_:* = 0;
         while(_loc2_ < numRows * numColumes)
         {
            if(puzzlePieces[_loc2_] == null)
            {
               _loc3_ = Math.floor(_loc2_ / numColumes);
               _loc4_ = _loc2_ % numColumes;
               if(_loc3_ > 0 && puzzlePieces[_loc2_ - numColumes] != null || _loc3_ < numRows - 1 && puzzlePieces[_loc2_ + numColumes] != null || _loc4_ > 0 && puzzlePieces[_loc2_ - 1] != null || _loc4_ < numColumes - 1 && puzzlePieces[_loc2_ + 1] != null)
               {
                  _loc1_.addItems(_loc2_);
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getJigsawPieceSideMap(param1:int, param2:int) : Array
      {
         var _loc3_:Array = JIGSAW_PIECE_SIDE[param1];
         var _loc4_:Array = new Array(4);
         var _loc5_:* = 0;
         while(_loc5_ < 4)
         {
            _loc4_[getSideIndex(_loc5_,param2)] = _loc3_[_loc5_];
            _loc5_++;
         }
         return _loc4_;
      }
      
      override public function timeup() : *
      {
         removeAllMouseListeners();
      }
      
      public function getFittingJigsawPieceRotation(param1:int, param2:int) : int
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Boolean = false;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:RandomBasket = null;
         var _loc3_:Array = new Array(null,null,null,null);
         var _loc4_:* = param2 - numColumes;
         if(_loc4_ < 0)
         {
            _loc3_[0] = 0;
         }
         else if(puzzlePieces[_loc4_] != null)
         {
            _loc3_[0] = -puzzlePieceSides[_loc4_][2];
         }
         var _loc5_:* = param2 + numColumes;
         if(_loc5_ >= numRows * numColumes)
         {
            _loc3_[2] = 0;
         }
         else if(puzzlePieces[_loc5_] != null)
         {
            _loc3_[2] = -puzzlePieceSides[_loc5_][0];
         }
         var _loc6_:* = param2 % numColumes;
         if(_loc6_ == 0)
         {
            _loc3_[3] = 0;
         }
         else
         {
            _loc9_ = param2 - 1;
            if(puzzlePieces[_loc9_] != null)
            {
               _loc3_[3] = -puzzlePieceSides[_loc9_][1];
            }
         }
         if(_loc6_ == numColumes - 1)
         {
            _loc3_[1] = 0;
         }
         else
         {
            _loc10_ = param2 + 1;
            if(puzzlePieces[_loc10_] != null)
            {
               _loc3_[1] = -puzzlePieceSides[_loc10_][3];
            }
         }
         var _loc7_:Array = new Array();
         var _loc8_:* = 0;
         while(_loc8_ < 4)
         {
            _loc11_ = true;
            _loc12_ = getJigsawPieceSideMap(param1,_loc8_);
            _loc13_ = 0;
            while(_loc13_ < 4)
            {
               if(_loc3_[_loc13_] != null && _loc3_[_loc13_] != _loc12_[_loc13_] || _loc3_[_loc13_] == null && _loc12_[_loc13_] == 0)
               {
                  _loc11_ = false;
                  break;
               }
               _loc13_++;
            }
            if(_loc11_)
            {
               _loc7_.push(_loc8_);
            }
            _loc8_++;
         }
         if(_loc7_.length > 0)
         {
            _loc14_ = new RandomBasket(0,_loc7_.length);
            return _loc7_[_loc14_.getNextItem()];
         }
         return -1;
      }
      
      public function getJigsawPiece(param1:int, param2:int, param3:int) : Sprite
      {
         var _loc4_:Sprite = getJigsawPieceMask(param1,param2);
         var _loc5_:Sprite = getPuzzleBoard();
         var _loc6_:Sprite = new Sprite();
         var _loc7_:int = Math.floor(param3 / numColumes);
         var _loc8_:int = param3 % numColumes;
         _loc4_.x = _loc8_ * PUZZLE_PIECE_WIDTH + PUZZLE_PIECE_WIDTH / 2;
         _loc4_.y = _loc7_ * PUZZLE_PIECE_HEIGHT + PUZZLE_PIECE_HEIGHT / 2;
         _loc5_.mask = _loc4_;
         _loc5_.addChild(_loc4_);
         _loc5_.x = -_loc4_.x;
         _loc5_.y = -_loc4_.y;
         _loc6_.addChild(_loc5_);
         _loc6_.cacheAsBitmap = true;
         return _loc6_;
      }
      
      public function getNextValidRandomPiece(param1:RandomBasket, param2:RandomBasket, param3:Boolean = false) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:RandomBasket = null;
         var _loc8_:RandomBasket = null;
         if(param3)
         {
            _loc7_ = getConnectedEmptyCellBasket();
         }
         else
         {
            _loc7_ = param1.clone();
         }
         do
         {
            if(_loc7_.length() == 0)
            {
               _loc5_ = -1;
               _loc6_ = -1;
               _loc4_ = -1;
               break;
            }
            _loc4_ = int(_loc7_.getNextItem());
            _loc8_ = param2.clone();
            do
            {
               if(_loc8_.length() == 0)
               {
                  _loc5_ = -1;
                  break;
               }
               _loc5_ = int(_loc8_.getNextItem());
               trace("cellIndex=" + _loc4_ + " jigsawPieceType=" + _loc5_);
               _loc6_ = getFittingJigsawPieceRotation(_loc5_,_loc4_);
            }
            while(_loc6_ == -1);
            
         }
         while(_loc5_ == -1);
         
         if(_loc4_ != -1)
         {
            param1.removeItems(_loc4_);
            param2.removeItems(_loc5_);
         }
         return new Array(_loc4_,_loc5_,_loc6_);
      }
      
      public function getJigsawPieceMask(param1:int, param2:int, param3:int = -1) : Sprite
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = new JigsawPieces();
         _loc4_.gotoAndStop(param1 + 1);
         if(param2 == ROTATION_90)
         {
            _loc4_.rotation = 90;
         }
         else if(param2 == ROTATION_180)
         {
            _loc4_.rotation = 180;
         }
         else if(param2 == ROTATION_270)
         {
            _loc4_.rotation = 270;
         }
         if(param3 != -1)
         {
            _loc5_ = Math.floor(param3 / numColumes);
            _loc6_ = param3 % numColumes;
            _loc4_.x = _loc6_ * PUZZLE_PIECE_WIDTH + PUZZLE_PIECE_WIDTH / 2;
            _loc4_.y = _loc5_ * PUZZLE_PIECE_HEIGHT + PUZZLE_PIECE_HEIGHT / 2;
         }
         return _loc4_;
      }
      
      public function pieceMouseDownListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:* = correctPuzzlePieces.indexOf(param1.currentTarget);
         if(_loc2_ != -1)
         {
            puzzleBoard.removeChild(correctPuzzlePiecesMask[_loc2_]);
            puzzlePieceLayer.removeChild(param1.currentTarget.parent);
            correctPuzzlePiecesMask.splice(_loc2_,1);
            correctPuzzlePieces.splice(_loc2_,1);
            if(correctPuzzlePieces.length == 0)
            {
               removeAllMouseListeners();
               container.correct(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
            }
            container.addScore(CORRECT_SCORE.value);
         }
         else
         {
            removeAllMouseListeners();
            container.fail(true,GameWorld.CANVAS_CENTER_X,GameWorld.CANVAS_CENTER_Y);
            container.addScore(INCORRECT_SCORE.value);
         }
      }
      
      public function removeAllMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < puzzlePiecesToChoose.length)
         {
            puzzlePiecesToChoose[_loc1_].buttonMode = false;
            puzzlePiecesToChoose[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,pieceMouseDownListener);
            _loc1_++;
         }
      }
   }
}
