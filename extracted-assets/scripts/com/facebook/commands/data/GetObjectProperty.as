package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetObjectProperty extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_id","prop_name"];
      
      public static const METHOD_NAME:String = "data.getObjectProperty";
       
      
      public var obj_id:String;
      
      public var prop_name:String;
      
      public function GetObjectProperty(param1:String, param2:String)
      {
         super(METHOD_NAME);
         this.obj_id = param1;
         this.prop_name = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_id,this.prop_name);
         super.facebook_internal::initialize();
      }
   }
}
