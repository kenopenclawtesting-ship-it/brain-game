package com.facebook.commands.auth
{
   import com.facebook.net.FacebookCall;
   
   public class PromoteSession extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "auth.promoteSession";
       
      
      public function PromoteSession()
      {
         super(METHOD_NAME);
      }
   }
}
