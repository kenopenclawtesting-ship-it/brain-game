package com.playfish.coretech.engine.core
{
   public class PFDebug
   {
      
      public static const FALSE:Boolean = false;
      
      public static const TRACE_INFO:int = 0;
      
      private static const spacing:String = "   ";
      
      public static const TRACE_MESSAGE:int = 1;
      
      public static const TRUE:Boolean = true;
      
      private static const newline:String = "\n";
      
      public static const TRACE_ERROR:int = 3;
      
      public static var cbf:Function = null;
      
      public static const TRACE_WARNING:int = 2;
      
      public static var DEBUG:Boolean = true;
      
      public static var traceLevel:int = TRACE_INFO;
      
      {
         DEBUG = false;
      }
      
      public function PFDebug()
      {
         super();
      }
      
      public static function setDebugState(param1:Boolean) : void
      {
         DEBUG = param1;
      }
      
      public static function setTraceLevel(param1:int) : void
      {
         traceLevel = param1;
      }
      
      public static function trace(param1:String, param2:String) : void
      {
         announce(TRACE_MESSAGE,param2);
      }
      
      public static function message(param1:String) : void
      {
         announce(TRACE_MESSAGE,param1);
      }
      
      public static function assert(param1:Boolean, param2:String = "Unspecified assertion") : Boolean
      {
         if(!param1)
         {
            error(param2);
         }
         return !param1;
      }
      
      public static function setHandler(param1:Function) : void
      {
         cbf = param1;
      }
      
      public static function error(param1:String) : void
      {
         announce(TRACE_ERROR,param1);
      }
      
      public static function dumpToString(param1:Object, param2:String = "") : String
      {
         var _loc4_:uint = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:String = param2;
         if(param1 == null)
         {
            return "null";
         }
         if(param1 is Array)
         {
            if((param1 as Array).length == 0)
            {
               _loc3_ += "[]" + newline;
            }
            else
            {
               _loc4_ = 0;
               _loc3_ = "";
               for each(_loc5_ in param1)
               {
                  _loc3_ += param2 + "[" + _loc4_ + "] = " + newline + dumpToString(_loc5_,param2 + spacing);
                  _loc4_++;
               }
            }
         }
         else if(param1 is Function)
         {
            _loc3_ += "Function: " + param1.toString() + newline;
         }
         else if(param1 is Date)
         {
            _loc3_ += "Date: " + param1.toString() + newline;
         }
         else if(param1 is String || typeof param1 == "string")
         {
            _loc3_ += "\"" + param1.toString() + "\"" + newline;
         }
         else if(typeof param1 == "number" || typeof param1 == "boolean")
         {
            _loc3_ += param1.toString() + newline;
         }
         else if(param1 is Object)
         {
            _loc3_ = "";
            for(_loc6_ in param1)
            {
               _loc3_ += param2 + " ." + _loc6_ + " = " + param1[_loc6_] + newline;
            }
         }
         else
         {
            _loc3_ += param1.toString() + newline;
         }
         return _loc3_;
      }
      
      public static function warning(param1:String) : void
      {
         announce(TRACE_WARNING,param1);
      }
      
      public static function info(param1:String) : void
      {
         announce(TRACE_INFO,param1);
      }
      
      public static function announce(param1:int, param2:String) : void
      {
         if(DEBUG && param1 >= traceLevel && cbf != null)
         {
            cbf(param1,param2);
         }
      }
   }
}
