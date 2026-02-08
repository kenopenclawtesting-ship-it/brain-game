package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.whohasthebiggestbrain.*;
   
   public class CalculateElement
   {
      
      public static const SIGN_PLUS:int = 0;
      
      public static const SIGN_MINUS:int = 1;
      
      public static const SIGN_MULTIPLY:int = 2;
      
      public static const SIGN_DIVIDE:int = 3;
      
      public static const NUM_SIGNS:int = 4;
      
      public static const SIGN_STRING:Array = new Array("+","-","x","/");
       
      
      internal var number:int;
      
      internal var element1:CalculateElement;
      
      internal var element2:CalculateElement;
      
      internal var isRoot:Boolean;
      
      internal var sign:int;
      
      public function CalculateElement(param1:int = 0)
      {
         super();
         this.number = param1;
         this.isRoot = true;
      }
      
      public function getResult() : int
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(isRoot)
         {
            return number;
         }
         _loc1_ = element1.getResult();
         _loc2_ = element2.getResult();
         switch(sign)
         {
            case SIGN_PLUS:
               return _loc1_ + _loc2_;
            case SIGN_MINUS:
               return _loc1_ - _loc2_;
            case SIGN_MULTIPLY:
               return _loc1_ * _loc2_;
            case SIGN_DIVIDE:
               return Math.floor(_loc1_ / _loc2_);
            default:
               return 0;
         }
      }
      
      private function getNumberElementsIntoArray(param1:Array) : *
      {
         if(isRoot)
         {
            param1.push(this);
         }
         else
         {
            element1.getNumberElementsIntoArray(param1);
            element2.getNumberElementsIntoArray(param1);
         }
      }
      
      public function clone() : CalculateElement
      {
         var _loc1_:CalculateElement = null;
         if(isRoot)
         {
            return new CalculateElement(number);
         }
         _loc1_ = new CalculateElement();
         _loc1_.isRoot = isRoot;
         _loc1_.number = number;
         _loc1_.sign = sign;
         _loc1_.element1 = element1.clone();
         _loc1_.element2 = element2.clone();
         return _loc1_;
      }
      
      public function getSymbols() : Array
      {
         var _loc1_:Array = new Array();
         getSymbolsIntoArray(_loc1_,false);
         return _loc1_;
      }
      
      public function getString(param1:Boolean = true) : String
      {
         var _loc2_:* = null;
         if(!isRoot)
         {
            _loc2_ = element1.getString() + " " + SIGN_STRING[sign] + " " + element2.getString();
            if(param1)
            {
               _loc2_ = "(" + _loc2_ + ")";
            }
            return _loc2_;
         }
         return "" + number;
      }
      
      public function isIdentical(param1:CalculateElement) : Boolean
      {
         if(this.isRoot)
         {
            return param1.isRoot && param1.number == this.number;
         }
         return !param1.isRoot && (element1.isIdentical(param1.element1) && element2.isIdentical(param1.element2));
      }
      
      public function getNumberElements() : Array
      {
         var _loc1_:Array = new Array();
         getNumberElementsIntoArray(_loc1_);
         return _loc1_;
      }
      
      private function getSignElementsIntoArray(param1:Array) : *
      {
         if(!isRoot)
         {
            if(element1.isRoot && element2.isRoot)
            {
               param1.push(this);
            }
            else
            {
               element1.getSignElementsIntoArray(param1);
               param1.push(this);
               element2.getSignElementsIntoArray(param1);
            }
         }
      }
      
      public function getSignElements() : Array
      {
         var _loc1_:Array = new Array();
         getSignElementsIntoArray(_loc1_);
         return _loc1_;
      }
      
      public function getSymbolsIntoArray(param1:Array, param2:Boolean) : *
      {
         if(isRoot)
         {
            param1.push("" + number);
         }
         else
         {
            if(param2)
            {
               param1.push("(");
            }
            element1.getSymbolsIntoArray(param1,true);
            param1.push(SIGN_STRING[sign]);
            element2.getSymbolsIntoArray(param1,true);
            if(param2)
            {
               param1.push(")");
            }
         }
      }
      
      public function setSign(param1:int) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         this.sign = param1;
         switch(param1)
         {
            case SIGN_PLUS:
               _loc2_ = Engine.rnd(number / 2,number * 3 / 4);
               _loc3_ = number - _loc2_;
               break;
            case SIGN_MINUS:
               _loc3_ = Engine.rnd(number / 4,number / 2);
               _loc2_ = number + _loc3_;
               break;
            case SIGN_MULTIPLY:
               _loc4_ = Math.ceil(Math.sqrt(number));
               _loc2_ = Engine.rnd(Math.ceil(_loc4_ / 2),Math.ceil(_loc4_ + _loc4_ / 2));
               if(_loc2_ == 0)
               {
                  _loc3_ = Engine.rnd(1,number);
               }
               else
               {
                  _loc3_ = Math.floor(number / _loc2_);
               }
               break;
            case SIGN_DIVIDE:
               _loc3_ = Math.max(2,Engine.rnd(Math.ceil(number / 8),Math.ceil(number / 4)));
               _loc2_ = _loc3_ * number;
         }
         number = 0;
         this.isRoot = false;
         element1 = new CalculateElement(_loc2_);
         element2 = new CalculateElement(_loc3_);
      }
   }
}
