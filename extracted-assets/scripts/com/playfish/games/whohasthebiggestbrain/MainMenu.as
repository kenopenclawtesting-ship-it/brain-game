package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import com.playfish.rpc.brain.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.media.*;
   import flash.net.*;
   
   public class MainMenu extends BaseWorld
   {
      
      private static var invitePopUpDisplayed:Boolean = false;
       
      
      internal const MENU_ITEM_PLAY:int = 0;
      
      internal const MENU_ITEM_ACHIEVEMENT:int = 2;
      
      internal const MENU_ITEM_PROFILE:int = 3;
      
      internal const MENU_ITEM_INVITE:int = 1;
      
      internal const MENU_ITEM_MINIGAME:int = 5;
      
      internal var menuItems:Array;
      
      internal var visitUsUrl:String = "http://www.playfish.com";
      
      internal const MUNU_ITEM_CHALLENGE:int = 4;
      
      internal var inviteUrl:String = "http://www.playfish.com";
      
      internal var speechText:SpeechTextObject;
      
      public function MainMenu()
      {
         var _loc2_:String = null;
         var _loc3_:OverlayConfirm = null;
         super();
         var _loc1_:* = Engine.instance.getParameter("pf_invite_url");
         if(_loc1_ != null)
         {
            inviteUrl = _loc1_;
         }
         _loc1_ = Engine.instance.getParameter("pf_visitus_url");
         if(_loc1_ != null)
         {
            visitUsUrl = _loc1_;
         }
         initMenuScene();
         if(!invitePopUpDisplayed)
         {
            invitePopUpDisplayed = true;
            _loc2_ = WorldAdvert.adClient.getCustom("invite_pop_up");
            if(_loc2_ != null && Engine.rnd(0,100) < int(_loc2_))
            {
               _loc3_ = new OverlayConfirm(this,"Who Has The Biggest Brain? Is a lot more fun when you enjoy it with your friends! Choose which friends to share the game with now.",onInvitePopUpOK,null,new InvitePopup());
            }
         }
         GameWorld.setProfessorState("ProfessorHappy");
         if(!Engine.isSoundPlaying("ThemeMusic"))
         {
            Engine.playSound("ThemeMusic",-1);
         }
         addEventListener(Event.ADDED_TO_STAGE,onStageOrLanguageEvent);
      }
      
      public static function dummy() : *
      {
      }
      
      public function removeMouseListeners() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < menuItems.length)
         {
            setButtonMode(menuItems[_loc1_],false);
            menuItems[_loc1_].removeEventListener(MouseEvent.CLICK,menuItemMouseClickListener);
            _loc1_++;
         }
         setButtonMode(GameWorld.gameShowFrame.languageButton,false);
         setButtonMode(GameWorld.gameShowFrame.qualityButton,false);
         setButtonMode(GameWorld.gameShowFrame.soundButton,false);
         GameWorld.gameShowFrame.soundButton.removeEventListener(MouseEvent.CLICK,GameWorld.soundButtonClicked);
         GameWorld.gameShowFrame.qualityButton.removeEventListener(MouseEvent.CLICK,GameWorld.qualityButtonClicked);
         GameWorld.gameShowFrame.languageButton.removeEventListener(MouseEvent.CLICK,GameWorld.languageButtonClicked);
         GameWorld.gameShowFrame.languageButton.button.textField.visible = false;
      }
      
      private function onInvitePopUpOK() : void
      {
         Engine.openInviteScreen();
      }
      
      override public function tick(param1:uint) : *
      {
         if(speechText != null)
         {
            speechText.tick(param1);
         }
         if(GameWorld.gameShowFrame.currentLabel == "menu_idle")
         {
            GameWorld.gameShowFrame.languageButton.button.textField.visible = true;
         }
      }
      
      public function menuItemMouseClickListener(param1:MouseEvent) : *
      {
         var index:*;
         var e:MouseEvent = param1;
         Engine.playSound("ButtonMenu",1);
         index = menuItems.indexOf(e.currentTarget);
         if(index == MENU_ITEM_PLAY)
         {
            try
            {
               GameWorld.setProfessorState("ProfessorTalk");
               removeMouseListeners();
               Engine.setActiveWorld(new WorldGameSelect());
            }
            catch(e:Error)
            {
               GameWorld.rpcClient.recordGameEvent(RpcClient.GAME_EVENT_DEBUG,"error start game: " + e.toString(),dummy,dummy);
            }
         }
         else if(index == MENU_ITEM_INVITE)
         {
            if(Debug.TEST_FEED_FORM)
            {
               Engine.setActiveWorld(new WorldGloat());
            }
            else if(inviteUrl != null)
            {
               Engine.openInviteScreen();
            }
         }
         else if(index == MENU_ITEM_ACHIEVEMENT)
         {
            if(Debug.TEST_FEED_FORM)
            {
               Engine.setActiveWorld(new ChallengeSummary());
               GameWorld.isCheckingResultPage = true;
               ChallengeSummary.setResult(GameWorld.currentUserInfo,GameWorld.friendsHiscores[0],1,0,1,0);
            }
            else
            {
               Engine.setActiveWorld(new WorldAchievement());
            }
         }
         else if(index == MENU_ITEM_PROFILE)
         {
            Engine.setActiveWorld(new WorldProfile());
         }
         else if(index == MENU_ITEM_MINIGAME)
         {
            removeMouseListeners();
            GameWorld.gameState = GameWorld.GS_TEST_MINIGAME;
            Engine.setActiveWorld(new MinigameMenu());
         }
         else if(index == MUNU_ITEM_CHALLENGE)
         {
            removeMouseListeners();
            Engine.setActiveWorld(new ChallengeWorld());
         }
         if(index != MENU_ITEM_INVITE && index != MENU_ITEM_PROFILE && index != MENU_ITEM_ACHIEVEMENT)
         {
            GameWorld.gameShowFrame.iphoneButton.visible = false;
         }
         if(GameWorld.languageButtonNew != null)
         {
            GameWorld.languageButtonNew.visible = false;
         }
      }
      
      public function iphoneButtonOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = GameWorld.gameShowFrame.iphoneButton.getChildAt(0);
         if(!_loc2_.visible)
         {
            _loc2_.visible = true;
            _loc2_.gotoAndPlay(1);
         }
      }
      
      override public function notifyLanguageUpdate() : *
      {
         Engine.setFontForLang(GameWorld.gameShowFrame.playButton.button.textField,"Baveuse");
         Engine.setFontForLang(GameWorld.gameShowFrame.inviteButton.button.textField,"Baveuse");
         Engine.setFontForLang(GameWorld.gameShowFrame.achievementButton.button.textField,"Baveuse");
         Engine.setFontForLang(GameWorld.gameShowFrame.profileButton.button.textField,"Baveuse");
         Engine.setFontForLang(GameWorld.gameShowFrame.challengeButton.button.textField,"Baveuse");
         Engine.setFontForLang(GameWorld.gameShowFrame.iphoneButton.getChildAt(0).bubble.textInst,null);
         Engine.setFontForLang(GameWorld.gameShowFrame.challengeRequest.mc.title.textField,null);
         GameWorld.gameShowFrame.playButton.button.textField.text = LanguageTranslation.getPlayButtonText(LanguageButton.currentLanguage);
         GameWorld.gameShowFrame.inviteButton.button.textField.text = LanguageTranslation.getInviteButtonText(LanguageButton.currentLanguage);
         GameWorld.gameShowFrame.achievementButton.button.textField.text = LanguageTranslation.getTrophiesButtonText(LanguageButton.currentLanguage);
         GameWorld.gameShowFrame.profileButton.button.textField.text = LanguageTranslation.getProfileButtonText(LanguageButton.currentLanguage);
         GameWorld.gameShowFrame.challengeButton.button.textField.text = LanguageTranslation.getChallengeButtonText(LanguageButton.currentLanguage);
         GameWorld.gameShowFrame.challengeRequest.mc.title.textField.text = "You have a challenge request";
         GameWorld.gameShowFrame.iphoneButton.getChildAt(0).bubble.textInst.text = "Play on mobile!";
         var _loc1_:* = GameWorld.gameShowFrame.iphoneButton.getChildAt(0).bubble.textInst.numLines;
         GameWorld.gameShowFrame.iphoneButton.getChildAt(0).bubble.textInst.y = _loc1_ == 1 ? -9 : -16;
         initSpeechBubble();
         GameWorld.gameShowFrame.logo.gotoAndStop("pro");
         GameWorld.gameShowFrame.goProButton.main_.gotoAndStop("normal");
         if(speechText)
         {
            speechText.close();
            speechText = null;
         }
         initSpeechBubble();
      }
      
      private function onStageOrLanguageEvent(e:Event) : void
      {
         if(e.type == Event.ADDED_TO_STAGE)
         {
            removeEventListener(Event.ADDED_TO_STAGE,onStageOrLanguageEvent);
            if(stage)
            {
               stage.addEventListener(LanguageButton.LANGUAGE_CHANGED,onStageOrLanguageEvent,false,0,true);
            }
         }
         else if(e.type == LanguageButton.LANGUAGE_CHANGED)
         {
            GameWorld.currentLang = LanguageButton.currentLanguage;
            GameWorld.gameShowFrame.playButton.button.textField.text = LanguageTranslation.getPlayButtonText(GameWorld.currentLang);
            GameWorld.gameShowFrame.inviteButton.button.textField.text = LanguageTranslation.getInviteButtonText(GameWorld.currentLang);
            GameWorld.gameShowFrame.achievementButton.button.textField.text = LanguageTranslation.getTrophiesButtonText(GameWorld.currentLang);
            GameWorld.gameShowFrame.profileButton.button.textField.text = LanguageTranslation.getProfileButtonText(GameWorld.currentLang);
            GameWorld.gameShowFrame.challengeButton.button.textField.text = LanguageTranslation.getChallengeButtonText(GameWorld.currentLang);
            if(speechText)
            {
               speechText.close();
               speechText = null;
            }
            initSpeechBubble();
            notifyLanguageUpdate();
         }
      }
      
      public function initMenuScene() : *
      {
         GameWorld.gameShowFrameGotoandPlay("menu_start");
         initSpeechBubble();
         MinigameDefines.refreshMinigameTexts();
         menuItems = new Array();
         menuItems.push(GameWorld.gameShowFrame.playButton);
         menuItems.push(GameWorld.gameShowFrame.inviteButton);
         menuItems.push(GameWorld.gameShowFrame.achievementButton);
         menuItems.push(GameWorld.gameShowFrame.profileButton);
         menuItems.push(GameWorld.gameShowFrame.challengeButton);
         GameWorld.gameShowFrame.playButton.button.textField.mouseEnabled = false;
         GameWorld.gameShowFrame.inviteButton.button.textField.mouseEnabled = false;
         GameWorld.gameShowFrame.achievementButton.button.textField.mouseEnabled = false;
         GameWorld.gameShowFrame.profileButton.button.textField.mouseEnabled = false;
         GameWorld.gameShowFrame.challengeButton.button.textField.mouseEnabled = false;
         var iphoneTag:MovieClip = new IphoneTagAnimation();
         iphoneTag.x = -25;
         GameWorld.gameShowFrame.iphoneButton.mouseChildren = false;
         GameWorld.gameShowFrame.iphoneButton.addChildAt(iphoneTag,0);
         GameWorld.gameShowFrame.iphoneButton.addEventListener(MouseEvent.MOUSE_OVER,iphoneButtonOver);
         notifyLanguageUpdate();
         var i:int = 0;
         while(i < menuItems.length)
         {
            setButtonMode(menuItems[i],true);
            menuItems[i].addEventListener(MouseEvent.CLICK,menuItemMouseClickListener,false,0,true);
            i++;
         }
      }
      
      public function initSpeechBubble() : *
      {
         var _loc1_:RandomBasket = null;
         speechText = new SpeechTextObject(GameWorld.gameShowFrame.speechTextField.speechText,GameWorld.gameShowFrame.speechTextField);
         if(GameWorld.numberRoundsPlayed == 0)
         {
            if(GameWorld.currentUserInfo == null || GameWorld.currentUserInfo.highScore == 0)
            {
               speechText.addString(LanguageTranslation.getWelcomeText1(LanguageButton.currentLanguage));
            }
            else
            {
               _loc1_ = new RandomBasket();
               _loc1_.addItems(LanguageTranslation.getWelcomeText2(LanguageButton.currentLanguage)[0],LanguageTranslation.getWelcomeText2(LanguageButton.currentLanguage)[1],LanguageTranslation.getWelcomeText2(LanguageButton.currentLanguage)[2]);
               speechText.addString(String(_loc1_.getNextItem()));
            }
            if(GameWorld.friendsHiscores != null && GameWorld.friendsHiscores.length > 1)
            {
               _loc1_ = new RandomBasket();
               _loc1_.addItems(LanguageTranslation.getWelcomeText3(LanguageButton.currentLanguage)[0],LanguageTranslation.getWelcomeText3(LanguageButton.currentLanguage)[1],LanguageTranslation.getWelcomeText3(LanguageButton.currentLanguage)[2]);
               speechText.addString(String(_loc1_.getNextItem()));
            }
         }
         else
         {
            _loc1_ = new RandomBasket();
            _loc1_.addItems(LanguageTranslation.getInviteText2(LanguageButton.currentLanguage)[0],LanguageTranslation.getInviteText2(LanguageButton.currentLanguage)[1],LanguageTranslation.getInviteText2(LanguageButton.currentLanguage)[2]);
            speechText.addString(String(_loc1_.getNextItem()));
         }
      }
   }
}
