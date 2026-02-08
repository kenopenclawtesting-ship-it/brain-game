package com.facebook.commands.connect
{
   import com.facebook.data.connect.ConnectAccountMapCollection;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class RegisterUsers extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["accounts"];
      
      public static const METHOD_NAME:String = "connect.registerUsers";
       
      
      public var accounts:ConnectAccountMapCollection;
      
      public function RegisterUsers(param1:ConnectAccountMapCollection)
      {
         super(METHOD_NAME);
         this.accounts = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         var _loc1_:String = FacebookDataUtils.facebookCollectionToJSONArray(this.accounts);
         applySchema(SCHEMA,_loc1_);
         super.facebook_internal::initialize();
      }
   }
}
