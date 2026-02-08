package com.facebook.commands.application
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetPublicInfo extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["application_id","application_api_key","application_canvas_name"];
      
      public static const METHOD_NAME:String = "application.getPublicInfo";
       
      
      public var application_canvas_name:String;
      
      public var application_id:String;
      
      public var application_api_key:String;
      
      public function GetPublicInfo(param1:String = null, param2:String = null, param3:String = null)
      {
         super(METHOD_NAME);
         if(param1 == null && param2 == null && param3 == null)
         {
            throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
         }
         if(Boolean(param1) && !(param2 == null && param3 == null))
         {
            throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
         }
         if(Boolean(param2) && !(param1 == null && param3 == null))
         {
            throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
         }
         if(Boolean(param3) && !(param1 == null && param2 == null))
         {
            throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
         }
         this.application_id = param1;
         this.application_api_key = param2;
         this.application_canvas_name = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         this.applySchema(SCHEMA,this.application_id,this.application_api_key,this.application_canvas_name);
         super.facebook_internal::initialize();
      }
   }
}
