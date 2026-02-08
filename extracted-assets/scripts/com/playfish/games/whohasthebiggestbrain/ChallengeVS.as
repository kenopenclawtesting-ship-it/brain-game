package com.playfish.games.whohasthebiggestbrain
{
   import com.playfish.rpc.brain.*;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class ChallengeVS extends BaseWorld
   {
       
      
      private var _bgMC:MovieClip;
      
      private var _parentMC:MovieClip;
      
      public function ChallengeVS(param1:MovieClip = null)
      {
         super();
         _parentMC = param1;
         _bgMC = new VsPage();
         _bgMC.x = GameWorld.CANVAS_CENTER_X;
         _bgMC.y = GameWorld.CANVAS_CENTER_Y;
         addChild(_bgMC);
         initInfo();
         initButton();
      }
      
      private function okListener(param1:Event) : void
      {
         GameWorld.addGameShowFrame("zoomin1_idle");
         GameWorld.startChallenge(ChallengeWorld.miniGameID,ChallengeWorld.challengeMode);
      }
      
      public function initButton() : void
      {
         var _loc1_:uint = 0;
         setButtonMode(_bgMC.okButton,true);
         _bgMC.okButton.visible = false;
         _bgMC.okButton.addEventListener(MouseEvent.MOUSE_DOWN,okListener,false,0,true);
         setButtonMode(_bgMC.cancelButton,true);
         _bgMC.cancelButton.addEventListener(MouseEvent.MOUSE_DOWN,cancelListener,false,0,true);
         _bgMC.cancelButton.visible = false;
         if(ChallengeWorld.challengeMode == ChallengeWorld.CHALLENGE_MODE_SELECT && ChallengeWorld._selectGameType == ChallengeWorld.SELECT_GAME_SINGLE)
         {
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               if(_loc1_ != ChallengeWorld.minigameCategory)
               {
                  _bgMC.gameType["type" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      override public function tick(param1:uint) : *
      {
         if(_bgMC != null && !_bgMC.okButton.visible)
         {
            if(_bgMC.currentLabel == "idle")
            {
               _bgMC.okButton.visible = true;
            }
         }
         if(_bgMC != null && !_bgMC.cancelButton.visible)
         {
            if(_bgMC.currentLabel == "idle")
            {
               _bgMC.cancelButton.visible = true;
            }
         }
      }
      
      private function cancelListener(param1:Event) : void
      {
         if(GameWorld.isBeChallenged)
         {
            Engine.playSound("ButtonMenu",1);
            GameWorld.removeGameShowFrame();
            GameWorld.startMainMenu();
            GameWorld.isBeChallenged = false;
         }
         else
         {
            this.parent.removeChild(this);
            _bgMC = null;
            if(_parentMC != null)
            {
               _parentMC.BigNameCard.picBG.addChild(ChallengeWorld.challengerFace);
            }
         }
      }
      
      public function initInfo() : void
      {
         if(ChallengeWorld.playerFace != null)
         {
            _bgMC.card0.picBG.addChild(ChallengeWorld.playerFace);
         }
         _bgMC.card0.T_name.text = GameWorld.currentUserInfo.firstName;
         if(ChallengeWorld.challengerFace != null)
         {
            _bgMC.card1.picBG.addChild(ChallengeWorld.challengerFace);
         }
         _bgMC.card1.T_name.text = ChallengeWorld.challengePlayer.firstName;
      }
   }
}
