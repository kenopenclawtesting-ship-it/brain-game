package com.playfish.games.whohasthebiggestbrain.minigames
{
   import com.playfish.games.whohasthebiggestbrain.AnimatedSprite;
   import com.playfish.games.whohasthebiggestbrain.GameObject;
   import com.playfish.games.whohasthebiggestbrain.GameObjectLayer;
   import com.playfish.games.whohasthebiggestbrain.GameWorld;
   
   public class CubeBlock extends GameObject
   {
       
      
      internal var shadow:GameObject;
      
      public var row:int;
      
      public var colume:int;
      
      public var state:int;
      
      internal const STATE_DISAPPEAR:int = 1;
      
      public var blockHeight:int;
      
      internal const STATE_NORMAL:int = 0;
      
      public function CubeBlock(param1:GameObjectLayer, param2:int)
      {
         super(param1,new AnimatedSprite("Block" + param2),TYPE_NONE,1);
      }
      
      public function createShadow() : *
      {
         shadow = new GameObject(gameObjectLayer,new AnimatedSprite("CubeShadow"),GameObject.TYPE_NONE,0);
         shadow.x = x;
         shadow.y = tweenDestY + getHeight() / 4;
         shadow.scaleX = 0;
         shadow.scaleY = 0;
         shadow.alpha = 0;
         gameObjectLayer.addGameObject(shadow);
      }
      
      public function disappear() : *
      {
         state = STATE_DISAPPEAR;
      }
      
      override public function tick(param1:uint) : *
      {
         super.tick(param1);
         if(state == STATE_NORMAL)
         {
            if(shadow != null)
            {
               if(tweenType == TWEEN_NONE)
               {
                  gameObjectLayer.removeGameObject(shadow);
                  shadow = null;
               }
               else
               {
                  shadow.alpha = (GameWorld.CANVAS_HEIGHT - (tweenDestY - y)) / GameWorld.CANVAS_HEIGHT;
                  shadow.scaleX = shadow.alpha;
                  shadow.scaleY = shadow.scaleX;
               }
            }
         }
         else if(state == STATE_DISAPPEAR)
         {
            if(alpha > 0)
            {
               alpha = Math.max(alpha - 0.15,0);
               scaleX = alpha;
               scaleY = scaleX;
            }
         }
      }
   }
}
