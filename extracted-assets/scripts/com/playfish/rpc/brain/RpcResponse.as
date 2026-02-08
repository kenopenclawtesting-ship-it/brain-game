package com.playfish.rpc.brain
{
   import com.playfish.rpc.messaging.RpcMessagingResponse;
   
   internal class RpcResponse extends RpcMessagingResponse
   {
       
      
      public function RpcResponse()
      {
         super();
      }
      
      internal function readPendingChallenge() : PendingChallenge
      {
         var _loc1_:PendingChallenge = new PendingChallenge();
         _loc1_.id = readUintvar32();
         _loc1_.challenger = readUserInfo();
         _loc1_.score = readUintvar31();
         _loc1_.games = readArray(readUintvar31);
         return _loc1_;
      }
      
      internal function readMinigameScore() : MinigameScore
      {
         var _loc1_:Number = readUint8();
         var _loc2_:Number = readUintvar31();
         return new MinigameScore(_loc1_,_loc2_);
      }
      
      internal function readGloat() : Gloat
      {
         var _loc1_:Gloat = new Gloat();
         _loc1_.id = readUintvar32();
         _loc1_.resourceUrl = readString();
         _loc1_.resource = registerResourceUrl(_loc1_.resourceUrl);
         _loc1_.proOnly = readBoolean();
         return _loc1_;
      }
      
      internal function readAggregateScore() : AggregateScore
      {
         var _loc1_:AggregateScore = new AggregateScore();
         _loc1_.type = readUint8();
         _loc1_.totalScore = readUintvar32();
         _loc1_.playCount = readUintvar32();
         _loc1_.bestScore = readUintvar32();
         return _loc1_;
      }
      
      internal function readHistoricScore() : HistoricScore
      {
         var _loc1_:HistoricScore = new HistoricScore();
         _loc1_.date = readDate();
         _loc1_.scores = readArray(readAggregateScore);
         return _loc1_;
      }
      
      internal function readFullUserInfo() : UserInfo
      {
         var _loc1_:UserInfo = readUserInfo();
         _loc1_.proModeExpiry = readDate();
         _loc1_.friendRank = readUintvar32();
         _loc1_.worldRank = readUintvar32();
         _loc1_.playCount = readUintvar32();
         _loc1_.friendCount = readUintvar32();
         _loc1_.bestCategory = readUint8();
         return _loc1_;
      }
      
      internal function readUserInfo() : UserInfo
      {
         var _loc1_:UserInfo = new UserInfo();
         _loc1_.id = readNetworkUid();
         _loc1_.firstName = readString();
         _loc1_.fullName = readString();
         _loc1_.imageUrl = readString();
         _loc1_.image = registerResourceUrl(_loc1_.imageUrl);
         _loc1_.largeImageUrl = readString();
         _loc1_.largeImage = registerResourceUrl(_loc1_.largeImageUrl);
         _loc1_.profileUrl = readString();
         _loc1_.highScore = readUintvar32();
         _loc1_.achievementMask = readUintvar32();
         _loc1_.challengesWon = readUintvar31();
         _loc1_.challengesLost = readUintvar31();
         _loc1_.challengesScore = readUintvar31();
         _loc1_.minigameAggregateScores = readArray(readAggregateScore);
         _loc1_.isProUser = readBoolean();
         return _loc1_;
      }
   }
}
