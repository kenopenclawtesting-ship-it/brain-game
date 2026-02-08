package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.*;
   
   public class AchievementHandler
   {
      
      public static const MINIGAME_WEIGHT_OVER:int = 0;
      
      public static const MINIGAME_CUBE_COUNT_OVER:int = 1;
      
      public static const MINIGAME_SHAPE_ORDER_OVER:int = 2;
      
      public static const MINIGAME_CARD_PAIR_OVER:int = 3;
      
      public static const MINIGAME_CALCULATE_OVER:int = 4;
      
      public static const MINIGAME_MISSING_SIGN_OVER:int = 5;
      
      public static const MINIGAME_METEOR_OVER:int = 6;
      
      public static const MINIGAME_PUZZLE_OVER:int = 7;
      
      public static const MINIGAME_CAR_PATH_OVER:int = 8;
      
      public static const MINIGAME_HEXAGON_OVER:int = 9;
      
      public static const MINIGAME_MATH_COMBINATION_OVER:int = 10;
      
      public static const MINIGAME_MEMORY_SEQUENCE_OVER:int = 11;
      
      public static const CHALLENGE_WIN_TIMES:int = 12;
      
      public static const ALL_ROUNDER:int = 13;
      
      public static const PRECISION:int = 14;
      
      public static const TESTS_20:int = 15;
      
      public static const TESTS_100:int = 16;
      
      public static const CHALLENGE_POINT_OVER:int = 17;
      
      public static const OVER_1000:int = 18;
      
      public static const WEEKLY_TOP:int = 19;
      
      public static const IPHONE_PLAYER:int = 20;
      
      public static const NUM_ACHIEVEMENT:int = 21;
      
      public static const THRESHOLD_WEIGHT_OVER:int = 650;
      
      public static const THRESHOLD_CUBE_COUNT_OVER:int = 650;
      
      public static const THRESHOLD_SHAPE_ORDER_OVER:int = 650;
      
      public static const THRESHOLD_CARD_PAIR_OVER:int = 650;
      
      public static const THRESHOLD_CALCULATE_OVER:int = 650;
      
      public static const THRESHOLD_MISSING_SIGN_OVER:int = 650;
      
      public static const THRESHOLD_METEOR_OVER:int = 650;
      
      public static const THRESHOLD_PUZZLE_OVER:int = 650;
      
      public static const THRESHOLD_CAR_PATH_OVER:int = 650;
      
      public static const THRESHOLD_HEXAGON_OVER:int = 650;
      
      public static const THRESHOLD_MATH_COMBINATION_OVER:int = 650;
      
      public static const THRESHOLD_MEMORY_SEQUENCE_OVER:int = 650;
      
      public static const THRESHOLD_SUPER_INVITER:int = 20;
      
      public static const THRESHOLD_ALL_ROUNDER:int = 500;
      
      public static const THRESHOLD_PRECISION:int = 2600;
      
      public static const THRESHOLD_TESTS_20:int = 20;
      
      public static const THRESHOLD_TESTS_100:int = 100;
      
      public static const THRESHOLD_PERFECT_ATTENDANCE:int = 30;
      
      public static const THRESHOLD_OVER_1000:int = 1000;
      
      public static const THRESHOLD_WEEKLY_TOP:int = 1;
      
      public static const THRESHOLD_CHALLENGE_WIN_TIMES:int = 10;
      
      public static const THRESHOLD_CHALLENGE_POINTS_OVER:int = 1000;
      
      public static var pendingAchievements:int = 0;
       
      
      public function AchievementHandler()
      {
         super();
      }
      
      public static function achievementOK(param1:uint) : *
      {
         GameWorld.currentUserInfo.achievementMask = param1;
      }
      
      public static function awardAchievement(param1:uint, param2:int) : *
      {
         if(!hasAchievement(param1,param2) && !hasAchievement(pendingAchievements,param2))
         {
            trace("AAAA" + pendingAchievements);
            pendingAchievements |= 1 << param2;
            trace("bbbbb" + pendingAchievements);
         }
      }
      
      public static function getAchievementCount(param1:uint) : *
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         while(_loc3_ < NUM_ACHIEVEMENT)
         {
            if(hasAchievement(param1,_loc3_))
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function removePendingAchievement(param1:int) : *
      {
         pendingAchievements &= ~(1 << param1);
      }
      
      public static function hasAchievement(param1:uint, param2:int) : Boolean
      {
         return (param1 & 1 << param2) != 0;
      }
      
      private static function achievementPopupConfirm(param1:BaseWorld, param2:int) : *
      {
         removePendingAchievement(param2);
         showPendingAchievement(param1);
      }
      
      public static function showPendingAchievement(param1:BaseWorld) : *
      {
         var i:* = undefined;
         var popup:MovieClip = null;
         var icon:MovieClip = null;
         var parent:BaseWorld = param1;
         if(pendingAchievements != 0)
         {
            i = 0;
            while(i < NUM_ACHIEVEMENT)
            {
               if(AchievementHandler.hasAchievement(pendingAchievements,i))
               {
                  popup = new AchievementUnlockedPopupAnim();
                  icon = new AchieveIcons();
                  icon.gotoAndStop(i + 1);
                  popup.content.icon.addChild(icon);
                  Engine.setFontForLang(popup.content.title_,"Baveuse");
                  popup.content.title_.text = "Trophy Unlocked!";
                  new OverlayConfirm(parent,"Trophy" + i,function():*
                  {
                     achievementPopupConfirm(parent,i);
                  },null,popup,popup.content);
                  break;
               }
               i++;
            }
         }
      }
   }
}
