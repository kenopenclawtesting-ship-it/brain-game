package com.facebook.data.events
{
   import com.facebook.data.FacebookLocation;
   import com.facebook.data.users.FacebookUser;
   import com.facebook.data.users.FacebookUserCollection;
   
   public class FacebookEventData
   {
       
      
      public var eid:String;
      
      public var update_time:Date;
      
      public var attending:FacebookUserCollection;
      
      public var nid:Number;
      
      public var pic:String;
      
      public var name:String;
      
      public var not_replied:FacebookUserCollection;
      
      public var tagline:String;
      
      public var start_time:Date;
      
      public var end_time:Date;
      
      public var event_subtype:String;
      
      public var pic_small:String;
      
      public var pic_big:String;
      
      public var host:String;
      
      public var creator:FacebookUser;
      
      public var unsure:FacebookUserCollection;
      
      public var venue:FacebookLocation;
      
      public var location:String;
      
      public var description:String;
      
      public var declined:FacebookUserCollection;
      
      public var event_type:String;
      
      public function FacebookEventData(param1:String)
      {
         super();
         this.eid = param1;
      }
   }
}
