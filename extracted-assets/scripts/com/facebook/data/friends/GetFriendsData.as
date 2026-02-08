package com.facebook.data.friends
{
   import com.facebook.data.FacebookData;
   import com.facebook.data.users.FacebookUserCollection;
   
   public class GetFriendsData extends FacebookData
   {
       
      
      public var friends:FacebookUserCollection;
      
      public function GetFriendsData()
      {
         super();
      }
   }
}
