package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class GetUserPreference extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["pref_id"];
      
      public static const METHOD_NAME:String = "data.getUserPreference";
       
      
      public var value:String;
      
      public var pref_id:Number;
      
      public function GetUserPreference(param1:uint)
      {
         super(METHOD_NAME);
         if(param1 > 200)
         {
            throw new RangeError(InternalErrorMessages.USER_PREFERENCE_ID_RANGE_ERROR);
         }
         this.pref_id = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.pref_id);
         super.facebook_internal::initialize();
      }
   }
}
