package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.coretech.engine.core.PFArray;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformUser;
   import com.playfish.coretech.platform.socialstats.InviteRecommendations;
   import com.playfish.rpc.brain.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.*;
   import flash.text.TextField;
   
   public class HighScorePanel extends BaseWorld
   {
      
      public static const FACEBOOK_PROFILE_PAGE_URL:String = "http://www.facebook.com/profile.php?id=";
      
      public static const NUM_TOP_SCORES:uint = 3;
      
      public static const NUM_SCORES:uint = 8;
      
      public static const NUM_INVITES:uint = 2;
      
      public static const NUM_CACHED_SCROLLABLE_FRIEND_SCORES:uint = 100;
      
      public static const SCROLL_WINDOW_SIZE:uint = NUM_SCORES - NUM_TOP_SCORES;
      
      public static const TAB_FRIEND_SCORES:int = 0;
      
      public static const TAB_WORLD_SCORES:int = 1;
      
      public static const TAB_NETWORK_SCORES:int = 2;
      
      public static const TAB_SMART_500_SCORES:int = 3;
      
      public static const TAB_COUNT:int = 4;
      
      public static const SUB_TAB_WEEKLY:int = 0;
      
      public static const SUB_TAB_MONTHLY:int = 1;
      
      public static const SUB_TAB_ALL_TIME:int = 2;
      
      public static const SUBTAB_COUNT:int = 3;
      
      public static const MODE_TAB_NORMAL:int = 0;
      
      public static const MODE_TAB_CHALLENGE:int = 1;
      
      public static const TAB_TO_USER_CONTEXT:Array = new Array([RpcClient.USER_CONTEXT_FRIENDS,RpcClient.USER_CONTEXT_ALL,RpcClient.USER_CONTEXT_REGION],[RpcClient.USER_CONTEXT_CHALLENGE_FRIENDS,RpcClient.USER_CONTEXT_CHALLENGE_ALL,RpcClient.USER_CONTEXT_CHALLENGE_REGION]);
      
      public static const SUBTAB_TO_TIME_CONTEXT:Array = new Array(RpcClient.TIME_CONTEXT_WEEK,RpcClient.TIME_CONTEXT_MONTH,RpcClient.TIME_CONTEXT_ALL);
      
      public static const MAX_INVITE_RECOMMENDATION_ENTRIES:uint = 2;
      
      public static const JAVASCRIPT_FUNCTION_START:int = 11;
       
      
      internal var achievementPanels:Array;
      
      internal var scene:HiscoreBox;
      
      internal var entries:Array;
      
      internal var inviteIcons:Array;
      
      public var curModeTab:int = -1;
      
      internal var curSubTab:int = -1;
      
      internal const NUM_SCORES_PER_PAGE:int = 10;
      
      internal var nameTextFields:Array;
      
      internal var curTab:int = -1;
      
      internal var faces:Array;
      
      internal var posTextFields:Array;
      
      internal var popup:MovieClip;
      
      internal var modeTabs:Array;
      
      internal var curListStartRank:Array;
      
      internal var subTabs:Array;
      
      internal var brainTypePanels:Array;
      
      internal var challengeScores:Array;
      
      internal var brainTypeSprites:Array;
      
      internal var challengeInfos:Array;
      
      internal var cachedFaceImages:Array;
      
      internal var scoreTextFields:Array;
      
      internal var tabs:Array;
      
      public function HighScorePanel()
      {
         var i:*;
         curListStartRank = new Array();
         super();
         scene = new HiscoreBox();
         addChild(scene);
         nameTextFields = new Array();
         scoreTextFields = new Array();
         posTextFields = new Array();
         faces = new Array();
         brainTypePanels = new Array();
         brainTypeSprites = new Array();
         achievementPanels = new Array();
         cachedFaceImages = new Array();
         challengeInfos = new Array();
         challengeScores = new Array();
         entries = new Array();
         entries.push(scene.entry0);
         entries.push(scene.entry1);
         entries.push(scene.entry2);
         entries.push(scene.entry3);
         entries.push(scene.entry4);
         entries.push(scene.entry5);
         entries.push(scene.entry6);
         entries.push(scene.entry7);
         entries.push(scene.entry8);
         entries.push(scene.entry9);
         i = 0;
         while(i < entries.length)
         {
            faces.push(entries[i].face);
            brainTypePanels.push(entries[i].brainType);
            nameTextFields.push(entries[i].playerName);
            scoreTextFields.push(entries[i].score);
            posTextFields.push(entries[i].pos);
            achievementPanels.push(entries[i].achieve);
            challengeInfos.push(entries[i].chaIcon);
            challengeScores.push(entries[i].chaScore);
            entries[i].buttonMode = true;
            i++;
         }
         tabs = new Array();
         tabs.push(scene.tabFriends);
         tabs.push(scene.tabWorld);
         tabs.push(scene.tabNetwork);
         tabs.push(scene.tabSmart500);
         scene.tabFriends.textField.mouseEnabled = false;
         scene.tabWorld.textField.mouseEnabled = false;
         scene.tabSmart500.textField.mouseEnabled = false;
         tabs[TAB_NETWORK_SCORES].visible = false;
         subTabs = new Array();
         subTabs.push(scene.subTabWeek);
         subTabs.push(scene.subTabMonth);
         subTabs.push(scene.subTabAllTime);
         scene.subTabWeek.textField.mouseEnabled = false;
         scene.subTabMonth.textField.mouseEnabled = false;
         scene.subTabAllTime.textField.mouseEnabled = false;
         setTab(TAB_FRIEND_SCORES,SUB_TAB_MONTHLY);
         modeTabs = new Array();
         modeTabs.push(scene.normalButton);
         modeTabs.push(scene.challengeButton);
         scene.normalButton.textMC.textField.mouseEnabled = false;
         scene.challengeButton.textMC.textField.mouseEnabled = false;
         setModeTab(MODE_TAB_NORMAL);
         setButtonMode(scene.leftButton,true);
         setButtonMode(scene.rightButton,true);
         setButtonMode(scene.leftButton2,true);
         setButtonMode(scene.rightButton2,true);
         setButtonMode(scene.leftButton3,true);
         setButtonMode(scene.rightButton3,true);
         scene.leftButton.addEventListener(MouseEvent.CLICK,function(param1:Event):*
         {
            leftClickListener(1);
         });
         scene.rightButton.addEventListener(MouseEvent.CLICK,function(param1:Event):*
         {
            rightClickListener(1);
         });
         scene.leftButton2.addEventListener(MouseEvent.CLICK,function(param1:Event):*
         {
            leftClickListener(SCROLL_WINDOW_SIZE);
         });
         scene.rightButton2.addEventListener(MouseEvent.CLICK,function(param1:Event):*
         {
            rightClickListener(SCROLL_WINDOW_SIZE);
         });
         scene.leftButton3.addEventListener(MouseEvent.CLICK,function(param1:Event):*
         {
            leftClickListener(5 * SCROLL_WINDOW_SIZE);
         });
         scene.rightButton3.addEventListener(MouseEvent.CLICK,function(param1:Event):*
         {
            rightClickListener(5 * SCROLL_WINDOW_SIZE);
         });
         cacheAsBitmap = true;
      }
      
      public function achievementOverListener(param1:MouseEvent) : *
      {
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         if(popup != null)
         {
            removeChild(popup);
         }
         popup = new AchievementPopup();
         popup.textField.text = "";
         var _loc2_:* = 0;
         while(_loc2_ < AchievementHandler.NUM_ACHIEVEMENT)
         {
            _loc5_ = popup["icon" + _loc2_];
            _loc5_.achievementIndex = _loc2_;
            setButtonMode(_loc5_,true);
            _loc6_ = new AchieveIcons();
            _loc5_.content.addChild(_loc6_);
            if(Debug.DISPLAY_ALL_TROPHIES || AchievementHandler.hasAchievement(param1.currentTarget.achievementMask,_loc2_))
            {
               _loc6_.gotoAndStop(_loc2_ + 1);
            }
            else
            {
               _loc6_.gotoAndStop(_loc6_.totalFrames);
            }
            _loc5_.addEventListener(MouseEvent.MOUSE_OVER,achievementIconOverListener);
            _loc2_++;
         }
         var _loc3_:Rectangle = param1.currentTarget.getBounds(this);
         popup.x = _loc3_.left + _loc3_.width / 2 - popup.width / 2;
         popup.y = _loc3_.top - popup.height + 66;
         if(popup.x + popup.width >= GameWorld.CANVAS_WIDTH - GameWorld.CANVAS_CENTER_X)
         {
            popup.x = GameWorld.CANVAS_WIDTH - GameWorld.CANVAS_CENTER_X - popup.width;
            popup.gotoAndStop(3);
         }
         else if(popup.x < -GameWorld.CANVAS_CENTER_X)
         {
            popup.x = -GameWorld.CANVAS_CENTER_X;
            popup.gotoAndStop(1);
         }
         else
         {
            popup.gotoAndStop(2);
         }
         popup.addEventListener(MouseEvent.ROLL_OUT,popupMouseOutListener,false,0,true);
         var _loc4_:int = int(achievementPanels.indexOf(param1.currentTarget));
         addChild(popup);
      }
      
      public function popupMouseOutListener(param1:MouseEvent) : *
      {
         removeChild(popup);
         popup = null;
      }
      
      public function modeTabClickListener(param1:MouseEvent) : *
      {
         var _loc2_:int = int(modeTabs.indexOf(param1.currentTarget));
         setModeTab(_loc2_);
         resetList();
         trace("modeTabClicked =" + _loc2_);
         switch(_loc2_)
         {
            case MODE_TAB_NORMAL:
               setTab(curTab,curSubTab);
               showScores(getContext());
               break;
            case MODE_TAB_CHALLENGE:
               setTab(curTab,curSubTab);
               showChallengeScores(getContext());
         }
      }
      
      public function showScores(param1:uint) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(GameWorld.cachedHiscores[param1] == null)
         {
            GameWorld.getHighScores(getCurrentUserContext(),getCurrentTimeContext());
         }
         else
         {
            _loc2_ = GameWorld.getUserScoreIndex(GameWorld.cachedHiscores[param1]);
            _loc3_ = GameWorld.centerScores(_loc2_,GameWorld.cachedHiscores[param1],GameWorld.cachedHiscoresRank[param1]);
            updateScores(param1,_loc3_[0],_loc3_[1]);
         }
      }
      
      public function resetList(param1:int = 0) : *
      {
         var _loc2_:* = param1;
         while(_loc2_ < faces.length)
         {
            entries[_loc2_].removeEventListener(MouseEvent.CLICK,onAppUserClicked);
            if(faces[_loc2_].numChildren > 1)
            {
               faces[_loc2_].removeChildAt(1);
            }
            if(brainTypeSprites[_loc2_] != null)
            {
               entries[_loc2_].removeChild(brainTypeSprites[_loc2_]);
            }
            brainTypeSprites[_loc2_] = null;
            brainTypePanels[_loc2_].visible = true;
            nameTextFields[_loc2_].text = "...";
            scoreTextFields[_loc2_].text = "0";
            scoreTextFields[_loc2_].visible = false;
            posTextFields[_loc2_].visible = true;
            posTextFields[_loc2_].text = _loc2_ + 1;
            challengeInfos[_loc2_].visible = false;
            challengeScores[_loc2_].textField.visible = false;
            achievementPanels[_loc2_].achievementMask = 0;
            achievementPanels[_loc2_].removeEventListener(MouseEvent.MOUSE_OVER,achievementOverListener);
            achievementPanels[_loc2_].achievementCount.text = "";
            entries[_loc2_].iphone.visible = false;
            _loc2_++;
         }
      }
      
      public function achievementIconOverListener(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget).parent;
         Engine.setFontSize(_loc2_.textField,9,"CS",12,"CT",12);
         _loc2_.textField.text = Engine.getText("Trophy" + param1.currentTarget.achievementIndex);
      }
      
      public function leftClickListener(param1:int) : *
      {
         var _loc6_:UserInfo = null;
         var _loc7_:Array = null;
         var _loc2_:uint = getContext();
         var _loc3_:int = int(GameWorld.cachedHiscoresRank[_loc2_][GameWorld.cachedHiscoresRank[_loc2_].length - 1]);
         var _loc4_:* = Math.min(curListStartRank[_loc2_] + (SCROLL_WINDOW_SIZE - 1) + param1,_loc3_);
         var _loc5_:* = _loc4_ - (SCROLL_WINDOW_SIZE - 1);
         if(_loc5_ > curListStartRank[_loc2_])
         {
            _loc6_ = GameWorld.getUserWithRank(GameWorld.cachedHiscores[_loc2_],GameWorld.cachedHiscoresRank[_loc2_],_loc4_);
            _loc7_ = getScoreListInRange(GameWorld.cachedHiscores[_loc2_],GameWorld.cachedHiscoresRank[_loc2_],_loc5_,NUM_SCORES - NUM_TOP_SCORES);
            switch(curModeTab)
            {
               case MODE_TAB_NORMAL:
                  updateScores(_loc2_,_loc7_[0],_loc7_[1],NUM_TOP_SCORES);
                  break;
               case MODE_TAB_CHALLENGE:
                  updateChallengeScores(_loc2_,_loc7_[0],_loc7_[1],NUM_TOP_SCORES);
            }
         }
      }
      
      public function getScoreListInRange(param1:Array, param2:Array, param3:int, param4:int) : Array
      {
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         var _loc7_:* = 0;
         while(_loc7_ < param1.length)
         {
            if(param2[_loc7_] >= param3)
            {
               _loc5_.push(param1[_loc7_]);
               _loc6_.push(param2[_loc7_]);
            }
            if(_loc5_.length == param4)
            {
               break;
            }
            _loc7_++;
         }
         return new Array(_loc5_,_loc6_);
      }
      
      public function getCurrentUserContext() : int
      {
         return TAB_TO_USER_CONTEXT[curModeTab][curTab];
      }
      
      public function subTabClickListener(param1:MouseEvent) : *
      {
         var _loc2_:int = int(subTabs.indexOf(param1.currentTarget));
         setTab(curTab,_loc2_);
         switch(curModeTab)
         {
            case MODE_TAB_NORMAL:
               showScores(getContext());
               break;
            case MODE_TAB_CHALLENGE:
               showChallengeScores(getContext());
         }
      }
      
      public function rightClickListener(param1:int) : *
      {
         var _loc4_:UserInfo = null;
         var _loc5_:Array = null;
         var _loc2_:uint = getContext();
         var _loc3_:* = Math.max(curListStartRank[_loc2_] - param1,NUM_TOP_SCORES + 1);
         if(_loc3_ < curListStartRank[_loc2_])
         {
            _loc4_ = GameWorld.getUserWithRank(GameWorld.cachedHiscores[_loc2_],GameWorld.cachedHiscoresRank[_loc2_],_loc3_);
            if(_loc4_ != null)
            {
               _loc5_ = getScoreListInRange(GameWorld.cachedHiscores[_loc2_],GameWorld.cachedHiscoresRank[_loc2_],_loc3_,NUM_SCORES - NUM_TOP_SCORES);
               switch(curModeTab)
               {
                  case MODE_TAB_NORMAL:
                     updateScores(_loc2_,_loc5_[0],_loc5_[1],NUM_TOP_SCORES);
                     break;
                  case MODE_TAB_CHALLENGE:
                     updateChallengeScores(_loc2_,_loc5_[0],_loc5_[1],NUM_TOP_SCORES);
               }
            }
         }
      }
      
      public function setModeTab(param1:int) : *
      {
         var _loc2_:* = undefined;
         if(param1 != curModeTab)
         {
            cachedFaceImages = new Array();
            setButtonMode(modeTabs[param1],false);
            modeTabs[param1].removeEventListener(MouseEvent.CLICK,modeTabClickListener);
            modeTabs[param1].gotoAndStop("down");
            _loc2_ = 0;
            while(_loc2_ < modeTabs.length)
            {
               if(_loc2_ != param1)
               {
                  setButtonMode(modeTabs[_loc2_],true);
                  modeTabs[_loc2_].addEventListener(MouseEvent.CLICK,modeTabClickListener);
               }
               _loc2_++;
            }
            curModeTab = param1;
         }
         _loc2_ = 0;
         while(_loc2_ < entries.length)
         {
            entries[_loc2_].gotoAndStop(curModeTab + 1);
            switch(curModeTab)
            {
               case MODE_TAB_NORMAL:
                  challengeInfos[_loc2_].visible = false;
                  challengeScores[_loc2_].visible = false;
                  break;
               case MODE_TAB_CHALLENGE:
                  challengeInfos[_loc2_].visible = true;
                  challengeScores[_loc2_].visible = true;
                  break;
            }
            _loc2_++;
         }
      }
      
      public function addLoadingAnimations() : *
      {
         resetList();
         var _loc1_:* = 0;
         while(_loc1_ < faces.length)
         {
            faces[_loc1_].addChild(new HiscoreBoxLoading());
            _loc1_++;
         }
      }
      
      public function showChallengeScores(param1:uint) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(GameWorld.cachedHiscores[param1] == null)
         {
            GameWorld.getChallengeScores(getCurrentUserContext(),getCurrentTimeContext());
         }
         else
         {
            _loc2_ = GameWorld.getUserScoreIndex(GameWorld.cachedHiscores[param1]);
            _loc3_ = GameWorld.centerScores(_loc2_,GameWorld.cachedHiscores[param1],GameWorld.cachedHiscoresRank[param1]);
            updateChallengeScores(param1,_loc3_[0],_loc3_[1]);
         }
      }
      
      public function setNameTextField(param1:TextField, param2:String, param3:String) : void
      {
         if(param2 != null && param2.length > 0)
         {
            param1.text = param2;
         }
         else if(param3 != null && param3.length > 0)
         {
            param1.text = param3;
         }
         else
         {
            param1.text = "?";
         }
      }
      
      public function tabClickListener(param1:MouseEvent) : *
      {
         var _loc2_:int = int(tabs.indexOf(param1.currentTarget));
         setTab(_loc2_,curSubTab);
         switch(curModeTab)
         {
            case MODE_TAB_NORMAL:
               showScores(getContext());
               break;
            case MODE_TAB_CHALLENGE:
               showChallengeScores(getContext());
         }
      }
      
      public function onAppUserClicked(param1:MouseEvent) : void
      {
         var _loc4_:UserInfo = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:URLRequest = null;
         var _loc2_:* = getContext();
         var _loc3_:* = entries.indexOf(param1.currentTarget);
         if(_loc3_ < NUM_TOP_SCORES)
         {
            _loc4_ = GameWorld.getUserWithRank(GameWorld.cachedHiscores[_loc2_],GameWorld.cachedHiscoresRank[_loc2_],_loc3_ + 1);
         }
         else
         {
            _loc4_ = GameWorld.getUserWithRank(GameWorld.cachedHiscores[_loc2_],GameWorld.cachedHiscoresRank[_loc2_],curListStartRank[_loc2_] + _loc3_ - NUM_TOP_SCORES);
         }
         if(_loc4_ != null)
         {
            _loc5_ = PFEngine.instance.getParameterString("pf_profile_base");
            if(_loc5_.indexOf("javascript:",0) == 0)
            {
               _loc6_ = _loc5_.substring(JAVASCRIPT_FUNCTION_START,_loc5_.length);
               trace("javascriptFun:" + _loc6_);
               ExternalInterface.call(_loc6_,_loc4_.id);
               ExternalInterface.addCallback("JSCallBack",JSCallBack);
            }
            else
            {
               trace("profileUrl:" + _loc4_.profileUrl);
               _loc7_ = new URLRequest(_loc4_.profileUrl);
               navigateToURL(_loc7_,"_top");
            }
         }
         else
         {
            Engine.openInviteScreen();
         }
      }
      
      public function updateScores(param1:int, param2:Array, param3:Array, param4:int = 0) : *
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:* = false;
         var _loc11_:SocialPlatformUser = null;
         var _loc12_:MovieClip = null;
         var _loc13_:UserInfo = null;
         var _loc14_:int = 0;
         var _loc15_:Sprite = null;
         var _loc16_:* = undefined;
         trace("Try updating highscore context " + param1);
         if(param1 == getContext())
         {
            trace("Updating current highscore context " + param1);
            resetList(param4);
            _loc5_ = InviteRecommendations.instance.getRecommendedUIDsForInvitations();
            _loc6_ = Math.min(_loc5_.length,NUM_INVITES);
            _loc7_ = param4;
            while(_loc7_ < faces.length)
            {
               _loc8_ = _loc7_ - param4;
               _loc10_ = _loc7_ >= faces.length - _loc6_;
               if(_loc10_ || _loc8_ >= param2.length || param2[_loc8_] <= 0)
               {
                  if(_loc10_)
                  {
                     _loc11_ = InviteRecommendations.instance.pickRandomGoodFriendFromBestFriendsList(_loc5_);
                     PFArray.removeFromArray(_loc5_,_loc11_.getID());
                  }
                  if(_loc11_ != null)
                  {
                     _loc9_ = _loc11_.getProfileEntry(SocialPlatformUser.PROFILE_SMALL_PORTRAIT_URL);
                     setNameTextField(nameTextFields[_loc7_],_loc11_.getFirstName(),_loc11_.getFullName());
                     posTextFields[_loc7_].visible = false;
                  }
                  else
                  {
                     _loc9_ = null;
                     setNameTextField(nameTextFields[_loc7_],null,null);
                  }
                  _loc12_ = new InviteIcon();
                  _loc12_.height = faces[_loc7_].height;
                  _loc12_.scaleX = _loc12_.scaleY;
                  _loc12_.x = brainTypePanels[_loc7_].x;
                  _loc12_.y = brainTypePanels[_loc7_].y - faces[_loc7_].height / 2;
                  brainTypeSprites[_loc7_] = _loc12_;
                  entries[_loc7_].addChild(_loc12_);
                  brainTypePanels[_loc7_].visible = false;
                  scoreTextFields[_loc7_].visible = false;
                  entries[_loc7_].buttonMode = true;
                  entries[_loc7_].addEventListener(MouseEvent.CLICK,onAppUserClicked);
               }
               else
               {
                  _loc13_ = param2[_loc8_];
                  _loc14_ = int(param3[_loc8_]);
                  _loc9_ = _loc13_.imageUrl;
                  entries[_loc7_].addEventListener(MouseEvent.CLICK,onAppUserClicked);
                  if(_loc7_ == NUM_TOP_SCORES)
                  {
                     curListStartRank[param1] = _loc14_;
                  }
                  if(_loc13_.profileUrl != null && _loc13_.profileUrl.length > 0)
                  {
                     entries[_loc7_].buttonMode = true;
                     entries[_loc7_].addEventListener(MouseEvent.CLICK,onAppUserClicked);
                  }
                  _loc15_ = GameWorld.getBrainTypeMovieClip(GameWorld.getBrainType(_loc13_.highScore));
                  _loc15_.scaleX = brainTypePanels[_loc7_].scaleX;
                  _loc15_.scaleY = brainTypePanels[_loc7_].scaleY;
                  _loc15_.y = brainTypePanels[_loc7_].y - _loc15_.height / 2;
                  _loc15_.x = brainTypePanels[_loc7_].x;
                  brainTypeSprites[_loc7_] = _loc15_;
                  entries[_loc7_].addChild(_loc15_);
                  brainTypePanels[_loc7_].visible = false;
                  if(_loc13_.profileUrl != null && _loc13_.profileUrl.length > 0)
                  {
                     brainTypeSprites[_loc7_].buttonMode = true;
                     brainTypeSprites[_loc7_].addEventListener(MouseEvent.CLICK,onAppUserClicked);
                  }
                  setNameTextField(nameTextFields[_loc7_],_loc13_.firstName,_loc13_.fullName);
                  achievementPanels[_loc7_].achievementMask = _loc13_.achievementMask;
                  achievementPanels[_loc7_].addEventListener(MouseEvent.MOUSE_OVER,achievementOverListener,false,0,true);
                  scoreTextFields[_loc7_].text = _loc13_.highScore;
                  scoreTextFields[_loc7_].visible = true;
                  posTextFields[_loc7_].text = _loc14_;
                  entries[_loc7_].achieve.achievementCount.text = AchievementHandler.getAchievementCount(_loc13_.achievementMask) + "/" + AchievementHandler.NUM_ACHIEVEMENT;
                  if(Debug.DISPLAY_ALL_TROPHIES || AchievementHandler.hasAchievement(_loc13_.achievementMask,AchievementHandler.IPHONE_PLAYER))
                  {
                     entries[_loc7_].iphone.visible = true;
                  }
               }
               if(cachedFaceImages[_loc9_] == null)
               {
                  _loc16_ = GameWorld.getFaceImageFromURL(_loc9_);
                  if(_loc16_ != null)
                  {
                     faces[_loc7_].addChild(_loc16_);
                     cachedFaceImages[_loc9_] = _loc16_;
                  }
               }
               else
               {
                  faces[_loc7_].addChild(cachedFaceImages[_loc9_]);
               }
               _loc7_++;
            }
         }
      }
      
      public function JSCallBack(param1:Array) : void
      {
      }
      
      public function setTab(param1:int, param2:int) : *
      {
         var _loc3_:* = undefined;
         resetList();
         if(param1 != curTab || param2 != curSubTab)
         {
            cachedFaceImages = new Array();
         }
         if(param1 != curTab)
         {
            setButtonMode(tabs[param1],false);
            tabs[param1].removeEventListener(MouseEvent.CLICK,tabClickListener);
            tabs[param1].gotoAndStop("down");
            _loc3_ = 0;
            while(_loc3_ < tabs.length)
            {
               if(_loc3_ != param1)
               {
                  setButtonMode(tabs[_loc3_],true);
                  tabs[_loc3_].addEventListener(MouseEvent.CLICK,tabClickListener);
               }
               _loc3_++;
            }
            curTab = param1;
         }
         if(param2 != curSubTab)
         {
            setButtonMode(subTabs[param2],false);
            subTabs[param2].removeEventListener(MouseEvent.CLICK,subTabClickListener);
            subTabs[param2].gotoAndStop("down");
            _loc3_ = 0;
            while(_loc3_ < subTabs.length)
            {
               if(_loc3_ != param2)
               {
                  setButtonMode(subTabs[_loc3_],true);
                  subTabs[_loc3_].addEventListener(MouseEvent.CLICK,subTabClickListener);
               }
               _loc3_++;
            }
            curSubTab = param2;
         }
      }
      
      public function updateChallengeScores(param1:int, param2:Array, param3:Array, param4:int = 0) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:MovieClip = null;
         var _loc8_:UserInfo = null;
         var _loc9_:int = 0;
         var _loc10_:* = undefined;
         if(param1 == getContext())
         {
            resetList(param4);
            _loc5_ = param4;
            while(_loc5_ < faces.length)
            {
               _loc6_ = _loc5_ - param4;
               if(_loc6_ >= param2.length || param2[_loc6_] <= 0)
               {
                  challengeInfos[_loc5_].visible = false;
                  _loc7_ = new InviteIcon();
                  _loc7_.height = faces[_loc5_].height;
                  _loc7_.scaleX = _loc7_.scaleY;
                  _loc7_.x = brainTypePanels[_loc5_].x;
                  _loc7_.y = brainTypePanels[_loc5_].y - faces[_loc5_].height / 2;
                  brainTypeSprites[_loc5_] = _loc7_;
                  entries[_loc5_].addChild(_loc7_);
                  brainTypePanels[_loc5_].visible = false;
                  challengeScores[_loc5_].textField.visible = false;
                  entries[_loc5_].buttonMode = true;
               }
               else
               {
                  _loc8_ = param2[_loc6_];
                  _loc9_ = int(param3[_loc6_]);
                  if(_loc5_ == NUM_TOP_SCORES)
                  {
                     curListStartRank[param1] = _loc9_;
                  }
                  if(cachedFaceImages[_loc9_] == null)
                  {
                     _loc10_ = GameWorld.getFaceImageForUser(_loc8_);
                     if(_loc10_ != null)
                     {
                        faces[_loc5_].addChild(_loc10_);
                        cachedFaceImages[_loc9_] = _loc10_;
                     }
                  }
                  else
                  {
                     faces[_loc5_].addChild(cachedFaceImages[_loc9_]);
                  }
                  if(_loc8_.profileUrl != null && _loc8_.profileUrl.length > 0)
                  {
                     entries[_loc5_].buttonMode = true;
                     entries[_loc5_].addEventListener(MouseEvent.CLICK,onAppUserClicked);
                  }
                  if(_loc8_.firstName != null && _loc8_.firstName.length > 0)
                  {
                     nameTextFields[_loc5_].text = _loc8_.firstName;
                  }
                  else if(_loc8_.fullName != null && _loc8_.fullName.length > 0)
                  {
                     nameTextFields[_loc5_].text = _loc8_.fullName;
                  }
                  else
                  {
                     nameTextFields[_loc5_].text = "?";
                  }
                  achievementPanels[_loc5_].achievementMask = _loc8_.achievementMask;
                  achievementPanels[_loc5_].addEventListener(MouseEvent.MOUSE_OVER,achievementOverListener,false,0,true);
                  challengeInfos[_loc5_].winText.text = _loc8_.challengesWon;
                  challengeInfos[_loc5_].loseText.text = _loc8_.challengesLost;
                  challengeScores[_loc5_].textField.text = _loc8_.highScore;
                  challengeInfos[_loc5_].visible = true;
                  challengeScores[_loc5_].textField.visible = true;
                  posTextFields[_loc5_].text = _loc9_;
                  entries[_loc5_].achieve.achievementCount.text = AchievementHandler.getAchievementCount(_loc8_.achievementMask) + "/" + AchievementHandler.NUM_ACHIEVEMENT;
                  if(Debug.DISPLAY_ALL_TROPHIES || AchievementHandler.hasAchievement(_loc8_.achievementMask,AchievementHandler.IPHONE_PLAYER))
                  {
                     entries[_loc5_].iphone.visible = true;
                  }
               }
               _loc5_++;
            }
         }
      }
      
      public function getCurrentTimeContext() : int
      {
         return SUBTAB_TO_TIME_CONTEXT[curSubTab];
      }
      
      override public function notifyLanguageUpdate() : *
      {
         Engine.setFontForLang(scene.tabFriends.textField,"Arial Black");
         Engine.setFontForLang(scene.tabWorld.textField,"Arial Black");
         Engine.setFontForLang(scene.subTabWeek.textField,"Arial Black");
         Engine.setFontForLang(scene.subTabMonth.textField,"Arial Black");
         Engine.setFontForLang(scene.subTabAllTime.textField,"Arial Black");
         Engine.setFontForLang(scene.normalButton.textMC.textField,"Arial Black");
         Engine.setFontForLang(scene.challengeButton.textMC.textField,"Arial Black");
         Engine.setFontSize(scene.subTabWeek.textField,12,"CS",18,"CT",18);
         Engine.setFontSize(scene.subTabMonth.textField,12,"CS",18,"CT",18);
         Engine.setFontSize(scene.subTabAllTime.textField,12,"CS",18,"CT",18);
         scene.tabFriends.textField.text = "FRIENDS";
         scene.tabWorld.textField.text = "WORLD";
         scene.subTabWeek.textField.text = "WEEKLY";
         scene.subTabMonth.textField.text = "MONTHLY";
         scene.subTabAllTime.textField.text = "ALL-TIME";
         scene.normalButton.textMC.textField.text = "Normal";
         scene.challengeButton.textMC.textField.text = "Challenge";
      }
      
      public function setNetwork(param1:String) : *
      {
         if(param1 != null && param1.length > 0)
         {
            param1 = param1.toUpperCase();
            tabs[TAB_NETWORK_SCORES].visible = true;
            tabs[TAB_NETWORK_SCORES].networkName1.networkName.text = param1;
            tabs[TAB_NETWORK_SCORES].networkName1.networkName.mouseEnabled = false;
         }
      }
      
      public function clearHighscoreCaches() : *
      {
         cachedFaceImages = new Array();
      }
      
      public function getContext() : uint
      {
         return SUBTAB_TO_TIME_CONTEXT[curSubTab] | TAB_TO_USER_CONTEXT[curModeTab][curTab];
      }
   }
}
