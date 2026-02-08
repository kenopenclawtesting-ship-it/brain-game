package com.facebook.commands.photos
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetTags extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["pids"];
      
      public static const METHOD_NAME:String = "photos.getTags";
       
      
      public var pids:Array;
      
      public function GetTags(param1:Array = null)
      {
         super(METHOD_NAME);
         this.pids = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.pids));
         super.facebook_internal::initialize();
      }
   }
}
