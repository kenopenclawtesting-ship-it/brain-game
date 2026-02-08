package com.facebook.commands.groups
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetGroups extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["gids","uid"];
      
      public static const METHOD_NAME:String = "groups.get";
       
      
      public var uid:String;
      
      public var gids:Array;
      
      public function GetGroups(param1:Array = null, param2:String = null)
      {
         super(METHOD_NAME);
         this.gids = param1;
         this.uid = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.gids),this.uid);
         super.facebook_internal::initialize();
      }
   }
}
