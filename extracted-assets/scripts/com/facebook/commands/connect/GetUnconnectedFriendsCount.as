package com.facebook.commands.connect
{
   import com.facebook.net.FacebookCall;
   
   public class GetUnconnectedFriendsCount extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "connect.getUnconnectedFriendsCount";
       
      
      public function GetUnconnectedFriendsCount()
      {
         super(METHOD_NAME);
      }
   }
}
