package com.facebook.commands.links
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class PostLink extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","url","comment"];
      
      public static const METHOD_NAME:String = "links.post";
       
      
      public var uid:String;
      
      public var url:String;
      
      public var comment:String;
      
      public function PostLink(param1:String, param2:String, param3:String)
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.url = param2;
         this.comment = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,this.url,this.comment);
         super.facebook_internal::initialize();
      }
   }
}
