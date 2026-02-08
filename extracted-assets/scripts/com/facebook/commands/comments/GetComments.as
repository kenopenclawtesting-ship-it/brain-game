package com.facebook.commands.comments
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetComments extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["xid"];
      
      public static const METHOD_NAME:String = "comments.get";
       
      
      public var xid:String;
      
      public function GetComments(param1:String)
      {
         super(METHOD_NAME);
         this.xid = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.xid);
         super.facebook_internal::initialize();
      }
   }
}
