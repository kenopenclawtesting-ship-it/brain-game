package com.facebook.commands.profile
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.data.profile.InfoFieldsData;
   import com.facebook.data.profile.InfoItemData;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class SetInfo extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["title","type","items","uid","format"];
      
      public static const METHOD_NAME:String = "profile.setInfo";
       
      
      public var uid:String;
      
      public var items:InfoFieldsData;
      
      public var title:String;
      
      public var type:Number;
      
      public var format:String;
      
      public function SetInfo(param1:String, param2:Number, param3:InfoFieldsData, param4:String, param5:String = null)
      {
         super(METHOD_NAME);
         this.title = param1;
         this.type = param2;
         this.items = param3;
         this.uid = param4;
         this.format = param5;
      }
      
      override facebook_internal function initialize() : void
      {
         var _loc4_:InfoItemData = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc1_:Object = {
            "items":[],
            "field":this.items.field
         };
         var _loc2_:Number = this.items.items.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.items.items.getItemAt(_loc3_) as InfoItemData;
            _loc5_ = {};
            for each(_loc6_ in _loc4_.facebook_internal::schema)
            {
               if(_loc4_[_loc6_] != null)
               {
                  _loc5_[_loc6_] = _loc4_[_loc6_];
               }
            }
            _loc1_.items.push(_loc5_);
            _loc3_++;
         }
         applySchema(SCHEMA,this.title,this.type,com.adobe.serialization.json.JSON.encode(_loc1_),this.uid,this.format);
         super.facebook_internal::initialize();
      }
   }
}
