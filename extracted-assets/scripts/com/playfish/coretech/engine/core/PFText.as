package com.playfish.coretech.engine.core
{
   import com.playfish.coretech.engine.utils.core.PFTextHandler;
   
   public class PFText
   {
      
      private static var textReplacers:Array = new Array();
      
      public static var textMappings:Object = new Array();
      
      {
         addTextReplacer(new PFTextReplacerNewline());
         setCurrentLanguage("en");
      }
      
      public function PFText()
      {
         super();
      }
      
      public static function registerTextString(param1:String, param2:String, param3:int, param4:int = 0) : void
      {
         var _loc5_:Object = textMappings[PFTextHandler.langCode];
         if(PFDebug.DEBUG)
         {
            PFDebug.assert(_loc5_[param1] != null && _loc5_[param1][param4] == null,"Dublicate language entry! langCode: " + PFTextHandler.langCode + ", textId: " + param1);
            PFDebug.assert(param2.length <= param3,"Translation too long! langCode: " + PFTextHandler.langCode + ", textId: " + param1 + ", length: " + param2.length + ", max: " + param3);
            PFDebug.assert(param2.length != 0,"String is empty, textId: " + param1 + ", langCode: " + PFTextHandler.langCode);
         }
         if(_loc5_[param1] == null)
         {
            _loc5_[param1] = new Array();
         }
         _loc5_[param1][param4] = param2;
      }
      
      public static function getText(param1:String, ... rest) : String
      {
         var _loc4_:PFTextReplacer = null;
         var _loc5_:int = 0;
         if(rest.length == 1 && rest[0] is Array)
         {
            rest = rest[0];
         }
         var _loc3_:String = getTextRaw(param1,PFLocaleNumeric.PLURAL_ZERO);
         for each(_loc4_ in textReplacers)
         {
            _loc3_ = _loc4_.replaceText(_loc3_);
         }
         _loc5_ = 0;
         while(_loc5_ < rest.length)
         {
            _loc3_ = PFString.replaceAll(_loc3_,"%" + (_loc5_ + 1),rest[_loc5_]);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function getTextRaw(param1:String, param2:int) : String
      {
         var _loc4_:uint = 0;
         var _loc3_:Object = textMappings[PFTextHandler.langCode];
         if(_loc3_[param1] != null)
         {
            if(_loc3_[param1][param2] != null && param2 < _loc3_[param1].length)
            {
               return _loc3_[param1][param2];
            }
            _loc4_ = PFLocaleNumeric.getPluralConcept(param2);
            if(_loc3_[param1][_loc4_] != null)
            {
               return _loc3_[param1][_loc4_];
            }
            if(_loc3_[param1][0] != null)
            {
               return _loc3_[param1][0];
            }
         }
         return param1;
      }
      
      public static function isLanguageLoaded(param1:String) : Boolean
      {
         return textMappings[param1] != null;
      }
      
      public static function registerMeta(param1:String, param2:String) : void
      {
         addTextReplacer(new PFTextReplacerMeta(param1,param2));
      }
      
      public static function registerTextID(param1:uint, param2:String) : void
      {
         registerTextString("" + param1,param2,0);
      }
      
      public static function addTextReplacer(param1:PFTextReplacer) : void
      {
         var _loc2_:PFTextReplacer = null;
         for each(_loc2_ in textReplacers)
         {
            if(_loc2_.getReplaceToken() == param1.getReplaceToken())
            {
               _loc2_.replaceReplacement(param1);
               return;
            }
         }
         textReplacers.push(param1);
      }
      
      private static function makeReplacements(param1:String, param2:int, param3:int, ... rest) : String
      {
         var _loc5_:PFTextReplacer = null;
         var _loc6_:int = 0;
         if(param1 != null)
         {
            for each(_loc5_ in textReplacers)
            {
               param1 = _loc5_.replaceText(param1);
            }
            if(param2 == 2)
            {
               param1 = PFString.replaceAll(param1,"%1","" + param3);
            }
            _loc6_ = 0;
            while(_loc6_ < rest.length)
            {
               param1 = PFString.replaceAll(param1,"%" + (_loc6_ + param2),rest[_loc6_]);
               _loc6_++;
            }
         }
         return param1;
      }
      
      public static function validate() : Boolean
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc1_:Boolean = true;
         if(PFDebug.DEBUG && PFTextHandler.langCode != "en")
         {
            _loc2_ = textMappings["en"];
            if(_loc2_ != null)
            {
               _loc3_ = textMappings[PFTextHandler.langCode];
               _loc4_ = new Array();
               _loc5_ = new Array();
               for(_loc6_ in _loc2_)
               {
                  if(!_loc3_[_loc6_])
                  {
                     _loc4_.push(_loc6_);
                  }
               }
               for(_loc6_ in _loc3_)
               {
                  if(!_loc2_[_loc6_])
                  {
                     _loc5_.push(_loc6_);
                  }
               }
               if(_loc4_.length > 0)
               {
                  PFDebug.warning("Language " + PFTextHandler.langCode + " has missing text ids compared to english: " + _loc4_);
               }
               if(_loc5_.length > 0)
               {
                  PFDebug.warning("Language " + PFTextHandler.langCode + " has additional text ids compared to english: " + _loc5_);
               }
            }
         }
         else
         {
            PFDebug.message("No validation occurs on English files");
         }
         return _loc1_;
      }
      
      public static function getTextN(param1:String, param2:int, ... rest) : String
      {
         var _loc5_:PFTextReplacer = null;
         var _loc6_:int = 0;
         if(PFDebug.DEBUG)
         {
            PFDebug.assert(param1 != null,"Requested text with null id");
         }
         var _loc4_:String = getTextRaw(param1,param2);
         for each(_loc5_ in textReplacers)
         {
            _loc4_ = _loc5_.replaceText(_loc4_);
         }
         _loc4_ = PFString.replaceAll(_loc4_,"%1","" + param2);
         _loc6_ = 0;
         while(_loc6_ < rest.length)
         {
            _loc4_ = PFString.replaceAll(_loc4_,"%" + (_loc6_ + 2),rest[_loc6_]);
            _loc6_++;
         }
         return _loc4_;
      }
      
      public static function getCurrentLanguage() : String
      {
         return PFTextHandler.langCode;
      }
      
      public static function setCurrentLanguage(param1:String) : void
      {
         if(textMappings[param1] == null)
         {
            textMappings[param1] = new Object();
         }
         PFTextHandler.langCode = param1;
      }
   }
}
