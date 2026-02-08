package com.facebook.commands.notifications
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class MarkRead extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["notification_ids"];
      
      public static const METHOD_NAME:String = "notifications.markRead";
       
      
      public var notification_ids:Array;
      
      public function MarkRead(param1:Array)
      {
         super(METHOD_NAME);
         this.notification_ids = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.notification_ids));
         super.facebook_internal::initialize();
      }
   }
}
