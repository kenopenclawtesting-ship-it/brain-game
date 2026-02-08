package
{
   import flash.events.IEventDispatcher;
   
   public interface DartShell extends IEventDispatcher
   {
       
      
      function loadAd(param1:String, param2:String, param3:String, param4:Array, param5:String, param6:String, param7:String, param8:String = null) : void;
      
      function loadAdByURL(param1:String, param2:String = null) : void;
      
      function getDartShellVersion() : String;
   }
}
