package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import com.playfish.rpc.share.RpcClientBase;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class WorldGoPro extends BaseWorld
   {
       
      
      internal var buttons:Array;
      
      internal var curScreenShot:MovieClip;
      
      internal var scene:MovieClip;
      
      internal var prev:BaseWorld;
      
      public function WorldGoPro(param1:BaseWorld)
      {
         super();
         trace("----WorldGoPro----");
         this.prev = param1;
         scene = new ProPage();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         scene.logo.gotoAndStop("pro");
         if(Engine.localiser.getCurrentLanguageName() == "简体中文")
         {
            scene.logo.gotoAndStop("proCHS");
         }
         else if(Engine.localiser.getCurrentLanguageName() == "繁體中文")
         {
            scene.logo.gotoAndStop("proCHT");
         }
         Engine.setFontForLang(scene.mainTextField,null);
         Engine.setFontForLang(scene.mainTextField2,null);
         scene.mainTextField.text = Engine.getText("GoProMain");
         scene.mainTextField2.text = Engine.getText("GoProMain2");
         var _loc2_:* = 0;
         while(_loc2_ < 6)
         {
            Engine.setFontForLang(scene["button" + _loc2_].textField,null);
            scene["button" + _loc2_].textField.text = Engine.getText("GoProBulletPoint" + _loc2_);
            _loc2_++;
         }
         setButtonMode(scene.backButton,true);
         scene.backButton.addEventListener(MouseEvent.CLICK,backClickListener);
         setButtonMode(scene.goProButton,true);
         scene.goProButton.addEventListener(MouseEvent.CLICK,payClickListener);
         GameWorld.rpcClient.recordGameEvent(RpcClientBase.GAME_EVENT_SELL_PAGE,null,GameWorld.dummy,GameWorld.dummy);
      }
      
      public function buttonOverListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonInGame",1);
         var _loc2_:int = int(buttons.indexOf(param1.currentTarget));
         if(curScreenShot == null)
         {
            curScreenShot = new ScreenShots();
            curScreenShot.x = -160;
            curScreenShot.y = 18;
            scene.addChild(curScreenShot);
         }
         curScreenShot.gotoAndStop(_loc2_ + 1);
         scene.stop();
      }
      
      public function payClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(new WorldGoProPay(this));
      }
      
      public function backClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(prev);
      }
      
      override public function tick(param1:uint) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:MovieClip = null;
         if(buttons == null && scene.currentLabel == "idle")
         {
            buttons = new Array();
            _loc2_ = 0;
            while(_loc2_ < 6)
            {
               _loc3_ = scene["button" + _loc2_];
               if(_loc3_ != null)
               {
                  buttons.push(_loc3_);
                  _loc3_.textField.mouseEnabled = false;
                  _loc3_.buttonMode = true;
                  _loc3_.addEventListener(MouseEvent.ROLL_OVER,buttonOverListener);
               }
               _loc2_++;
            }
         }
      }
   }
}
