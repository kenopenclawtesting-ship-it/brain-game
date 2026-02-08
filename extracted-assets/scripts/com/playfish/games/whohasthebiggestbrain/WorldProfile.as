package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class WorldProfile extends BaseWorld
   {
       
      
      internal const PROFILE_ACHIEVEMENT_FRIEND_RANK_RANGE:Array;
      
      internal const PROFILE_ACHIEVEMENT_PLAY_COUNT_RANGE:Array = [[100,int.MAX_VALUE],[50,99],[10,49],[0,9]];
      
      internal const MINIGAME_ENTRY_ORDER:Array = [MinigameDefines.MINIGAME_WEIGHT_GAME,MinigameDefines.MINIGAME_CUBE_COUNTER,MinigameDefines.MINIGAME_CAR_PATH,MinigameDefines.MINIGAME_CALCULATE,MinigameDefines.MINIGAME_MISSING_SIGN,MinigameDefines.MINIGAME_MATH_COMBINATION,MinigameDefines.MINIGAME_MATCH_CARD,MinigameDefines.MINIGAME_SHAPE_ORDER,MinigameDefines.MINIGAME_MEMORY_SEQUENCE,MinigameDefines.MINIGAME_METEOR_SEQUENCE,MinigameDefines.MINIGAME_JIGSAW_MATCH,MinigameDefines.MINIGAME_SEQUENCE_MATCH];
      
      internal var scene:MovieClip;
      
      internal var ScoreToNextLevel:int;
      
      internal const PROFILE_ACHIEVEMENT_FRIEND_COUNT_RANGE:Array;
      
      internal const PROFILE_ACHIEVEMENT_WORLD_RANK_RANGE:Array;
      
      internal var BrainNames:Array;
      
      public function WorldProfile()
      {
         this.BrainNames = [{"name":LanguageTranslation.getAmoebaNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getEarthwormNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getSnailNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getRatNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getCatNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getDogNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getGoatNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getChimpNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getGorillaNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getMissingLinkNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getNeanderthalNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getAverageJoeNameText(LanguageButton.currentLanguage)},{"name":"GEEK"},{"name":"NERD"},{"name":LanguageTranslation.getScholarNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getScientistNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getGeniusNameText(LanguageButton.currentLanguage)},{"name":LanguageTranslation.getSpaceAceNameText(LanguageButton.currentLanguage)},{"name":"CYBORG"},{"name":"ALIEN"},{"name":"SQUIDLIAN"},{"name":"BITBOT"},{"name":"SPACEBOT"},{"name":"CALCUBOT"},{"name":"ENCEPHALOBOT"},{"name":"BRAINBOT"},{"name":"NEUROBOT"},{"name":"COMPUTRON"},{"name":"XENOS"},{"name":"NEURONIAN"},{"name":"AEONIAN"},{"name":"GALAXION"}];
         var entryMC:MovieClip = null;
         var minigameType:int = 0;
         var aggregateScore:* = null;
         var j:* = undefined;
         super();
         GameWorld.removeGameShowFrame();
         scene = new ProfileScene();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         Engine.setFontForLang(scene.profileTitle,"Baveuse");
         Engine.setFontForLang(scene.bestTitle,null);
         Engine.setFontForLang(scene.averageTitle,null);
         scene.profileTitle.text = LanguageTranslation.getProfileButtonText(LanguageButton.currentLanguage);
         scene.bestTitle.text = LanguageTranslation.getBestScoreText(LanguageButton.currentLanguage);
         scene.averageTitle.text = LanguageTranslation.getAverageScoreText(LanguageButton.currentLanguage);
         var i:* = 0;
         while(i < MINIGAME_ENTRY_ORDER.length)
         {
            entryMC = scene["entry" + i];
            if(entryMC != null)
            {
               minigameType = int(MINIGAME_ENTRY_ORDER[i]);
               aggregateScore = null;
               j = 0;
               while(j < GameWorld.minigameAggregateScores.length)
               {
                  if(GameWorld.minigameAggregateScores[j].type == minigameType)
                  {
                     aggregateScore = GameWorld.minigameAggregateScores[j];
                     break;
                  }
                  j++;
               }
               if(aggregateScore != null)
               {
                  entryMC.bestTextField.text = aggregateScore.bestScore;
                  entryMC.averageTextField.text = Math.floor(aggregateScore.totalScore / aggregateScore.playCount);
               }
               else
               {
                  entryMC.bestTextField.text = "0";
                  entryMC.averageTextField.text = "0";
               }
               i++;
            }
            entryMC.bestTextField.mouseEnabled = false;
            entryMC.averageTextField.mouseEnabled = false;
            entryMC.icon.gotoAndStop(minigameType + 1);
            entryMC.gotoAndStop("standard");
            var brainTypeIndex:int = GameWorld.getBrainType(GameWorld.entireHighScore);
            scene.brainTypeSprite.gotoAndStop(brainTypeIndex + 1);
            Engine.setFontForLang(scene.brainTypeTextField,null);
            scene.brainTypeTextField.text = BrainNames[brainTypeIndex].name;
            scene.brainSize.text = GameWorld.entireHighScore;
            var nextBrainTypeIndex:* = brainTypeIndex + 1;
            if(nextBrainTypeIndex < GameWorld.BRAIN_TYPE_SCORE_RANGE.length)
            {
               scene.nextBrainTypeSprite.gotoAndStop(nextBrainTypeIndex + 1);
               Engine.setFontForLang(scene.nextBrainTypeTextField,null);
               ScoreToNextLevel = GameWorld.BRAIN_TYPE_SCORE_RANGE[nextBrainTypeIndex] - GameWorld.entireHighScore + 100;
               scene.nextBrainTypeTextField.text = ScoreToNextLevel + "cm3 from";
            }
            else
            {
               scene.nextBrainTypeSprite.visible = false;
               Engine.setFontForLang(scene.nextBrainTypeTextField,null);
               scene.nextBrainTypeTextField.text = LanguageTranslation.getFinalEvolutionText(LanguageButton.currentLanguage);
            }
            scene.friendsMedal.gotoAndStop(4);
            scene.worldRankMedal.gotoAndStop(1);
            scene.friendRankMedal.gotoAndStop(1);
            setProfileAchievementMedalFrame(GameWorld.playCountNew,scene.playMedal,PROFILE_ACHIEVEMENT_PLAY_COUNT_RANGE);
            scene.bestAtMedal.gotoAndStop(1);
            scene.friendRankMedalTextField.text = LanguageTranslation.getRankAmongFriendsText(LanguageButton.currentLanguage) + "1";
            Number("1");
            scene.playMedalTextField.text = GameWorld.playCountNew + LanguageTranslation.getTotalGamesPlayedText(LanguageButton.currentLanguage);
            scene.friendsMedalTextField.text = "0" + LanguageTranslation.getFriendsPlayingText(LanguageButton.currentLanguage);
            scene.bestAtMedalTextField.text = LanguageTranslation.getBestCategoryText(LanguageButton.currentLanguage);
            scene.worldRankMedalTextField.text = LanguageTranslation.getWorldRankPercentileText(LanguageButton.currentLanguage) + "1";
            setButtonMode(scene.backButton,true);
            scene.backButton.addEventListener(MouseEvent.CLICK,backClickListener);
            Engine.setFontForLang(scene.achievementButton.button.textField,"Baveuse");
            Engine.setFontForLang(scene.statsButton.button.textField,"Baveuse");
            scene.achievementButton.button.textField.text = LanguageTranslation.getTrophiesButtonText(LanguageButton.currentLanguage);
            scene.achievementButton.button.textField.mouseEnabled = false;
            scene.feedbtn.visible = false;
            setButtonMode(scene.achievementButton,true);
            scene.achievementButton.addEventListener(MouseEvent.CLICK,achievementClickListener);
            scene.statsButton.button.textField.text = LanguageTranslation.getCalendarButtonText(LanguageButton.currentLanguage);
            scene.statsButton.button.textField.mouseEnabled = false;
            setButtonMode(scene.statsButton,true);
            scene.statsButton.addEventListener(MouseEvent.CLICK,statsClickListener);
            scene.feedbtn.feed.text.text = "SHARE";
            Engine.setFontForLang(scene.feedbtn.feed.text,"Arnold 2.1");
            Engine.setFontSize(scene.feedbtn.feed.text,16,"EL",14);
         }
      }
      
      public function achievementClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldAchievement());
      }
      
      public function backClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         GameWorld.addGameShowFrame("menu_start");
         GameWorld.startMainMenu();
      }
      
      public function goProClickListener(param1:MouseEvent) : *
      {
         Engine.setActiveWorld(new WorldGoPro(this));
      }
      
      public function setProfileAchievementMedalFrame(param1:int, param2:MovieClip, param3:Array) : *
      {
         var _loc4_:* = 0;
         while(_loc4_ < param3.length)
         {
            if(param1 >= param3[_loc4_][0] && param1 <= param3[_loc4_][1])
            {
               param2.gotoAndStop(_loc4_ + 1);
               return;
            }
            _loc4_++;
         }
         param2.stop();
      }
      
      public function statsClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldStats());
      }
   }
}
