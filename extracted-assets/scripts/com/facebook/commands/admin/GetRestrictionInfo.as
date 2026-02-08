package com.facebook.commands.admin
{
   import com.facebook.net.FacebookCall;
   
   public class GetRestrictionInfo extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "admin.getRestrictionInfo";
       
      
      public function GetRestrictionInfo()
      {
         super(METHOD_NAME);
      }
   }
}
