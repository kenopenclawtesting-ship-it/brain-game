package com.facebook.commands.admin
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetMetrics extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["start_time","end_time","period","metrics"];
      
      public static const METHOD_NAME:String = "admin.getMetrics";
       
      
      public var period:uint;
      
      public var metrics:Array;
      
      public var end_time:Date;
      
      public var start_time:Date;
      
      public function GetMetrics(param1:Date, param2:Date, param3:uint, param4:Array)
      {
         super(METHOD_NAME);
         this.start_time = param1;
         this.end_time = param2;
         this.period = param3;
         this.metrics = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toDateString(this.start_time),FacebookDataUtils.toDateString(this.end_time),this.period,com.adobe.serialization.json.JSON.encode(this.metrics));
         super.facebook_internal::initialize();
      }
   }
}
