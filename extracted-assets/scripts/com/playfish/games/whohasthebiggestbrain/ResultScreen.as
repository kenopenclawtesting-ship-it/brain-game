package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class ResultScreen extends BaseWorld
   {
       
      
      internal var timer:int;
      
      internal var bgSprites:Array;
      
      internal var scene:ResultScene;
      
      internal const SCROLL_SPEED_X:Number = 0.2;
      
      internal var picBoxes:Array;
      
      internal var fadeInLayer:Sprite;
      
      internal var state:int;
      
      internal var animatedBrainTypeSprite:AnimatedSprite;
      
      internal const STATE_SPRITE_MOVE_TO_CENTER:* = 1;
      
      internal const STATE_IDLE:* = 3;
      
      internal const STATE_PANNING:* = 2;
      
      internal var brainTypeSprites:Array;
      
      internal var posBubbles:Array;
      
      internal var playerIndex:int;
      
      internal const STATE_FADE_OUT:* = 4;
      
      internal const STATE_FADE_IN:* = 0;
      
      internal var skipButton:MovieClip;
      
      internal var emotions:Array;
      
      public function ResultScreen()
      {
         var _loc2_:* = undefined;
         var _loc5_:UserInfo = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc10_:* = undefined;
         var _loc11_:MovieClip = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:MovieClip = null;
         picBoxes = new Array();
         posBubbles = new Array();
         brainTypeSprites = new Array();
         bgSprites = new Array();
         emotions = new Array();
         super();
         scene = new ResultScene();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         playerIndex = GameWorld.getUserScoreIndex(GameWorld.friendsHiscores);
         if(playerIndex == -1)
         {
            playerIndex = 0;
         }
         if(GameWorld.friendsHiscores != null)
         {
            picBoxes = new Array();
            posBubbles = new Array();
            brainTypeSprites = new Array();
            _loc2_ = 0;
            while(_loc2_ < GameWorld.friendsHiscores.length)
            {
               if((_loc5_ = GameWorld.friendsHiscores[_loc2_]).highScore > 0)
               {
                  _loc6_ = new ResultScenePic();
                  _loc7_ = new ResultSceneBubble();
                  _loc6_.score.text = "" + _loc5_.highScore;
                  _loc7_.position.text = "" + GameWorld.friendsHiscoresRank[_loc2_];
                  if((_loc8_ = GameWorld.getFaceImageForUser(_loc5_)) != null)
                  {
                     _loc6_.pic.addChild(_loc8_);
                  }
                  picBoxes.splice(0,0,_loc6_);
                  posBubbles.splice(0,0,_loc7_);
                  _loc9_ = GameWorld.getBrainType(_loc5_.highScore);
                  _loc10_ = GameWorld.getBrainTypeMovieClip(_loc9_);
                  brainTypeSprites.splice(0,0,_loc10_);
                  (_loc11_ = new HighScoreBg()).gotoAndStop(_loc9_ + 1);
                  bgSprites.splice(0,0,_loc11_);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 10)
            {
               (_loc12_ = new ResultScenePic()).score.text = "" + 0;
               picBoxes.push(_loc12_);
               (_loc13_ = new ResultSceneBubble()).position.text = "" + (10 - _loc2_);
               posBubbles.push(_loc13_);
               brainTypeSprites.push(GameWorld.getBrainTypeMovieClip(0));
               (_loc14_ = new HighScoreBg()).gotoAndStop(_loc2_ + 1);
               bgSprites.push(_loc14_);
               _loc2_++;
            }
            picBoxes[picBoxes.length - 1 - playerIndex].score.text = "" + GameWorld.currentUserScore;
            GameWorld.currentUserInfo.highScore = GameWorld.currentUserScore;
         }
         brainTypeSprites[picBoxes.length - 1 - playerIndex] = null;
         var _loc1_:Number = Number(bgSprites[0].width);
         _loc2_ = 0;
         while(_loc2_ < picBoxes.length)
         {
            picBoxes[_loc2_].x = GameWorld.CANVAS_WIDTH / 2 + _loc2_ * _loc1_;
            picBoxes[_loc2_].y = scene.pic.y;
            posBubbles[_loc2_].x = picBoxes[_loc2_].x;
            posBubbles[_loc2_].y = scene.bubble.y;
            scene.addChild(picBoxes[_loc2_]);
            scene.addChild(posBubbles[_loc2_]);
            bgSprites[_loc2_].x = picBoxes[_loc2_].x;
            bgSprites[_loc2_].y = scene.brainType.y;
            scene.addChild(bgSprites[_loc2_]);
            if(brainTypeSprites[_loc2_] != null)
            {
               brainTypeSprites[_loc2_].x = picBoxes[_loc2_].x;
               brainTypeSprites[_loc2_].y = scene.brainType.y - brainTypeSprites[_loc2_].height / 2;
               scene.addChild(brainTypeSprites[_loc2_]);
            }
            _loc2_++;
         }
         animatedBrainTypeSprite = new AnimatedSprite("AnimatedAnimal");
         animatedBrainTypeSprite.scaleX = 1.2;
         animatedBrainTypeSprite.scaleY = 1.2;
         trace("player brain type = " + GameWorld.getBrainType(GameWorld.currentUserInfo.highScore));
         var _loc3_:* = GameWorld.getBrainTypeMovieClip(GameWorld.getBrainType(GameWorld.currentUserInfo.highScore));
         _loc3_.y = -_loc3_.height / 2;
         animatedBrainTypeSprite.mc.animal.removeChildAt(0);
         animatedBrainTypeSprite.mc.animal.addChild(_loc3_);
         animatedBrainTypeSprite.x = -GameWorld.CANVAS_WIDTH / 2 - animatedBrainTypeSprite.width;
         animatedBrainTypeSprite.y = scene.brainType.y;
         scene.addChild(animatedBrainTypeSprite);
         scene.removeChild(scene.pic);
         scene.removeChild(scene.bubble);
         scene.removeChild(scene.brainType);
         fadeInLayer = new Sprite();
         fadeInLayer.alpha = 1;
         fadeInLayer.graphics.beginFill(16777215);
         var _loc4_:Rectangle = scene.getBounds(scene);
         fadeInLayer.graphics.drawRect(_loc4_.x,_loc4_.y,_loc4_.width,_loc4_.height);
         scene.addChild(fadeInLayer);
         Engine.playSound("CrowdCheerSound",1);
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:Array = null;
         var _loc2_:* = param1 * SCROLL_SPEED_X;
         animatedBrainTypeSprite.tickAnimation(param1);
         if(state == STATE_FADE_IN)
         {
            fadeInLayer.alpha -= 0.1;
            if(fadeInLayer.alpha <= 0)
            {
               scene.removeChild(fadeInLayer);
               state = STATE_SPRITE_MOVE_TO_CENTER;
            }
         }
         else if(state == STATE_SPRITE_MOVE_TO_CENTER)
         {
            animatedBrainTypeSprite.x += _loc2_;
            if(animatedBrainTypeSprite.x >= 0)
            {
               animatedBrainTypeSprite.x == 0;
               skipButton = new ButtonOk();
               skipButton.x = GameWorld.CANVAS_WIDTH / 2 - skipButton.width;
               skipButton.y = GameWorld.CANVAS_HEIGHT / 2 - skipButton.height;
               setButtonMode(skipButton,true);
               scene.addChild(skipButton);
               skipButton.addEventListener(MouseEvent.CLICK,skipButtonDownListener);
               state = STATE_PANNING;
            }
         }
         else if(state == STATE_PANNING)
         {
            _loc3_ = picBoxes[picBoxes.length - 1 - playerIndex].x - _loc2_;
            if(_loc3_ <= 0)
            {
               _loc2_ += _loc3_;
            }
            _loc4_ = 0;
            while(_loc4_ < picBoxes.length)
            {
               picBoxes[_loc4_].x -= _loc2_;
               posBubbles[_loc4_].x -= _loc2_;
               if(brainTypeSprites[_loc4_] != null)
               {
                  _loc5_ = brainTypeSprites[_loc4_].x;
                  brainTypeSprites[_loc4_].x -= _loc2_;
                  if(emotions[_loc4_] == null)
                  {
                     if(_loc5_ > 0 && brainTypeSprites[_loc4_].x <= 0)
                     {
                        emotions[_loc4_] = Engine.getMovieClip("Emotion" + Engine.rnd(0,3));
                        emotions[_loc4_].x = brainTypeSprites[_loc4_].x;
                        emotions[_loc4_].y = brainTypeSprites[_loc4_].getBounds(scene).top - emotions[_loc4_].getBounds(emotions[_loc4_]).bottom - 4;
                        scene.addChild(emotions[_loc4_]);
                     }
                  }
                  else
                  {
                     emotions[_loc4_].x -= _loc2_;
                  }
               }
               bgSprites[_loc4_].x -= _loc2_;
               _loc4_++;
            }
            if(picBoxes[picBoxes.length - 1 - playerIndex].x <= 0)
            {
               animatedBrainTypeSprite.finishAtFirstFrame = true;
               state = STATE_IDLE;
            }
         }
         else if(state != STATE_IDLE)
         {
            if(state == STATE_FADE_OUT)
            {
               fadeInLayer.alpha += 0.1;
               if(fadeInLayer.alpha >= 1)
               {
                  _loc6_ = GameWorld.cachedHiscores[RpcClient.USER_CONTEXT_FRIENDS | RpcClient.TIME_CONTEXT_MONTH];
                  if(GameWorld.getUserScoreIndex(_loc6_) < _loc6_.length - 1)
                  {
                     Engine.setActiveWorld(new WorldGloat());
                  }
                  else if(FeedForm.waitFeed == FeedForm.FEEDID_HIGHSCORE1 || Debug.TEST_FEED_FORM)
                  {
                     FeedForm.openWaitFeedDialog();
                     GameWorld.startMainMenu();
                     Engine.playSound("ApplauseSound",1);
                  }
                  else if(WorldAdvert.isAdReady())
                  {
                     Engine.setActiveWorld(new WorldAdvert());
                  }
                  else
                  {
                     WorldAdvert.destroyAd();
                     GameWorld.startMainMenu();
                     Engine.playSound("ApplauseSound",1);
                  }
               }
            }
         }
      }
      
      public function skipButtonDownListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         skipButton.removeEventListener(MouseEvent.CLICK,skipButtonDownListener);
         scene.removeChild(skipButton);
         scene.addChild(fadeInLayer);
         state = STATE_FADE_OUT;
      }
   }
}
