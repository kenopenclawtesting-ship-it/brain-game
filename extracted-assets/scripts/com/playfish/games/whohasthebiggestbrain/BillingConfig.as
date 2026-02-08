package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.coretech.engine.PFEngine;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import flash.xml.*;
   
   public class BillingConfig
   {
      
      public static var countryCode:String = "default";
      
      private static var skuProviders:Array = new Array();
      
      public static var retry:Boolean = false;
      
      public static var configUrl:String = "";
      
      private static var countrySkusDisabled:Array = new Array();
      
      public static const PAYMENT_PROVIDER_NAMES:Array = ["","paypal","trialpay","paymo","paybycash","onebip"];
      
      private static var countrySkusEnabled:Array = new Array();
      
      private static var skuIds:Array = new Array();
       
      
      public function BillingConfig()
      {
         super();
      }
      
      public static function loadConfig(param1:String) : *
      {
         var _loc2_:URLLoader = new URLLoader(new URLRequest(param1));
         _loc2_.addEventListener(Event.COMPLETE,xmlLoaded);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,xmlError);
      }
      
      public static function xmlError(param1:Event) : *
      {
         trace(param1.toString());
         if(!BillingConfig.retry)
         {
            BillingConfig.retry = true;
            loadConfig(configUrl);
         }
         else
         {
            trace(">>>>>>>>>>>>>>>>>billingErrorListener");
         }
      }
      
      private static function getProviderIndex(param1:String) : int
      {
         var _loc2_:Number = 0;
         while(_loc2_ < PAYMENT_PROVIDER_NAMES.length)
         {
            if(PAYMENT_PROVIDER_NAMES[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public static function getSkuProvider(param1:uint) : int
      {
         var _loc2_:int = int(skuIds.indexOf(param1));
         if(_loc2_ != -1)
         {
            return skuProviders[_loc2_];
         }
         return -1;
      }
      
      public static function getProviderState(param1:*) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Array = countrySkusEnabled[countryCode];
         var _loc3_:Array = countrySkusDisabled[countryCode];
         var _loc4_:Array = new Array();
         if(_loc2_ == null)
         {
            _loc2_ = countrySkusEnabled["DEFAULT"];
         }
         if(_loc2_ != null)
         {
            for each(_loc5_ in _loc2_)
            {
               if(_loc4_.indexOf(_loc5_) == -1 && (param1 == 0 || getSkuProvider(_loc5_) == param1))
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         if(_loc3_ != null)
         {
            _loc6_ = int(_loc3_.length - 1);
            while(_loc6_ >= 0)
            {
               _loc7_ = int(_loc3_[_loc6_]);
               if((_loc8_ = int(_loc4_.indexOf(_loc7_))) != -1)
               {
                  _loc4_.splice(_loc8_,1);
               }
               _loc6_--;
            }
         }
         return _loc4_;
      }
      
      public static function xmlLoaded(param1:Event) : *
      {
         var _loc3_:XML = null;
         var _loc4_:XML = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:* = false;
         var _loc13_:Array = null;
         var _loc2_:XML = new XML(param1.currentTarget.data);
         for each(_loc3_ in _loc2_..skuEntry)
         {
            _loc6_ = int(_loc3_.@id);
            _loc7_ = getProviderIndex(_loc3_.@provider);
            skuIds.push(_loc6_);
            skuProviders.push(_loc7_);
         }
         for each(_loc4_ in _loc2_..country)
         {
            _loc8_ = _loc4_.@code.split(/\s*,\s*/);
            _loc9_ = new Array();
            _loc10_ = new Array();
            for each(_loc3_ in _loc4_..sku)
            {
               _loc6_ = int(_loc3_.@id);
               if(_loc12_ = _loc3_.@enabled == "true")
               {
                  if(_loc9_.indexOf(_loc6_) == -1)
                  {
                     _loc9_.push(_loc6_);
                  }
               }
               else if(_loc10_.indexOf(_loc6_) == -1)
               {
                  _loc10_.push(_loc6_);
               }
            }
            for each(_loc11_ in _loc8_)
            {
               _loc11_ = _loc11_.toUpperCase();
               for each(_loc6_ in _loc9_)
               {
                  if((_loc13_ = countrySkusEnabled[_loc11_]) == null)
                  {
                     _loc13_ = new Array();
                     countrySkusEnabled[_loc11_] = _loc13_;
                  }
                  _loc13_.push(_loc6_);
               }
               for each(_loc6_ in _loc10_)
               {
                  if((_loc13_ = countrySkusDisabled[_loc11_]) == null)
                  {
                     _loc13_ = new Array();
                     countrySkusDisabled[_loc11_] = _loc13_;
                  }
                  _loc13_.push(_loc6_);
               }
            }
         }
         if((_loc5_ = countrySkusEnabled["DEFAULT"] as Array) != null)
         {
            for each(_loc13_ in countrySkusEnabled)
            {
               if(_loc13_ != _loc5_)
               {
                  for each(_loc6_ in _loc5_)
                  {
                     if(_loc13_.indexOf(_loc6_) == -1)
                     {
                        _loc13_.push(_loc6_);
                     }
                  }
               }
            }
         }
         WorldGoProPay.billingConfigLoadSuccess = true;
      }
      
      public static function init() : *
      {
         var _loc1_:String = PFEngine.instance.getParameterString("pf_user_country");
         var _loc2_:String = PFEngine.instance.getParameterString("pf_billing_config");
         if(_loc1_ != null)
         {
            BillingConfig.countryCode = _loc1_.toUpperCase();
         }
         else
         {
            BillingConfig.countryCode = "DEFAULT";
         }
         if(_loc2_ == null || _loc2_.length <= 0)
         {
            _loc2_ = PFEngine.instance.getParameterString("pf_billing_config");
         }
         loadConfig(_loc2_);
      }
   }
}
