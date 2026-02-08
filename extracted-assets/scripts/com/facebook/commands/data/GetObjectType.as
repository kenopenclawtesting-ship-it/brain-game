package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetObjectType extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type"];
      
      public static const METHOD_NAME:String = "data.getObjectType";
       
      
      public var obj_type:String;
      
      public function GetObjectType(param1:String)
      {
         super(METHOD_NAME);
         this.obj_type = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type);
         super.facebook_internal::initialize();
      }
   }
}
