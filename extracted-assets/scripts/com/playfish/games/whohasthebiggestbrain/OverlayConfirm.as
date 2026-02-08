package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class OverlayConfirm extends BaseWorld
   {
       
      
      private var okListener:Function;
      
      private var mcContent:MovieClip;
      
      private var parentWorld:BaseWorld;
      
      private var cancelListener:Function;
      
      public function OverlayConfirm(param1:BaseWorld, param2:String, param3:Function, param4:Function = null, param5:MovieClip = null, param6:MovieClip = null)
      {
         super();
         this.parentWorld = param1;
         this.okListener = param3;
         this.cancelListener = param4;
         param1.mouseChildren = false;
         var _loc7_:Sprite;
         (_loc7_ = new Sprite()).graphics.beginFill(0);
         _loc7_.graphics.drawRect(0,0,GameWorld.CANVAS_WIDTH,GameWorld.CANVAS_HEIGHT);
         _loc7_.alpha = 0.5;
         addChild(_loc7_);
         var _loc8_:MovieClip;
         if((_loc8_ = param5) == null)
         {
            _loc8_ = new ConfirmDialog();
         }
         _loc8_.x = GameWorld.CANVAS_CENTER_X;
         _loc8_.y = GameWorld.CANVAS_CENTER_Y;
         addChild(_loc8_);
         mcContent = param6;
         if(mcContent == null)
         {
            mcContent = _loc8_;
         }
         if(param2 != null && mcContent.headerText != null)
         {
            Engine.setFontForLang(mcContent.headerText,"Arial black");
            mcContent.headerText.text = param2;
         }
         if(mcContent.okButton != null)
         {
            setButtonMode(mcContent.okButton,true);
            mcContent.okButton.addEventListener(MouseEvent.CLICK,okButtonClickListener);
         }
         if(mcContent.noButton != null)
         {
            setButtonMode(mcContent.noButton,true);
            mcContent.noButton.addEventListener(MouseEvent.CLICK,noButtonClickListener);
         }
         Engine.instance.addChild(this);
      }
      
      public function okButtonClickListener(param1:MouseEvent) : void
      {
         Engine.playSound("ButtonMenu",1);
         if(okListener != null)
         {
            okListener();
         }
         end();
      }
      
      public function noButtonClickListener(param1:MouseEvent) : void
      {
         Engine.playSound("ButtonMenu",1);
         if(cancelListener != null)
         {
            cancelListener();
         }
         end();
      }
      
      public function end() : void
      {
         parentWorld.mouseChildren = true;
         Engine.instance.removeChild(this);
         Engine.setFocus(parentWorld);
      }
   }
}
