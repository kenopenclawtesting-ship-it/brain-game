package com.facebook.commands.fbml
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetRefHandle extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["handle","fmbl"];
      
      public static const METHOD_NAME:String = "fbml.setRefHandle";
       
      
      public var handle:String;
      
      public var fmbl:String;
      
      public function SetRefHandle(param1:String, param2:String)
      {
         super(METHOD_NAME);
         this.handle = param1;
         this.fmbl = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.handle,this.fmbl);
         super.facebook_internal::initialize();
      }
   }
}
