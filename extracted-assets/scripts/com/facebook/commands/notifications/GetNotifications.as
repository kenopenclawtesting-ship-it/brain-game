package com.facebook.commands.notifications
{
   import com.facebook.net.FacebookCall;
   
   public class GetNotifications extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "notifications.get";
       
      
      public function GetNotifications()
      {
         super(METHOD_NAME);
      }
   }
}
