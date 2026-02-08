package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1259")]
   public dynamic class Chart extends MovieClip
   {
       
      
      public var content:ChartMovieClip;
      
      public function Chart()
      {
         super();
         addFrameScript(9,frame10,19,frame20,29,frame30);
      }
      
      internal function frame30() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame20() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame10() : *
      {
         stop();
      }
   }
}
