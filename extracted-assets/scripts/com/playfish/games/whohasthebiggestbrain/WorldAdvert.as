package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.games.ad2.*;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class WorldAdvert extends BaseWorld
   {
      
      private static const AD_PLACEMENT_ID:int = 1;
      
      public static var ad:AdHandler;
      
      public static var adClient:AdClient;
       
      
      private const STATE_IDLE:int = 1;
      
      private var scene:MovieClip;
      
      private var state:int = 0;
      
      private const STATE_FADE_OUT:int = 2;
      
      private const STATE_FADE_IN:int = 0;
      
      public function WorldAdvert()
      {
         super();
         scene = new GoogleAdScene();
         scene.x = GameWorld.CANVAS_CENTER_X;
         scene.y = GameWorld.CANVAS_CENTER_Y;
         addChild(scene);
         setButtonMode(scene.okButton,true);
         scene.okButton.addEventListener(MouseEvent.CLICK,okButtonClickListener);
         if(isAdReady())
         {
            scene.okButton.visible = false;
            ad.addEventListener(AdHandler.EVENT_ENABLE_SKIP,adEnableSkip,false,0,true);
            ad.addEventListener(AdHandler.EVENT_SHOW,adShow,false,0,true);
            scene.adFrame.addChild(ad);
            ad.play();
            state = STATE_IDLE;
         }
         else
         {
            scene.okButton.visible = true;
         }
         var _loc1_:SpeechTextObject = new SpeechTextObject(scene.speechTextField.speechText,scene.speechTextField);
         _loc1_.addString(Engine.getText("AdvertIntoText"));
         Engine.stopSound("ThemeMusic");
      }
      
      public static function loadAd() : *
      {
         try
         {
            trace("---------------");
            trace("adClient =" + adClient);
            if(adClient != null)
            {
               if(!GameWorld.currentUserInfo.isProUser && ad == null)
               {
                  ad = adClient.getAd(AD_PLACEMENT_ID);
                  trace("ad =" + ad);
                  if(ad != null)
                  {
                     ad.addEventListener(AdHandler.EVENT_LOAD_ERROR,adLoadError,false,0,true);
                     ad.addEventListener(AdHandler.EVENT_COMPLETE,adComplete,false,0,true);
                     ad.load();
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function destroyAd() : *
      {
         if(ad != null)
         {
            ad.end();
            ad = null;
         }
      }
      
      public static function adComplete(param1:Event) : *
      {
         trace("ad is Complete");
         destroyAd();
      }
      
      public static function isAdReady() : Boolean
      {
         try
         {
            trace("ad = " + ad);
            trace("ad.isReady( = " + ad.isReady());
         }
         catch(e:Error)
         {
            trace(e.toString());
         }
         return ad != null && ad.isReady();
      }
      
      public static function adLoadError(param1:Event) : *
      {
         trace("ad is LoadError");
         destroyAd();
      }
      
      public function adShow(param1:Event) : *
      {
      }
      
      public function adEnableSkip(param1:Event) : *
      {
         scene.okButton.visible = true;
      }
      
      public function okButtonClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         scene.okButton.removeEventListener(MouseEvent.CLICK,okButtonClickListener);
         destroyAd();
      }
      
      override public function tick(param1:uint) : *
      {
         if(state == STATE_IDLE)
         {
            if(ad == null)
            {
               scene.gotoAndPlay("fade_out");
               state = STATE_FADE_OUT;
            }
         }
         else if(state == STATE_FADE_OUT)
         {
            if(scene.currentFrame >= scene.totalFrames)
            {
               GameWorld.startMainMenu();
            }
         }
      }
   }
}
