package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetObjects extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_ids","prop_names"];
      
      public static const METHOD_NAME:String = "data.getObjects";
       
      
      public var obj_ids:Array;
      
      public var prop_names:Array;
      
      public function GetObjects(param1:Array, param2:Array = null)
      {
         super(METHOD_NAME);
         this.obj_ids = param1;
         this.prop_names = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.obj_ids),FacebookDataUtils.toArrayString(this.prop_names));
         super.facebook_internal::initialize();
      }
   }
}
