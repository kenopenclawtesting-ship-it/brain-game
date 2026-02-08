package com.facebook.commands.notifications
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetList extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["start_time","include_read"];
      
      public static const METHOD_NAME:String = "notifications.getList";
       
      
      public var start_time:Date;
      
      public var include_read:Boolean;
      
      public function GetList(param1:Date = null, param2:Boolean = false)
      {
         super(METHOD_NAME);
         this.start_time = param1;
         this.include_read = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toDateString(this.start_time),this.include_read);
         super.facebook_internal::initialize();
      }
   }
}
