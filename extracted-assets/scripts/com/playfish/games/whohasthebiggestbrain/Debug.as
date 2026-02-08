package com.playfish.games.whohasthebiggestbrain
{
   public class Debug
   {
      
      public static var minigameScoreHistory:Array;
      
      public static const DEBUG:Boolean = FlashVars.debug;
      
      public static const TEST_FEED_FORM:Boolean = false;
      
      public static const SHORTTIME:Boolean = false;
      
      public static const CHEAT:Boolean = false;
      
      public static const NETWORK_ONLY:Boolean = false;
      
      public static const OVERRIDE_FLASH_VARS:Boolean = DEBUG;
      
      public static const NETWORK_TEST_FLASH_VARS:String = FlashVars.value;
      
      public static const FORCE_PRO:Boolean = DEBUG ? false : false;
      
      public static const FORCE_STANDARD:Boolean = DEBUG ? true : false;
      
      public static const DISPLAY_ALL_TROPHIES:Boolean = false;
      
      public static const FEEDFORM_ALWAYS_SHOW:Boolean = false;
      
      public static const FEEDFORM_AUTO_LAUNCH:Boolean = false;
       
      
      public function Debug()
      {
         super();
      }
      
      public static function init() : *
      {
         var _loc1_:* = undefined;
         if(DEBUG)
         {
            minigameScoreHistory = new Array();
            _loc1_ = 0;
            while(_loc1_ < MinigameDefines.MINIGAMES.length)
            {
               minigameScoreHistory.push(new Array());
               _loc1_++;
            }
         }
      }
   }
}
