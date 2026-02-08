package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1360")]
   public dynamic class ProPage2 extends MovieClip
   {
       
      
      public var cover1:MovieClip;
      
      public var termTickBox:ProTickMark;
      
      public var mainTextField:TextField;
      
      public var termLink:MovieClip;
      
      public var logo:MovieClip;
      
      public var termDesc:TextField;
      
      public var backButton:ButtonBack;
      
      public var cover2:MovieClip;
      
      public var cover3:MovieClip;
      
      public var group:MovieClip;
      
      public function ProPage2()
      {
         super();
         addFrameScript(6,frame7);
      }
      
      internal function frame7() : *
      {
         stop();
      }
   }
}
