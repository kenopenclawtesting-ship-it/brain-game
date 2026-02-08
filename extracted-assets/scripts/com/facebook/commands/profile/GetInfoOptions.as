package com.facebook.commands.profile
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetInfoOptions extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["field"];
      
      public static const METHOD_NAME:String = "profile.getInfoOptions";
       
      
      public var field:String;
      
      public function GetInfoOptions(param1:String)
      {
         super(METHOD_NAME);
         this.field = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.field);
         super.facebook_internal::initialize();
      }
   }
}
