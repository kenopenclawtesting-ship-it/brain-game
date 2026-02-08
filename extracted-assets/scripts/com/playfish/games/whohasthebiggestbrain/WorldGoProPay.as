package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.share.PurchasableItem;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.net.*;
   
   public class WorldGoProPay extends BaseWorld
   {
      
      public static var billingConfigLoadSuccess:* = false;
       
      
      internal var prev:BaseWorld;
      
      internal const CURRENCY_SYMBOL:Array = ["USD","$",100,"GBP","£",100,"EUR","€",100];
      
      internal var scene:MovieClip;
      
      internal const SKU_TRIALPAY:int = 1;
      
      internal const SKU_PAYPAL_UUNLIMITED:int = 0;
      
      internal var purchasableItems:Array;
      
      internal const PROVIDER_ID:Array = [PurchasableItem.PAYMENT_PROVIDER_PAYPAL,PurchasableItem.PAYMENT_PROVIDER_PAYMO,PurchasableItem.PAYMENT_PROVIDER_TRIALPAY];
      
      internal var skuIds:Array;
      
      internal var payButtons:Array;
      
      internal const SKU_BUTTON_NAME:Array = ["paypalButton0","paymoButton0","trialpayButton"];
      
      public function WorldGoProPay(param1:BaseWorld)
      {
         var _loc3_:* = undefined;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Array = null;
         skuIds = new Array();
         payButtons = new Array();
         super();
         trace(11);
         this.prev = param1;
         scene = new ProPage2();
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
         var _loc2_:String = Engine.instance.getParameterString("pf_user_country");
         if(_loc2_ != "")
         {
            if(_loc2_.toLowerCase() == "gb")
            {
            }
         }
         trace(22);
         GameWorld.rpcClient.getPurchasableItems(getPurchasableItemsOK,getPurchasableItemsFail);
         trace(33);
         _loc3_ = 0;
         while(_loc3_ < SKU_BUTTON_NAME.length)
         {
            if((_loc9_ = scene.group[SKU_BUTTON_NAME[_loc3_]]) != null)
            {
               _loc9_.skuIndex = _loc3_;
               payButtons.push(_loc9_);
               setButtonMode(_loc9_,true);
               _loc9_.addEventListener(MouseEvent.CLICK,payClickListener);
               if(_loc9_.payButton != null && _loc9_.payButton.textField != null)
               {
                  _loc9_.payButton.textField.mouseEnabled = false;
               }
               _loc9_.visible = false;
               (_loc10_ = new HiscoreBoxLoading()).x = _loc9_.x;
               _loc10_.y = _loc9_.y;
               _loc9_.loading = _loc10_;
               scene.group.addChild(_loc10_);
               _loc11_ = BillingConfig.getProviderState(PROVIDER_ID[_loc3_]);
               trace("==>providerid:" + PROVIDER_ID[_loc3_] + ",length:" + _loc11_.length);
               skuIds.push(_loc11_.length > 0 ? _loc11_[0] : 0);
               scene["cover" + (_loc3_ + 1)].visible = _loc11_.length <= 0;
            }
            _loc3_++;
         }
         trace(44);
         setButtonMode(scene.backButton,true);
         scene.backButton.addEventListener(MouseEvent.CLICK,backClickListener);
         Engine.setFontForLang(scene.mainTextField,null);
         scene.mainTextField.text = Engine.getText("GoProPayMain");
         var _loc4_:String = "<TEXTFORMAT LEADING=\"-3\"><P ALIGN=\"LEFT\"><FONT FACE=\"Arial\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\"><B>";
         var _loc5_:String = "</B></FONT></P></TEXTFORMAT>";
         var _loc6_:String = "<FONT COLOR=\"#0066FF\"><A href=\"";
         var _loc7_:String = "\" target=\"_blank\"><B><U>";
         var _loc8_:String = "</U></B></A></FONT>";
         Engine.setFontForLang(scene.termLink.textField,null);
         Engine.setFontForLang(scene.termDesc,null);
         Engine.localiser.setReplaceString("TermsOfServiceLink",_loc6_ + Engine.getText("TermsOfServiceURL") + _loc7_ + Engine.getText("GoProTermsOfService") + _loc8_);
         Engine.localiser.setReplaceString("SupportLink",_loc6_ + Engine.getText("SupportURL") + _loc7_ + Engine.getText("SupportURLDisplay") + _loc8_);
         scene.termLink.textField.htmlText = _loc4_ + Engine.getText("GoProIAgreeTo") + _loc5_;
         scene.termDesc.htmlText = _loc4_ + Engine.getText("GoProPaymentSmallPrint") + _loc5_;
         scene.termTickBox.x = scene.termLink.x - 26;
         scene.termTickBox.gotoAndPlay("unticked");
         scene.termTickBox.addEventListener(MouseEvent.MOUSE_DOWN,termTickBoxListener);
         trace(55);
      }
      
      public function getCurrencyDivider(param1:String) : int
      {
         var _loc2_:int = int(CURRENCY_SYMBOL.indexOf(param1));
         if(_loc2_ != -1)
         {
            return CURRENCY_SYMBOL[_loc2_ + 2];
         }
         return null;
      }
      
      public function payClickListener(param1:MouseEvent) : *
      {
         var url:URLRequest = null;
         var e:MouseEvent = param1;
         var skuIndex:* = e.currentTarget.skuIndex;
         Engine.playSound("ButtonMenu",1);
         if(scene.termTickBox.currentLabel == "ticked")
         {
            url = getPurchasableItem(skuIndex).getPurchaseLink(PROVIDER_ID[skuIndex]);
            if(url != null)
            {
               navigateToURL(url,"_top");
            }
         }
         else
         {
            new OverlayConfirm(this,"Please read and agree to the Terms of Service first.",function():*
            {
            },null,new InfoDialog());
         }
      }
      
      public function getPurchasableItemsFail() : *
      {
         Engine.setActiveWorld(prev);
      }
      
      public function getPurchasableItemsOK(param1:Array) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:PurchasableItem = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         trace("items = " + param1);
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            trace((param1[_loc2_] as PurchasableItem).skuId + "   " + (param1[_loc2_] as PurchasableItem).price + "  " + (param1[_loc2_] as PurchasableItem).currency);
            _loc2_++;
         }
         if(param1 == null || param1.length == 0)
         {
            Engine.setActiveWorld(prev);
         }
         else
         {
            this.purchasableItems = param1;
            scene.termTickBox.visible = true;
            scene.termLink.visible = true;
            _loc2_ = 0;
            while(_loc2_ < payButtons.length)
            {
               _loc3_ = getPurchasableItem(payButtons[_loc2_].skuIndex);
               if(_loc3_ != null && _loc3_.getPurchaseLink(PROVIDER_ID[_loc2_]) != null)
               {
                  if(payButtons[_loc2_].loading != null)
                  {
                     scene.group.removeChild(payButtons[_loc2_].loading);
                     payButtons[_loc2_].loading = null;
                  }
                  payButtons[_loc2_].visible = true;
                  if(payButtons[_loc2_].payButton != null && payButtons[_loc2_].payButton.textField != null)
                  {
                     if(_loc3_ != null)
                     {
                        _loc4_ = _loc3_.currency;
                        _loc5_ = "GoProSKU" + skuIds[payButtons[_loc2_].skuIndex];
                        if(Engine.getText(_loc5_) == _loc5_)
                        {
                           if(PROVIDER_ID[_loc2_] == PurchasableItem.PAYMENT_PROVIDER_PAYPAL)
                           {
                              _loc5_ = "GoProSKU1000";
                           }
                           else if(PROVIDER_ID[_loc2_] == PurchasableItem.PAYMENT_PROVIDER_PAYMO)
                           {
                              _loc5_ = "GoProSKU1071";
                           }
                        }
                        Engine.setFontForLang(payButtons[_loc2_].payButton.textField,null);
                        payButtons[_loc2_].payButton.textField.text = Engine.getText(_loc5_,["price",getCurrencySymbol(_loc4_) + _loc3_.price / getCurrencyDivider(_loc4_)]);
                     }
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public function backClickListener(param1:MouseEvent) : *
      {
         Engine.playSound("ButtonMenu",1);
         Engine.setActiveWorld(prev);
      }
      
      public function termTickBoxListener(param1:MouseEvent) : *
      {
         if(scene.termTickBox.currentLabel == "ticked")
         {
            scene.termTickBox.gotoAndPlay("unticked");
         }
         else
         {
            scene.termTickBox.gotoAndPlay("ticked");
         }
      }
      
      public function getPurchasableItem(param1:int) : PurchasableItem
      {
         var _loc2_:* = 0;
         while(_loc2_ < purchasableItems.length)
         {
            if(purchasableItems[_loc2_].skuId == skuIds[param1])
            {
               return purchasableItems[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getCurrencySymbol(param1:String) : String
      {
         var _loc2_:int = int(CURRENCY_SYMBOL.indexOf(param1));
         if(_loc2_ != -1)
         {
            return CURRENCY_SYMBOL[_loc2_ + 1];
         }
         return null;
      }
   }
}
