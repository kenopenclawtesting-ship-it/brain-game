package com.facebook.commands.data
{
   import com.facebook.data.data.SetAssociationsDataCollection;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetAssociations extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["assocs","name"];
      
      public static const METHOD_NAME:String = "data.setAssociations";
       
      
      protected var name:String;
      
      protected var assocs:SetAssociationsDataCollection;
      
      public function SetAssociations(param1:SetAssociationsDataCollection, param2:String = null)
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
