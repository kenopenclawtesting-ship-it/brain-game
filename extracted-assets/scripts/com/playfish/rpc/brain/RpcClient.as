package com.playfish.rpc.brain
{
   import com.playfish.rpc.messaging.IRpcMessagingClient;
   import com.playfish.rpc.messaging.RpcMessagingClient;
   import com.playfish.rpc.share.NetworkUid;
   import com.playfish.rpc.share.RpcClientBase;
   
   public class RpcClient extends RpcMessagingClient implements IRpcMessagingClient
   {
      
      internal static const CALL_TYPE_createChallenge:uint = 28;
      
      internal static const CALL_TYPE_uploadScore2:uint = 10;
      
      internal static const CALL_TYPE_uploadMobileScore:uint = 41;
      
      internal static const CALL_TYPE_getHistoricScores:uint = 13;
      
      public static const USER_CONTEXT_CHALLENGE_REGION:uint = 7;
      
      public static const USER_CONTEXT_REGION:uint = 4;
      
      internal static const CALL_TYPE_uploadChallengeScore:uint = 31;
      
      internal static const CALL_TYPE_addAchievements:uint = 15;
      
      public static const BATCHMODE_INORDER:uint = RpcClientBase.BATCHMODE_INORDER;
      
      internal static const CALL_TYPE_getGloatList:uint = 7;
      
      internal static const CALL_TYPE_rejectChallenge:uint = 30;
      
      public static const TIME_CONTEXT_MONTH:uint = 32;
      
      internal static const CALL_TYPE_getUserInfo2:uint = 40;
      
      internal static const CALL_TYPE_recordMessageSeen:uint = 65;
      
      public static const USER_CONTEXT_FRIENDS:uint = 2;
      
      internal static const CALL_TYPE_uploadPracticeScore:uint = 14;
      
      internal static const CALL_TYPE_getScores:uint = 39;
      
      public static const USER_CONTEXT_CHALLENGE_FRIENDS:uint = 6;
      
      public static const TIME_CONTEXT_WEEK:uint = 16;
      
      public static const BATCHMODE_ASYNC:uint = RpcClientBase.BATCHMODE_ASYNC;
      
      public static const USER_CONTEXT_ALL:uint = 1;
      
      public static const TIME_CONTEXT_ALL:uint = 0;
      
      public static const USER_CONTEXT_CHALLENGE_ALL:uint = 5;
      
      internal static const CALL_TYPE_getChallengeFriends:uint = 26;
      
      internal static const CALL_TYPE_getMessagingInfo:uint = 64;
      
      public static const GAME_EVENT_DEBUG:uint = 2;
      
      public static const BATCHMODE_CONDITIONAL:uint = RpcClientBase.BATCHMODE_CONDITIONAL;
      
      public static const GAME_EVENT_START:uint = 1;
      
      internal static const CALL_TYPE_sendGloat:uint = 8;
      
      internal static const CALL_TYPE_getPendingChallenges:uint = 27;
      
      internal static const CALL_TYPE_acceptChallenge:uint = 29;
      
      public static const GAME_EVENT_INIT_DONE:uint = 0;
       
      
      public function RpcClient(param1:Object, param2:uint = 0)
      {
         var loaderParameters:Object = param1;
         var defaultNumResourceCopies:uint = param2;
         super(loaderParameters,defaultNumResourceCopies,function():RpcRequest
         {
            return new RpcRequest();
         },function():RpcResponse
         {
            return new RpcResponse();
         });
      }
      
      private static function getChallengeFriendsResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var challengeFriends:Array = null;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         challengeFriends = response.readArray(response.readUserInfo);
         return function():void
         {
            successCallback(challengeFriends);
         };
      }
      
      private static function createChallengeResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var challengeId:uint = 0;
         var seed0:uint = 0;
         var seed1:uint = 0;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         challengeId = response.readUintvar32();
         seed0 = response.readUintvar32();
         seed1 = response.readUintvar32();
         return function():void
         {
            successCallback(challengeId,seed0,seed1);
         };
      }
      
      private static function getPendingChallengesResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var pendingChallenges:Array = null;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         pendingChallenges = response.readArray(response.readPendingChallenge);
         return function():void
         {
            successCallback(pendingChallenges);
         };
      }
      
      private static function getHistoricScoresResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var historicScores:Array = null;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         historicScores = response.readArray(response.readHistoricScore);
         return function():void
         {
            successCallback(historicScores);
         };
      }
      
      private static function acceptChallengeResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var seed0:uint = 0;
         var seed1:uint = 0;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         seed0 = response.readUintvar32();
         seed1 = response.readUintvar32();
         return function():void
         {
            successCallback(seed0,seed1);
         };
      }
      
      private static function getScoresResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var scores:Array = null;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         scores = response.readSparseArray(response.readUserInfo);
         return function():void
         {
            successCallback(scores);
         };
      }
      
      private static function getGloatListResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var gloats:Array = null;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         gloats = response.readArray(response.readGloat);
         return function():void
         {
            successCallback(gloats);
         };
      }
      
      private static function addAchievementsResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var newAchievements:uint = 0;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         newAchievements = response.readUintvar32();
         return function():void
         {
            successCallback(newAchievements);
         };
      }
      
      private static function getUserInfoResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var userInfo:UserInfo = null;
         var region:String = null;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         userInfo = response.readFullUserInfo();
         region = response.readString();
         return function():void
         {
            successCallback(userInfo,region);
         };
      }
      
      private static function uploadScoreResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var accepted:Boolean = false;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         accepted = response.readBoolean();
         return function():void
         {
            successCallback(accepted);
         };
      }
      
      private static function uploadMobileScoreResponseHandler(param1:RpcResponse, param2:Function) : Function
      {
         var accepted:Boolean = false;
         var userInfo:UserInfo = null;
         var response:RpcResponse = param1;
         var successCallback:Function = param2;
         accepted = response.readBoolean();
         userInfo = response.readFullUserInfo();
         return function():void
         {
            successCallback(accepted,userInfo);
         };
      }
      
      public function recordMessageSeen(param1:int, param2:int, param3:Function, param4:Function) : void
      {
         super.recordMessageSeenWithCallType(CALL_TYPE_recordMessageSeen,param1,param2,param3,param4);
      }
      
      public function rejectChallenge(param1:uint, param2:Function, param3:Function) : void
      {
         var _loc4_:RpcRequest;
         (_loc4_ = RpcRequest(newRpcRequest(CALL_TYPE_rejectChallenge,emptyResponseHandler,param2,param3))).writeUintvar32(param1);
         _loc4_.perform();
      }
      
      public function addAchievements(param1:uint, param2:Function, param3:Function) : void
      {
         var _loc4_:RpcRequest;
         (_loc4_ = RpcRequest(newRpcRequest(CALL_TYPE_addAchievements,addAchievementsResponseHandler,param2,param3))).writeUintvar32(param1);
         _loc4_.perform();
      }
      
      public function createChallenge(param1:NetworkUid, param2:Array, param3:Function, param4:Function) : void
      {
         var _loc5_:RpcRequest;
         (_loc5_ = RpcRequest(newRpcRequest(CALL_TYPE_createChallenge,createChallengeResponseHandler,param3,param4))).writeNetworkUid(param1);
         _loc5_.writeArray(param2,_loc5_.writeUintvar31);
         _loc5_.perform();
      }
      
      public function getChallengeFriends(param1:Function, param2:Function) : void
      {
         var _loc3_:RpcRequest = RpcRequest(newRpcRequest(CALL_TYPE_getChallengeFriends,getChallengeFriendsResponseHandler,param1,param2));
         _loc3_.perform();
      }
      
      public function getGloatList(param1:Function, param2:Function) : void
      {
         var _loc3_:RpcRequest = RpcRequest(newRpcRequest(CALL_TYPE_getGloatList,getGloatListResponseHandler,param1,param2));
         _loc3_.perform();
      }
      
      public function getUserInfo(param1:Function, param2:Function) : void
      {
         var _loc3_:RpcRequest = RpcRequest(newRpcRequest(CALL_TYPE_getUserInfo2,getUserInfoResponseHandler,param1,param2));
         _loc3_.perform();
      }
      
      public function uploadChallengeScore(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Function, param6:Function) : void
      {
         var _loc7_:RpcRequest;
         (_loc7_ = RpcRequest(newRpcRequest(CALL_TYPE_uploadChallengeScore,uploadScoreResponseHandler,param5,param6))).writeUintvar32(param1);
         _loc7_.writeUintvar31(param2);
         _loc7_.writeUintvar32(param3);
         _loc7_.writeBoolean(param4);
         _loc7_.writeArray(timingData,_loc7_.writeTimingData);
         _loc7_.perform();
      }
      
      public function getPendingChallenges(param1:Function, param2:Function) : void
      {
         var _loc3_:RpcRequest = RpcRequest(newRpcRequest(CALL_TYPE_getPendingChallenges,getPendingChallengesResponseHandler,param1,param2));
         _loc3_.perform();
      }
      
      public function sendGloat(param1:uint, param2:String, param3:NetworkUid, param4:Function, param5:Function) : void
      {
         var _loc6_:RpcRequest;
         (_loc6_ = RpcRequest(newRpcRequest(CALL_TYPE_sendGloat,emptyResponseHandler,param4,param5))).writeUintvar32(param1);
         _loc6_.writeString(param2);
         _loc6_.writeNetworkUid(param3);
         _loc6_.perform();
      }
      
      public function getHistoricScores(param1:Function, param2:Function) : void
      {
         var _loc3_:RpcRequest = RpcRequest(newRpcRequest(CALL_TYPE_getHistoricScores,getHistoricScoresResponseHandler,param1,param2));
         _loc3_.perform();
      }
      
      public function getScores(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:uint, param6:Function, param7:Function) : void
      {
         var _loc8_:RpcRequest;
         (_loc8_ = RpcRequest(newRpcRequest(CALL_TYPE_getScores,getScoresResponseHandler,param6,param7))).writeUintvar32(param1);
         _loc8_.writeUintvar32(param2);
         _loc8_.writeUintvar32(param3);
         _loc8_.writeBoolean(param4);
         _loc8_.writeUint8(param5);
         _loc8_.perform();
      }
      
      public function uploadScore(param1:uint, param2:Array, param3:uint, param4:Function, param5:Function) : void
      {
         var _loc6_:RpcRequest;
         (_loc6_ = RpcRequest(newRpcRequest(CALL_TYPE_uploadScore2,uploadScoreResponseHandler,param4,param5))).writeUintvar32(param1);
         _loc6_.writeArray(param2,_loc6_.writeMinigameScore);
         _loc6_.writeUintvar32(param3);
         _loc6_.writeArray(timingData,_loc6_.writeTimingData);
         _loc6_.perform();
      }
      
      public function acceptChallenge(param1:uint, param2:Function, param3:Function) : void
      {
         var _loc4_:RpcRequest;
         (_loc4_ = RpcRequest(newRpcRequest(CALL_TYPE_acceptChallenge,acceptChallengeResponseHandler,param2,param3))).writeUintvar32(param1);
         _loc4_.perform();
      }
      
      public function getMessagingInfo(param1:Function, param2:Function) : void
      {
         super.getMessagingInfoWithCallType(CALL_TYPE_getMessagingInfo,param1,param2);
      }
      
      public function uploadPracticeScore(param1:MinigameScore, param2:Function, param3:Function) : void
      {
         var _loc4_:RpcRequest;
         (_loc4_ = RpcRequest(newRpcRequest(CALL_TYPE_uploadPracticeScore,uploadScoreResponseHandler,param2,param3))).writeMinigameScore(param1);
         _loc4_.writeArray(timingData,_loc4_.writeTimingData);
         _loc4_.perform();
      }
      
      public function uploadMobileScore(param1:Array, param2:Function, param3:Function) : void
      {
         var _loc4_:RpcRequest;
         (_loc4_ = RpcRequest(newRpcRequest(CALL_TYPE_uploadMobileScore,uploadMobileScoreResponseHandler,param2,param3))).writeArray(param1,_loc4_.writeHistoricScore);
         _loc4_.perform();
      }
   }
}
