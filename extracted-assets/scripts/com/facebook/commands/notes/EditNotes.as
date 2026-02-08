package com.facebook.commands.notes
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class EditNotes extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["note_id","title","content"];
      
      public static const METHOD_NAME:String = "notes.edit";
       
      
      public var note_id:String;
      
      public var content:String;
      
      public var title:String;
      
      public function EditNotes(param1:String = "", param2:String = "", param3:String = "")
      {
         super(METHOD_NAME);
         this.note_id = param1;
         this.title = param2;
         this.content = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.note_id,this.title,this.content);
         super.facebook_internal::initialize();
      }
   }
}
