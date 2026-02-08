package com.facebook.commands.fql
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class FqlMultiquery extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["queries"];
      
      public static const METHOD_NAME:String = "fql.multiquery";
       
      
      public var queries:Object;
      
      public function FqlMultiquery(param1:Object)
      {
         super(METHOD_NAME);
         this.queries = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,com.adobe.serialization.json.JSON.encode(this.queries));
         super.facebook_internal::initialize();
      }
   }
}
