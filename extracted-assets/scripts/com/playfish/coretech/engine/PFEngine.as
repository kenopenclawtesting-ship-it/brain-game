package com.playfish.coretech.engine
{
   import com.playfish.coretech.engine.core.*;
   import com.playfish.coretech.engine.game.PFBaseObject;
   import flash.display.*;
   import flash.system.*;
   import flash.utils.*;
   
   public class PFEngine extends MovieClip
   {
      
      public static var instance:PFEngine;
       
      
      public var worldObjectList:PFBaseObject;
      
      protected var flashVars:Object;
      
      public function PFEngine()
      {
         super();
         instance = this;
         worldObjectList = new PFBaseObject();
      }
      
      public function setParameterVars(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            flashVars[_loc2_] = param1[_loc2_];
         }
      }
      
      public function getParameterString(param1:String) : String
      {
         return getParameter(param1) as String;
      }
      
      public function getStageWidth() : Number
      {
         return 0;
      }
      
      public function tickEngine(param1:uint) : void
      {
         worldObjectList.tickBase(param1);
      }
      
      public function setParameter(param1:String, param2:String) : void
      {
         flashVars[param1] = param2;
      }
      
      public function getStageX() : Number
      {
         return 0;
      }
      
      public function getMovieClip(param1:String) : MovieClip
      {
         var mcClass:Class = null;
         var name:String = param1;
         try
         {
            mcClass = Class(getDefinitionByName(name));
            if(mcClass != null)
            {
               return new mcClass();
            }
         }
         catch(e:Error)
         {
            PFDebug.trace(null,e.getStackTrace());
         }
         return null;
      }
      
      override public function toString() : String
      {
         var _loc2_:String = null;
         var _loc1_:* = "";
         _loc1_ += "Parameters:";
         for(_loc2_ in flashVars)
         {
            _loc1_ += _loc2_ + "=" + flashVars[_loc2_] + ", ";
         }
         return _loc1_;
      }
      
      public function removeWorldObject(param1:PFBaseObject) : void
      {
         worldObjectList.removeObject(param1);
      }
      
      public function hasParameter(param1:String) : Boolean
      {
         return flashVars[param1] != undefined;
      }
      
      public function initialize() : void
      {
         flashVars = stage.loaderInfo.parameters;
         if(PFDebug.DEBUG)
         {
            PFDebug.trace(null,"Setting up PFEngine: " + toString());
         }
      }
      
      public function getStageY() : Number
      {
         return 0;
      }
      
      public function getParameter(param1:String) : Object
      {
         if(flashVars == null)
         {
            return null;
         }
         return flashVars[param1];
      }
      
      public function getStageHeight() : Number
      {
         return 0;
      }
      
      public function addWorldObject(param1:PFBaseObject) : void
      {
         worldObjectList.addObject(param1);
      }
      
      public function setParameterString(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc2_:Array = param1.split("&");
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.split("=");
            setParameter(_loc4_[0],_loc4_[1]);
         }
      }
   }
}
