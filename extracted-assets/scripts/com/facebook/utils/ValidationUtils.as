package com.facebook.utils
{
   public class ValidationUtils
   {
       
      
      public function ValidationUtils()
      {
         super();
      }
      
      public static function validateLength(param1:String) : Boolean
      {
         return param1 == null || param1.length >= 255 ? false : true;
      }
      
      public static function isDataObjectTypeValid(param1:String) : Boolean
      {
         if(param1 == null || param1.length > 32)
         {
            return false;
         }
         var _loc2_:RegExp = /[^a-z_0-9]/ig;
         return !_loc2_.exec(param1);
      }
   }
}
