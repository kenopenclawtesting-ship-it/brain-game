package com.facebook.commands.friends
{
   import com.facebook.net.FacebookCall;
   
   public class GetLists extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "friends.getLists";
       
      
      public function GetLists()
      {
         super(METHOD_NAME);
      }
   }
}
