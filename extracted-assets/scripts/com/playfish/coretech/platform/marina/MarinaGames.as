package com.playfish.coretech.platform.marina
{
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.engine.filesystem.PFReadXML;
   import com.playfish.coretech.platform.socialnetwork.SocialNetwork;
   import flash.utils.*;
   
   public class MarinaGames extends PFReadXML
   {
      
      private static var callbackHandler:Function;
      
      private static var gameList:Array;
      
      public static var instance:MarinaGames = null;
      
      private static var gameData:Array;
       
      
      public function MarinaGames(param1:String, param2:Boolean = true, param3:Function = null)
      {
         super(param1);
         gameList = new Array();
         gameData = new Array();
         callbackHandler = param3;
         instance = this;
      }
      
      public static function getGameApplicationID(param1:String) : String
      {
         var _loc2_:int = int(gameList.indexOf(param1));
         return _loc2_ == -1 ? null : gameData[_loc2_]["app"];
      }
      
      public static function getGameList() : Array
      {
         return gameList;
      }
      
      public static function getGameCount() : uint
      {
         return gameList == null ? 0 : gameList.length;
      }
      
      public static function toString() : String
      {
         var _loc2_:Object = null;
         var _loc1_:String = "";
         for each(_loc2_ in gameData)
         {
            _loc1_ += _loc2_["name"] + " (" + _loc2_["ref"] + "): AppId=" + _loc2_["app"] + "  CanvasURL=" + _loc2_["url"] + "  FanPage=" + getGameFanPage(_loc2_["id"]) + "\n";
         }
         return _loc1_;
      }
      
      public static function getGameRefFromCanvas(param1:String) : String
      {
         var _loc2_:Object = null;
         for each(_loc2_ in gameData)
         {
            if(_loc2_["url"] == param1)
            {
               return _loc2_["ref"];
            }
         }
         return null;
      }
      
      public static function getGameCanvasURLFromReference(param1:String) : String
      {
         var _loc2_:Object = null;
         for each(_loc2_ in gameData)
         {
            if(_loc2_["ref"] == param1)
            {
               return _loc2_["url"];
            }
         }
         return null;
      }
      
      public static function getGameName(param1:String) : String
      {
         var _loc2_:int = int(gameList.indexOf(param1));
         return _loc2_ == -1 ? null : gameData[_loc2_]["name"];
      }
      
      public static function getGameFanPage(param1:String = null) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = int(gameList.indexOf(param1));
         if(_loc2_ == -1)
         {
            return null;
         }
         if(gameData[_loc2_]["fanpage"] == null)
         {
            return gameData[_loc2_]["app"];
         }
         return gameData[_loc2_]["fanpage"];
      }
      
      public static function getGameReference(param1:String) : String
      {
         var _loc2_:int = int(gameList.indexOf(param1));
         return _loc2_ == -1 ? null : gameData[_loc2_]["ref"];
      }
      
      public static function getGameIDFromReference(param1:String) : String
      {
         var _loc2_:Object = null;
         for each(_loc2_ in gameData)
         {
            if(_loc2_["ref"] == param1)
            {
               return _loc2_["app"];
            }
         }
         return null;
      }
      
      override public function initialiseFromXML(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Object = null;
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         var _loc9_:XML = null;
         var _loc2_:String = SocialNetwork.current.getID();
         for each(_loc3_ in param1..game)
         {
            _loc4_ = new Object();
            _loc5_ = _loc3_..name[0];
            _loc4_["ref"] = _loc3_.@ref.toString();
            _loc4_["name"] = !!_loc5_ ? _loc5_.toString() : null;
            for each(_loc6_ in _loc3_..network)
            {
               if(_loc6_.@id.toString() == _loc2_)
               {
                  _loc7_ = _loc6_..fanpage[0];
                  _loc8_ = _loc6_..application[0];
                  _loc9_ = _loc6_..url[0];
                  _loc4_["fanpage"] = !!_loc7_ ? _loc7_.@id.toString() : null;
                  _loc4_["app"] = !!_loc8_ ? _loc8_.@id.toString() : null;
                  _loc4_["url"] = !!_loc9_ ? _loc9_.@canvas.toString() : null;
               }
            }
            if(_loc4_["app"] == null)
            {
               PFDebug.error("No application key is specified for " + _loc4_["name"]);
            }
            gameList.push(_loc4_["app"]);
            gameData.push(_loc4_);
         }
         if(callbackHandler != null)
         {
            callbackHandler(this);
         }
      }
   }
}
