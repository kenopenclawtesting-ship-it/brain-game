package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1431")]
   public dynamic class AchievementUnlockedPopupAnim extends MovieClip
   {
       
      
      public var content:AchievementUnlockedPopup;
      
      public function AchievementUnlockedPopupAnim()
      {
         super();
         addFrameScript(11,frame12);
      }
      
      internal function frame12() : *
      {
         stop();
      }
   }
}
