package com.facebook.commands.message
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetThreadsInFolder extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["folder_id","uid","limit","offset"];
      
      public static const METHOD_NAME:String = "Message.getThreadsInFolder";
       
      
      public var offset:String;
      
      public var uid:String;
      
      public var limit:String;
      
      public var folder_id:String;
      
      public function GetThreadsInFolder(param1:String = null, param2:String = null, param3:String = null, param4:String = null)
      {
         super(METHOD_NAME);
         this.folder_id = param1;
         this.uid = param2;
         this.limit = param3;
         this.offset = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.folder_id,this.uid,this.limit,this.offset);
         super.facebook_internal::initialize();
      }
   }
}
