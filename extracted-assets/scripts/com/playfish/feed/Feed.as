package com.playfish.feed
{
   public class Feed
   {
       
      
      private var piHeight:Number;
      
      private var psImgSrc:Array;
      
      private var psSendTo:String;
      
      private var paFlashParameters:Map;
      
      private var piWidth:Number;
      
      private var piFeedId:String;
      
      private var psFlashSrc:String = null;
      
      private var psQuestionMsg:String;
      
      private var paParameters:Map;
      
      private var psDefaultresponse:String;
      
      public function Feed(param1:String)
      {
         super();
         paFlashParameters = new Map();
         psImgSrc = new Array();
         paParameters = FeedTemplate.feedData;
         piFeedId = FeedTemplate.FEED_ARRAYS[param1].id;
         psQuestionMsg = FeedTemplate.FEED_ARRAYS[param1].question;
         psDefaultresponse = FeedTemplate.FEED_ARRAYS[param1].defaultMsg;
         psFlashSrc = FeedTemplate.FEED_ARRAYS[param1].flash;
         var _loc2_:String = FeedTemplate.FEED_ARRAYS[param1].flashImage;
         if(_loc2_.length > 0)
         {
            psImgSrc.push(FeedTemplate.FEED_ARRAYS[param1].flashImage);
         }
      }
      
      public function set defaultResponse(param1:String) : void
      {
         this.psDefaultresponse = param1;
      }
      
      public function set height(param1:Number) : void
      {
         this.piHeight = param1;
      }
      
      public function set width(param1:Number) : void
      {
         this.piWidth = param1;
      }
      
      public function set sendTo(param1:String) : void
      {
         this.psSendTo = param1;
      }
      
      public function addFlashParameters(param1:String, param2:String) : void
      {
         paFlashParameters.put(param1,param2);
      }
      
      public function set question(param1:String) : void
      {
         this.psQuestionMsg = param1;
      }
      
      public function generateJSon() : String
      {
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc1_:* = "{";
         if(psFlashSrc.length > 0)
         {
            _loc4_ = true;
            _loc5_ = 0;
            while(_loc5_ < paFlashParameters.length)
            {
               if(_loc4_)
               {
                  psFlashSrc += "?";
               }
               else
               {
                  psFlashSrc += "&";
               }
               psFlashSrc += paFlashParameters.getKeyAt(_loc5_) + "=" + paFlashParameters.get(paFlashParameters.getKeyAt(_loc5_));
               _loc4_ = false;
               _loc5_++;
            }
            _loc1_ += "\"flash\":{\"swfsrc\":\"" + psFlashSrc + "\",\"imgsrc\":\"" + psImgSrc + "\",\"width\":\"" + piWidth + "\", \"height\":\"" + piHeight + "\"}";
         }
         else if(psImgSrc.length > 0)
         {
            _loc1_ += "\"images\":[";
            _loc6_ = true;
            for each(_loc7_ in psImgSrc)
            {
               if(!_loc6_)
               {
                  _loc1_ += ",";
               }
               _loc1_ += "{\"src\":\"" + _loc7_ + "\", \"href\":\"" + paParameters.get("gameLink") + "\"}";
               _loc6_ = false;
            }
            _loc1_ += "]";
         }
         if(_loc1_.length > 2)
         {
            _loc1_ += ",";
         }
         var _loc2_:Boolean = true;
         var _loc3_:Number = 0;
         while(_loc3_ < paParameters.length)
         {
            if(!_loc2_)
            {
               _loc1_ += ",";
            }
            _loc1_ += "\"" + paParameters.getKeyAt(_loc3_) + "\":\"" + paParameters.get(paParameters.getKeyAt(_loc3_)) + "\"";
            _loc2_ = false;
            _loc3_++;
         }
         _loc1_ += "}";
         trace("Js StringA " + _loc1_);
         return _loc1_;
      }
      
      public function toArray() : Array
      {
         var _loc1_:Array = new Array();
         trace("piFeedId " + piFeedId + " " + psQuestionMsg + " " + " " + psDefaultresponse);
         _loc1_.push(piFeedId);
         _loc1_.push(psQuestionMsg);
         _loc1_.push(psDefaultresponse);
         _loc1_.push(generateJSon());
         _loc1_.push(this.psSendTo);
         return _loc1_;
      }
      
      public function set actionLink(param1:String) : void
      {
         this.paParameters.put("gameLink",param1);
      }
      
      public function get imgSrc() : Array
      {
         return this.psImgSrc;
      }
      
      public function addImgSrc(param1:String) : void
      {
         this.psImgSrc.push(param1);
      }
      
      public function setImgSrc(param1:String, param2:int) : void
      {
         this.psImgSrc[param2] = param1;
      }
      
      public function addParameters(param1:String, param2:String) : void
      {
         paParameters.put(param1,param2);
      }
   }
}
