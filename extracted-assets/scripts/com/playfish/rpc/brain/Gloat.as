package com.playfish.rpc.brain
{
   public class Gloat
   {
       
      
      public var resourceUrl:String;
      
      public var proOnly:Boolean;
      
      public var id:uint;
      
      public var resource:Array;
      
      public function Gloat()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[Gloat: id=" + id + " resourceUrl=" + resourceUrl + " proOnly=" + proOnly + "]";
      }
   }
}
