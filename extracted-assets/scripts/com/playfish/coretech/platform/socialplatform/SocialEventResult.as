package com.playfish.coretech.platform.socialplatform
{
   import com.playfish.coretech.engine.utils.core.PFXMLProcessor;
   
   public class SocialEventResult
   {
      
      public static const VALID_FLAGS_RESULT_DATA:uint = 4;
      
      public static const VALID_FLAGS_RESULT_RAW:uint = 2;
      
      public static const VALID_FLAGS_RESULT:uint = 1;
      
      public static const VALID_FLAGS_RESULT_XML:uint = 8;
       
      
      public var success:Boolean;
      
      public var resultData:Array;
      
      public var resultRaw:String;
      
      public var platformQuery:Object;
      
      public var platformEvent:Object;
      
      public var errorMessage:String;
      
      public var resultXML:XML;
      
      public var flags:uint;
      
      public function SocialEventResult(param1:Object = null, param2:Object = null)
      {
         super();
         success = false;
         platformQuery = param1;
         platformEvent = param2;
         errorMessage = "Event data not set up in code, by some lazy programmer...";
         resultRaw = "";
         resultData = null;
         resultXML = null;
      }
      
      protected function checkValidity() : void
      {
         flags |= VALID_FLAGS_RESULT;
         flags |= resultRaw == null ? 0 : VALID_FLAGS_RESULT_RAW;
         flags |= resultXML == null ? 0 : VALID_FLAGS_RESULT_XML;
         flags |= resultData == null ? 0 : VALID_FLAGS_RESULT_DATA;
      }
      
      public function applyResult(param1:String) : void
      {
         resultRaw = param1;
         var _loc2_:Object = XML.settings;
         XML.setSettings(XML.defaultSettings());
         resultXML = new XML(resultRaw);
         resultData = PFXMLProcessor.toDataBlock(resultXML);
         XML.setSettings(_loc2_);
         checkValidity();
      }
      
      public function applyResultData(param1:Array) : void
      {
         resultRaw = null;
         resultXML = null;
         resultData = param1;
         checkValidity();
      }
   }
}
