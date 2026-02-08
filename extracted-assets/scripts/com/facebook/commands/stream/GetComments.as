package com.facebook.commands.stream
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetComments extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["post_id"];
      
      public static const METHOD_NAME:String = "stream.getComments";
       
      
      public var post_id:String;
      
      public function GetComments(param1:String = null)
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
