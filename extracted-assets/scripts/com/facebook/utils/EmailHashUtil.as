package com.facebook.utils
{
   import com.adobe.crypto.MD5;
   import flash.utils.ByteArray;
   
   public class EmailHashUtil
   {
      
      protected static const crcTable:Array = createCRCTable();
       
      
      public function EmailHashUtil()
      {
         super();
      }
      
      protected static function CRC32(param1:ByteArray, param2:uint = 0, param3:uint = 0) : uint
      {
         if(param2 >= param1.length)
         {
            param2 = param1.length;
         }
         if(param3 == 0)
         {
            param3 = uint(param1.length - param2);
         }
         if(param3 + param2 > param1.length)
         {
            param3 = uint(param1.length - param2);
         }
         var _loc4_:uint = 4294967295;
         var _loc5_:uint = param2;
         while(_loc5_ < param3)
         {
            _loc4_ = uint(uint(crcTable[(_loc4_ ^ param1[_loc5_]) & 0xFF]) ^ _loc4_ >>> 8);
            _loc5_++;
         }
         return _loc4_ ^ 4294967295;
      }
      
      protected static function createCRCTable() : Array
      {
         var _loc2_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < 256)
         {
            _loc2_ = _loc3_;
            _loc4_ = 0;
            while(_loc4_ < 8)
            {
               if(_loc2_ & 1)
               {
                  _loc2_ = uint(3988292384 ^ _loc2_ >>> 1);
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               _loc4_++;
            }
            _loc1_.push(_loc2_);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public static function createHash(param1:String) : String
      {
         var _loc2_:String = null;
         _loc2_ = param1.replace(/\s/ig,"");
         _loc2_ = _loc2_.toLowerCase();
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(_loc2_);
         var _loc4_:uint = CRC32(_loc3_,0,_loc3_.length);
         var _loc5_:String = MD5.hash(_loc2_);
         return _loc4_ + "_" + _loc5_;
      }
   }
}
