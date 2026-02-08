package
{
   import com.doubleclick.dartshell.errors.events.DartShellErrorEvent;
   import com.doubleclick.dartshell.events.DartShellLoadedEvent;
   import flash.display.Loader;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   
   public class DartShellSWFLoader extends EventDispatcher
   {
       
      
      private var loader:Loader;
      
      private var dartShellUrl:String;
      
      public function DartShellSWFLoader(param1:String = null)
      {
         super();
         this.dartShellUrl = param1 == null ? "http://ad.doubleclick.net/879366/DartShell9_" + Distribution.VERSION + ".swf" : param1;
         Security.allowDomain(extractDomainFromUrl(param1));
         loader = new Loader();
      }
      
      private function extractDomainFromUrl(param1:String) : String
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = getProtocol(param1).length;
         _loc3_ = Number(param1.indexOf("/",_loc2_));
         return _loc3_ != -1 ? param1.substring(0,_loc3_) : param1;
      }
      
      public function load() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:LoaderContext = null;
         getLoader().addEventListener(DartShellLoadedEvent.TYPE,onDartShellLoaded);
         getLoader().addEventListener(DartShellErrorEvent.TYPE,onDartShellError);
         _loc1_ = new URLRequest(dartShellUrl);
         if(Security.sandboxType == Security.REMOTE)
         {
            _loc2_ = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
            getLoader().load(_loc1_,_loc2_);
         }
         else
         {
            getLoader().load(_loc1_);
         }
      }
      
      public function getLoader() : Loader
      {
         return loader;
      }
      
      private function getProtocol(param1:String) : String
      {
         return param1.substring(0,param1.indexOf("//") + 2);
      }
      
      private function onDartShellError(param1:DartShellErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onDartShellLoaded(param1:DartShellLoadedEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}
