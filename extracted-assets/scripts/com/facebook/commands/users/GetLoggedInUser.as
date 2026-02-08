package com.facebook.commands.users
{
   import com.facebook.net.FacebookCall;
   
   public class GetLoggedInUser extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "users.getLoggedInUser";
       
      
      public function GetLoggedInUser()
      {
         super(METHOD_NAME);
      }
   }
}
