package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.games.whohasthebiggestbrain.minigames.Calculate;
   import com.playfish.games.whohasthebiggestbrain.minigames.CarPath;
   import com.playfish.games.whohasthebiggestbrain.minigames.CubeCounter;
   import com.playfish.games.whohasthebiggestbrain.minigames.JigsawMatch;
   import com.playfish.games.whohasthebiggestbrain.minigames.MatchCard;
   import com.playfish.games.whohasthebiggestbrain.minigames.MathCombination;
   import com.playfish.games.whohasthebiggestbrain.minigames.MemorySequence;
   import com.playfish.games.whohasthebiggestbrain.minigames.MeteorSequence;
   import com.playfish.games.whohasthebiggestbrain.minigames.MissingSign;
   import com.playfish.games.whohasthebiggestbrain.minigames.SequenceMatch;
   import com.playfish.games.whohasthebiggestbrain.minigames.ShapeOrder;
   import com.playfish.games.whohasthebiggestbrain.minigames.WeightGame;
   
   public class MinigameDefines
   {
      
      public static const MINIGAME_SHAPE_ORDER:int = 0;
      
      public static const MINIGAME_MATCH_CARD:int = 1;
      
      public static const MINIGAME_CALCULATE:int = 2;
      
      public static const MINIGAME_MISSING_SIGN:int = 3;
      
      public static const MINIGAME_CUBE_COUNTER:int = 4;
      
      public static const MINIGAME_WEIGHT_GAME:int = 5;
      
      public static const MINIGAME_METEOR_SEQUENCE:int = 6;
      
      public static const MINIGAME_JIGSAW_MATCH:int = 7;
      
      public static const MINIGAME_MATH_COMBINATION:int = 8;
      
      public static const MINIGAME_SEQUENCE_MATCH:int = 9;
      
      public static const MINIGAME_MEMORY_SEQUENCE:int = 10;
      
      public static const MINIGAME_CAR_PATH:int = 11;
      
      public static const NUM_MINIGAMES:int = 12;
      
      public static const MINIGAME_CAT_ANALYSE:int = 0;
      
      public static const MINIGAME_CAT_CALCULATE:int = 1;
      
      public static const MINIGAME_CAT_MEMORY:int = 2;
      
      public static const MINIGAME_CAT_IDENTIFY:int = 3;
      
      public static const NUM_MINIGAME_CAT:int = 4;
      
      public static const MINIGAMES:Array = [{
         "minigameClass":ShapeOrder,
         "name":"ShapeOrder",
         "category":MINIGAME_CAT_MEMORY,
         "tutorial":TutShapeOrder,
         "tutorialText":LanguageTranslation.getShapeOrderText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":MatchCard,
         "name":"MatchCard",
         "category":MINIGAME_CAT_MEMORY,
         "tutorial":TutCards,
         "tutorialText":LanguageTranslation.getCardPairsText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":Calculate,
         "name":"Calculate",
         "category":MINIGAME_CAT_CALCULATE,
         "tutorial":TutCalc,
         "tutorialText":LanguageTranslation.getMissingNumberText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":MissingSign,
         "name":"MissingSign",
         "category":MINIGAME_CAT_CALCULATE,
         "tutorial":TutMissingSign,
         "tutorialText":LanguageTranslation.getMissingSignText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":CubeCounter,
         "name":"CubeCounter",
         "category":MINIGAME_CAT_ANALYSE,
         "tutorial":TutCubes,
         "tutorialText":LanguageTranslation.getCubeCounterText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":WeightGame,
         "name":"WeightGame",
         "category":MINIGAME_CAT_ANALYSE,
         "tutorial":TutWeight,
         "tutorialText":LanguageTranslation.getBalanceText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":MeteorSequence,
         "name":"MeteorSequence",
         "category":MINIGAME_CAT_IDENTIFY,
         "tutorial":TutMeteor,
         "tutorialText":LanguageTranslation.getAsteroidsText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":JigsawMatch,
         "name":"JigsawMatch",
         "category":MINIGAME_CAT_IDENTIFY,
         "tutorial":TutPuzzle,
         "tutorialText":LanguageTranslation.getJigsawText(LanguageButton.currentLanguage),
         "pro":false
      },{
         "minigameClass":MathCombination,
         "name":"MathCombination",
         "category":MINIGAME_CAT_CALCULATE,
         "tutorial":TutMathCombo,
         "tutorialText":LanguageTranslation.getMathCombText(LanguageButton.currentLanguage),
         "pro":true
      },{
         "minigameClass":SequenceMatch,
         "name":"SequenceMatch",
         "category":MINIGAME_CAT_IDENTIFY,
         "tutorial":TutSequenceMatch,
         "tutorialText":LanguageTranslation.getHexPathText(LanguageButton.currentLanguage),
         "pro":true
      },{
         "minigameClass":MemorySequence,
         "name":"MemorySequence",
         "category":MINIGAME_CAT_MEMORY,
         "tutorial":TutMemSequence,
         "tutorialText":LanguageTranslation.getActionSequenceText(LanguageButton.currentLanguage),
         "pro":true
      },{
         "minigameClass":CarPath,
         "name":"CarPath",
         "category":MINIGAME_CAT_ANALYSE,
         "tutorial":TutCarPath,
         "tutorialText":LanguageTranslation.getCarPathText(LanguageButton.currentLanguage),
         "pro":true
      }];
      
      public static const TUTORIAL_SCENE_CLASS:Array = [BgAnalyse,BgCalculate,BgMemory,BgIdentify];
      
      public static const TUTORIAL_PRE_TEXT_FOR_CATEGORY:Array = [LanguageTranslation.getAnalyticalText(LanguageButton.currentLanguage),LanguageTranslation.getCalculateText(LanguageButton.currentLanguage),LanguageTranslation.getMemoryText(LanguageButton.currentLanguage),LanguageTranslation.getVisualText(LanguageButton.currentLanguage)];
       
      
      public function MinigameDefines()
      {
         super();
      }
      
      public static function refreshMinigameTexts() : void
      {
         var lang:String = LanguageButton.currentLanguage;
         MINIGAMES[0].tutorialText = LanguageTranslation.getShapeOrderText(lang);
         MINIGAMES[1].tutorialText = LanguageTranslation.getCardPairsText(lang);
         MINIGAMES[2].tutorialText = LanguageTranslation.getMissingNumberText(lang);
         MINIGAMES[3].tutorialText = LanguageTranslation.getMissingSignText(lang);
         MINIGAMES[4].tutorialText = LanguageTranslation.getCubeCounterText(lang);
         MINIGAMES[5].tutorialText = LanguageTranslation.getBalanceText(lang);
         MINIGAMES[6].tutorialText = LanguageTranslation.getAsteroidsText(lang);
         MINIGAMES[7].tutorialText = LanguageTranslation.getJigsawText(lang);
         MINIGAMES[8].tutorialText = LanguageTranslation.getMathCombText(lang);
         MINIGAMES[9].tutorialText = LanguageTranslation.getHexPathText(lang);
         MINIGAMES[10].tutorialText = LanguageTranslation.getActionSequenceText(lang);
         MINIGAMES[11].tutorialText = LanguageTranslation.getCarPathText(lang);
         TUTORIAL_PRE_TEXT_FOR_CATEGORY[0] = LanguageTranslation.getAnalyticalText(lang);
         TUTORIAL_PRE_TEXT_FOR_CATEGORY[1] = LanguageTranslation.getCalculateText(lang);
         TUTORIAL_PRE_TEXT_FOR_CATEGORY[2] = LanguageTranslation.getMemoryText(lang);
         TUTORIAL_PRE_TEXT_FOR_CATEGORY[3] = LanguageTranslation.getVisualText(lang);
      }
   }
}
