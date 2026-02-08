package com.facebook.commands.notes
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class CreateNotes extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","title","content"];
      
      public static const METHOD_NAME:String = "notes.create";
       
      
      public var uid:String;
      
      public var title:String;
      
      public var content:String;
      
      public function CreateNotes(param1:String, param2:String, param3:String)
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.title = param2;
         this.content = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,this.title,this.content);
         super.facebook_internal::initialize();
      }
   }
}
