package com.facebook.commands.data
{
   import com.facebook.net.FacebookCall;
   
   public class GetUserPreferences extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "data.getUserPreferences";
       
      
      public function GetUserPreferences()
      {
         super(METHOD_NAME);
      }
   }
}
