package com.playfish.feed
{
   public class FeedTemplate
   {
      
      public static var FEED_ARRAYS:Array = new Array();
      
      public static var feedData:Map = new Map();
       
      
      private var psDefault:String;
      
      private var psQuestion:String;
      
      private var paFlashParameter:Map;
      
      private var psFlash:String;
      
      private var psFlashImage:String;
      
      private var psId:String;
      
      public function FeedTemplate()
      {
         super();
      }
      
      public static function loadXML(param1:String) : void
      {
      }
      
      public static function parseFeed(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc4_:XMLList = null;
         var _loc5_:XML = null;
         var _loc6_:FeedTemplate = null;
         var _loc2_:XMLList = param1.Feed;
         for each(_loc3_ in _loc2_)
         {
            trace(_loc3_);
            _loc6_ = new FeedTemplate();
            _loc6_.psId = _loc3_.@id;
            _loc6_.psDefault = _loc3_.@response;
            _loc6_.psQuestion = _loc3_.@question;
            _loc6_.psFlash = _loc3_.@flash;
            _loc6_.psFlashImage = _loc3_.@pic;
            FEED_ARRAYS[_loc3_.@type] = _loc6_;
            trace(_loc3_.@id + " " + _loc3_.@pic);
         }
         _loc4_ = param1.Tokens.Token;
         for each(_loc5_ in _loc4_)
         {
            feedData.put(_loc5_.@key,_loc5_.@value);
         }
      }
      
      public function get defaultMsg() : String
      {
         return psDefault;
      }
      
      public function get question() : String
      {
         return psQuestion;
      }
      
      public function get flash() : String
      {
         return psFlash;
      }
      
      public function get flashImage() : String
      {
         return psFlashImage;
      }
      
      public function get id() : String
      {
         return psId;
      }
   }
}
