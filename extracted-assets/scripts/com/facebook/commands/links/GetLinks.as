package com.facebook.commands.links
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetLinks extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["uid","link_ids","limit"];
      
      public static const METHOD_NAME:String = "links.get";
       
      
      public var uid:String;
      
      public var link_ids:Array;
      
      public var limit:String;
      
      public function GetLinks(param1:String = null, param2:Array = null, param3:String = null)
      {
         super(METHOD_NAME);
         this.uid = param1;
         this.link_ids = param2;
         this.limit = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.uid,FacebookDataUtils.toArrayString(this.link_ids),this.limit);
         super.facebook_internal::initialize();
      }
   }
}
