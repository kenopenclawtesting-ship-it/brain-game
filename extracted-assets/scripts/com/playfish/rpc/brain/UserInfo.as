package com.playfish.rpc.brain
{
   import com.playfish.rpc.share.NetworkUid;
   
   public class UserInfo
   {
      
      public static const CATEGORY_ANALYSE:uint = 1;
      
      public static const CATEGORY_CALCULATE:uint = 2;
      
      public static const CATEGORY_MEMORISE:uint = 3;
      
      public static const CATEGORY_IDENTIFY:uint = 4;
       
      
      public var bestCategory:uint = 1;
      
      public var challengesScore:uint;
      
      public var profileUrl:String;
      
      public var isProUser:Boolean = true;
      
      public var highScore:uint;
      
      public var friendCount:uint = 0;
      
      public var imageUrl:String;
      
      public var challengesWon:uint;
      
      public var lastChallengeUserScore:uint;
      
      public var id:NetworkUid;
      
      public var lastChallengeOtherScore:uint;
      
      public var challengesLost:uint;
      
      public var minigameAggregateScores:Array;
      
      public var fullName:String;
      
      public var playCount:uint;
      
      public var achievementMask:uint = 0;
      
      public var proModeExpiry:Date;
      
      public var lastChallengeOtherName:String;
      
      public var lastChallengeTime:Date;
      
      public var firstName:String;
      
      public var largeImage:Array;
      
      public var image:Array;
      
      public var challengesTied:uint;
      
      public var friendRank:uint = 1;
      
      public var worldRank:uint = 1;
      
      public var largeImageUrl:String;
      
      public function UserInfo()
      {
         this.minigameAggregateScores = [{
            "type":5,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":4,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":11,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":2,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":3,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":8,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":1,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":0,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":10,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":6,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":7,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         },{
            "type":9,
            "bestScore":0,
            "totalScore":0,
            "playCount":0,
            "score":0
         }];
         super();
      }
      
      public function toString() : String
      {
         var _loc2_:AggregateScore = null;
         var _loc1_:* = "[UserInfo: id=" + id + " firstName=\"" + firstName + "\" fullName=\"" + fullName + "\" imageUrl=" + imageUrl + " largeImageUrl=" + largeImageUrl + " highScore=" + highScore + " achievementMask=" + achievementMask + " ChallengeWon =" + challengesWon + " ChallengeLost= " + challengesLost + " challengesScore = " + challengesScore + " minigameAggregateScores={";
         for each(_loc2_ in minigameAggregateScores)
         {
            _loc1_ += " " + _loc2_;
         }
         return _loc1_ + " } profileUrl=" + profileUrl + " isProUser=" + isProUser + " proModeExpiry=" + proModeExpiry + " friendRank=" + friendRank + " worldRank=" + worldRank + " playCount=" + playCount + " friendCount=" + friendCount + " bestCategory=" + bestCategory + "]";
      }
   }
}
