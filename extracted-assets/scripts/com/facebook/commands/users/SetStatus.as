package com.facebook.commands.users
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetStatus extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["status","clear","status_includes_verb","uid"];
      
      public static const METHOD_NAME:String = "users.setStatus";
       
      
      public var uid:String;
      
      public var status:String;
      
      public var status_includes_verb:Boolean;
      
      public var clear:Boolean;
      
      public function SetStatus(param1:String = null, param2:Boolean = false, param3:Boolean = false, param4:String = null)
      {
         super(METHOD_NAME);
         this.status = param1;
         this.clear = param2;
         this.status_includes_verb = param3;
         this.uid = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.status,this.clear,this.status_includes_verb,this.uid);
         super.facebook_internal::initialize();
      }
   }
}
