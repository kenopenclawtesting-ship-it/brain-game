package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.coretech.engine.ui.PFPopUp;
   import flash.display.MovieClip;
   
   public class EmailRequestPopup extends PFPopUp
   {
       
      
      public function EmailRequestPopup()
      {
         var _loc2_:MovieClip = null;
         var _loc1_:MovieClip = new EmailRequestPopupAnim();
         _loc2_ = _loc1_.content;
         super(_loc1_,_loc2_.okButton,_loc2_.noButton,true);
         this.x = GameWorld.CANVAS_CENTER_X;
         this.y = GameWorld.CANVAS_CENTER_Y;
         MovieClip(_loc2_.icon).gotoAndPlay("intro");
         notifyLanguageUpdate();
      }
      
      override public function notifyLanguageUpdate() : void
      {
         var _loc4_:String = null;
         var _loc1_:MovieClip = popUpContent.content;
         Engine.setFontForLang(_loc1_.title_,"Baveuse");
         Engine.setFontForLang(_loc1_.headerText,"Arnold 2.1");
         Engine.setFontForLang(_loc1_.footerText,"Arnold 2.1");
         Engine.setFontForLang(_loc1_.noButton.text,"Arnold 2.1");
         _loc1_.title_.text = Engine.getText("EmailRequestTitle");
         _loc1_.headerText.text = Engine.getText("EmailRequestBody");
         _loc1_.footerText.text = Engine.getText("EmailRequestFooter");
         var _loc2_:MovieClip = _loc1_.noButton;
         var _loc3_:String = _loc2_.currentLabel;
         for each(_loc4_ in _loc2_.currentLabels)
         {
            _loc2_.gotoAndStop(_loc4_);
            _loc2_.text.text = Engine.getText("LaterButton");
         }
         _loc2_.gotoAndStop(_loc3_);
      }
   }
}
