package com.facebook.commands.pages
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class IsAppAdded extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["page_id"];
      
      public static const METHOD_NAME:String = "pages.isAppAdded";
       
      
      public var page_id:String;
      
      public function IsAppAdded(param1:String = null)
      {
         super(METHOD_NAME);
         this.page_id = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.page_id);
         super.facebook_internal::initialize();
      }
   }
}
