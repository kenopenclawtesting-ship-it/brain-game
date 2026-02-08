package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetObjectProperty extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_id","prop_name","prop_value"];
      
      public static const METHOD_NAME:String = "data.setObjectProperty";
       
      
      public var obj_id:String;
      
      public var prop_value:String;
      
      public var prop_name:String;
      
      public function SetObjectProperty(param1:String, param2:String, param3:String)
      {
         super(METHOD_NAME);
         this.obj_id = param1;
         this.prop_name = param2;
         this.prop_value = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_id,this.prop_name,this.prop_value);
         super.facebook_internal::initialize();
      }
   }
}
