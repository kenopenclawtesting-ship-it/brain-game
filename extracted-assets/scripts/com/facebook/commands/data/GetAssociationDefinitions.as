package com.facebook.commands.data
{
   import com.facebook.net.FacebookCall;
   
   public class GetAssociationDefinitions extends FacebookCall
   {
      
      public static const SCHEMA:Array = [];
      
      public static const METHOD_NAME:String = "data.getAssociationDefinitions";
       
      
      public function GetAssociationDefinitions()
      {
         super(METHOD_NAME);
      }
   }
}
