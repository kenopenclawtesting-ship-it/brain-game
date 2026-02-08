package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.socialplatform.SocialFeed;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.external.*;
   import com.playfish.feed.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class FeedForm
   {
      
      public static var tipName:String;
      
      public static const FEEDID_TAUNT:String = "FeedIDTaunt";
      
      public static const FEEDID_HIGHSCORE:String = "FeedIDHighScore";
      
      public static const DEFAULT_TRANSPORT_TYPE:String = "BrainDefaultTransportType";
      
      public static var feedBtn:MovieClip;
      
      public static const FEEDID_CHALLENGEWIN:String = "FeedIDChallengeWin";
      
      public static var FEEDENABLE:Boolean = true;
      
      public static const GAME_LINK:* = "http://apps.facebook.com/biggestbrain/gameinfo?pf_ria=1&pf_ref=fp";
      
      public static const FEEDID_NOTHING:String = "FeedIDNothing";
      
      public static var waitFeed:String = FEEDID_NOTHING;
      
      public static const FEEDID_HIGHSCORE1:String = "FeedIDHighScore1";
       
      
      public function FeedForm()
      {
         super();
      }
      
      public static function openWaitFeedDialog(param1:Array = null) : *
      {
         if(waitFeed != FEEDID_NOTHING)
         {
            openFeedDialog(waitFeed,param1);
            waitFeed = FEEDID_NOTHING;
         }
      }
      
      public static function showButton() : *
      {
         if(FEEDENABLE)
         {
            feedBtn.visible = true;
         }
      }
      
      public static function feedClick(param1:MouseEvent) : *
      {
         openFeedDialog(tipName);
      }
      
      public static function registerFeedTypes() : void
      {
         SocialPlatform.current.feeds.registerFeedType(FEEDID_HIGHSCORE,DEFAULT_TRANSPORT_TYPE);
         SocialPlatform.current.feeds.registerFeedType(FEEDID_TAUNT,DEFAULT_TRANSPORT_TYPE);
         SocialPlatform.current.feeds.registerFeedType(FEEDID_CHALLENGEWIN,DEFAULT_TRANSPORT_TYPE);
         SocialPlatform.current.feeds.registerFeedType(FEEDID_HIGHSCORE1,DEFAULT_TRANSPORT_TYPE);
      }
      
      public static function feedMouseOver(param1:MouseEvent) : *
      {
         feedBtn.tip.gotoAndStop(tipName);
         feedBtn.tip.visible = true;
      }
      
      public static function hideButton() : *
      {
         feedBtn.visible = false;
      }
      
      public static function initButton(param1:MovieClip, param2:String, param3:Boolean = true) : *
      {
         feedBtn = param1;
         tipName = param2;
         if(FEEDENABLE)
         {
            feedBtn.tip.visible = false;
            feedBtn.tip.feedText.tf.text = Engine.getText("FeedTip");
            trace("==>" + Engine.getText("FeedTip"));
            BaseWorld.setButtonMode(feedBtn,true);
            if(param3)
            {
               feedBtn.addEventListener(MouseEvent.MOUSE_OVER,feedMouseOver);
               feedBtn.addEventListener(MouseEvent.MOUSE_OUT,feedMouseOut);
               feedBtn.addEventListener(MouseEvent.CLICK,feedClick);
            }
         }
         else
         {
            feedBtn.visible = false;
         }
      }
      
      public static function openFeedDialog(param1:String, param2:Array = null) : *
      {
         var lastindex:int;
         var typeIndex:int;
         var imgpath:String;
         var userName:String;
         var tl:String;
         var template:Feed;
         var feed:SocialFeed;
         var feedId:String = param1;
         var p:Array = param2;
         if(!FEEDENABLE)
         {
            return;
         }
         template = new Feed("general-template");
         tl = Engine.localiser.curLangCode;
         if(tl != "en")
         {
            Engine.localiser.setLang("en");
         }
         feed = SocialPlatform.current.feeds.createFeed(feedId,true);
         feed.createLink("Play WHTBB",GAME_LINK);
         userName = GameWorld.currentUserInfo.firstName;
         lastindex = int(template.imgSrc[0].toString().lastIndexOf("/"));
         imgpath = template.imgSrc[0].toString().substring(0,lastindex + 1);
         typeIndex = GameWorld.getBrainType(GameWorld.currentUserInfo.highScore);
         switch(feedId)
         {
            case FEEDID_HIGHSCORE:
            case FEEDID_HIGHSCORE1:
               feed.addStreamData(feed.createTitleText("Share your achievement with your friends?"));
               feed.addStreamData(feed.createInformationText(userName + " has a brain size rating of " + Engine.getText("BrainTypeName" + typeIndex) + " with a score of " + GameWorld.currentUserInfo.highScore + " cm3 according to Who Has The Biggest Brain?",GAME_LINK));
               feed.addStreamData(feed.createDescriptionText(userName + "\'s performance shines in " + Engine.getText("Category" + (GameWorld.currentUserInfo.bestCategory - 1)) + "."));
               feed.addStreamData(feed.createMediaImage(imgpath + "braintype" + typeIndex.toString() + ".png",GAME_LINK,""));
               break;
            case FEEDID_TAUNT:
               feed.addStreamData(feed.createTitleText("Send your friend a taunt?"));
               feed.addStreamData(feed.createInformationText("Who Has The Biggest Brain? Newsflash!",GAME_LINK));
               feed.addStreamData(feed.createDescriptionText(userName + " officially has a bigger brain than " + p[0].firstName + "!"));
               feed.addStreamData(feed.createMediaImage(imgpath + "taunt_1.png",GAME_LINK,""));
               break;
            case FEEDID_CHALLENGEWIN:
               feed.addStreamData(feed.createTitleText("Send your friend a taunt?"));
               feed.addStreamData(feed.createInformationText("Official Who Has The Biggest Brain Challenge Newsflash!",GAME_LINK));
               feed.addStreamData(feed.createDescriptionText(userName + " just won a challenge against " + p[0].firstName + "!"));
               feed.addStreamData(feed.createMediaImage(imgpath + "challenge_1.png",GAME_LINK,""));
         }
         feed.publish(function(param1:Event):void
         {
            PFDebug.trace("FEED","Feed publish successful");
         });
         if(tl != "en")
         {
            Engine.localiser.setLang(tl);
         }
      }
      
      public static function feedMouseOut(param1:MouseEvent) : *
      {
         feedBtn.tip.visible = false;
      }
   }
}
