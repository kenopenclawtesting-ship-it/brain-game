package com.facebook.commands.comments
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class AddComments extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["xid","text","uid","title","url","publish_to_stream"];
      
      public static const METHOD_NAME:String = "comments.add";
       
      
      public var text:String;
      
      public var url:String;
      
      public var uid:String;
      
      public var xid:String;
      
      public var publish_to_stream:Boolean;
      
      public var title:String;
      
      public function AddComments(param1:String, param2:String, param3:String = null, param4:String = null, param5:String = null, param6:Boolean = false)
      {
         super(METHOD_NAME);
         this.xid = param1;
         this.text = param2;
         this.uid = param3;
         this.title = param4;
         this.url = param5;
         this.publish_to_stream = param6;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.xid,this.text,this.uid,this.title,this.url,this.publish_to_stream);
         super.facebook_internal::initialize();
      }
   }
}
