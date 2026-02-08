package com.playfish.games.whohasthebiggestbrain
{
   import flash.events.*;
   import flash.net.*;
   import flash.utils.ByteArray;
   import flash.xml.*;
   
   public class Localiser
   {
       
      
      public const MAX_REPLACE_DEPTH:int = 3;
      
      public var errorCallBack:Function;
      
      public var langCodes:Array;
      
      public var contents:Array;
      
      public var curLangCode:String;
      
      public var textId:Array;
      
      public var textBody:Array;
      
      public var langNames:Array;
      
      public var completeCallBack:Function;
      
      public function Localiser(param1:String, param2:String, param3:Function = null, param4:Function = null)
      {
         super();
         trace("==>" + param2);
         this.curLangCode = param2;
         this.completeCallBack = param3 == null ? dummy : param3;
         this.errorCallBack = param4 == null ? dummy : param4;
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader(new URLRequest(param1))).dataFormat = URLLoaderDataFormat.BINARY;
         _loc5_.addEventListener(Event.COMPLETE,init);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,error);
      }
      
      public function getTextFromId(param1:String, param2:int = 0, param3:Array = null) : String
      {
         var _loc4_:String = null;
         var _loc5_:int;
         if((_loc5_ = int(textId.indexOf(param1))) != -1)
         {
            _loc4_ = getText(textBody[_loc5_],param2,param3);
         }
         else if(param3 != null && param3.indexOf(param1) != -1)
         {
            _loc4_ = param3[param3.indexOf(param1) + 1];
         }
         else
         {
            _loc4_ = replaceGameString(param1);
         }
         return _loc4_;
      }
      
      protected function replaceGameString(param1:String) : String
      {
         return param1;
      }
      
      private function error(param1:IOErrorEvent) : *
      {
         errorCallBack();
      }
      
      private function init(param1:Event) : *
      {
         var data:ByteArray = null;
         var langXML:XML = null;
         var curContent:XML = null;
         var e:Event = param1;
         try
         {
            data = e.currentTarget.data;
            data.uncompress();
            langXML = new XML(data);
            langCodes = new Array();
            langNames = new Array();
            contents = new Array();
            for each(curContent in langXML.content)
            {
               contents.push(curContent);
               langCodes.push(String(curContent.attribute("lang")));
               langNames.push(String(curContent.attribute("name")));
            }
            setLang(curLangCode);
            completeCallBack();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            errorCallBack();
         }
      }
      
      public function getText(param1:String, param2:int = 0, param3:Array = null) : String
      {
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         if(param2++ >= MAX_REPLACE_DEPTH)
         {
            return param1;
         }
         var _loc4_:int = 0;
         do
         {
            _loc5_ = param1.indexOf("%",_loc4_);
            _loc6_ = null;
            if(_loc5_ != -1)
            {
               if((_loc7_ = param1.indexOf("%",_loc5_ + 1)) != -1)
               {
                  _loc6_ = param1.substring(_loc5_ + 1,_loc7_);
                  if((_loc8_ = getTextFromId(_loc6_,param2,param3)) != null)
                  {
                     param1 = param1.substring(0,_loc5_) + _loc8_ + param1.substring(_loc7_ + 1);
                     _loc4_ = _loc5_ + _loc8_.length;
                  }
               }
            }
         }
         while(_loc6_ != null);
         
         return param1;
      }
      
      public function getCurrentLanguageName() : String
      {
         var _loc1_:int = int(langCodes.indexOf(curLangCode));
         return langNames[_loc1_];
      }
      
      private function dummy() : *
      {
      }
      
      public function setReplaceString(param1:String, param2:String) : void
      {
         if(textId.indexOf(param1) == -1)
         {
            textId.push(param1);
         }
         textBody[textId.indexOf(param1)] = param2;
      }
      
      public function setLang(param1:String) : *
      {
         var _loc5_:XML = null;
         var _loc6_:* = undefined;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc2_:int = int(langCodes.indexOf(param1));
         if(_loc2_ == -1)
         {
            _loc2_ = 0;
         }
         curLangCode = langCodes[_loc2_];
         var _loc3_:XML = contents[_loc2_];
         textId = new Array();
         textBody = new Array();
         var _loc4_:* = _loc3_.text.attributes();
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.name() == "id")
            {
               textId.push(_loc5_.toString());
            }
         }
         _loc6_ = _loc3_.text.body;
         for each(_loc7_ in _loc6_)
         {
            _loc8_ = (_loc8_ = _loc7_).replace(/\\n/g,"\n");
            textBody.push(_loc8_);
         }
      }
      
      public function initNextLang() : *
      {
         var _loc1_:int = int(langCodes.indexOf(curLangCode));
         setLang(langCodes[(_loc1_ + 1) % langCodes.length]);
      }
   }
}
