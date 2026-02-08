package com.playfish.feed
{
   public class Map
   {
       
      
      private var entries:Object;
      
      private var keysList:Array;
      
      public function Map()
      {
         keysList = new Array();
         entries = new Object();
         super();
      }
      
      public function get(param1:Object) : Object
      {
         return entries[param1];
      }
      
      public function getKeysList() : Array
      {
         return keysList.slice();
      }
      
      public function getKeyAt(param1:uint) : Object
      {
         return keysList[param1];
      }
      
      public function get length() : uint
      {
         return keysList.length;
      }
      
      public function getValueAt(param1:uint) : Object
      {
         return entries[param1];
      }
      
      public function put(param1:String, param2:String) : void
      {
         if(entries[param1] != null)
         {
            entries[param1] = param2;
         }
         else
         {
            entries[param1] = param2;
            keysList.push(param1);
         }
      }
   }
}
