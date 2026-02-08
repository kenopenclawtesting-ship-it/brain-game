package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ProfileChart
   {
       
      
      internal var chartGraphLayer:Sprite;
      
      internal var summaryScene:MovieClip;
      
      internal const CHART_FILL_COLOUR:int = 16711680;
      
      internal const CHART_SCALE:int = 800;
      
      internal var CHART_SCALE_NEW:int;
      
      internal var chartRadius:int;
      
      internal var chartGraphStep:int;
      
      internal var chart:MovieClip;
      
      internal var categoryScores:Array;
      
      public function ProfileChart(param1:MovieClip, param2:MovieClip, param3:Array)
      {
         super();
         this.chart = param2;
         this.summaryScene = param1;
         this.categoryScores = param3;
         var defaultScale:int = 1000;
         var maxScore:int = Math.max(param3[0],param3[1],param3[2],param3[3]);
         if(maxScore > defaultScale)
         {
            CHART_SCALE_NEW = maxScore;
         }
         else
         {
            CHART_SCALE_NEW = defaultScale;
         }
         chartGraphLayer = param2.colorLayer;
         chartGraphLayer.graphics.clear();
         chartGraphLayer.removeChildAt(0);
         chartGraphLayer.rotation = -45;
         chartRadius = chart.width / chart.scaleX / 2;
      }
      
      public function tick() : *
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:int = 0;
         if(chartGraphStep <= CHART_SCALE_NEW)
         {
            chartGraphLayer.graphics.clear();
            chartGraphLayer.graphics.beginFill(CHART_FILL_COLOUR);
            _loc1_ = chartRadius / CHART_SCALE_NEW;
            chartGraphLayer.graphics.moveTo(0,-Math.min(Math.min(categoryScores[MinigameDefines.MINIGAME_CAT_ANALYSE],CHART_SCALE_NEW) * _loc1_,chartGraphStep));
            chartGraphLayer.graphics.lineTo(Math.min(Math.min(categoryScores[MinigameDefines.MINIGAME_CAT_CALCULATE],CHART_SCALE_NEW) * _loc1_,chartGraphStep),0);
            chartGraphLayer.graphics.lineTo(0,Math.min(Math.min(categoryScores[MinigameDefines.MINIGAME_CAT_IDENTIFY],CHART_SCALE_NEW) * _loc1_,chartGraphStep));
            chartGraphLayer.graphics.lineTo(-Math.min(Math.min(categoryScores[MinigameDefines.MINIGAME_CAT_MEMORY],CHART_SCALE_NEW) * _loc1_,chartGraphStep),0);
            chartGraphLayer.graphics.moveTo(0,-Math.min(Math.min(categoryScores[MinigameDefines.MINIGAME_CAT_ANALYSE],CHART_SCALE_NEW) * _loc1_,chartGraphStep));
            chartGraphLayer.graphics.endFill();
         }
         if(summaryScene.score0 != null)
         {
            _loc2_ = chartGraphStep * CHART_SCALE_NEW / chartRadius;
            summaryScene.score0.text = Math.min(_loc2_,categoryScores[MinigameDefines.MINIGAME_CAT_ANALYSE]);
            summaryScene.score1.text = Math.min(_loc2_,categoryScores[MinigameDefines.MINIGAME_CAT_CALCULATE]);
            summaryScene.score2.text = Math.min(_loc2_,categoryScores[MinigameDefines.MINIGAME_CAT_IDENTIFY]);
            summaryScene.score3.text = Math.min(_loc2_,categoryScores[MinigameDefines.MINIGAME_CAT_MEMORY]);
         }
         chartGraphStep += 2;
      }
   }
}
