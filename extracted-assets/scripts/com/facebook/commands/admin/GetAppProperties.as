package com.facebook.commands.admin
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetAppProperties extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["properties"];
      
      public static const METHOD_NAME:String = "admin.getAppProperties";
       
      
      public var properties:Array;
      
      public function GetAppProperties(param1:Array)
      {
         super(METHOD_NAME);
         this.properties = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.properties));
         super.facebook_internal::initialize();
      }
   }
}
