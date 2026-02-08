package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol512")]
   public dynamic class GameScene extends MovieClip
   {
       
      
      public var times:Times;
      
      public var number1:MovieClip;
      
      public var number2:TextField;
      
      public var minus:Minus;
      
      public var divide:Divide;
      
      public var plus:Plus;
      
      public var sign:MovieClip;
      
      public function GameScene()
      {
         super();
      }
   }
}
