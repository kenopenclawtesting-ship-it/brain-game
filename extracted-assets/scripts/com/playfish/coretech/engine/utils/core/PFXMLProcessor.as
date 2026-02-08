package com.playfish.coretech.engine.utils.core
{
   public class PFXMLProcessor
   {
       
      
      public function PFXMLProcessor()
      {
         super();
      }
      
      public static function toDataBlock(param1:XML) : Array
      {
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         var _loc6_:XMLList = null;
         var _loc7_:* = undefined;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc2_:Array = new Array();
         var _loc3_:XMLList = param1.children();
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = new Object();
            _loc6_ = _loc4_.children();
            for(_loc7_ in _loc6_)
            {
               _loc9_ = (_loc8_ = _loc6_[_loc7_]).localName().toString();
               _loc10_ = _loc8_.toString();
               _loc5_[_loc9_] = _loc10_;
            }
            _loc2_.push(_loc5_);
         }
         return _loc2_;
      }
   }
}
