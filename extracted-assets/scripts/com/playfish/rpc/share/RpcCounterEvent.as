package com.playfish.rpc.share
{
   public class RpcCounterEvent
   {
       
      
      public var eventStatus:uint;
      
      public var userID:NetworkUid;
      
      public var eventData:String;
      
      public var triggerDate:Date;
      
      public var senderID:NetworkUid;
      
      public var counterEventID:uint;
      
      public var aggregateID:uint;
      
      public var eventType:uint;
      
      public function RpcCounterEvent()
      {
         super();
      }
      
      public function toString() : String
      {
         return "CounterEvent: counterEventID: " + counterEventID + "userID: " + userID + "aggregateID: " + aggregateID + "eventType:  " + eventType + "triggerDate: " + triggerDate + ", eventStatus: " + eventStatus + ", senderID: " + senderID + ", eventData: " + eventData;
      }
   }
}
