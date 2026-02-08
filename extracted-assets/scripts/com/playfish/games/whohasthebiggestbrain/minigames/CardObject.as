package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.whohasthebiggestbrain.*;
   import flash.display.Sprite;
   
   public class CardObject extends GameObject
   {
      
      internal static const CARD_STATE_REVEALING:* = 0;
      
      internal static const CARD_STATE_REVEALED:* = 1;
      
      internal static const CARD_STATE_UNREVEALING:* = 2;
      
      internal static const CARD_STATE_UNREVEALED:* = 3;
       
      
      internal var cardState:uint;
      
      internal var cardType:uint;
      
      internal var cardFace:Sprite;
      
      internal var cardCorrect:Boolean = false;
      
      public function CardObject(param1:GameObjectLayer, param2:int)
      {
         super(param1,new AnimatedSprite("Cardfront"),TYPE_NONE,-1);
         this.cardType = param2;
         this.cardFace = Engine.getMovieClip("Card_" + MatchCard.CARD_TYPE_NAMES[param2]);
         cardState = CARD_STATE_UNREVEALED;
      }
      
      public function disappear() : *
      {
         mainSprite.setAnimation("Carddisappear",1);
         if(cardFace != null)
         {
            mainSprite.mc.card.addChild(cardFace);
         }
         removeWhenComplete = true;
         mainSprite.scaleX = 1;
         cardState == CARD_STATE_REVEALED;
      }
      
      public function unreveal() : *
      {
         cardState = CARD_STATE_UNREVEALING;
      }
      
      public function reveal() : *
      {
         cardState = CARD_STATE_REVEALING;
      }
      
      override public function tick(param1:uint) : *
      {
         super.tick(param1);
         if(cardState == CARD_STATE_REVEALING)
         {
            if(mainSprite.isAnimation("Cardback"))
            {
               mainSprite.scaleX += 0.2;
               if(mainSprite.scaleX >= 1)
               {
                  mainSprite.scaleX = 1;
                  cardState = CARD_STATE_REVEALED;
               }
            }
            else
            {
               mainSprite.scaleX -= 0.2;
               if(mainSprite.scaleX <= 0.2)
               {
                  mainSprite.scaleX = 0.2;
                  mainSprite.setAnimation("Cardback",-1);
                  mainSprite.addChild(cardFace);
               }
            }
         }
         else if(cardState == CARD_STATE_UNREVEALING)
         {
            if(mainSprite.isAnimation("Cardfront"))
            {
               mainSprite.scaleX += 0.2;
               if(mainSprite.scaleX >= 1)
               {
                  mainSprite.scaleX = 1;
                  cardState = CARD_STATE_UNREVEALED;
               }
            }
            else
            {
               mainSprite.scaleX -= 0.2;
               if(mainSprite.scaleX <= 0.2)
               {
                  mainSprite.scaleX = 0.2;
                  mainSprite.removeChild(cardFace);
                  mainSprite.setAnimation("Cardfront",1);
               }
            }
         }
      }
   }
}
