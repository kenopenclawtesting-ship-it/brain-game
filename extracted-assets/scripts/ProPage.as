package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1409")]
   public dynamic class ProPage extends MovieClip
   {
       
      
      public var button2:MovieClip;
      
      public var button3:MovieClip;
      
      public var button5:pro_button6;
      
      public var button4:MovieClip;
      
      public var mainTextField:TextField;
      
      public var mainTextField2:TextField;
      
      public var screenshot:MovieClip;
      
      public var logo:MovieClip;
      
      public var goProButton:ButtonOk;
      
      public var backButton:ButtonBack;
      
      public var button0:MovieClip;
      
      public var button1:MovieClip;
      
      public function ProPage()
      {
         super();
         addFrameScript(239,frame240);
      }
      
      internal function frame240() : *
      {
         gotoAndPlay("idle");
      }
   }
}
