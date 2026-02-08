package com.playfish.coretech.platform.socialstats
{
   import com.playfish.coretech.engine.core.PFArray;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.engine.core.PFSingleton;
   import com.playfish.coretech.platform.socialplatform.SocialPlatform;
   import com.playfish.coretech.platform.socialplatform.SocialPlatformUser;
   
   public class InviteRecommendations extends PFSingleton
   {
      
      public static var sDebugRecommendationsLimit:int = -1;
      
      public static var sFriendInfoBatchSize:int = 20;
       
      
      private var mBestFriendRandomBias:Number = 1;
      
      private var mAppName:String;
      
      public function InviteRecommendations(param1:String)
      {
         mAppName = param1;
         super();
      }
      
      public static function get instance() : InviteRecommendations
      {
         return getInstance(InviteRecommendations) as InviteRecommendations;
      }
      
      public static function getFriendsWhoAreAppUsers() : Array
      {
         var _loc3_:String = null;
         var _loc4_:SocialPlatformUser = null;
         var _loc1_:Array = SocialPlatform.current.friends.getFriendList();
         var _loc2_:Array = new Array();
         for each(_loc3_ in _loc1_)
         {
            if((_loc4_ = SocialPlatform.current.getPlayer(_loc3_)).getProfileEntry(SocialPlatformUser.PROFILE_APPLICATION_USER) == "1")
            {
               _loc2_.push(_loc4_.getID());
            }
         }
         return _loc2_;
      }
      
      private function friendQueryBatchCompleted() : void
      {
         PFDebug.trace("SOCIAL","Friend query batch completed");
         mBestFriendRandomBias = 3;
      }
      
      public function prepare() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         PFDebug.assert(SocialPlatform.current.friends.isAvailable(),"Require SocialPlatformFriends to be available");
         SocialPlatform.current.application.setFriendshipMetric(FriendshipMetric.PHOTOGRAPHIC_SUBJECT);
         var _loc1_:Array = PFArray.remove(SocialStats.getUnenquiredFriendList(),getFriendsWhoAreAppUsers());
         _loc1_ = PFArray.remove(_loc1_,SocialStats.getFriendsWhoAreFansOf(mAppName));
         if(_loc1_.length > sFriendInfoBatchSize)
         {
            _loc2_ = int(Math.random() * _loc1_.length);
            _loc3_ = _loc2_ + sFriendInfoBatchSize - _loc1_.length;
            _loc1_ = (_loc4_ = _loc1_).slice(_loc2_,_loc2_ + sFriendInfoBatchSize);
            if(_loc3_ > 0)
            {
               _loc1_ = _loc1_.splice(_loc1_.length - 1,0,_loc4_.slice(_loc3_));
            }
         }
         PFDebug.trace("SOCIAL","Requesting friendship info for " + _loc1_.length + " friends");
         SocialPlatform.current.user.evaluateFriendship(_loc1_,friendQueryBatchCompleted);
      }
      
      public function getRecommendedUIDsForInvitations() : Array
      {
         var mapUserObjToUid:Function = null;
         mapUserObjToUid = function(param1:*, param2:int, param3:Array):String
         {
            return param1.uid;
         };
         var recommendations:Array = SocialStats.getBestFriendList().map(mapUserObjToUid);
         recommendations = PFArray.remove(recommendations,getFriendsWhoAreAppUsers());
         recommendations = PFArray.remove(recommendations,SocialStats.getFriendsWhoAreFansOf(mAppName));
         if(PFDebug.DEBUG && sDebugRecommendationsLimit >= 0)
         {
            recommendations.splice(sDebugRecommendationsLimit);
         }
         return recommendations;
      }
      
      public function pickRandomGoodFriendFromBestFriendsList(param1:Array) : SocialPlatformUser
      {
         var _loc2_:uint = uint(Math.pow(Math.random(),mBestFriendRandomBias) * param1.length);
         var _loc3_:String = param1[_loc2_];
         return SocialPlatform.current.getPlayer(_loc3_);
      }
   }
}
