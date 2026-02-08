package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetAssociatedObjectCounts extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name","obj_ids"];
      
      public static const METHOD_NAME:String = "data.getAssociatedObjectCounts";
       
      
      public var obj_ids:Array;
      
      public var name:String;
      
      public function GetAssociatedObjectCounts(param1:String, param2:Array)
      {
         super(METHOD_NAME);
         this.name = param1;
         this.obj_ids = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name,this.obj_ids);
         super.facebook_internal::initialize();
      }
   }
}
