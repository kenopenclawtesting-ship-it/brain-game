package com.facebook.commands.stream
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RemovePost extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["post_id"];
      
      public static const METHOD_NAME:String = "stream.remove";
       
      
      public var post_id:String;
      
      public function RemovePost(param1:String)
      {
         super(METHOD_NAME);
         this.post_id = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.post_id);
         super.facebook_internal::initialize();
      }
   }
}
