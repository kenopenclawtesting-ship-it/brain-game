package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1468")]
   public dynamic class ChallengeModeSelect extends MovieClip
   {
       
      
      public var randomMode:MovieClip;
      
      public var backButton:ButtonBack;
      
      public var selectMode:MovieClip;
      
      public function ChallengeModeSelect()
      {
         super();
         addFrameScript(13,frame14,22,frame23);
      }
      
      internal function frame14() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame23() : *
      {
         gotoAndStop(1);
      }
   }
}
