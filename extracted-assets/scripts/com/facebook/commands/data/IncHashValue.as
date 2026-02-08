package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class IncHashValue extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type","key","prop_name","increment"];
      
      public static const METHOD_NAME:String = "data.incHashValue";
       
      
      public var obj_type:String;
      
      public var increment:Number;
      
      public var prop_name:String;
      
      public var key:String;
      
      public function IncHashValue(param1:String, param2:String, param3:String, param4:Number)
      {
         super(METHOD_NAME);
         this.obj_type = param1;
         this.key = param2;
         this.prop_name = param3;
         this.increment = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type,this.key,this.prop_name,this.increment);
         super.facebook_internal::initialize();
      }
   }
}
