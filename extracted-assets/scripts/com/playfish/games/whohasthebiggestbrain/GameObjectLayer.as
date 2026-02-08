package com.playfish.games.whohasthebiggestbrain
{
   import flash.display.*;
   
   public class GameObjectLayer extends Sprite
   {
       
      
      internal var objectsToAdd:Array;
      
      internal var objectsToRemove:Array;
      
      internal var gameObjects:Array;
      
      public function GameObjectLayer()
      {
         super();
         reset();
      }
      
      public function addGameObject(param1:GameObject) : *
      {
         objectsToAdd.push(param1);
      }
      
      public function removeGameObject(param1:GameObject) : *
      {
         objectsToRemove.push(param1);
      }
      
      public function updateSpritePosition(param1:Number, param2:Number) : *
      {
         x = -param1;
         y = -param2;
      }
      
      public function tick(param1:uint) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < gameObjects.length)
         {
            GameObject(gameObjects[_loc2_]).tick(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < objectsToRemove.length)
         {
            gameObjects.splice(gameObjects.indexOf(objectsToRemove[_loc2_]),1);
            removeChild(objectsToRemove[_loc2_]);
            _loc2_++;
         }
         objectsToRemove.splice(0,objectsToRemove.length);
         _loc2_ = 0;
         while(_loc2_ < objectsToAdd.length)
         {
            gameObjects.push(objectsToAdd[_loc2_]);
            _loc3_ = 0;
            while(_loc3_ < numChildren)
            {
               if(objectsToAdd[_loc2_].mainSprite.drawPriority < GameObject(getChildAt(_loc3_)).mainSprite.drawPriority)
               {
                  addChildAt(objectsToAdd[_loc2_],_loc2_);
                  break;
               }
               _loc3_++;
            }
            if(_loc3_ == numChildren)
            {
               addChild(objectsToAdd[_loc2_]);
            }
            _loc2_++;
         }
         objectsToAdd.splice(0,objectsToAdd.length);
      }
      
      public function reset() : *
      {
         var _loc1_:* = numChildren - 1;
         while(_loc1_ >= 0)
         {
            removeChildAt(_loc1_);
            _loc1_--;
         }
         gameObjects = new Array();
         objectsToRemove = new Array();
         objectsToAdd = new Array();
      }
   }
}
