package com.facebook.commands.stream
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetStream extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["viewer_id","source_ids","start_time","end_time","limit","filter_key"];
      
      public static const METHOD_NAME:String = "stream.get";
       
      
      public var source_ids:Array;
      
      public var viewer_id:String;
      
      public var start_time:Date;
      
      public var end_time:Date;
      
      public var filter_key:String;
      
      public var limit:uint;
      
      public function GetStream(param1:String, param2:Array = null, param3:Date = null, param4:Date = null, param5:uint = 30, param6:String = null)
      {
         this.viewer_id = param1;
         this.source_ids = param2;
         this.start_time = param3;
         this.end_time = param4;
         this.limit = param5;
         this.filter_key = param6;
         super(METHOD_NAME);
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.viewer_id,FacebookDataUtils.toArrayString(this.source_ids),FacebookDataUtils.toDateString(this.start_time),FacebookDataUtils.toDateString(this.end_time),this.limit,this.filter_key);
         super.facebook_internal::initialize();
      }
   }
}
