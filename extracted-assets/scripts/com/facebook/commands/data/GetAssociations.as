package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetAssociations extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_id1","obj_id2","no_data"];
      
      public static const METHOD_NAME:String = "data.getAssociations";
       
      
      public var obj_id1:String;
      
      public var no_data:Boolean;
      
      public var obj_id2:String;
      
      public function GetAssociations(param1:String, param2:String, param3:Boolean = true)
      {
         super(METHOD_NAME);
         this.obj_id1 = param1;
         this.obj_id2 = param2;
         this.no_data = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_id1,this.obj_id2,this.no_data);
         super.facebook_internal::initialize();
      }
   }
}
