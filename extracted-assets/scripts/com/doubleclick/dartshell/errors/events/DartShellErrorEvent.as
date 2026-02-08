package com.doubleclick.dartshell.errors.events
{
   import com.doubleclick.dartshell.errors.DartShellError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   
   public class DartShellErrorEvent extends ErrorEvent
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.errors.events.onDartShellError";
       
      
      private var error:DartShellError;
      
      public function DartShellErrorEvent(param1:String = "com.doubleclick.dartshell.errors.events.onDartShellError", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function setError(param1:DartShellError) : void
      {
         this.error = param1;
      }
      
      override public function clone() : Event
      {
         var _loc1_:DartShellErrorEvent = null;
         _loc1_ = new DartShellErrorEvent();
         _loc1_.setError(getError());
         return _loc1_;
      }
      
      public function getError() : DartShellError
      {
         return this.error;
      }
   }
}
