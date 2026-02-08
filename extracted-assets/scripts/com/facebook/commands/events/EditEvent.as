package com.facebook.commands.events
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.data.events.EditEventData;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class EditEvent extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["eid","event_info"];
      
      public static const METHOD_NAME:String = "events.edit";
       
      
      public var eid:String;
      
      public var event_info:EditEventData;
      
      public function EditEvent(param1:String, param2:EditEventData)
      {
         super(METHOD_NAME);
         this.eid = param1;
         this.event_info = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc1_:Object = {};
         for each(_loc2_ in this.event_info.schema)
         {
            _loc3_ = this.event_info[_loc2_];
            if(_loc3_ is Date)
            {
               _loc3_ = FacebookDataUtils.toDateString(_loc3_ as Date);
            }
            _loc1_[_loc2_] = _loc3_;
         }
         applySchema(SCHEMA,this.eid,com.adobe.serialization.json.JSON.encode(this.event_info));
         super.facebook_internal::initialize();
      }
   }
}
