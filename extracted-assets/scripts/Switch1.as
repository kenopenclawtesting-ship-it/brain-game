package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1301")]
   public dynamic class Switch1 extends MovieClip
   {
       
      
      public function Switch1()
      {
         super();
         addFrameScript(12,frame13,24,frame25);
      }
      
      internal function frame25() : *
      {
         gotoAndStop("off");
      }
      
      internal function frame13() : *
      {
         gotoAndPlay("off");
      }
   }
}
