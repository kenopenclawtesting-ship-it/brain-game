package com.facebook.commands.intl
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetTranslations extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["locale","all"];
      
      public static const METHOD_NAME:String = "intl.getTranslations";
       
      
      public var all:Boolean;
      
      public var locale:String;
      
      public function GetTranslations(param1:String = "en_US", param2:Boolean = false)
      {
         super(METHOD_NAME);
         this.locale = param1;
         this.all = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.locale,this.all);
         super.facebook_internal::initialize();
      }
   }
}
