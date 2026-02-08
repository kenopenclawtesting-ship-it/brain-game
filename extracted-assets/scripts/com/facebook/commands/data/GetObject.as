package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetObject extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_id","prop_names"];
      
      public static const METHOD_NAME:String = "data.getObject";
       
      
      public var obj_id:String;
      
      public var prop_names:Array;
      
      public function GetObject(param1:String, param2:Array = null)
      {
         super(METHOD_NAME);
         this.obj_id = param1;
         this.prop_names = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_id,this.prop_names);
         super.facebook_internal::initialize();
      }
   }
}
