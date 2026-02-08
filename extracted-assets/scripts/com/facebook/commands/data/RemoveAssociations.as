package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RemoveAssociations extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["assocs","name"];
      
      public static const METHOD_NAME:String = "data.removeAssociations";
       
      
      public var name:String;
      
      public var assocs:Array;
      
      public function RemoveAssociations(param1:Array, param2:String = "")
      {
         super(METHOD_NAME);
         this.assocs = param1;
         this.name = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.assocs,this.name);
         super.facebook_internal::initialize();
      }
   }
}
