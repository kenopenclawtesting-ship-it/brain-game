package com.playfish.coretech.engine.core
{
   public class PFLocaleNumeric
   {
      
      public static const PLURAL_ZERO:int = 0;
      
      public static const PLURAL_SINGULAR:int = 1;
      
      public static var isZeroPlural:Boolean = true;
      
      public static const PLURAL_MANY:int = 3;
      
      public static const PLURAL_PLURAL:int = 2;
       
      
      public function PFLocaleNumeric()
      {
         super();
      }
      
      public static function getPluralConcept(param1:int) : uint
      {
         switch(param1)
         {
            case 1:
               return PLURAL_SINGULAR;
            case 0:
               return isZeroPlural ? uint(PLURAL_PLURAL) : uint(PLURAL_ZERO);
            case 2:
         }
         return PLURAL_PLURAL;
      }
      
      public static function getSeparator() : String
      {
         return ",";
      }
      
      public static function initialize(param1:String) : void
      {
      }
      
      public static function getDecimalPoint() : String
      {
         return ".";
      }
      
      public static function getGrouping() : String
      {
         return "3;-1";
      }
      
      public static function intToString(param1:int) : String
      {
         return PFString.intToString(param1,getSeparator(),getGrouping());
      }
   }
}
