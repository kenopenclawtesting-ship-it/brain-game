package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.rpc.brain.UserInfo;
   
   public class BrainGameLocaliser extends Localiser
   {
       
      
      public function BrainGameLocaliser(param1:String, param2:Function, param3:Function)
      {
         var _loc4_:String = PFEngine.instance.getParameterString("pf_lang_url");
         if(Debug.DEBUG)
         {
            _loc4_ = "lang.xml";
         }
         else if(_loc4_ == "")
         {
            trace("langUrl = " + _loc4_);
            _loc4_ = "lang.xml";
         }
         super(_loc4_,param1,param2,param3);
      }
      
      override protected function replaceGameString(param1:String) : String
      {
         var _loc2_:UserInfo = null;
         var _loc3_:int = 0;
         if(param1 == "FirstName")
         {
            if(GameWorld.currentUserInfo != null)
            {
               return GameWorld.currentUserInfo.firstName;
            }
         }
         else if(param1 == "LastName")
         {
            if(GameWorld.currentUserInfo != null)
            {
               return GameWorld.currentUserInfo.fullName;
            }
         }
         else if(param1 == "BrainType")
         {
            if(GameWorld.currentUserInfo != null)
            {
               return Engine.getText("BrainType" + GameWorld.getBrainType(GameWorld.currentUserScore));
            }
         }
         else
         {
            if(param1 == "BrainSize")
            {
               return "" + GameWorld.currentUserScore;
            }
            if(param1 == "PlayerRank")
            {
               if(GameWorld.friendsHiscores != null)
               {
                  return "" + GameWorld.getUserScoreRank(GameWorld.friendsHiscores,GameWorld.friendsHiscoresRank);
               }
               return "?";
            }
            if(param1 == "TopFriendName")
            {
               if(GameWorld.friendsHiscores != null)
               {
                  _loc2_ = GameWorld.getUserAtIndex(0,GameWorld.friendsHiscores);
                  if(_loc2_ != null)
                  {
                     return _loc2_.firstName;
                  }
               }
               return "?";
            }
            if(param1 == "TopFriendSize")
            {
               if(GameWorld.friendsHiscores != null)
               {
                  _loc2_ = GameWorld.getUserAtIndex(0,GameWorld.friendsHiscores);
                  if(_loc2_ != null)
                  {
                     return "" + _loc2_.highScore;
                  }
               }
               return "?";
            }
            if(param1 == "TopFriendType")
            {
               if(GameWorld.friendsHiscores != null)
               {
                  _loc2_ = GameWorld.getUserAtIndex(0,GameWorld.friendsHiscores);
                  if(_loc2_ != null)
                  {
                     _loc3_ = GameWorld.getBrainType(_loc2_.highScore);
                     return Engine.getText("BrainType" + _loc3_);
                  }
               }
               return "?";
            }
            if(param1 == "SupportMailAddress")
            {
               return "support@playfish.com";
            }
         }
         return param1;
      }
   }
}
