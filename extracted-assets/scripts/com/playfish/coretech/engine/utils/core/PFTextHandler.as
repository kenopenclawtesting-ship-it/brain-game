package com.playfish.coretech.engine.utils.core
{
   import com.playfish.coretech.engine.core.*;
   import flash.net.*;
   import flash.xml.*;
   
   public class PFTextHandler extends PFXMLLoader
   {
      
      public static var langCode:String = "en";
      
      public static var instance:PFTextHandler;
       
      
      public function PFTextHandler(param1:String = null, param2:Boolean = true)
      {
         if(param1 != null)
         {
            super(param1,param2);
         }
         instance = this;
      }
      
      override public function initialiseFromXML(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         for each(_loc2_ in param1..content)
         {
            for each(_loc3_ in _loc2_..text)
            {
               _loc4_ = _loc3_.toString();
               _loc5_ = int(_loc3_.@maxLength);
               _loc6_ = int(_loc3_.@plural);
               PFText.registerTextString(_loc3_.@id,_loc4_,_loc5_,_loc6_);
            }
         }
      }
   }
}
