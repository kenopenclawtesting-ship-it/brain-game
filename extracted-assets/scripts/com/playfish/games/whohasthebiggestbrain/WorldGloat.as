package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.Timer;
   
   public class WorldGloat extends BaseWorld
   {
       
      
      internal const SCROLL_GLOAT_RIGHT:* = 2;
      
      internal var scene:MovieClip;
      
      internal const FADE_STATE_IN:int = 0;
      
      internal var scrollGloat:int = 0;
      
      internal var gloatList:Array;
      
      internal var friendIcons:Array;
      
      internal var friendPanelImages:Array;
      
      internal var gloatMovieClips:Array;
      
      internal var friendImageList:Array;
      
      internal var gloatPanels:Array;
      
      internal var fadeLayer:Sprite;
      
      internal var selectedFriendIndex:int = -1;
      
      internal var gloatPanelHeight:int;
      
      internal var firstFriendPanelIndex:int;
      
      internal var numFriendIcons:int = 7;
      
      internal var numFriendIconsPerScreen:int = 7;
      
      internal var initialTextFocus:Boolean = false;
      
      internal var currentUserImage:DisplayObject;
      
      internal var confirmPopup:MovieClip;
      
      internal var friendList:Array;
      
      internal const FADE_STATE_OUT:int = 2;
      
      internal var gloatPanelWidth:int;
      
      internal var numGloats:int = 1;
      
      internal var selectedFriendPanelState:int;
      
      internal const FADE_STATE_NONE:int = 1;
      
      internal var fadeState:int = 0;
      
      internal const SCROLL_GLOAT_LEFT:* = 1;
      
      internal var gloatPanelGloatIndex:Array;
      
      public function WorldGloat()
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:Sprite = null;
         super();
         scene = new GloatScene();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         scene.gloatArrowLeft.visible = false;
         scene.gloatArrowRight.visible = false;
         GameWorld.rpcClient.numResourceCopies = 0;
         GameWorld.rpcClient.getGloatList(gloatListOK,gloatListFail);
         friendIcons = new Array();
         friendIcons.push(scene.friend5);
         friendIcons.push(scene.friend4);
         friendIcons.push(scene.friend3);
         friendIcons.push(scene.friend2);
         friendIcons.push(scene.friend1);
         var _loc1_:Array = GameWorld.cachedHiscores[RpcClient.USER_CONTEXT_FRIENDS | RpcClient.TIME_CONTEXT_MONTH];
         var _loc2_:Array = GameWorld.cachedHiscoresRank[RpcClient.USER_CONTEXT_FRIENDS | RpcClient.TIME_CONTEXT_MONTH];
         trace("GameWorld.getUserScoreIndex(scoreList)=" + GameWorld.getUserScoreIndex(_loc1_));
         friendList = new Array();
         var _loc3_:int = GameWorld.getUserScoreIndex(_loc1_) + 1;
         _loc4_ = _loc3_;
         while(_loc4_ < _loc1_.length)
         {
            friendList.push(_loc1_[_loc4_]);
            _loc4_++;
         }
         currentUserImage = GameWorld.getFaceImageForUser(GameWorld.currentUserInfo);
         friendImageList = new Array();
         _loc4_ = 0;
         while(_loc4_ < friendList.length)
         {
            friendImageList[_loc4_] = new Array();
            _loc5_ = 0;
            while(_loc5_ < 2)
            {
               friendImageList[_loc4_][_loc5_] = GameWorld.getFaceImageForUser(friendList[_loc4_]);
               _loc5_++;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < friendIcons.length)
         {
            if(_loc4_ >= friendList.length)
            {
               friendIcons[_loc4_].visible = false;
            }
            else
            {
               friendIcons[_loc4_].buttonMode = true;
               friendIcons[_loc4_].addEventListener(MouseEvent.MOUSE_DOWN,friendIconListener);
            }
            _loc4_++;
         }
         friendPanelImages = new Array();
         _loc4_ = 0;
         while(_loc4_ < friendIcons.length)
         {
            friendPanelImages[_loc4_] = null;
            _loc4_++;
         }
         updateFriendPanels(0);
         gloatPanels = new Array();
         gloatPanels.push(scene.gloatPanel);
         gloatPanelWidth = scene.gloatPanel.width / scene.gloatPanel.scaleX;
         gloatPanelHeight = scene.gloatPanel.height / scene.gloatPanel.scaleY;
         gloatPanelGloatIndex = new Array();
         gloatMovieClips = new Array();
         _loc4_ = 0;
         while(_loc4_ < numGloats)
         {
            gloatMovieClips[_loc4_] = null;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < gloatPanels.length)
         {
            gloatMovieClips[_loc4_] = new GloatMovieClip(this,_loc4_);
            gloatPanels[_loc4_].addChild(gloatMovieClips[_loc4_]);
            gloatPanelGloatIndex[_loc4_] = _loc4_;
            (_loc6_ = new Sprite()).graphics.beginFill(16777215);
            _loc6_.graphics.drawRect(-gloatPanelWidth / 2,-gloatPanelHeight / 2,gloatPanelWidth,gloatPanelHeight);
            gloatPanels[_loc4_].mask = _loc6_;
            gloatPanels[_loc4_].addChild(_loc6_);
            _loc4_++;
         }
         updateGloatPageNumber(gloatPanelGloatIndex[0]);
         setButtonMode(scene.send,true);
         scene.send.addEventListener(MouseEvent.CLICK,sendButtonListener);
         scene.send.alpha = 0.3;
         scene.send.tip.visible = false;
         scene.send.feed.text.text = Engine.getText("ShareButton");
         Engine.setFontForLang(scene.send.feed.text,"Arnold 2.1");
         Engine.setFontSize(scene.send.feed.text,16,"EL",14);
         setButtonMode(scene.skip,true);
         scene.skip.addEventListener(MouseEvent.CLICK,skipButtonListener);
         scene.skip.text.text = Engine.getText("ContinueButton");
         Engine.setFontForLang(scene.skip.text,"Arnold 2.1");
         Engine.setFontSize(scene.skip.text,16,"EL",14);
         setButtonMode(scene.friendArrowLeft,true);
         scene.friendArrowLeft.addEventListener(MouseEvent.CLICK,friendLeftArrowListener);
         setButtonMode(scene.friendArrowRight,true);
         scene.friendArrowRight.addEventListener(MouseEvent.CLICK,friendRightArrowListener);
         setButtonMode(scene.addCredits,true);
         scene.pro.visible = false;
         Engine.setFontForLang(scene.gloatText,null);
         Engine.setFontForLang(scene.taunt,"Baveuse");
         scene.taunt.text = Engine.getText("SendTaunt");
         scene.gloatText.text = Engine.getText("GloatDefaultText");
         initFadeLayer(16777215);
         addChild(fadeLayer);
         trace("complete load");
      }
      
      public function startFadeToMainMenu() : *
      {
         initFadeLayer(16777215);
         fadeLayer.alpha = 0;
         addChild(fadeLayer);
         fadeState = FADE_STATE_OUT;
      }
      
      public function updateSendButton() : *
      {
         if(selectedFriendIndex == -1 || !GameWorld.currentUserInfo.isProUser && gloatList[gloatPanelGloatIndex[0]].proOnly)
         {
            scene.send.alpha = 0.3;
         }
         else
         {
            scene.send.alpha = 1;
         }
      }
      
      public function initFadeLayer(param1:int) : *
      {
         fadeLayer = new Sprite();
         fadeLayer.graphics.beginFill(param1);
         fadeLayer.graphics.drawRect(0,0,GameWorld.CANVAS_WIDTH,GameWorld.CANVAS_HEIGHT);
         fadeLayer.graphics.endFill();
      }
      
      public function friendIconListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         var _loc2_:* = friendIcons.indexOf(param1.currentTarget);
         setSelectedFriendPanel(_loc2_);
      }
      
      public function askFeedListener(param1:TimerEvent) : *
      {
         param1.currentTarget.stop();
         removeChild(confirmPopup);
         confirmPopup = new GloatConfirmationFailed();
         confirmPopup.title.text = Engine.getText("GloatSendFeed");
         confirmPopup.x = GameWorld.CANVAS_CENTER_X;
         confirmPopup.y = GameWorld.CANVAS_CENTER_Y;
         addChild(confirmPopup);
         setButtonMode(confirmPopup.sendButton,true);
         setButtonMode(confirmPopup.skipButton,true);
         confirmPopup.sendButton.addEventListener(MouseEvent.CLICK,feedOKListener);
         confirmPopup.skipButton.addEventListener(MouseEvent.CLICK,feedCancelListener);
      }
      
      public function feedCancelListener(param1:MouseEvent) : *
      {
         param1.currentTarget.stop();
         removeChild(fadeLayer);
         removeChild(confirmPopup);
         startFadeToMainMenu();
      }
      
      public function sendFailListener() : *
      {
         removeChild(confirmPopup);
         confirmPopup = new GloatConfirmationFailed();
         confirmPopup.title.text = Engine.getText("GloatSendFail");
         confirmPopup.x = GameWorld.CANVAS_CENTER_X;
         confirmPopup.y = GameWorld.CANVAS_CENTER_Y;
         addChild(confirmPopup);
         setButtonMode(confirmPopup.sendButton,true);
         setButtonMode(confirmPopup.skipButton,true);
         confirmPopup.sendButton.addEventListener(MouseEvent.CLICK,sendButtonListener);
         confirmPopup.skipButton.addEventListener(MouseEvent.CLICK,skipButtonListener);
      }
      
      public function updateFriendPanels(param1:int) : *
      {
         var _loc4_:UserInfo = null;
         var _loc2_:* = 0;
         while(_loc2_ < friendIcons.length)
         {
            if(friendPanelImages[_loc2_] != null)
            {
               friendIcons[_loc2_].removeChild(friendPanelImages[_loc2_]);
               friendPanelImages[_loc2_] = null;
               friendIcons[_loc2_].playerName.text = "";
               friendIcons[_loc2_].playerScore.text = "";
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < friendIcons.length)
         {
            if((_loc4_ = friendList[param1 + _loc2_]) != null)
            {
               friendPanelImages[_loc2_] = friendImageList[param1 + _loc2_][0];
               if(friendPanelImages[_loc2_] != null)
               {
                  friendIcons[_loc2_].addChild(friendPanelImages[_loc2_]);
               }
               friendIcons[_loc2_].playerName.text = _loc4_.firstName;
               friendIcons[_loc2_].playerScore.text = _loc4_.highScore;
            }
            _loc2_++;
         }
         scene.tick.visible = false;
         var _loc3_:* = getSelectedFriendPanelIndex();
         if(_loc3_ != -1)
         {
            setSelectedFriendPanel(_loc3_);
         }
         scene.friendArrowLeft.enable = true;
         scene.friendArrowLeft.visible = true;
         scene.friendArrowRight.enable = true;
         scene.friendArrowRight.visible = true;
         if(param1 == 0)
         {
            scene.friendArrowRight.enable = false;
            scene.friendArrowRight.visible = false;
         }
         if(param1 + friendIcons.length >= friendList.length)
         {
            scene.friendArrowLeft.enable = false;
            scene.friendArrowLeft.visible = false;
         }
      }
      
      public function getSelectedFriendPanelIndex() : int
      {
         var _loc1_:* = selectedFriendIndex - firstFriendPanelIndex;
         if(_loc1_ >= 0 && _loc1_ < friendIcons.length)
         {
            return _loc1_;
         }
         return -1;
      }
      
      public function setSelectedFriendPanel(param1:int) : *
      {
         var _loc2_:int = selectedFriendIndex;
         selectedFriendIndex = firstFriendPanelIndex + param1;
         if(selectedFriendIndex < friendList.length)
         {
            scene.tick.visible = true;
            scene.tick.x = friendIcons[param1].x;
            if(_loc2_ != selectedFriendIndex)
            {
               getSelectedGloatMovieClip().updateLoserImage();
            }
            updateSendButton();
         }
      }
      
      public function dismissTimerListener(param1:TimerEvent) : *
      {
         param1.currentTarget.stop();
         removeChild(fadeLayer);
         if(confirmPopup != null)
         {
            removeChild(confirmPopup);
         }
         startFadeToMainMenu();
      }
      
      public function getSelectedGloatMovieClip() : GloatMovieClip
      {
         return gloatMovieClips[gloatPanelGloatIndex[0]];
      }
      
      public function gloatListOK(param1:Array) : *
      {
         trace("gloat ok. num gloats=" + param1.length);
         this.gloatList = param1;
         numGloats = param1.length;
         gloatMovieClips[0].loadGloatMovieClip(param1[0].resourceUrl);
         setCurrentGloat(0,0);
         updateGloatPageNumber(gloatPanelGloatIndex[0]);
         scene.gloatArrowLeft.visible = true;
         setButtonMode(scene.gloatArrowLeft,true);
         scene.gloatArrowLeft.addEventListener(MouseEvent.CLICK,gloatLeftArrowListener);
         scene.gloatArrowRight.visible = true;
         setButtonMode(scene.gloatArrowRight,true);
         scene.gloatArrowRight.addEventListener(MouseEvent.CLICK,gloatRightArrowListener);
      }
      
      public function gloatLeftArrowListener(param1:MouseEvent) : *
      {
         scrollGloat = SCROLL_GLOAT_LEFT;
      }
      
      public function sendButtonListener(param1:MouseEvent) : *
      {
         if(!GameWorld.currentUserInfo.isProUser && Boolean(gloatList[gloatPanelGloatIndex[0]].proOnly))
         {
            return;
         }
         if(selectedFriendIndex == -1)
         {
            return;
         }
         Engine.playSound("ButtonMenu",1);
         if(confirmPopup != null)
         {
            removeChild(confirmPopup);
            confirmPopup = null;
         }
         else
         {
            initFadeLayer(0);
            fadeLayer.alpha = 0.5;
            addChild(fadeLayer);
         }
         confirmPopup = new GloatConfirmation();
         confirmPopup.title.text = Engine.getText("GloatSending");
         confirmPopup.x = GameWorld.CANVAS_CENTER_X;
         confirmPopup.y = GameWorld.CANVAS_CENTER_Y;
         addChild(confirmPopup);
         GameWorld.rpcClient.sendGloat(gloatPanelGloatIndex[0],scene.gloatText.text,friendList[selectedFriendIndex].id,sendOKListener,sendFailListener);
         scene.mouseEnabled = false;
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!initialTextFocus)
         {
            initialTextFocus = true;
            Engine.setFocus(scene.gloatText);
            scene.gloatText.setSelection(0,scene.gloatText.length);
         }
         if(scrollGloat == SCROLL_GLOAT_RIGHT)
         {
            _loc2_ = 0;
            while(_loc2_ < gloatPanels.length)
            {
               if(gloatPanels[_loc2_].contains(gloatMovieClips[gloatPanelGloatIndex[_loc2_]]))
               {
                  gloatPanels[_loc2_].removeChild(gloatMovieClips[gloatPanelGloatIndex[_loc2_]]);
               }
               _loc3_ = (gloatPanelGloatIndex[_loc2_] + 1) % numGloats;
               setCurrentGloat(_loc2_,_loc3_);
               gloatPanels[_loc2_].addChild(gloatMovieClips[_loc3_]);
               _loc2_++;
            }
            updateGloatPageNumber(gloatPanelGloatIndex[0]);
            scrollGloat = 0;
         }
         else if(scrollGloat == SCROLL_GLOAT_LEFT)
         {
            _loc2_ = 0;
            while(_loc2_ < gloatPanels.length)
            {
               if(gloatPanels[_loc2_].contains(gloatMovieClips[gloatPanelGloatIndex[_loc2_]]))
               {
                  gloatPanels[_loc2_].removeChild(gloatMovieClips[gloatPanelGloatIndex[_loc2_]]);
               }
               _loc3_ = gloatPanelGloatIndex[_loc2_] - 1;
               if(_loc3_ < 0)
               {
                  _loc3_ += numGloats;
               }
               setCurrentGloat(_loc2_,_loc3_);
               gloatPanels[_loc2_].addChild(gloatMovieClips[_loc3_]);
               _loc2_++;
            }
            updateGloatPageNumber(gloatPanelGloatIndex[0]);
            scrollGloat = 0;
         }
         if(gloatMovieClips[gloatPanelGloatIndex[0]] != null)
         {
            gloatMovieClips[gloatPanelGloatIndex[0]].setText(scene.gloatText.text);
         }
         if(fadeState == FADE_STATE_IN)
         {
            fadeLayer.alpha -= 0.1;
            if(fadeLayer.alpha <= 0)
            {
               removeChild(fadeLayer);
               fadeState = FADE_STATE_NONE;
            }
         }
         else if(fadeState == FADE_STATE_OUT)
         {
            fadeLayer.alpha += 0.1;
            if(fadeLayer.alpha >= 1)
            {
               if(WorldAdvert.isAdReady())
               {
                  Engine.setActiveWorld(new WorldAdvert());
               }
               else
               {
                  WorldAdvert.destroyAd();
                  GameWorld.startMainMenu();
                  Engine.playSound("ApplauseSound",1);
               }
               return;
            }
         }
      }
      
      public function sendOKListener() : *
      {
         confirmPopup.title.text = Engine.getText("GloatSent");
         var _loc1_:Timer = new Timer(1000,1);
         _loc1_.addEventListener(TimerEvent.TIMER,dismissTimerListener);
         _loc1_.start();
         if(Engine.instance.getParameter("pf_network") != "igoogle")
         {
            FeedForm.openFeedDialog(FeedForm.FEEDID_TAUNT,new Array(friendList[selectedFriendIndex]));
         }
      }
      
      public function friendLeftArrowListener(param1:MouseEvent) : *
      {
         var _loc2_:* = firstFriendPanelIndex;
         firstFriendPanelIndex = Math.min(firstFriendPanelIndex + 1,friendList.length - friendIcons.length);
         if(_loc2_ != firstFriendPanelIndex)
         {
            updateFriendPanels(firstFriendPanelIndex);
         }
      }
      
      public function updateGloatPriceTag(param1:int) : *
      {
         if(gloatList == null || gloatList.length == 0)
         {
            scene.priceTag.price.text = "";
         }
         else
         {
            scene.priceTag.price.text = gloatList[param1].price;
         }
      }
      
      public function feedOKListener(param1:MouseEvent) : *
      {
         FeedForm.openFeedDialog(FeedForm.FEEDID_TAUNT,new Array(friendList[selectedFriendIndex]));
         param1.currentTarget.stop();
         removeChild(confirmPopup);
         confirmPopup = null;
         var _loc2_:Timer = new Timer(2000,1);
         _loc2_.addEventListener(TimerEvent.TIMER,dismissTimerListener);
         _loc2_.start();
      }
      
      public function gloatListFail() : *
      {
      }
      
      public function gloatRightArrowListener(param1:MouseEvent) : *
      {
         scrollGloat = SCROLL_GLOAT_RIGHT;
      }
      
      public function getSelectedGloat() : Gloat
      {
         return gloatList[gloatPanelGloatIndex[0]];
      }
      
      public function skipButtonListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         if(confirmPopup != null)
         {
            removeChild(fadeLayer);
            removeChild(confirmPopup);
            confirmPopup = null;
         }
         startFadeToMainMenu();
      }
      
      public function setCurrentGloat(param1:int, param2:int) : *
      {
         gloatPanelGloatIndex[param1] = param2;
         if(gloatMovieClips[param2] == null)
         {
            gloatMovieClips[param2] = new GloatMovieClip(this,param2);
            gloatMovieClips[param2].loadGloatMovieClip(gloatList[param2].resourceUrl);
         }
         if(!GameWorld.currentUserInfo.isProUser && Boolean(gloatList[param2].proOnly))
         {
            scene.pro.visible = true;
         }
         else
         {
            scene.pro.visible = false;
         }
         gloatMovieClips[param2].showNotify();
         updateSendButton();
      }
      
      public function friendRightArrowListener(param1:MouseEvent) : *
      {
         var _loc2_:* = firstFriendPanelIndex;
         firstFriendPanelIndex = Math.max(firstFriendPanelIndex - 1,0);
         if(_loc2_ != firstFriendPanelIndex)
         {
            updateFriendPanels(firstFriendPanelIndex);
         }
      }
      
      public function updateGloatPageNumber(param1:int) : *
      {
         if(gloatList == null || gloatList.length == 0)
         {
            scene.pageNumber.text = "";
         }
         else
         {
            scene.pageNumber.text = param1 + 1 + "/" + numGloats;
         }
      }
   }
}
