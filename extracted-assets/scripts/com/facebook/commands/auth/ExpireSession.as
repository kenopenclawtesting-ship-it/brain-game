package com.facebook.commands.auth
{
   import com.facebook.net.FacebookCall;
   
   public class ExpireSession extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "auth.expireSession";
       
      
      public function ExpireSession()
      {
         super(METHOD_NAME);
      }
   }
}
