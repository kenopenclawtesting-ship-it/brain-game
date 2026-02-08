package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1459")]
   public dynamic class ChallengeGameSelect extends MovieClip
   {
       
      
      public var fullButton:MovieClip;
      
      public var okButton:ButtonOk;
      
      public var gamePanel:MovieClip;
      
      public var backButton:ButtonBack;
      
      public var singleButton:MovieClip;
      
      public function ChallengeGameSelect()
      {
         super();
         addFrameScript(16,frame17,31,frame32);
      }
      
      internal function frame32() : *
      {
         stop();
      }
      
      internal function frame17() : *
      {
         gotoAndPlay("Idle");
      }
   }
}
