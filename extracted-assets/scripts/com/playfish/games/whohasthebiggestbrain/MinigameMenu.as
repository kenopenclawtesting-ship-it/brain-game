package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.games.ad.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class MinigameMenu extends BaseWorld
   {
       
      
      internal var menuItems:Array;
      
      public function MinigameMenu()
      {
         super();
         var _loc1_:MinigameMenuScene = new MinigameMenuScene();
         addChild(_loc1_);
         menuItems = new Array();
         menuItems.push(_loc1_.menuitem1);
         menuItems.push(_loc1_.menuitem2);
         menuItems.push(_loc1_.menuitem3);
         menuItems.push(_loc1_.menuitem4);
         menuItems.push(_loc1_.menuitem5);
         menuItems.push(_loc1_.menuitem6);
         menuItems.push(_loc1_.menuitem7);
         menuItems.push(_loc1_.menuitem8);
         menuItems.push(_loc1_.menuitem9);
         menuItems.push(_loc1_.menuitem10);
         menuItems.push(_loc1_.menuitem11);
         menuItems.push(_loc1_.menuitem12);
         _loc1_.menuitem13.textfield.text = "gloat";
         _loc1_.menuitem13.buttonMode = true;
         _loc1_.menuitem13.addEventListener(MouseEvent.CLICK,gloatClickListener);
         _loc1_.menuitem14.textfield.text = "google ad";
         _loc1_.menuitem14.buttonMode = true;
         _loc1_.menuitem14.addEventListener(MouseEvent.CLICK,googleAdClickListener);
         _loc1_.menuitem15.textfield.text = "stats";
         _loc1_.menuitem15.buttonMode = true;
         _loc1_.menuitem15.addEventListener(MouseEvent.CLICK,statClickListener);
         x = GameWorld.CANVAS_CENTER_X;
         y = GameWorld.CANVAS_CENTER_Y;
         var _loc2_:* = 0;
         while(_loc2_ < menuItems.length)
         {
            menuItems[_loc2_].addEventListener(MouseEvent.CLICK,menuItemMouseClickListener);
            menuItems[_loc2_].textfield.selectable = false;
            menuItems[_loc2_].textfield.mouseEnabled = false;
            menuItems[_loc2_].buttonMode = true;
            menuItems[_loc2_].textfield.text = MinigameDefines.MINIGAMES[_loc2_].name;
            _loc2_++;
         }
      }
      
      public function googleAdClickListener(param1:MouseEvent) : *
      {
         WorldAdvert.loadAd();
         WorldAdvert.ad.addEventListener(AdHandler.EVENT_READY_TO_PLAY,onGoogleAdInit);
         WorldAdvert.ad.addEventListener(AdHandler.EVENT_LOAD_ERROR,onGoogleAdError);
      }
      
      public function statClickListener(param1:MouseEvent) : *
      {
         Engine.setActiveWorld(new WorldStats());
      }
      
      public function menuItemMouseClickListener(param1:MouseEvent) : *
      {
         var _loc2_:int = int(menuItems.indexOf(param1.target));
         Engine.stopSound("ThemeMusic");
         GameWorld.startPractice(_loc2_);
      }
      
      public function onGoogleAdInit(param1:Event) : *
      {
         Engine.setActiveWorld(new WorldAdvert());
      }
      
      public function onGoogleAdError(param1:Event) : *
      {
         Engine.setActiveWorld(new WorldAdvert());
      }
      
      public function gloatClickListener(param1:MouseEvent) : *
      {
         Engine.setActiveWorld(new WorldGloat());
      }
   }
}
