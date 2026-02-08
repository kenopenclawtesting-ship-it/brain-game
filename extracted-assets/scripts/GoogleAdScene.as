package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol97")]
   public dynamic class GoogleAdScene extends MovieClip
   {
       
      
      public var adFrame:MovieClip;
      
      public var speechTextField:SpeechTextBox2;
      
      public var tutorialSpeechTextField:SpeechTextBox2;
      
      public var okButton:ButtonOk;
      
      public var professor:MovieClip;
      
      public var content:MovieClip;
      
      public function GoogleAdScene()
      {
         super();
         addFrameScript(18,frame19);
      }
      
      internal function frame19() : *
      {
         stop();
      }
   }
}
