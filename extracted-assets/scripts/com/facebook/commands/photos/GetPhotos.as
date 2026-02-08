package com.facebook.commands.photos
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetPhotos extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["subj_id","aid","pids"];
      
      public static const METHOD_NAME:String = "photos.get";
       
      
      protected var subj_id:String;
      
      protected var aid:String;
      
      protected var pids:Array;
      
      public function GetPhotos(param1:String = "", param2:String = "", param3:Array = null)
      {
         super(METHOD_NAME);
         this.subj_id = param1;
         this.aid = param2;
         this.pids = param3;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.subj_id,this.aid,FacebookDataUtils.toArrayString(this.pids));
         super.facebook_internal::initialize();
      }
   }
}
