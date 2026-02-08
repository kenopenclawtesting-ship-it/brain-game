package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import com.playfish.rpc.share.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   
   public class ChallengeFriendsPage extends BaseWorld
   {
      
      private static const SORT_NAME:uint = 2;
      
      private static const SORT_RANK:uint = 0;
      
      private static const SORT_SCORE:uint = 1;
      
      private static const CARD_OFFY:Number = 120;
      
      private static const BAR_NUM:uint = 9;
      
      private static const CARD_OFFX:Number = 90;
       
      
      private var _lineStartIndex:uint = 0;
      
      private var _friendsStartIndex:uint = 0;
      
      private var _lineEnd:uint = 0;
      
      private var _vsPage:ChallengeVS;
      
      private var _cardContainer:MovieClip;
      
      private var _sortButton:MovieClip;
      
      private var _sortType:uint;
      
      private var _cardDestination:Number = 0;
      
      private var _cards:Array;
      
      private var _cardLineY:Array;
      
      private var _bgMC:MovieClip;
      
      public function ChallengeFriendsPage()
      {
         _cards = new Array();
         _cardLineY = new Array();
         super();
         _bgMC = new FriendsPage();
         _bgMC.x = GameWorld.CANVAS_CENTER_X;
         _bgMC.y = GameWorld.CANVAS_CENTER_Y;
         addChild(_bgMC);
         setButtonMode(_bgMC.backButton,true);
         _bgMC.backButton.addEventListener(MouseEvent.MOUSE_DOWN,backButtonListener);
         setButtonMode(_bgMC.okButton,true);
         _bgMC.okButton.addEventListener(MouseEvent.MOUSE_DOWN,enterVsPage,false,0,true);
         Engine.setFontForLang(_bgMC.friendTitle.textfield,"Baveuse");
         _bgMC.friendTitle.textfield.text = Engine.getText("FirendsTitle");
         initSortBar();
         initFriendsInfo();
         ChallengeWorld.playerFace = GameWorld.getFaceImageForUser(GameWorld.currentUserInfo);
      }
      
      public function initFriendsInfo() : void
      {
         setButtonMode(_bgMC.arrowUp,true);
         setButtonMode(_bgMC.arrowDown,true);
         _bgMC.arrowUp.addEventListener(MouseEvent.MOUSE_DOWN,updatePage,false,0,true);
         _bgMC.arrowDown.addEventListener(MouseEvent.MOUSE_DOWN,updatePage,false,0,true);
         setButtonMode(_bgMC.directUp,true);
         setButtonMode(_bgMC.directDown,true);
         _bgMC.directUp.addEventListener(MouseEvent.MOUSE_DOWN,updatePage,false,0,true);
         _bgMC.directDown.addEventListener(MouseEvent.MOUSE_DOWN,updatePage,false,0,true);
         initBar();
         updateNameCard(0);
         ChallengeWorld.challengePlayer = GameWorld.friendsInfo[0];
      }
      
      public function cardMouseOutListener(param1:Event) : void
      {
         param1.currentTarget.scaleX = 1;
         param1.currentTarget.scaleY = 1;
      }
      
      public function updateSort(param1:*) : void
      {
         switch(param1)
         {
            case SORT_RANK:
               _cards.sortOn("challengePoint",Array.DESCENDING | Array.NUMERIC);
               break;
            case SORT_SCORE:
               _cards.sortOn("highScore",Array.DESCENDING | Array.NUMERIC);
               break;
            case SORT_NAME:
               _cards.sortOn("firstName");
         }
         updateFriendsCard();
      }
      
      public function updateBar(param1:uint) : void
      {
         var _loc2_:* = (_cardDestination - _cardContainer.y) / 5;
         _cardContainer.y += _loc2_;
      }
      
      public function updateBigNameBar(param1:uint) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:uint = 0;
         _bgMC.BigNameCard.textMC.T_name.text = GameWorld.friendsInfo[param1].fullName;
         _bgMC.BigNameCard.textMC.T_score.text = GameWorld.friendsInfo[param1].highScore;
         for each(_loc2_ in _cards)
         {
            if(_loc2_.friendIndex == param1)
            {
               _bgMC.BigNameCard.textMC.T_rank.text = _loc2_.challengeRank;
               if(NetworkUid.areEqual(_loc2_.id,GameWorld.currentUserInfo.id))
               {
                  _bgMC.okButton.visible = false;
               }
               else
               {
                  _bgMC.okButton.visible = true;
               }
            }
         }
         _bgMC.BigNameCard.textMC.T_win.text = GameWorld.friendsInfo[param1].challengesWon;
         _bgMC.BigNameCard.textMC.T_lose.text = GameWorld.friendsInfo[param1].challengesLost;
         if(_bgMC.BigNameCard.picBG.numChildren > 1)
         {
            _loc3_ = 1;
            while(_loc3_ < _bgMC.BigNameCard.picBG.numChildren)
            {
               _bgMC.BigNameCard.picBG.removeChild(_bgMC.BigNameCard.picBG.getChildAt(1));
               _loc3_++;
            }
         }
         ChallengeWorld.challengerFace = GameWorld.getFaceImageForUser(GameWorld.friendsInfo[param1]);
         if(ChallengeWorld.challengerFace != null)
         {
            _bgMC.BigNameCard.picBG.addChild(ChallengeWorld.challengerFace);
         }
      }
      
      private function backButtonListener(param1:Event) : void
      {
         Engine.playSound("ButtonInGame",1);
         param1.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN,backButtonListener);
         this.parent.removeChild(this);
         ChallengeWorld.firendsPage = null;
         GameWorld.gameShowFrame.iphoneButton.visible = false;
      }
      
      public function getDestination(param1:uint) : Number
      {
         return _bgMC.cardBG.nameBarPos.y - _cards[param1 * 3].y;
      }
      
      public function updateSortButton(param1:MovieClip) : *
      {
         setButtonMode(_sortButton,true);
         _sortButton = param1;
         setButtonMode(_sortButton,false);
         _sortButton.gotoAndStop("selected");
         param1.buttonMode = true;
      }
      
      public function getTargetLine(param1:uint) : MovieClip
      {
         return _cards[param1 * 3];
      }
      
      public function initBar() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         GameWorld.friendsInfo.sortOn("challengesScore",Array.DESCENDING | Array.NUMERIC);
         _cardContainer = new MovieClip();
         var _loc1_:uint = 0;
         while(_loc1_ < GameWorld.friendsInfo.length)
         {
            _loc2_ = new NameBar();
            _loc2_.id = GameWorld.friendsInfo[_loc1_].id;
            _loc2_.firstName = GameWorld.friendsInfo[_loc1_].firstName;
            _loc2_.highScore = GameWorld.friendsInfo[_loc1_].highScore;
            trace(" GameWorld.friendsInfo[i].highScore" + GameWorld.friendsInfo[_loc1_].highScore);
            trace(" GameWorld.friendsInfo[i].challengesScore" + GameWorld.friendsInfo[_loc1_].challengesScore);
            _loc2_.challengePoint = GameWorld.friendsInfo[_loc1_].challengesScore;
            _loc2_.challengeRank = _loc1_ + 1;
            _loc2_.friendIndex = _loc1_;
            _loc2_.text.T_name.mouseEnabled = false;
            _loc2_.text.T_score.mouseEnabled = false;
            _loc2_.text.T_rank.mouseEnabled = false;
            _loc2_.text.T_name.text = GameWorld.friendsInfo[_loc1_].firstName;
            _loc2_.text.T_score.text = GameWorld.friendsInfo[_loc1_].highScore;
            _loc2_.text.T_rank.text = _loc2_.challengeRank;
            _loc3_ = GameWorld.getFaceImageForUser(GameWorld.friendsInfo[_loc1_]);
            if(_loc3_ != null)
            {
               _loc2_.picBG.addChild(_loc3_);
            }
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,chooseChallenger,false,0,true);
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,cardMouseOverListener,false,0,true);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,cardMouseOutListener,false,0,true);
            _loc2_.x = uint(_loc1_ % 3) * CARD_OFFX;
            _loc2_.y = uint(_loc1_ / 3) * CARD_OFFY;
            _cardContainer.addChild(_loc2_);
            _cards.push(_loc2_);
            _loc1_++;
         }
         if(_cards.length % 3 != 0)
         {
            _lineEnd = _cards.length / 3 + 1;
         }
         else
         {
            _lineEnd = _cards.length / 3;
         }
         _bgMC.cardBG.nameBarPos.visible = false;
         _cardContainer.x = _bgMC.cardBG.nameBarPos.x;
         _cardContainer.y = _bgMC.cardBG.nameBarPos.y;
         _cardDestination = _bgMC.cardBG.nameBarPos.y;
         _cardContainer.cacheAsBitmap = true;
         _bgMC.cardBG.rect.addChild(_cardContainer);
      }
      
      public function initSortBar() : void
      {
         setButtonMode(_bgMC.sortBar.sortRank,true);
         setButtonMode(_bgMC.sortBar.sortScore,true);
         setButtonMode(_bgMC.sortBar.sortName,true);
         _bgMC.sortBar.sortRank.textField.mouseEnabled = false;
         _bgMC.sortBar.sortScore.textField.mouseEnabled = false;
         _bgMC.sortBar.sortName.textField.mouseEnabled = false;
         Engine.setFontForLang(_bgMC.sortBar.sortRank.textField,null);
         Engine.setFontForLang(_bgMC.sortBar.sortScore.textField,null);
         Engine.setFontForLang(_bgMC.sortBar.sortName.textField,null);
         _bgMC.sortBar.sortRank.textField.text = Engine.getText("SortRank");
         _bgMC.sortBar.sortScore.textField.text = Engine.getText("SortScore");
         _bgMC.sortBar.sortName.textField.text = Engine.getText("SortName");
         _bgMC.sortBar.sortRank.textField.y = -_bgMC.sortBar.sortRank.textField.textHeight / 2;
         _bgMC.sortBar.sortScore.textField.y = -_bgMC.sortBar.sortRank.textField.textHeight / 2;
         _bgMC.sortBar.sortName.textField.y = -_bgMC.sortBar.sortRank.textField.textHeight / 2;
         _bgMC.sortBar.sortRank.addEventListener(MouseEvent.MOUSE_DOWN,sortFriends,false,0,true);
         _bgMC.sortBar.sortScore.addEventListener(MouseEvent.MOUSE_DOWN,sortFriends,false,0,true);
         _bgMC.sortBar.sortName.addEventListener(MouseEvent.MOUSE_DOWN,sortFriends,false,0,true);
         _bgMC.sortBar.sortRank.sortType = SORT_RANK;
         _bgMC.sortBar.sortScore.sortType = SORT_SCORE;
         _bgMC.sortBar.sortName.sortType = SORT_NAME;
         _sortType = SORT_RANK;
         updateSortButton(_bgMC.sortBar.sortRank);
      }
      
      public function sortFriends(param1:Event) : void
      {
         updateSortButton(MovieClip(param1.currentTarget));
         _sortType = param1.currentTarget.sortType;
         updateSort(_sortType);
      }
      
      public function enterVsPage(param1:Event) : void
      {
         _vsPage = new ChallengeVS(_bgMC);
         this.addChild(_vsPage);
      }
      
      public function updateNameCard(param1:uint) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in _cards)
         {
            if(NetworkUid.areEqual(_loc2_.id,GameWorld.currentUserInfo.id))
            {
               _loc2_.gotoAndStop(3);
               if(_loc2_.friendIndex == param1)
               {
                  updateBigNameBar(param1);
               }
            }
            else if(_loc2_.friendIndex == param1)
            {
               _loc2_.gotoAndStop(2);
               updateBigNameBar(param1);
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
         }
      }
      
      public function chooseChallenger(param1:Event) : void
      {
         ChallengeWorld.challengePlayer = GameWorld.friendsInfo[param1.currentTarget.friendIndex];
         updateNameCard(param1.currentTarget.friendIndex);
      }
      
      override public function tick(param1:uint) : *
      {
         updateBar(_lineStartIndex);
         if(_vsPage != null)
         {
            _vsPage.tick(0);
         }
      }
      
      public function updatePage(param1:Event) : void
      {
         switch(param1.currentTarget)
         {
            case _bgMC.arrowUp:
               if(_lineStartIndex > 0)
               {
                  --_lineStartIndex;
               }
               break;
            case _bgMC.arrowDown:
               if(_lineStartIndex < _lineEnd - 3)
               {
                  ++_lineStartIndex;
               }
               break;
            case _bgMC.directUp:
               if(_lineStartIndex > 3)
               {
                  _lineStartIndex -= 3;
               }
               else
               {
                  _lineStartIndex = 0;
               }
               break;
            case _bgMC.directDown:
               if(_lineStartIndex < _lineEnd - 5)
               {
                  _lineStartIndex += 3;
               }
               else if(_lineEnd > 3)
               {
                  _lineStartIndex = _lineEnd - 3;
               }
               else
               {
                  _lineStartIndex = 0;
               }
         }
         trace("_lineStartIndex =" + _lineStartIndex);
         _cardDestination = getDestination(_lineStartIndex);
      }
      
      public function updateFriendsCard() : void
      {
         _bgMC.cardBG.rect.removeChild(_cardContainer);
         _cardContainer = new MovieClip();
         _cardContainer.x = _bgMC.cardBG.nameBarPos.x;
         _cardContainer.y = _bgMC.cardBG.nameBarPos.y;
         _cardDestination = _bgMC.cardBG.nameBarPos.y;
         _cardContainer.cacheAsBitmap = true;
         var _loc1_:uint = 0;
         while(_loc1_ < _cards.length)
         {
            _cards[_loc1_].x = uint(_loc1_ % 3) * CARD_OFFX;
            _cards[_loc1_].y = uint(_loc1_ / 3) * CARD_OFFY;
            _cardContainer.addChild(_cards[_loc1_]);
            _loc1_++;
         }
         _bgMC.cardBG.rect.addChild(_cardContainer);
      }
      
      public function cardMouseOverListener(param1:Event) : void
      {
         param1.currentTarget.scaleX = 1.1;
         param1.currentTarget.scaleY = 1.1;
      }
   }
}
