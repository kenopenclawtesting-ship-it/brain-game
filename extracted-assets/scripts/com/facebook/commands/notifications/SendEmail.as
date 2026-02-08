package com.facebook.commands.notifications
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class SendEmail extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["recipients","subject","text","subject"];
      
      public static const METHOD_NAME:String = "notifications.sendEmail";
       
      
      public var recipients:Array;
      
      public var fbml:String;
      
      public var subject:String;
      
      public var text:String;
      
      public function SendEmail(param1:Array, param2:String, param3:String, param4:String)
      {
         super(METHOD_NAME);
         this.recipients = param1;
         this.subject = param2;
         this.text = param3;
         this.fbml = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.recipients),this.subject,this.text,this.fbml);
         super.facebook_internal::initialize();
      }
   }
}
