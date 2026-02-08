package com.playfish.coretech.engine.ui
{
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.coretech.engine.game.*;
   import com.playfish.coretech.skeleton.billing.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PFPopUp extends PFBaseWorld
   {
      
      private static var popUpQueue:Array = new Array();
      
      public static var activePopUp:Array = new Array();
      
      protected static var valid:Boolean;
       
      
      public var startFrame:int;
      
      public var popUpContent:MovieClip;
      
      public var alphaLayer:PFBaseObject;
      
      public function PFPopUp(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:Boolean = true)
      {
         super();
         if(param4)
         {
            alphaLayer = new PFBaseObject();
         }
         this.popUpContent = param1;
         if(popUpContent != null)
         {
            startFrame = popUpContent.currentFrame;
            addChild(popUpContent);
         }
         if(param2)
         {
            setButtonMode(param2,true);
            param2.addEventListener(MouseEvent.CLICK,onOkClick,false,0,true);
         }
         if(param3)
         {
            setButtonMode(param3,true);
            param3.addEventListener(MouseEvent.CLICK,onCancelClick,false,0,true);
         }
         valid = true;
      }
      
      public static function getTopActivePopUp() : PFPopUp
      {
         if(activePopUp.length == 0)
         {
            return null;
         }
         return activePopUp[activePopUp.length - 1];
      }
      
      public function _remove() : void
      {
         activePopUp.splice(activePopUp.indexOf(this),1);
         if(activePopUp.length == 0 && popUpQueue.length > 0)
         {
            popUpQueue[0].show();
            popUpQueue.splice(0,1);
         }
      }
      
      public function remove() : void
      {
         if(alphaLayer)
         {
            PFEngine.instance.removeWorldObject(alphaLayer);
         }
         PFEngine.instance.removeWorldObject(this);
         activePopUp.splice(activePopUp.indexOf(this),1);
         if(activePopUp.length == 0 && popUpQueue.length > 0)
         {
            popUpQueue[0].show();
            popUpQueue.splice(0,1);
         }
         PFEngine.instance.stage.removeEventListener(Event.FULLSCREEN,onFullScreen);
      }
      
      public function isShown() : Boolean
      {
         return activePopUp.indexOf(this) != -1;
      }
      
      public function queueToShow() : void
      {
         if(activePopUp.length > 0)
         {
            popUpQueue.push(this);
         }
         else
         {
            show();
         }
      }
      
      public function getPopupContent() : MovieClip
      {
         return popUpContent;
      }
      
      private function onOkClick(param1:MouseEvent) : void
      {
         remove();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onCancelClick(param1:MouseEvent) : void
      {
         remove();
         dispatchEvent(new Event(Event.CANCEL));
      }
      
      private function onFullScreen(param1:Event) : void
      {
         if(alphaLayer)
         {
            alphaLayer.graphics.clear();
            alphaLayer.graphics.beginFill(0,0.3);
            alphaLayer.graphics.drawRect(PFEngine.instance.getStageX(),PFEngine.instance.getStageY(),PFEngine.instance.getStageWidth(),PFEngine.instance.getStageHeight());
            alphaLayer.graphics.endFill();
         }
      }
      
      public function _show() : void
      {
         if(activePopUp.indexOf(this) == -1)
         {
            activePopUp.push(this);
         }
      }
      
      public function show() : void
      {
         if(activePopUp.indexOf(this) == -1)
         {
            if(alphaLayer)
            {
               alphaLayer.drawPriority = this.drawPriority;
               PFEngine.instance.addWorldObject(alphaLayer);
            }
            PFEngine.instance.addWorldObject(this);
            if(popUpContent != null)
            {
               popUpContent.gotoAndPlay(startFrame);
            }
            activePopUp.push(this);
            PFEngine.instance.stage.addEventListener(Event.FULLSCREEN,onFullScreen,false,0,true);
            onFullScreen(null);
         }
      }
   }
}
