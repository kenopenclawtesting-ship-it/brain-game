package com.playfish.rpc.share
{
   public class PfCashMessage
   {
       
      
      internal var msgTime:Date;
      
      internal var msgId:uint;
      
      internal var msgText:String;
      
      public function PfCashMessage(param1:uint, param2:Date, param3:String)
      {
         super();
         this.msgId = param1;
         this.msgTime = param2;
         this.msgText = param3;
      }
      
      public function toString() : String
      {
         return "PfCashMessage{msgId=" + String(msgId) + ",msgTime=" + String(msgTime) + ",msgText=" + String(msgText) + "}";
      }
      
      public function getMsgId() : uint
      {
         return msgId;
      }
      
      public function getMsgText() : String
      {
         return msgText;
      }
      
      public function getMsgTime() : Date
      {
         return msgTime;
      }
   }
}
