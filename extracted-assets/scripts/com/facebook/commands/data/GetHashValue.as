package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetHashValue extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type","key","prop_name"];
      
      public static const METHOD_NAME:String = "data.getHashValue";
       
      
      public var obj_type:String;
      
      public var prop_name:String;
      
      public var key:String;
      
      public function GetHashValue(param1:String, param2:String, param3:String)
      {
         super(METHOD_NAME);
         this.obj_type = param1;
         this.key = param2;
         this.prop_name = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type,this.key,this.prop_name);
         super.facebook_internal::initialize();
      }
   }
}
