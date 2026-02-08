package com.facebook.commands.data
{
   import com.facebook.data.data.NameValueData;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class UpdateObject extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_id","properties","replace"];
      
      public static const METHOD_NAME:String = "data.updateObject";
       
      
      public var properties:NameValueData;
      
      public var replace:Boolean;
      
      public var obj_id:String;
      
      public function UpdateObject(param1:String, param2:NameValueData, param3:Boolean)
      {
         super(METHOD_NAME);
         this.obj_id = param1;
         this.properties = param2;
         this.replace = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_id,this.properties,this.replace);
         super.facebook_internal::initialize();
      }
   }
}
