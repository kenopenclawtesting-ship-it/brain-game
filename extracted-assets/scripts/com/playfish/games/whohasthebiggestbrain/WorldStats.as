package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import flash.display.*;
   import flash.events.*;
   
   public class WorldStats extends BaseWorld
   {
      
      internal static var historicScores:Array;
       
      
      internal var curToolTip:MovieClip;
      
      internal var cellWidth:int = 16;
      
      internal var scene:MovieClip;
      
      internal var curClosestDot:MovieClip;
      
      internal const GRAPH_TYPE_OVERALL:int = 0;
      
      internal var curYear:int = 0;
      
      internal var historicScoreIndex:int;
      
      internal var curMonth:int = 0;
      
      internal var graphLayer:Sprite;
      
      private var graphType:int = 0;
      
      internal var cellHeight:int = 25;
      
      internal var valuePerCellY:int = 500;
      
      internal const DAYS_IN_MONTH:Array = [31,28,31,30,31,30,31,31,30,31,30,31];
      
      internal var minYear:int;
      
      internal var scaleTextFields:Array;
      
      internal const MINIGAME_GRAPH_COLOUR:Array = [7265159,7265159,16771182,16771182,16089213,16089213,8566498,8566498,16771182,8566498,7265159,16089213];
      
      internal const MINIGAME_GRAPH_SCALE_PER_CELL:int = 150;
      
      internal var maxYear:int;
      
      internal const NUM_MONTH:int = 12;
      
      internal var dots:Array;
      
      internal var numCellsX:int = 31;
      
      internal var minMonth:int;
      
      internal const OVERALL_GRAPH_COLOUR:int = 10526880;
      
      internal var minigameIcons:Array;
      
      internal const GRAPH_TYPE_MINIGAME:int = 1;
      
      internal const OVERALL_GRAPH_SCALE_PER_CELL:int = 500;
      
      internal var maxMonth:int;
      
      public function WorldStats()
      {
         var _loc4_:* = undefined;
         dots = new Array();
         super();
         GameWorld.removeGameShowFrame();
         scene = new StatsScene();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         Engine.setFontForLang(scene.calendarTitle,null);
         scene.calendarTitle.text = Engine.getText("MenuItemCalendar");
         scaleTextFields = new Array();
         var _loc1_:int = 0;
         while(scene.chart.content["scaleTextField" + _loc1_] != null)
         {
            scaleTextFields.push(scene.chart.content["scaleTextField" + _loc1_]);
            _loc1_++;
         }
         minigameIcons = new Array();
         var _loc2_:* = 0;
         while(_loc2_ < MinigameDefines.NUM_MINIGAMES)
         {
            (_loc4_ = scene["minigameIcon" + _loc2_]).selected = false;
            minigameIcons[_loc2_] = _loc4_;
            setButtonMode(_loc4_,true);
            _loc2_++;
         }
         setButtonMode(scene.overallIcon,true);
         setButtonMode(scene.nextMonthButton,true);
         setButtonMode(scene.prevMonthButton,true);
         setButtonMode(scene.backButton,true);
         scene.backButton.addEventListener(MouseEvent.CLICK,backClickListener);
         Engine.setFontForLang(scene.profileButton.button.textField,null);
         scene.profileButton.button.textField.text = Engine.getText("MenuItemProfile");
         scene.profileButton.button.textField.mouseEnabled = false;
         setButtonMode(scene.profileButton,true);
         scene.profileButton.addEventListener(MouseEvent.CLICK,profileClickListener);
         Engine.setFontForLang(scene.achievementButton.button.textField,null);
         scene.achievementButton.button.textField.text = Engine.getText("MenuItemTrophy");
         scene.achievementButton.button.textField.mouseEnabled = false;
         setButtonMode(scene.achievementButton,true);
         scene.achievementButton.addEventListener(MouseEvent.CLICK,achievementClickListener);
         scene.chart.addEventListener(MouseEvent.MOUSE_MOVE,mouseChartMoveListener);
         scene.chart.addEventListener(MouseEvent.ROLL_OUT,mouseChartOutListener);
         graphLayer = new Sprite();
         scene.chart.content.addChild(graphLayer);
         var _loc3_:Date = new Date();
         setDate(_loc3_.getMonth(),_loc3_.getFullYear());
         if(historicScores != null)
         {
            initStats();
         }
         else
         {
            GameWorld.rpcClient.getHistoricScores(getHistoricScoresOK,getHistoricScoresFail);
         }
      }
      
      public static function resetCachedStats() : *
      {
         historicScores = null;
      }
      
      public function clearGraph() : *
      {
         var _loc1_:* = undefined;
         graphLayer.graphics.clear();
         if(dots != null)
         {
            _loc1_ = 0;
            while(_loc1_ < dots.length)
            {
               graphLayer.removeChild(dots[_loc1_]);
               _loc1_++;
            }
         }
         dots = new Array();
      }
      
      public function nextMonthClickListener(param1:MouseEvent) : *
      {
         if(curYear < maxYear || curYear == maxYear && curMonth < maxMonth)
         {
            Engine.playSound("ButtonMenu",1);
            ++curMonth;
            if(curMonth >= NUM_MONTH)
            {
               ++curYear;
               curMonth -= NUM_MONTH;
            }
            setDate(curMonth,curYear);
            updateCurrentGraph();
            scene.chart.gotoAndPlay("right");
         }
      }
      
      public function overallIconClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         var _loc2_:* = 0;
         while(_loc2_ < minigameIcons.length)
         {
            minigameIcons[_loc2_].selected = false;
            setButtonMode(minigameIcons[_loc2_],true);
            _loc2_++;
         }
         setButtonMode(scene.overallIcon,false);
         scene.overallIcon.gotoAndStop("selected");
         graphType = GRAPH_TYPE_OVERALL;
         updateCurrentGraph();
      }
      
      public function paintGraph(param1:int, param2:Array, param3:String, param4:int) : *
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:AggregateScore = null;
         var _loc11_:* = undefined;
         var _loc12_:MovieClip = null;
         var _loc5_:Graphics;
         (_loc5_ = graphLayer.graphics).lineStyle(2,param1);
         var _loc8_:Boolean = true;
         var _loc9_:* = 0;
         while(_loc9_ < param2.length)
         {
            _loc10_ = null;
            _loc11_ = 0;
            while(_loc11_ < param2[_loc9_].scores.length)
            {
               if(param2[_loc9_].scores[_loc11_].type == param4)
               {
                  _loc10_ = param2[_loc9_].scores[_loc11_];
                  break;
               }
               _loc11_++;
            }
            if(_loc10_ != null)
            {
               _loc6_ = (param2[_loc9_].date.getDate() - 1) * cellWidth + cellWidth / 2;
               _loc7_ = -_loc10_.bestScore * cellHeight / valuePerCellY + scaleTextFields[0].y + scaleTextFields[0].height / 2;
               if(_loc8_)
               {
                  _loc5_.moveTo(_loc6_,_loc7_);
                  _loc8_ = false;
               }
               else
               {
                  _loc5_.lineTo(_loc6_,_loc7_);
               }
               (_loc12_ = new StatDot()).gotoAndStop("idle" + param3);
               _loc12_.x = _loc6_;
               _loc12_.y = _loc7_;
               _loc12_.category = param3;
               _loc12_.score = _loc10_.bestScore;
               dots.push(_loc12_);
               graphLayer.addChild(_loc12_);
            }
            _loc9_++;
         }
      }
      
      public function getHistoricScoresFail() : *
      {
      }
      
      public function minigameIconClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         if(graphType != GRAPH_TYPE_MINIGAME)
         {
            setButtonMode(scene.overallIcon,true);
         }
         graphType = GRAPH_TYPE_MINIGAME;
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         if(_loc2_.selected)
         {
            _loc2_.selected = false;
            setButtonMode(_loc2_,true);
         }
         else
         {
            _loc2_.selected = true;
            setButtonMode(_loc2_,false);
            _loc2_.buttonMode = true;
            _loc2_.gotoAndStop("selected");
         }
         updateCurrentGraph();
      }
      
      public function getScores(param1:int, param2:int) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Array = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < historicScores.length)
         {
            _loc5_ = int(historicScores[_loc4_].date.getMonth());
            if((_loc6_ = int(historicScores[_loc4_].date.getFullYear())) < param2 || _loc6_ == param2 && _loc5_ < param1)
            {
               break;
            }
            if(_loc5_ == param1 && _loc6_ == param2)
            {
               _loc3_.push(historicScores[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function backClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         GameWorld.startMainMenu();
      }
      
      public function setDate(param1:int, param2:int) : *
      {
         curMonth = param1;
         curYear = param2;
         Engine.setFontForLang(scene.month,null);
         scene.month.text = Engine.getText("Month" + (curMonth + 1)) + "  " + curYear;
         scene.chart.content.gotoAndStop(DAYS_IN_MONTH[curMonth] - 28 + 1);
      }
      
      public function getHistoricScoresOK(param1:Array) : *
      {
         if(param1 != null && param1.length > 0)
         {
            historicScores = param1;
            initStats();
         }
      }
      
      public function updateCurrentGraph() : *
      {
         var _loc1_:Array = null;
         var _loc2_:* = undefined;
         clearGraph();
         if(graphType == GRAPH_TYPE_OVERALL)
         {
            updateScale(OVERALL_GRAPH_SCALE_PER_CELL);
            _loc1_ = getScores(curMonth,curYear);
            trace("updateCurrentGraph graphType=GRAPH_TYPE_OVERALL",_loc1_.length,_loc1_);
            paintGraph(OVERALL_GRAPH_COLOUR,getScores(curMonth,curYear),"",AggregateScore.COMBINED_SCORE);
         }
         else if(graphType == GRAPH_TYPE_MINIGAME)
         {
            updateScale(MINIGAME_GRAPH_SCALE_PER_CELL);
            _loc2_ = 0;
            while(_loc2_ < minigameIcons.length)
            {
               if(minigameIcons[_loc2_].selected)
               {
                  paintGraph(MINIGAME_GRAPH_COLOUR[_loc2_],getScores(curMonth,curYear),MinigameDefines.MINIGAMES[_loc2_].category,_loc2_);
               }
               _loc2_++;
            }
         }
      }
      
      public function mouseChartOutListener(param1:MouseEvent) : *
      {
         if(curClosestDot != null)
         {
            curClosestDot.gotoAndStop("idle" + curClosestDot.category);
            curClosestDot = null;
            graphLayer.removeChild(curToolTip);
            curToolTip = null;
         }
      }
      
      public function updateScale(param1:int) : *
      {
         valuePerCellY = param1;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         while(_loc3_ < scaleTextFields.length)
         {
            scaleTextFields[_loc3_].text = _loc2_;
            _loc2_ += valuePerCellY;
            _loc3_++;
         }
      }
      
      public function prevMonthClickListener(param1:MouseEvent) : *
      {
         if(curYear > minYear || curYear == minYear && curMonth > minMonth)
         {
            Engine.playSound("ButtonMenu",1);
            --curMonth;
            if(curMonth < 0)
            {
               --curYear;
               curMonth += NUM_MONTH;
            }
            setDate(curMonth,curYear);
            updateCurrentGraph();
            scene.chart.gotoAndPlay("left");
         }
      }
      
      public function profileClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldProfile());
      }
      
      public function achievementClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldAchievement());
      }
      
      public function initStats() : *
      {
         historicScoreIndex = 0;
         setDate(historicScores[0].date.getMonth(),historicScores[0].date.getFullYear());
         maxYear = curYear;
         maxMonth = curMonth;
         minYear = historicScores[historicScores.length - 1].date.getFullYear();
         minMonth = historicScores[historicScores.length - 1].date.getMonth();
         scene.nextMonthButton.addEventListener(MouseEvent.CLICK,nextMonthClickListener);
         scene.prevMonthButton.addEventListener(MouseEvent.CLICK,prevMonthClickListener);
         var _loc1_:* = 0;
         while(_loc1_ < MinigameDefines.NUM_MINIGAMES)
         {
            scene["minigameIcon" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,minigameIconClickListener);
            _loc1_++;
         }
         setButtonMode(scene.overallIcon,false);
         scene.overallIcon.gotoAndStop("selected");
         scene.overallIcon.addEventListener(MouseEvent.MOUSE_DOWN,overallIconClickListener);
         paintGraph(OVERALL_GRAPH_COLOUR,getScores(curMonth,curYear),"",AggregateScore.COMBINED_SCORE);
      }
      
      public function mouseChartMoveListener(param1:MouseEvent) : *
      {
         var _loc3_:MovieClip = null;
         var _loc5_:Number = NaN;
         var _loc2_:Number = Number.MAX_VALUE;
         var _loc4_:* = 0;
         while(_loc4_ < dots.length)
         {
            if(Math.floor(dots[_loc4_].x / cellWidth) == Math.floor(scene.chart.mouseX / cellWidth))
            {
               if((_loc5_ = Math.abs(dots[_loc4_].y - scene.chart.mouseY)) < _loc2_)
               {
                  _loc3_ = dots[_loc4_];
                  _loc2_ = _loc5_;
               }
            }
            _loc4_++;
         }
         if(_loc3_ != curClosestDot)
         {
            if(curClosestDot != null)
            {
               curClosestDot.gotoAndStop("idle" + curClosestDot.category);
               curClosestDot = null;
               graphLayer.removeChild(curToolTip);
               curToolTip = null;
            }
            if(_loc3_ != null)
            {
               curClosestDot = _loc3_;
               _loc3_.gotoAndStop("selected" + curClosestDot.category);
               curToolTip = new StatDotToolTip();
               curToolTip.scoreTextField.text = _loc3_.score;
               curToolTip.scoreTextField.mouseEnabled = false;
               curToolTip.x = _loc3_.x;
               curToolTip.y = _loc3_.y - 20;
               graphLayer.addChild(curToolTip);
            }
         }
      }
   }
}
