package com.facebook.commands.notes
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetNotes extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid"];
      
      public static const METHOD_NAME:String = "notes.get";
       
      
      public var uid:String;
      
      public function GetNotes(param1:String = "")
      {
         super(METHOD_NAME);
         this.uid = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
