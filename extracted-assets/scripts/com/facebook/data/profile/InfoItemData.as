package com.facebook.data.profile
{
   import com.facebook.facebook_internal;
   
   use namespace facebook_internal;
   
   public class InfoItemData
   {
       
      
      facebook_internal var schema:Array;
      
      public var sublabel:String;
      
      public var label:String;
      
      public var link:String;
      
      public var image:String;
      
      public var description:String;
      
      public function InfoItemData()
      {
         super();
         facebook_internal::schema = ["label","link","image","description","sublabel"];
      }
   }
}
