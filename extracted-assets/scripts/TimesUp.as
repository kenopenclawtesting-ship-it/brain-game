package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol756")]
   public dynamic class TimesUp extends MovieClip
   {
       
      
      public var timesUpText:MovieClip;
      
      public function TimesUp()
      {
         super();
         addFrameScript(74,frame75);
      }
      
      internal function frame75() : *
      {
         stop();
      }
   }
}
