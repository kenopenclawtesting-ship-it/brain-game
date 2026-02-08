package com.facebook.commands.profile
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetFBML extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["markup","uid","profile","mobile_profile","profile_main"];
      
      public static const METHOD_NAME:String = "profile.setFBML";
       
      
      public var uid:String;
      
      public var profile_main:String;
      
      public var markup:String;
      
      public var profile:String;
      
      public var mobile_profile:String;
      
      public function SetFBML(param1:String = null, param2:String = null, param3:String = null, param4:String = null, param5:String = null)
      {
         super(METHOD_NAME);
         this.markup = param1;
         this.uid = param2;
         this.profile = param3;
         this.mobile_profile = param4;
         this.profile_main = param5;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.markup,this.uid,this.profile,this.mobile_profile,this.profile_main);
         super.facebook_internal::initialize();
      }
   }
}
