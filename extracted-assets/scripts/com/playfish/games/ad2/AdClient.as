package com.playfish.games.ad2
{
   import com.playfish.rpc.share.*;
   import flash.events.*;
   import flash.net.*;
   
   public class AdClient extends EventDispatcher
   {
      
      public static const GOOGLE_AD:int = 0;
      
      public static const MOCHIAD:int = 1;
      
      public static const DOUBLE_CLICK:int = 2;
      
      public static const YUME:int = 3;
      
      public static const RANDOM_AD:int = 4;
      
      private static const AD_HANDLER:Array = [GoogleAdHandler,MochiAdHandler,DoubleClickHandler,YumeAdHandler];
      
      private static const PROVIDERS:Array = ["google","mochi","doubleclick","yume"];
      
      public static const AD_EVENT_PROVIDER_NO_ADS:String = "no_ads";
      
      public static const AD_EVENT_RESULT_OK:String = "ok";
      
      public static const AD_EVENT_RESULT_FAIL:String = "fail";
       
      
      private var config:Object;
      
      private var countryCode:String;
      
      private var adEntries:Array;
      
      private var network:String;
      
      private var rpcClient:RpcClientBase;
      
      private var customEntries:Object;
      
      public function AdClient(param1:String, param2:String, param3:String, param4:RpcClientBase = null)
      {
         this.customEntries = new Object();
         super();
         this.rpcClient = param4;
         this.network = param3;
         if(param2 != null)
         {
            this.countryCode = param2.toLowerCase();
         }
         if(this.network == null)
         {
            network = "facebook";
         }
         if(param1 == null || param1.length <= 0)
         {
            param1 = "adconfig.xml";
         }
         loadConfigXml(param1);
      }
      
      public function getCustom(param1:String) : String
      {
         return customEntries[param1];
      }
      
      private function error(param1:IOErrorEvent) : *
      {
         dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
      }
      
      private function trim(param1:String) : String
      {
         param1 = param1.replace(/^\s+/,"");
         return param1.replace(/\s+$/,"");
      }
      
      private function loadConfigXml(param1:String) : *
      {
         var _loc2_:URLLoader = new URLLoader(new URLRequest(param1));
         _loc2_.addEventListener(Event.COMPLETE,completeListener);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,error);
      }
      
      private function completeListener(param1:Event) : *
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function recordAdEvent(param1:String, param2:String, param3:int, param4:String = null) : *
      {
         var message:String = null;
         var provider:String = param1;
         var result:String = param2;
         var placementId:int = param3;
         var detail:String = param4;
         if(rpcClient != null)
         {
            message = "provider=" + provider + " result=" + result + " country=" + countryCode + " placement_id=" + placementId;
            if(detail != null)
            {
               message += " detail=" + detail;
            }
            rpcClient.recordGameEvent(RpcClientBase.GAME_EVENT_AD_IMPRESSION,message,function():*
            {
            },function():*
            {
            });
         }
      }
      
      public function getAd(param1:int = -1) : AdHandler
      {
         var adEntry:Object;
         var rndWeight:int;
         var adType:int = 0;
         var placementId:int = param1;
         var totalWeight:int = 0;
         var i:* = 0;
         while(i < adEntries.length)
         {
            totalWeight += adEntries[i].weight;
            i++;
         }
         rndWeight = Math.floor(Math.random() * totalWeight);
         adEntry = null;
         i = 0;
         while(i < adEntries.length)
         {
            if(rndWeight < adEntries[i].weight)
            {
               adEntry = adEntries[i];
               break;
            }
            rndWeight -= adEntries[i].weight;
            i++;
         }
         if(adEntry != null)
         {
            adType = int(PROVIDERS.indexOf(adEntry.config.provider));
            if(adType != -1)
            {
               try
               {
                  return new AD_HANDLER.[adType](this,PROVIDERS[adType],placementId,adEntry.config);
               }
               catch(e:Error)
               {
                  trace(e.getStackTrace());
               }
            }
         }
         recordAdEvent(AD_EVENT_PROVIDER_NO_ADS,"",placementId);
         return null;
      }
   }
}
