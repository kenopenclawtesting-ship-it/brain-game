package com.facebook.commands.notes
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class DeleteNotes extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["title","content","uid"];
      
      public static const METHOD_NAME:String = "notes.delete";
       
      
      public var uid:String;
      
      public var title:String;
      
      public var content:String;
      
      public function DeleteNotes(param1:String, param2:String, param3:String = "")
      {
         super(METHOD_NAME);
         this.title = param1;
         this.content = param2;
         this.uid = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.title,this.content,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
