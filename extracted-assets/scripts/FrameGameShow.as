package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol395")]
   public dynamic class FrameGameShow extends MovieClip
   {
       
      
      public var achievementButton:ButtonAchivements;
      
      public var bg:BgBrain;
      
      public var speechTextField:SpeechTextBox1;
      
      public var tutorialSpeechTextField:SpeechTextBox2;
      
      public var qualityButton:MovieClip;
      
      public var playButton:MovieClip;
      
      public var inviteButton:MovieClip;
      
      public var soundButton:MovieClip;
      
      public var languageButton:MovieClip;
      
      public var logo:MovieClip;
      
      public var challengeRequest:MovieClip;
      
      public var professor:MovieClip;
      
      public var challengeButton:MovieClip;
      
      public var iphoneButton:MovieClip;
      
      public var content:MovieClip;
      
      public var profileButton:MovieClip;
      
      public var goProButton:MovieClip;
      
      public function FrameGameShow()
      {
         super();
         addFrameScript(100,frame101,151,frame152,185,frame186,206,frame207,242,frame243);
      }
      
      internal function frame152() : *
      {
         gotoAndPlay("zoomin1_idle");
      }
      
      internal function frame243() : *
      {
         stop();
      }
      
      internal function frame101() : *
      {
         gotoAndPlay("menu_idle");
      }
      
      internal function frame186() : *
      {
         gotoAndPlay("zoomout1_idle");
      }
      
      internal function frame207() : *
      {
         gotoAndPlay("menu_start");
      }
   }
}
