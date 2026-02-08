package com.doubleclick.dartshell.events
{
   import flash.events.Event;
   
   public class DartShellLoadedEvent extends Event
   {
      
      public static const TYPE:String = "com.doubleclick.dartshell.events.onDartShellLoaded";
       
      
      private var dartShell:DartShell;
      
      public function DartShellLoadedEvent(param1:String = "com.doubleclick.dartshell.events.onDartShellLoaded", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function setDartShell(param1:DartShell) : void
      {
         this.dartShell = param1;
      }
      
      public function getDartShell() : DartShell
      {
         return dartShell;
      }
      
      override public function clone() : Event
      {
         var _loc1_:DartShellLoadedEvent = null;
         _loc1_ = new DartShellLoadedEvent();
         _loc1_.setDartShell(getDartShell());
         return _loc1_;
      }
   }
}
