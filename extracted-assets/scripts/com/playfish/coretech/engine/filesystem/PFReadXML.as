package com.playfish.coretech.engine.filesystem
{
   import com.playfish.coretech.engine.core.PFDebug;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   
   public class PFReadXML extends URLLoader
   {
       
      
      public var xml:XML;
      
      protected var request:URLRequest;
      
      public function PFReadXML(param1:String)
      {
         var filename:String = param1;
         super();
         if(filename != null)
         {
            xml = null;
            try
            {
               request = new URLRequest(filename);
               addEventListener(Event.COMPLETE,onFeedXMLLoaderComplete);
               super.load(request);
            }
            catch(error:Error)
            {
               PFDebug.trace(null,"Error in XML loader: " + error.message);
            }
         }
      }
      
      private function onFeedXMLLoaderComplete(param1:Event) : void
      {
         var e:Event = param1;
         try
         {
            xml = new XML(e.currentTarget.data);
            initialiseFromXML(xml);
         }
         catch(error:Error)
         {
            PFDebug.trace(null,"Error in XML load complete: " + error.message);
         }
      }
      
      public function initialiseFromXML(param1:XML) : void
      {
      }
   }
}
