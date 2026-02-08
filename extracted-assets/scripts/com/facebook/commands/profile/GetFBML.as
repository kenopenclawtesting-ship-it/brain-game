package com.facebook.commands.profile
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetFBML extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","type"];
      
      public static const METHOD_NAME:String = "profile.getFBML";
       
      
      public var uid:String;
      
      public var type:Number;
      
      public function GetFBML(param1:String = null, param2:Number = NaN)
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.type = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,this.type);
         super.facebook_internal::initialize();
      }
   }
}
