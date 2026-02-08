package com.playfish.games.whohasthebiggestbrain.utils
{
   import com.playfish.games.whohasthebiggestbrain.*;
   
   public class RandomBasket
   {
       
      
      internal var basket:Array;
      
      public function RandomBasket(param1:int = 0, param2:int = 0)
      {
         basket = new Array();
         super();
         var _loc3_:* = param1;
         while(_loc3_ < param2)
         {
            basket.push(_loc3_);
            _loc3_++;
         }
      }
      
      public function getNextItem() : Object
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(basket.length > 0)
         {
            _loc1_ = Engine.rnd(0,basket.length);
            _loc2_ = basket[_loc1_];
            basket.splice(_loc1_,1);
            return _loc2_;
         }
         return null;
      }
      
      public function addItemArray(param1:Array) : *
      {
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            basket.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function clone() : RandomBasket
      {
         var _loc1_:* = new RandomBasket(0,0);
         _loc1_.basket = new Array(basket.length);
         var _loc2_:* = 0;
         while(_loc2_ < basket.length)
         {
            _loc1_.basket[_loc2_] = basket[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function removeItems(... rest) : *
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         while(_loc2_ < rest.length)
         {
            _loc3_ = int(basket.indexOf(rest[_loc2_]));
            if(_loc3_ != -1)
            {
               basket.splice(basket.indexOf(rest[_loc2_]),1);
            }
            _loc2_++;
         }
      }
      
      public function length() : int
      {
         return basket.length;
      }
      
      public function addItems(... rest) : *
      {
         var _loc2_:* = 0;
         while(_loc2_ < rest.length)
         {
            basket.push(rest[_loc2_]);
            _loc2_++;
         }
      }
   }
}
