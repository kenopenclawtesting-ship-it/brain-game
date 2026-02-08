package com.facebook.commands.feed
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   public class PublishUserAction extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["template_bundle_id","template_data","target_ids","body_general","story_size","user_message"];
      
      public static const METHOD_NAME:String = "feed.publishUserAction";
       
      
      public var target_ids:Array;
      
      public var story_size:Number;
      
      public var template_data:Object;
      
      public var body_general:String;
      
      public var user_message:String;
      
      public var template_bundle_id:String;
      
      public function PublishUserAction(param1:String, param2:Object, param3:Array = null, param4:String = null, param5:Number = NaN, param6:String = null)
      {
         super(METHOD_NAME);
         this.template_bundle_id = param1;
         this.template_data = param2;
         this.target_ids = param3;
         this.body_general = param4;
         this.story_size = param5;
         this.user_message = param6;
         applySchema(SCHEMA,param1,com.adobe.serialization.json.JSON.encode(param2),FacebookDataUtils.toArrayString(param3),param4,param5,param6);
      }
   }
}
