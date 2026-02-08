package com.facebook.commands.data
{
   import com.facebook.net.FacebookCall;
   
   public class GetObjectTypes extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "data.getObjectTypes";
       
      
      public function GetObjectTypes()
      {
         super(METHOD_NAME);
      }
   }
}
