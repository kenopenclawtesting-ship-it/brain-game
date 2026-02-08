package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetUserPreference extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["pref_id","value"];
      
      public static const METHOD_NAME:String = "data.setUserPreference";
       
      
      public var value:String;
      
      public var pref_id:Number;
      
      public function SetUserPreference(param1:uint, param2:String)
      {
         super(METHOD_NAME);
         if(param1 > 200)
         {
            throw new RangeError(InternalErrorMessages.USER_PREFERENCE_ID_RANGE_ERROR);
         }
         if(param2 != null && param2.length > 128)
         {
            throw new RangeError(InternalErrorMessages.USER_PREFERENCE_VALUE_RANGE_ERROR);
         }
         if(param2 == null)
         {
            param2 = "0";
         }
         this.pref_id = param1;
         this.value = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.pref_id,this.value);
         super.facebook_internal::initialize();
      }
   }
}
