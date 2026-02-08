package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetAssociatedObjectCount extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name","obj_id"];
      
      public static const METHOD_NAME:String = "data.getAssociatedObjectCount";
       
      
      public var obj_id:String;
      
      public var name:String;
      
      public function GetAssociatedObjectCount(param1:String, param2:String)
      {
         super(METHOD_NAME);
         this.name = param1;
         this.obj_id = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name,this.obj_id);
         super.facebook_internal::initialize();
      }
   }
}
