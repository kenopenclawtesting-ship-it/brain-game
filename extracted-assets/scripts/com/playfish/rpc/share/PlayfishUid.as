package com.playfish.rpc.share
{
   public class PlayfishUid
   {
       
      
      internal var _playfishUid:uint;
      
      public function PlayfishUid(param1:uint)
      {
         super();
         this._playfishUid = param1;
      }
      
      public static function create(param1:uint) : PlayfishUid
      {
         return new PlayfishUid(param1);
      }
      
      public function get playfishUid() : uint
      {
         return _playfishUid;
      }
   }
}
