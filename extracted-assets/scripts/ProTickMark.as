package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1344")]
   public dynamic class ProTickMark extends MovieClip
   {
       
      
      public function ProTickMark()
      {
         super();
         addFrameScript(9,frame10,28,frame29);
      }
      
      internal function frame29() : *
      {
         gotoAndPlay("unticked");
      }
      
      internal function frame10() : *
      {
         stop();
      }
   }
}
