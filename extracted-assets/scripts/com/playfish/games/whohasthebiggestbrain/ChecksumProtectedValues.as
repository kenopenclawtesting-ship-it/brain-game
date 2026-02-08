package com.playfish.games.whohasthebiggestbrain
{
   public class ChecksumProtectedValues
   {
       
      
      private var numValues:int;
      
      private var protectedValueChecksums:Array;
      
      private var protectedValues:Array;
      
      public const ENCRYPT_CONST:* = 286331153;
      
      public function ChecksumProtectedValues(param1:int)
      {
         protectedValues = new Array();
         protectedValueChecksums = new Array();
         super();
         this.numValues = param1;
         init();
      }
      
      public function changeValue(param1:int, param2:int) : *
      {
         setValue(param1,getValue(param1) + param2);
      }
      
      public function checkAllValues() : Boolean
      {
         var _loc1_:* = 0;
         while(_loc1_ < numValues)
         {
            if(!checkValue(_loc1_))
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function checkValue(param1:int) : Boolean
      {
         return encryptValue(protectedValues[param1]) == protectedValueChecksums[param1];
      }
      
      public function encryptValue(param1:int) : int
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
      
      public function setValue(param1:int, param2:int) : *
      {
         if(checkValue(param1))
         {
            protectedValueChecksums[param1] = encryptValue(param2);
            protectedValues[param1] = param2;
         }
         else
         {
            protectedValueChecksums[param1] += Engine.rnd(1000000,2000000);
         }
      }
      
      public function init() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < numValues)
         {
            protectedValues[_loc1_] = 0;
            protectedValueChecksums[_loc1_] = encryptValue(protectedValues[_loc1_]);
            _loc1_++;
         }
      }
      
      public function getValue(param1:int) : int
      {
         return protectedValues[param1];
      }
   }
}
