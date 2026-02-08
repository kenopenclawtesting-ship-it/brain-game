package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.commands.notifications.SendNotification;
   import com.playfish.coretech.engine.core.PFArray;
   import com.playfish.coretech.platform.socialplatform.SocialFeed;
   import com.playfish.coretech.platform.socialplatform.stream.IStreamParameter;
   import com.playfish.coretech.platform.socialplatform.stream.StreamLink;
   import com.playfish.coretech.platform.socialplatform.stream.StreamUnlinkedText;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SocialNotificationsFeed_Facebook extends SocialFeed
   {
       
      
      private var userList:Array;
      
      public function SocialNotificationsFeed_Facebook(param1:String, param2:Boolean = false)
      {
         super(param2);
         userList = new Array();
      }
      
      override public function setTargetUser(param1:*) : Boolean
      {
         if(param1 is String)
         {
            userList.push(param1);
         }
         else if(param1 is Array)
         {
            userList = PFArray.union(userList,param1);
         }
         return true;
      }
      
      override public function publish(param1:Function = null) : EventDispatcher
      {
         var _loc4_:IStreamParameter = null;
         var _loc5_:SendNotification = null;
         var _loc6_:StreamLink = null;
         super.publish(param1);
         var _loc2_:String = "";
         var _loc3_:String = "";
         for each(_loc4_ in parameters)
         {
            if(_loc4_ is StreamLink)
            {
               _loc6_ = _loc4_ as StreamLink;
               _loc3_ += _loc2_;
               _loc3_ += "<a href=\'" + _loc6_.href + "\'>" + _loc6_.text + "</a>";
               _loc2_ = " ";
            }
            if(_loc4_ is StreamUnlinkedText)
            {
               _loc3_ += _loc2_;
               _loc3_ += (_loc4_ as StreamUnlinkedText).textMessage;
               _loc2_ = " ";
            }
         }
         _loc5_ = new SendNotification(userList,_loc3_);
         SocialPlatform_Facebook.facebook.post(_loc5_);
         dispatchEvent(new Event(Event.COMPLETE));
         return this;
      }
   }
}
