package com.facebook.commands.admin
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetAllocation extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["integration_point_name"];
      
      public static const METHOD_NAME:String = "admin.getAllocation";
       
      
      public var user:String;
      
      public var integration_point_name:String;
      
      public function GetAllocation(param1:String, param2:String = null)
      {
         super(METHOD_NAME);
         this.integration_point_name = param1;
         this.user = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.integration_point_name);
         super.facebook_internal::initialize();
      }
   }
}
