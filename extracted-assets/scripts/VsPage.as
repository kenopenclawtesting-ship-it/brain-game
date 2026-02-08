package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1538")]
   public dynamic class VsPage extends MovieClip
   {
       
      
      public var card1:MovieClip;
      
      public var card0:MovieClip;
      
      public var cancelButton:MovieClip;
      
      public var okButton:ButtonOk;
      
      public var gameType:MovieClip;
      
      public function VsPage()
      {
         super();
         addFrameScript(22,frame23);
      }
      
      internal function frame23() : *
      {
         gotoAndPlay("idle");
      }
   }
}
