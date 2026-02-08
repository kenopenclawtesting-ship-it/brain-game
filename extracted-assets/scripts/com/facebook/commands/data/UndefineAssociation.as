package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class UndefineAssociation extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name"];
      
      public static const METHOD_NAME:String = "data.undefineAssociation";
       
      
      public var name:String;
      
      public function UndefineAssociation(param1:String)
      {
         super(METHOD_NAME);
         this.name = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name);
         super.facebook_internal::initialize();
      }
   }
}
