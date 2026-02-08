package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RemoveHashKeys extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type","keys"];
      
      public static const METHOD_NAME:String = "data.removeHashKeys";
       
      
      public var obj_type:String;
      
      public var keys:Array;
      
      public function RemoveHashKeys(param1:String, param2:Array)
      {
         super(METHOD_NAME);
         this.obj_type = param1;
         this.keys = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type,this.keys);
         super.facebook_internal::initialize();
      }
   }
}
