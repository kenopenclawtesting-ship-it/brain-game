package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RemoveHashKey extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type","key"];
      
      public static const METHOD_NAME:String = "data.removeHashKey";
       
      
      public var obj_type:String;
      
      public var key:String;
      
      public function RemoveHashKey(param1:String, param2:String)
      {
         super(METHOD_NAME);
         this.obj_type = param1;
         this.key = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type,this.key);
         super.facebook_internal::initialize();
      }
   }
}
