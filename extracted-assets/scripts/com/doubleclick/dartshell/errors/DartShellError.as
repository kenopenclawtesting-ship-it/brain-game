package com.doubleclick.dartshell.errors
{
   public class DartShellError extends Error
   {
       
      
      private var cause:String = "Error";
      
      public function DartShellError(param1:String, param2:int = 0)
      {
         cause = "Error";
         super(param1,param2);
         name = "DartShellError";
      }
      
      public function getCause() : String
      {
         return cause;
      }
      
      public function setCause(param1:String) : void
      {
         this.cause = param1;
      }
   }
}
