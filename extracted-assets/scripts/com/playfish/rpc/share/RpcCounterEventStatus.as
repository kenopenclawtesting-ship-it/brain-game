package com.playfish.rpc.share
{
   public class RpcCounterEventStatus
   {
      
      public static const COUNTER_EVENT_STATUS_DELETED:uint = 2;
      
      public static const COUNTER_EVENT_STATUS_VIEWED:uint = 1;
      
      public static const COUNTER_EVENT_STATUS_NEW:uint = 0;
      
      public static const COUNTER_EVENT_STATUS_COMPLETED:uint = 4;
       
      
      public var eventStatus:uint;
      
      public var counterEventID:uint;
      
      public function RpcCounterEventStatus()
      {
         super();
      }
      
      public function toString() : String
      {
         return "CounterEventStatus: counterEventID: " + counterEventID + ", eventStatus: " + eventStatus;
      }
   }
}
