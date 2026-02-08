package com.playfish.games.whohasthebiggestbrain.utils
{
   import flash.net.*;
   import flash.utils.*;
   
   public class Preferences
   {
      
      public static const QUALITY:int = 1;
      
      public static var values:* = new Array(true,true,"en",null);
      
      public static const PROGAME_SELECTION:int = 3;
      
      private static const PREFERENCE_NAME:* = new Array("sound","quality","lang","progameselection");
      
      public static const SOUND:int = 0;
      
      public static const LANGUAGE:int = 2;
       
      
      public function Preferences()
      {
         super();
      }
      
      public static function load() : *
      {
         var sharedObject:SharedObject = null;
         var i:* = undefined;
         var value:* = undefined;
         try
         {
            sharedObject = SharedObject.getLocal("brainPreferences");
            i = 0;
            while(i < PREFERENCE_NAME.length)
            {
               value = sharedObject.data[PREFERENCE_NAME[i]];
               if(value != null)
               {
                  values[i] = value;
               }
               i++;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function save(param1:int = -1) : *
      {
         var sharedObject:SharedObject = null;
         var i:* = undefined;
         var index:int = param1;
         try
         {
            sharedObject = SharedObject.getLocal("brainPreferences");
            if(index == -1)
            {
               i = 0;
               while(i < PREFERENCE_NAME.length)
               {
                  sharedObject.setProperty(PREFERENCE_NAME[i],values[i]);
                  i++;
               }
            }
            else
            {
               sharedObject.setProperty(PREFERENCE_NAME[index],values[index]);
            }
         }
         catch(e:Error)
         {
         }
      }
   }
}
