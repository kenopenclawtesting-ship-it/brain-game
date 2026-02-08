package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.coretech.contrib.ChallengeGamesSocialInitialiser;
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.socialnetwork.SocialNetwork;
   import com.playfish.external.*;
   import com.playfish.games.utils.*;
   import com.playfish.games.whohasthebiggestbrain.utils.*;
   import com.playfish.rpc.brain.*;
   import flash.display.*;
   import flash.events.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class Engine extends PFEngine
   {
      
      public static var worldContainer:Sprite;
      
      public static var instance:Engine;
      
      public static var curWorld:BaseWorld;
      
      public static var stageHeight:uint;
      
      public static var localiser:Localiser;
      
      internal static var versionBox:MovieClip;
      
      public static var overlay:MovieClip;
      
      public static var stageWidth:uint;
      
      public static const GAME_VERSION:String = "2.6.7";
      
      public static const OVERLAYENABLE:Boolean = true;
      
      public static var debug:Function = trace;
      
      public static const STAGE_WIDTH:int = 640;
      
      public static const STAGE_HEIGHT:int = 700;
      
      internal static var rand:Random = new Random();
      
      public static const KEY_UP:* = 1 << 0;
      
      public static const KEY_DOWN:* = 1 << 1;
      
      public static const KEY_LEFT:* = 1 << 2;
      
      public static const KEY_RIGHT:* = 1 << 3;
      
      public static const KEY_SPACE:* = 1 << 4;
      
      public static const KEY_DEL:* = 1 << 5;
      
      public static const KEY_F1:* = 1 << 6;
      
      public static const KEY_OTHER:* = 1 << 7;
      
      public static var keyBuffer:int = 0;
      
      public static var activeSoundChannels:Array = new Array();
      
      public static var activeSoundNames:Array = new Array();
      
      public static var soundVolume:int = 1;
      
      public static var cachedSoundNames:Array = new Array();
      
      public static var cachedSounds:Array = new Array();
       
      
      private var errorScene:MovieClip;
      
      public var lastTickTime:int;
      
      public var fpsTextField:TextField;
      
      private var initCompleteCallback:Function;
      
      public function Engine()
      {
         super();
         PFDebug.setDebugState(Debug.DEBUG);
         PFDebug.setHandler(trace);
         instance = this;
         this.addEventListener(Event.ADDED_TO_STAGE,init);
      }
      
      public static function anyKey() : Boolean
      {
         return keyBuffer != 0;
      }
      
      public static function payComplete(param1:ExternalPageEvent) : *
      {
         GameWorld.rpcClient.getUserInfo(getUserInfoOK,GameWorld.getUserInfoFail);
      }
      
      public static function isKeyPressed(param1:*) : *
      {
         return (keyBuffer & param1) != 0;
      }
      
      public static function rndFloat(param1:Number, param2:Number) : Number
      {
         return Math.random() * (param2 - param1) + param1;
      }
      
      public static function setFocus(param1:InteractiveObject) : *
      {
         instance.stage.focus = param1;
      }
      
      public static function openPayScreen(param1:URLRequest) : *
      {
         trace(param1.url + "?" + String(param1.data));
         var _loc2_:ExternalPage = new ExternalPage("trialPay");
         _loc2_.addEventListener(ExternalPageEvent.COMPLETE,payComplete);
         instance.mouseChildren = false;
         overlay = createOverlay();
         overlay.alpha = 0.65;
         instance.addChild(overlay);
         _loc2_.show(param1.url + "?" + String(param1.data));
      }
      
      public static function showVersion() : *
      {
         if(versionBox == null)
         {
            versionBox = new VersionBox();
            versionBox.textField.text += GAME_VERSION;
            instance.addChild(versionBox);
         }
         else
         {
            instance.removeChild(versionBox);
            versionBox = null;
         }
      }
      
      public static function getAngle(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:* = param3 - param1;
         var _loc6_:* = param2 - param4;
         if(_loc5_ < 0)
         {
            return Math.atan(_loc6_ / _loc5_) + Math.PI;
         }
         if(_loc5_ > 0)
         {
            return Math.atan(_loc6_ / _loc5_);
         }
         if(_loc6_ > 0)
         {
            return Math.PI / 2;
         }
         if(_loc6_ < 0)
         {
            return Math.PI + Math.PI / 2;
         }
         return 0;
      }
      
      public static function getText(param1:String, param2:Array = null) : String
      {
         if(localiser != null)
         {
            return localiser.getTextFromId(param1,0,param2);
         }
         return param1;
      }
      
      public static function setGlobalSoundVolume(param1:int) : *
      {
         soundVolume = param1;
         SoundMixer.soundTransform = new SoundTransform(param1);
         var _loc2_:* = 0;
         while(_loc2_ < activeSoundChannels.length)
         {
            activeSoundChannels[_loc2_].soundTransform = new SoundTransform(param1);
            _loc2_++;
         }
      }
      
      public static function setVersion(param1:String) : *
      {
         if(versionBox != null)
         {
            versionBox.textField.text = param1;
         }
      }
      
      public static function rnd(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 == param2)
         {
            return param1;
         }
         if(param1 > param2)
         {
            _loc3_ = param1;
            param1 = param2;
            param2 = _loc3_;
         }
         return rand.nextInt(param2 - param1) + param1;
      }
      
      public static function getUserInfoOK(param1:UserInfo, param2:String, param3:String) : *
      {
         var userInfo:UserInfo = param1;
         var network:String = param2;
         var lang:String = param3;
         instance.mouseChildren = true;
         try
         {
            instance.removeChild(overlay);
            GameWorld.getUserInfoOK(userInfo,network);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function keyUpListener(param1:KeyboardEvent) : *
      {
         var _loc2_:int = translateKeyCode(param1.keyCode);
         keyBuffer &= ~_loc2_;
         if(curWorld != null)
         {
            curWorld.keyUp(_loc2_,param1.charCode);
         }
      }
      
      public static function dummy() : *
      {
      }
      
      public static function createOverlay() : MovieClip
      {
         var _loc1_:MovieClip = new MovieClip();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(0,0,GameWorld.CANVAS_WIDTH,GameWorld.CANVAS_HEIGHT);
         _loc1_.alpha = 0.65;
         return _loc1_;
      }
      
      public static function stopSound(param1:String) : *
      {
         var i:* = undefined;
         var name:String = param1;
         try
         {
            i = activeSoundNames.length - 1;
            while(i >= 0)
            {
               if(activeSoundNames[i] == name)
               {
                  activeSoundChannels[i].stop();
                  activeSoundChannels.splice(i,1);
                  activeSoundNames.splice(i,1);
               }
               i--;
            }
         }
         catch(e:Error)
         {
            trace("Error stoping sound: " + name);
         }
      }
      
      public static function translateKeyCode(param1:int) : *
      {
         switch(param1)
         {
            case 32:
               return KEY_SPACE;
            case 37:
               return KEY_LEFT;
            case 38:
               return KEY_UP;
            case 39:
               return KEY_RIGHT;
            case 40:
               return KEY_DOWN;
            case 112:
               return KEY_F1;
            case 110:
            case 8:
            case 46:
               return KEY_DEL;
            default:
               return KEY_OTHER;
         }
      }
      
      public static function openInviteScreen() : *
      {
         var _loc2_:ExternalPage = null;
         var _loc3_:URLRequest = null;
         var _loc1_:* = Engine.instance.getParameter("pf_invite_url");
         if(_loc1_ != null && _loc1_.length > 0)
         {
            if(Engine.OVERLAYENABLE)
            {
               _loc2_ = new ExternalPage("invite");
               _loc2_.addEventListener(ExternalPageEvent.COMPLETE,inviteComplete);
               if(SocialNetwork.isFacebook())
               {
                  instance.mouseChildren = false;
                  overlay = createOverlay();
                  overlay.alpha = 0.65;
                  instance.addChild(overlay);
               }
               _loc2_.show();
            }
            else
            {
               _loc3_ = new URLRequest(_loc1_);
               navigateToURL(_loc3_,"_top");
            }
         }
      }
      
      public static function playSound(param1:String, param2:int) : SoundChannel
      {
         var soundFactory:Sound = null;
         var index:int = 0;
         var loopValue:* = undefined;
         var soundClass:Class = null;
         var name:String = param1;
         var loops:int = param2;
         var soundChannel:SoundChannel = null;
         try
         {
            index = int(cachedSoundNames.indexOf(name));
            if(index != -1)
            {
               soundFactory = cachedSounds[index];
            }
            else
            {
               soundClass = Class(getDefinitionByName(name));
               soundFactory = new soundClass();
               cachedSoundNames.push(name);
               cachedSounds.push(soundFactory);
            }
            loopValue = loops;
            if(loopValue == 0 || loopValue == -1)
            {
               loopValue = 999999;
            }
            soundChannel = soundFactory.play(0,loopValue,new SoundTransform(soundVolume));
            if(soundChannel != null)
            {
               if(loops != 0 && loops != -1)
               {
                  soundChannel.addEventListener(Event.SOUND_COMPLETE,soundCompleteListener);
               }
               activeSoundChannels.push(soundChannel);
               activeSoundNames.push(name);
            }
         }
         catch(e:Error)
         {
            trace("Error playing sound: " + name);
            trace(e.getStackTrace());
         }
         return soundChannel;
      }
      
      public static function soundCompleteListener(param1:Event) : *
      {
         var _loc2_:int = int(activeSoundChannels.indexOf(param1.currentTarget));
         param1.currentTarget.removeEventListener(Event.SOUND_COMPLETE,soundCompleteListener);
         activeSoundNames.splice(_loc2_,1);
         activeSoundChannels.splice(_loc2_,1);
      }
      
      public static function setFontForLang(param1:TextField, param2:String) : *
      {
         var _loc3_:* = param1.getTextFormat();
         if(localiser.curLangCode == "el")
         {
            switch(param2)
            {
               case "Baveuse":
               case "Arnold 2.1":
                  _loc3_.font = "Arial Black";
                  break;
               default:
                  _loc3_.font = param2;
            }
            param1.embedFonts = true;
         }
         else if(localiser.curLangCode == "CS" || localiser.curLangCode == "CT")
         {
            param1.embedFonts = false;
            _loc3_.font = "Arial";
         }
         else
         {
            if(param2 != null)
            {
               _loc3_.font = param2;
            }
            param1.embedFonts = true;
         }
         param1.defaultTextFormat = _loc3_;
         param1.setTextFormat(_loc3_);
      }
      
      public static function inviteComplete(param1:ExternalPageEvent) : *
      {
         var event:ExternalPageEvent = param1;
         instance.mouseChildren = true;
         try
         {
            instance.removeChild(overlay);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function resetKeys() : *
      {
         keyBuffer = 0;
      }
      
      public static function isSoundPlaying(param1:String) : Boolean
      {
         var _loc2_:* = activeSoundNames.length - 1;
         while(_loc2_ >= 0)
         {
            if(activeSoundNames[_loc2_] == param1)
            {
               return true;
            }
            _loc2_--;
         }
         return false;
      }
      
      public static function setActiveWorld(param1:BaseWorld) : *
      {
         if(curWorld != null)
         {
            curWorld.destroy();
            worldContainer.removeChild(curWorld);
         }
         curWorld = param1;
         worldContainer.addChild(curWorld);
         instance.stage.focus = curWorld;
      }
      
      public static function registerLocaliser(param1:Localiser) : *
      {
         localiser = param1;
      }
      
      public static function getMovieClip(param1:String) : MovieClip
      {
         var _loc2_:Class = Class(getDefinitionByName(param1));
         return new _loc2_();
      }
      
      public static function keyDownListener(param1:KeyboardEvent) : *
      {
         trace("keycode=" + param1.keyCode + " charCode=" + param1.charCode);
         var _loc2_:int = translateKeyCode(param1.keyCode);
         keyBuffer |= _loc2_;
         if(_loc2_ == KEY_F1)
         {
            showVersion();
         }
         if(curWorld != null)
         {
            curWorld.keyDown(_loc2_,param1.charCode);
         }
      }
      
      public static function setFontSize(param1:TextField, param2:uint, ... rest) : *
      {
         var _loc4_:TextFormat = param1.getTextFormat();
         _loc4_.size = param2;
         var _loc5_:* = 0;
         while(_loc5_ < rest.length)
         {
            if(Engine.localiser.curLangCode == rest[_loc5_])
            {
               _loc4_.size = rest[_loc5_ + 1];
            }
            _loc5_ += 2;
         }
         param1.setTextFormat(_loc4_);
         param1.defaultTextFormat = _loc4_;
      }
      
      public function start() : *
      {
         initCompleteCallback = null;
         stage.addEventListener(Event.ENTER_FRAME,tick);
         lastTickTime = getTimer();
         GameWorld.isCheckingResultPage = false;
         setActiveWorld(new GameWorld(this));
      }
      
      public function init(param1:Event) : *
      {
         var e:Event = param1;
         super.initialize();
         stageWidth = STAGE_WIDTH;
         stageHeight = STAGE_HEIGHT;
         stage.stageFocusRect = false;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownListener);
         stage.addEventListener(KeyboardEvent.KEY_UP,keyUpListener);
         worldContainer = new Sprite();
         addChild(worldContainer);
         addChild(worldObjectList);
         try
         {
            if(!Debug.NETWORK_ONLY && Debug.OVERRIDE_FLASH_VARS)
            {
               setParameterVars(new URLVariables(Debug.NETWORK_TEST_FLASH_VARS));
            }
            GameWorld.rpcClient = new RpcClient(flashVars,0);
            GameWorld.rpcClient.init(rpcInitSuccess,rpcInitFail);
            ChallengeGamesSocialInitialiser.initialise("brain");
            FeedForm.registerFeedTypes();
            BillingConfig.init();
         }
         catch(ex:Error)
         {
            trace("Networking init error:");
            trace(ex.message);
            trace(ex.getStackTrace());
            rpcInitFail();
         }
         if(!Debug.DEBUG)
         {
            fpsTextField = new TextField();
            fpsTextField.width = stageWidth;
            fpsTextField.textColor = 11184810;
            fpsTextField.selectable = false;
            fpsTextField.mouseEnabled = false;
            addChild(fpsTextField);
         }
      }
      
      public function gameWorldInitDone(param1:Boolean) : *
      {
         trace("-------------------gameWorldInitDone " + param1);
         start();
      }
      
      public function rpcInitSuccess() : *
      {
         trace("rpc Init is success!");
         GameWorld.init(gameWorldInitDone);
      }
      
      public function setInitCompleteCallback(param1:Function) : *
      {
         this.initCompleteCallback = param1;
      }
      
      public function rpcInitFail() : *
      {
         PFDebug.warning("rpc Init is fail!");
         if(Debug.NETWORK_ONLY)
         {
            if(initCompleteCallback != null)
            {
               initCompleteCallback();
            }
            else
            {
               start();
            }
         }
         else
         {
            GameWorld.init(gameWorldInitDone);
         }
      }
      
      public function tick(param1:Event) : void
      {
         var _loc2_:int = int(getTimer());
         var _loc3_:int = _loc2_ - lastTickTime;
         lastTickTime = _loc2_;
         tickEngine(_loc3_);
         if(curWorld != null)
         {
            curWorld.tick(_loc3_);
         }
         if(Debug.DEBUG)
         {
            fpsTextField.height = 500;
            fpsTextField.multiline = true;
            fpsTextField.wordWrap = true;
            fpsTextField.text = "FPS: " + (1000 / _loc3_).toFixed(2) + " MEM: " + System.totalMemory + " Active sounds: " + activeSoundChannels.length;
         }
      }
   }
}
