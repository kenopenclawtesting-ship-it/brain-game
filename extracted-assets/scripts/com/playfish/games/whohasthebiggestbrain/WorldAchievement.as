package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class WorldAchievement extends BaseWorld
   {
       
      
      internal var icons:Array;
      
      internal var scene:MovieClip;
      
      public function WorldAchievement()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         super();
         GameWorld.removeGameShowFrame();
         scene = new AchievementScene();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         Engine.setFontForLang(scene.trophiesTitle,"Baveuse");
         scene.trophiesTitle.text = LanguageTranslation.getTrophiesButtonText(LanguageButton.currentLanguage);
         icons = new Array();
         var _loc1_:int = 0;
         while(scene["icon" + _loc1_] != null)
         {
            _loc2_ = scene["icon" + _loc1_];
            setButtonMode(_loc2_,true);
            icons.push(_loc2_);
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,iconOverListener);
            _loc3_ = new AchieveIcons();
            if(Debug.DISPLAY_ALL_TROPHIES || AchievementHandler.hasAchievement(GameWorld.achievementMask,_loc1_))
            {
               _loc3_.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               _loc3_.gotoAndStop(_loc3_.totalFrames);
            }
            _loc2_.content.addChild(_loc3_);
            _loc1_++;
         }
         scene.achievementCount.text = AchievementHandler.getAchievementCount(GameWorld.achievementMask) + "/" + AchievementHandler.NUM_ACHIEVEMENT;
         setButtonMode(scene.backButton,true);
         scene.backButton.addEventListener(MouseEvent.CLICK,backClickListener);
         Engine.setFontForLang(scene.profileButton.button.textField,"Baveuse");
         scene.profileButton.button.textField.text = LanguageTranslation.getProfileButtonText(LanguageButton.currentLanguage);
         scene.profileButton.button.textField.mouseEnabled = false;
         setButtonMode(scene.profileButton,true);
         scene.profileButton.addEventListener(MouseEvent.CLICK,profileClickListener);
         Engine.setFontForLang(scene.statsButton.button.textField,"Baveuse");
         scene.statsButton.button.textField.text = LanguageTranslation.getCalendarButtonText(LanguageButton.currentLanguage);
         scene.statsButton.button.textField.mouseEnabled = false;
         setButtonMode(scene.statsButton,true);
         scene.statsButton.addEventListener(MouseEvent.CLICK,statsClickListener);
      }
      
      public function iconOverListener(param1:MouseEvent) : *
      {
         var _loc2_:int = int(icons.indexOf(param1.currentTarget));
         scene.achievementTextField.text = Engine.getText("Trophy" + _loc2_);
      }
      
      public function profileClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldProfile());
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
      
      public function statsClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldStats());
      }
   }
}
