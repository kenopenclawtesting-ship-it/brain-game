package com.playfish.coretech.platform.natural.facebook
{
   import com.facebook.commands.fql.FqlQuery;
   import com.playfish.coretech.engine.core.PFDebug;
   
   public class FBFqlQuery extends FqlQuery
   {
       
      
      public var queuedObjectRef:Object;
      
      public var callbackFunctionRef:Function;
      
      public function FBFqlQuery(param1:String, param2:Object, param3:Function = null)
      {
         super(param1);
         queuedObjectRef = param2;
         callbackFunctionRef = param3;
         PFDebug.trace(null,"FB FQL:" + param1);
      }
   }
}
