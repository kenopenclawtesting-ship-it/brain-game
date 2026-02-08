package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class CreateObject extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type","properties"];
      
      public static const METHOD_NAME:String = "data.createObject";
       
      
      protected var obj_type:String;
      
      protected var properties:*;
      
      public function CreateObject(param1:String, param2:* = null)
      {
         super(METHOD_NAME);
         this.obj_type = param1;
         this.properties = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type,this.properties);
         super.facebook_internal::initialize();
      }
   }
}
