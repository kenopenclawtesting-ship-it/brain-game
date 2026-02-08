package com.playfish.coretech.platform.natural.facebook
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.data.events.CreateEventData;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class FBCreateEvent extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["event_info"];
      
      public static const METHOD_NAME:String = "events.create";
       
      
      public var event_info:CreateEventData;
      
      public function FBCreateEvent(param1:CreateEventData)
      {
         super(METHOD_NAME);
         this.event_info = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc1_:Object = {};
         for each(_loc2_ in event_info.facebook_internal::schema)
         {
            _loc3_ = event_info[_loc2_];
            if(_loc3_ is Date)
            {
               _loc3_ = FacebookDataUtils.toDateString(_loc3_ as Date);
            }
            _loc1_[_loc2_] = _loc3_;
         }
         applySchema(SCHEMA,com.adobe.serialization.json.JSON.encode(_loc1_));
         super.facebook_internal::initialize();
      }
   }
}
