package com.playfish.games.utils
{
   public class ProtectedInt
   {
      
      private static const CONSTANT:int = 1716716216;
      
      private static const ROUNDS:int = 10;
      
      internal static var rnd:Random = new Random();
      
      private static const POLY:uint = 3172090281;
      
      private static const RPOLY:int = (POLY << 1) + 1;
       
      
      private var checksum:int;
      
      private const ENCRYPT_CONST:* = 286331153;
      
      public var _value:int;
      
      public function ProtectedInt(param1:int = 0)
      {
         super();
         _value = encode(param1);
         checksum = getChecksum(_value);
      }
      
      public function set value(param1:int) : *
      {
         if(isValid())
         {
            _value = encode(param1);
            checksum = getChecksum(_value);
         }
         else
         {
            checksum += rnd.nextInt(1000000) + 1000000;
         }
      }
      
      public function isValid() : Boolean
      {
         return getChecksum(_value) == checksum;
      }
      
      private function decode(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < ROUNDS)
         {
            if((param1 & 2147483648) != 0)
            {
               param1 = param1 << 1 ^ RPOLY;
            }
            else
            {
               param1 <<= 1;
            }
            _loc2_++;
         }
         return param1 - CONSTANT;
      }
      
      public function get value() : int
      {
         return decode(_value);
      }
      
      private function encode(param1:int) : int
      {
         param1 += CONSTANT;
         var _loc2_:int = 0;
         while(_loc2_ < ROUNDS)
         {
            if((param1 & 1) != 0)
            {
               param1 = param1 >>> 1 ^ POLY;
            }
            else
            {
               param1 >>>= 1;
            }
            _loc2_++;
         }
         return param1;
      }
      
      private function getChecksum(param1:int) : int
      {
         param1 += ENCRYPT_CONST;
         var _loc2_:* = 0;
         while(_loc2_ < 10)
         {
            param1 = param1 >> 1 ^ (param1 & 1) * 2567483615;
            _loc2_++;
         }
         return param1;
      }
   }
}
