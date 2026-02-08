package com.facebook.commands.stream
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class AddLike extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["post_id","uid"];
      
      public static const METHOD_NAME:String = "stream.addLike";
       
      
      public var uid:String;
      
      public var post_id:String;
      
      public function AddLike(param1:String = null, param2:String = null)
      {
         super(METHOD_NAME);
         this.post_id = param1;
         this.uid = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.post_id,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
