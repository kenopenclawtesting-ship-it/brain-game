package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class DeleteObjects extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_ids"];
      
      public static const METHOD_NAME:String = "data.deleteObjects";
       
      
      public var obj_ids:Array;
      
      public function DeleteObjects(param1:Array)
      {
         super(METHOD_NAME);
         this.obj_ids = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_ids);
         super.facebook_internal::initialize();
      }
   }
}
