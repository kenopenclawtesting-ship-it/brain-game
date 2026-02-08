package com.facebook.commands.feed
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class PublishTemplatizedAction extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["title_template","title_data","body_template","body_data","body_general","page_actor_id","image_1","image_1_link","image_2","image_2_link","image_3","image_3_link","image_4","image_4_link","target_ids"];
      
      public static const METHOD_NAME:String = "feed.publishTemplatizedAction";
       
      
      public var title_template:String;
      
      public var image_4_link:String;
      
      public var target_ids:Array;
      
      public var body_general:String;
      
      public var image_1:String;
      
      public var image_2:String;
      
      public var image_3:String;
      
      public var image_4:String;
      
      public var image_2_link:String;
      
      public var page_actor_id:String;
      
      public var body_data:Object;
      
      public var image_1_link:String;
      
      public var title_data:Object;
      
      public var body_template:String;
      
      public var image_3_link:String;
      
      public function PublishTemplatizedAction(param1:String, param2:Object = null, param3:String = "", param4:String = "", param5:String = "", param6:String = "", param7:String = "", param8:String = "", param9:String = "", param10:String = "", param11:String = "", param12:String = "", param13:String = "", param14:String = "", param15:Array = null)
      {
         super(METHOD_NAME);
         this.title_template = param1;
         this.title_data = param2;
         this.body_template = param3;
         this.body_data = param4;
         this.body_general = param5;
         this.page_actor_id = param6;
         this.image_1 = param7;
         this.image_1_link = param8;
         this.image_2 = param9;
         this.image_2_link = param10;
         this.image_3 = param11;
         this.image_3_link = param12;
         this.image_4 = param13;
         this.image_4_link = param14;
         this.target_ids = param15;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.title_template,com.adobe.serialization.json.JSON.encode(this.title_data),this.body_template,this.body_data,this.body_general,this.page_actor_id,this.image_1,this.image_1_link,this.image_2,this.image_2_link,this.image_3,this.image_3_link,this.image_4,this.image_4_link,FacebookDataUtils.toArrayString(this.target_ids));
         super.facebook_internal::initialize();
      }
   }
}
