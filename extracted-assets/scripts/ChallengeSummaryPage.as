package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1560")]
   public dynamic class ChallengeSummaryPage extends MovieClip
   {
       
      
      public var card0:MovieClip;
      
      public var card1:MovieClip;
      
      public var ok2Button:ButtonOk;
      
      public var pointBar0:MovieClip;
      
      public var pointBar1:MovieClip;
      
      public var okButton:ButtonContinue;
      
      public var feedButton:FeedButton;
      
      public var score0:MovieClip;
      
      public var score1:MovieClip;
      
      public function ChallengeSummaryPage()
      {
         super();
         addFrameScript(32,frame33,68,frame69,117,frame118,162,frame163);
      }
      
      internal function frame69() : *
      {
         stop();
      }
      
      internal function frame33() : *
      {
         gotoAndPlay("idle");
      }
      
      internal function frame118() : *
      {
         stop();
      }
      
      internal function frame163() : *
      {
         stop();
      }
   }
}
