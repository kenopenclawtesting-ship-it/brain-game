package com.facebook.commands.stream
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class AddComment extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["post_id","comment"];
      
      public static const METHOD_NAME:String = "stream.addComment";
       
      
      public var post_id:String;
      
      public var comment:String;
      
      public function AddComment(param1:String, param2:String)
      {
         super(METHOD_NAME);
         this.post_id = param1;
         this.comment = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.post_id,this.comment);
         super.facebook_internal::initialize();
      }
   }
}
