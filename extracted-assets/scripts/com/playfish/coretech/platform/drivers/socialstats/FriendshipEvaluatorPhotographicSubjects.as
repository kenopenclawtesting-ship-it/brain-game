package com.playfish.coretech.platform.drivers.socialstats
{
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.drivers.socialplatform.facebook.SocialPlatform_Facebook;
   import com.playfish.coretech.platform.socialplatform.*;
   import com.playfish.coretech.platform.socialstats.*;
   
   public class FriendshipEvaluatorPhotographicSubjects extends FriendshipEvaluator
   {
       
      
      protected var processed:Boolean;
      
      public function FriendshipEvaluatorPhotographicSubjects()
      {
         super();
         processed = false;
      }
      
      private function photoSubjectHandler(param1:SocialEventResult, param2:RequestProcessor, param3:Object) : void
      {
         var query:Object = null;
         var weight:uint = 0;
         var uid:String = null;
         var target:String = null;
         var scoreInc:uint = 0;
         var lastSubject:String = null;
         var qline:Object = null;
         var friendID:String = null;
         var event:SocialEventResult = param1;
         var requestProc:RequestProcessor = param2;
         var queryInst:Object = param3;
         try
         {
            if(SocialPlatform_Facebook.isValidEventSuccess(event))
            {
               query = queryInst["query"];
               weight = uint(queryInst["weight"]);
               uid = queryInst["query"]["user"];
               target = queryInst["query"]["target"];
               scoreInc = 10 * weight / 100;
               lastSubject = "";
               for each(qline in event.resultData)
               {
                  SocialPlatform.current.user.updateFriendStats(qline.subject,scoreInc);
               }
               for each(friendID in SocialPlatform.current.user.getFriendIDList())
               {
                  SocialPlatform.current.user.updateFriendStats(friendID,1);
               }
               processed = true;
            }
         }
         catch(error:Error)
         {
            PFDebug.trace(null,"Exception (photo stats):" + (error == null ? "Unknown" : error.message));
         }
         requestProc.onComplete();
      }
      
      override public function generateQuery(param1:Object, param2:Object) : Object
      {
         if(processed)
         {
            return null;
         }
         var _loc3_:String = param1.toString();
         var _loc4_:String = param2.toString();
         updateFriendStatsAll(_loc3_);
         var _loc5_:Object;
         (_loc5_ = new Object())["fql"] = "SELECT pid, subject FROM photo_tag WHERE pid IN (SELECT pid FROM photo_tag WHERE subject=" + _loc3_ + ") AND subject!=\'\' AND subject!=" + _loc3_ + " ORDER BY pid";
         _loc5_["user"] = _loc3_;
         _loc5_["target"] = _loc4_;
         return _loc5_;
      }
      
      override public function processQuery(param1:RequestProcessor, param2:Object) : Boolean
      {
         var _loc3_:Object = param2["query"];
         SocialPlatform_Facebook.instance.queueQuery(_loc3_["fql"].toString(),photoSubjectHandler,param1,param2);
         return true;
      }
      
      override public function reset() : void
      {
         processed = false;
      }
   }
}
