package com.facebook.commands.data
{
   import com.facebook.data.data.NameValueCollection;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class SetUserPreferences extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["map","replace"];
      
      public static const METHOD_NAME:String = "data.setUserPreferences";
       
      
      public var replace:Boolean;
      
      public var map:NameValueCollection;
      
      public function SetUserPreferences(param1:NameValueCollection, param2:Boolean)
      {
         super(METHOD_NAME);
         this.map = param1;
         this.replace = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toJSONValuesArray(this.map.toArray()),this.replace);
         super.facebook_internal::initialize();
      }
   }
}
