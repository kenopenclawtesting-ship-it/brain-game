package com.facebook.data.events
{
   import com.facebook.facebook_internal;
   
   use namespace facebook_internal;
   
   public class CreateEventData
   {
       
      
      public var street:String;
      
      public var category:String;
      
      public var start_time:Date;
      
      public var name:String;
      
      public var tagline:String;
      
      public var privacy_type:String;
      
      public var page_id:Number;
      
      public var email:String;
      
      facebook_internal var schema:Array;
      
      public var host:String;
      
      public var description:String;
      
      public var city:String;
      
      public var phone:String;
      
      public var end_time:Date;
      
      public var location:String;
      
      public var subcategory:String;
      
      public function CreateEventData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Date, param8:Date, param9:String = null, param10:String = null, param11:String = null, param12:Number = NaN, param13:String = null, param14:String = null, param15:String = null)
      {
         super();
         this.facebook_internal::schema = ["name","category","subcategory","host","location","city","start_time","end_time","street","phone","email","page_id","description","privacy_type","tagline"];
         this.name = param1;
         this.category = param2;
         this.subcategory = param3;
         this.host = param4;
         this.location = param5;
         this.city = param6;
         this.start_time = param7;
         this.end_time = param8;
         this.street = param9;
         this.phone = param10;
         this.email = param11;
         this.page_id = param12;
         this.description = param13;
         this.privacy_type = param14;
         this.tagline = param15;
      }
   }
}
