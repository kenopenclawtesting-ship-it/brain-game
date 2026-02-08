package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetAssociatedObjects extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name","obj_id","no_data"];
      
      public static const METHOD_NAME:String = "data.getAssociatedObjects";
       
      
      public var obj_id:String;
      
      public var no_data:Boolean;
      
      public var name:String;
      
      public function GetAssociatedObjects(param1:String, param2:String, param3:Boolean = false)
      {
         super(METHOD_NAME);
         this.name = param1;
         this.obj_id = param2;
         this.no_data = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name,this.obj_id,this.no_data);
         super.facebook_internal::initialize();
      }
   }
}
