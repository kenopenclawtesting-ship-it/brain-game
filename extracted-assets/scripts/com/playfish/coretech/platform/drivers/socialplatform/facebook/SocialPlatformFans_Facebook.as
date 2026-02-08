package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.playfish.coretech.engine.core.PFArray;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.marina.MarinaGames;
   import com.playfish.coretech.platform.socialplatform.FanPage;
   import com.playfish.coretech.platform.socialplatform.SocialEventResult;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFans;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformFansSettings;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformModuleSettings;
   
   public class SocialPlatformFans_Facebook extends SocialPlatformFans
   {
       
      
      private var gameListIndex:uint;
      
      private var gameListCache:Array;
      
      public function SocialPlatformFans_Facebook(param1:SocialPlatformFansSettings)
      {
         super(param1);
      }
      
      public function onGetFanFriends(param1:SocialEventResult) : void
      {
         var fanPageID:String = null;
         var fanFriends:Array = null;
         var user:Object = null;
         var fp:FanPage = null;
         var event:SocialEventResult = param1;
         try
         {
            if(SocialPlatform_Facebook.isValidEventSuccess(event))
            {
               fanPageID = MarinaGames.getGameFanPage(gameListCache[gameListIndex]);
               fanFriends = new Array();
               for each(user in event.resultData)
               {
                  fanFriends.push(user.uid);
               }
               fp = getFanPage(fanPageID);
               fp.addFans(fanFriends);
            }
            else
            {
               PFDebug.trace(null,event.errorMessage);
            }
            ++gameListIndex;
            if(prepareGameFanSearch() == false)
            {
               available = true;
               platformBackRef.onPrepareComplete(PREPARATION_MASK,this);
            }
         }
         catch(error:Error)
         {
            platformBackRef.onPrepareComplete(PREPARATION_MASK,this);
            PFDebug.trace(null,"Exception (fans):" + (error == null ? "Unknown" : error.message));
         }
      }
      
      private function prepareGameFanSearch() : Boolean
      {
         if(gameListCache == null || gameListIndex >= gameListCache.length)
         {
            return false;
         }
         var _loc1_:String = platformBackRef.user.getID();
         var _loc2_:String = MarinaGames.getGameFanPage(gameListCache[gameListIndex]);
         var _loc3_:* = "SELECT uid FROM page_fan WHERE page_id = " + _loc2_ + " AND (uid == " + _loc1_ + " OR (uid IN (SELECT uid2 FROM friend WHERE uid1 = " + _loc1_ + ") ) )";
         return SocialPlatform_Facebook.instance.makeQuery(_loc3_,onGetFanFriends);
      }
      
      override public function prepare(param1:SocialPlatform, param2:SocialPlatformModuleSettings) : Boolean
      {
         super.prepare(param1,param2);
         if(platformBackRef.isPreparing(PREPARATION_MASK) || !param2.enable || isAvailable())
         {
            return true;
         }
         if(MarinaGames.instance == null)
         {
            PFDebug.error("No Marina has been loaded. You can not retrieve fans without it.");
            return false;
         }
         gameListIndex = 0;
         gameListCache = new Array();
         if((param2 as SocialPlatformFansSettings).onlyLoadCurrentGameFans)
         {
            gameListCache.push(SocialPlatform.getGameID());
         }
         else
         {
            PFArray.addToArray(gameListCache,MarinaGames.getGameList());
         }
         if(prepareGameFanSearch())
         {
            platformBackRef.onPrepareBegin(PREPARATION_MASK);
         }
         return true;
      }
      
      override public function isSupported() : Boolean
      {
         return true;
      }
   }
}
