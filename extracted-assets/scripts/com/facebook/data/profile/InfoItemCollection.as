package com.facebook.data.profile
{
   import com.facebook.utils.FacebookArrayCollection;
   
   public class InfoItemCollection extends FacebookArrayCollection
   {
       
      
      public function InfoItemCollection(param1:Array = null)
      {
         super(null,InfoItemData);
      }
      
      public function addInfoItem(param1:InfoItemData) : void
      {
         this.addItem(param1);
      }
   }
}
