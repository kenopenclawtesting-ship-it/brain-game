package com.facebook.commands.friends
{
   import com.facebook.net.FacebookCall;
   
   public class GetAppUsers extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "friends.getAppUsers";
       
      
      public function GetAppUsers()
      {
         super(METHOD_NAME);
      }
   }
}
