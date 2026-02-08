package com.facebook.commands.profile
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetInfoOptions extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["field","options","format"];
      
      public static const METHOD_NAME:String = "profile.setInfoOptions";
       
      
      public var options:Array;
      
      public var format:String;
      
      public var field:String;
      
      public function SetInfoOptions(param1:String, param2:Array, param3:String)
      {
         super(METHOD_NAME);
         this.field = param1;
         this.options = param2;
         this.format = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.field,this.options,this.format);
         super.facebook_internal::initialize();
      }
   }
}
