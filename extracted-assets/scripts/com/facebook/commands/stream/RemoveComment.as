package com.facebook.commands.stream
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RemoveComment extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["comment_id","uid"];
      
      public static const METHOD_NAME:String = "stream.removeComment";
       
      
      public var uid:String;
      
      public var comment_id:String;
      
      public function RemoveComment(param1:String, param2:String = null)
      {
         super(METHOD_NAME);
         this.comment_id = param1;
         this.uid = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.comment_id,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
