package com.facebook.commands.feed
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.data.feed.ActionLinkCollection;
   import com.facebook.data.feed.TemplateCollection;
   import com.facebook.data.feed.TemplateData;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class RegisterTemplateBundle extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["one_line_story_templates","short_story_templates","full_story_template","action_links"];
      
      public static const METHOD_NAME:String = "feed.registerTemplateBundle";
       
      
      public var action_links:ActionLinkCollection;
      
      public var full_story_template:TemplateData;
      
      public var short_story_templates:TemplateCollection;
      
      public var one_line_story_templates:Array;
      
      public function RegisterTemplateBundle(param1:Array, param2:TemplateCollection, param3:TemplateData, param4:ActionLinkCollection)
      {
         super(METHOD_NAME);
         this.one_line_story_templates = param1;
         this.short_story_templates = param2;
         this.full_story_template = param3;
         this.action_links = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,com.adobe.serialization.json.JSON.encode(this.one_line_story_templates),FacebookDataUtils.facebookCollectionToJSONArray(this.short_story_templates),com.adobe.serialization.json.JSON.encode(this.full_story_template),FacebookDataUtils.facebookCollectionToJSONArray(this.action_links));
         super.facebook_internal::initialize();
      }
   }
}
