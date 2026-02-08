package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.*;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class GloatMovieClip extends Sprite
   {
       
      
      internal var gloatScreen:WorldGloat;
      
      internal var loadingMC:MovieClip;
      
      internal var gloatMC:MovieClip;
      
      internal var gloatIndex:int;
      
      public function GloatMovieClip(param1:WorldGloat, param2:int)
      {
         super();
         this.gloatScreen = param1;
         this.gloatIndex = param2;
         loadingMC = new LoadGloatAnimation();
         addChild(loadingMC);
      }
      
      public function loadGloatDone(param1:Event) : *
      {
         gloatMC = MovieClip(param1.target.content);
         var _loc2_:* = gloatScreen.gloatPanelWidth / GameWorld.CANVAS_WIDTH;
         var _loc3_:* = gloatScreen.gloatPanelHeight / GameWorld.CANVAS_HEIGHT;
         var _loc4_:* = Math.min(_loc2_,_loc3_);
         gloatMC.scaleX = _loc4_;
         gloatMC.scaleY = _loc4_;
         gloatMC.x = -gloatScreen.gloatPanelWidth / 2;
         gloatMC.y = -gloatScreen.gloatPanelHeight / 2;
         removeChild(loadingMC);
         loadingMC = null;
         addChild(gloatMC);
         if(gloatIndex == gloatScreen.gloatPanelGloatIndex[0])
         {
            showNotify();
         }
      }
      
      public function updateLoserImage() : *
      {
         var _loc1_:* = undefined;
         if(gloatMC != null)
         {
            if(gloatMC.image2.numChildren > 1)
            {
               gloatMC.image2.removeChildAt(1);
            }
            if(gloatScreen.selectedFriendIndex != -1)
            {
               _loc1_ = gloatScreen.friendImageList[gloatScreen.selectedFriendIndex][1];
               if(_loc1_ != null)
               {
                  gloatMC.image2.addChild(_loc1_);
               }
            }
         }
      }
      
      public function loadGloatMovieClip(param1:String) : *
      {
         var _loc2_:Loader = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,loadGloatDone);
         var _loc3_:URLRequest = new URLRequest(param1);
         _loc2_.load(_loc3_);
      }
      
      public function showNotify() : *
      {
         var _loc1_:* = undefined;
         if(gloatMC != null)
         {
            _loc1_ = gloatScreen.currentUserImage;
            if(_loc1_ != null)
            {
               gloatMC.image1.addChild(_loc1_);
            }
            updateLoserImage();
            setText(gloatScreen.scene.gloatText.text);
         }
      }
      
      public function setText(param1:String) : *
      {
         if(gloatMC != null)
         {
            if(gloatMC["gloatText"] != undefined)
            {
               gloatMC.gloatText.text = param1;
            }
         }
      }
   }
}
