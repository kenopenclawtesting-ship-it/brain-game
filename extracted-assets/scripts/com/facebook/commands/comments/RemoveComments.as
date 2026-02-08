package com.facebook.commands.comments
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RemoveComments extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["xid","comment_id"];
      
      public static const METHOD_NAME:String = "comments.remove";
       
      
      public var commentID:String;
      
      public var xid:String;
      
      public function RemoveComments(param1:String, param2:String)
      {
         super(METHOD_NAME);
         this.xid = param1;
         this.commentID = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.xid,this.commentID);
         super.facebook_internal::initialize();
      }
   }
}
