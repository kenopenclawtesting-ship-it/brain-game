package com.facebook.commands.status
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetStatus extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["status","uid"];
      
      public static const METHOD_NAME:String = "Status.set";
       
      
      public var uid:String;
      
      public var status:String;
      
      public function SetStatus(param1:String = null, param2:String = null)
      {
         super(METHOD_NAME);
         this.status = param1;
         this.uid = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.status,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
