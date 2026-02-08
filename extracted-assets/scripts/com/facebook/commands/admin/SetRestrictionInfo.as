package com.facebook.commands.admin
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetRestrictionInfo extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["restriction_str"];
      
      public static const METHOD_NAME:String = "admin.setRestrictionInfo";
       
      
      public var restriction_str:String;
      
      public function SetRestrictionInfo(param1:String = "")
      {
         super(METHOD_NAME);
         this.restriction_str = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         this.applySchema(SCHEMA,this.restriction_str);
         super.facebook_internal::initialize();
      }
   }
}
