package com.facebook.utils
{
   import com.facebook.data.FBJSData;
   import com.facebook.events.FacebookEvent;
   import flash.events.AsyncErrorEvent;
   import flash.events.ErrorEvent;
   import flash.events.EventDispatcher;
   import flash.events.SecurityErrorEvent;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   
   public class FBJSBridgeUtil extends EventDispatcher
   {
      
      protected static var receiveConnection:LocalConnection;
      
      protected static var connection:LocalConnection;
       
      
      protected var _params:Array;
      
      protected var _methodName:String;
      
      public var fb_fbjs_connection:String;
      
      public var _api_key:String;
      
      public var fb_local_connection:String;
      
      public function FBJSBridgeUtil(param1:String, param2:String, param3:String)
      {
         var api_key:String = param1;
         var fb_local_connection:String = param2;
         var fb_fbjs_connection:String = param3;
         super();
         this._api_key = api_key;
         this.fb_local_connection = fb_local_connection;
         this.fb_fbjs_connection = fb_fbjs_connection;
         if(connection == null)
         {
            connection = new LocalConnection();
            connection.allowInsecureDomain("*");
            connection.allowDomain("*");
            connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onSendError,false,0,true);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSendError,false,0,true);
            connection.addEventListener(StatusEvent.STATUS,this.onSendStatus,false,0,true);
         }
         if(receiveConnection == null)
         {
            receiveConnection = new LocalConnection();
            receiveConnection.allowInsecureDomain("apps.facebook.com","apps.*.facebook.com");
            receiveConnection.allowDomain("apps.facebook.com","apps.*.facebook.com");
            receiveConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onReceiveError,false,0,true);
            receiveConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onReceiveError,false,0,true);
            receiveConnection.addEventListener(StatusEvent.STATUS,this.onReceiveStatus,false,0,true);
            receiveConnection.client = {"asFunction":this.asFunction};
            try
            {
               receiveConnection.connect(fb_fbjs_connection);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function onSendStatus(param1:StatusEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onSendError(param1:ErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function asFunction(... rest) : void
      {
         var _loc2_:FBJSData = new FBJSData();
         _loc2_.results = rest;
         dispatchEvent(new FacebookEvent(FacebookEvent.COMPLETE,false,false,true,_loc2_));
      }
      
      protected function onReceiveError(param1:ErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function execute() : void
      {
         connection.send(this.fb_local_connection,"callFBJS",this._methodName,this._params);
      }
      
      protected function onReceiveStatus(param1:StatusEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function close() : void
      {
         try
         {
            connection.close();
         }
         catch(e:*)
         {
         }
         try
         {
            receiveConnection.close();
         }
         catch(e:*)
         {
         }
      }
      
      public function call(param1:String, ... rest) : void
      {
         this._methodName = param1;
         this._params = rest;
         this.execute();
      }
   }
}
