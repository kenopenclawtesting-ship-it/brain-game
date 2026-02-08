package com.doubleclick.dartshell.common.events
{
   import flash.events.Event;
   
   public class LogEvent extends Event
   {
      
      public static const TYPE:String = "onLogEvent";
       
      
      private var msg:String;
      
      public function LogEvent(param1:String = "onLogEvent", param2:Boolean = false, param3:Boolean = false, param4:String = "")
      {
         super(param1,param2,param3);
         this.msg = param4;
      }
      
      public function get message() : String
      {
         return msg;
      }
      
      override public function clone() : Event
      {
         return new LogEvent(LogEvent.TYPE,false,false,msg);
      }
   }
}
