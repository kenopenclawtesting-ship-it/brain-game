package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class DeleteObject extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_id"];
      
      public static const METHOD_NAME:String = "data.deleteObject";
       
      
      public var obj_id:String;
      
      public function DeleteObject(param1:String)
      {
         super(METHOD_NAME);
         this.obj_id = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_id);
         super.facebook_internal::initialize();
      }
   }
}
