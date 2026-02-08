package com.facebook.data.events
{
   public class EditEventData
   {
       
      
      public var description:String;
      
      public var subcategory:String;
      
      public var start_time:Date;
      
      public var tagline:String;
      
      public var privacy_type:String;
      
      public var street:String;
      
      public var host_id:Number;
      
      public var schema:Array;
      
      public var email:String;
      
      public var host:String;
      
      public var city:String;
      
      public var phone:String;
      
      public var end_time:Date;
      
      public var location:String;
      
      public var category:String;
      
      public function EditEventData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Date, param7:Date, param8:String = null, param9:String = null, param10:String = null, param11:Number = NaN, param12:String = null, param13:String = null, param14:String = null)
      {
         super();
         this.schema = ["city","category","subcategory","host","location","start_time","end_time","street","phone","email","host_id","description","privacy_type","tagline"];
         this.city = param1;
         this.category = param2;
         this.subcategory = param3;
         this.host = param4;
         this.location = param5;
         this.start_time = param6;
         this.end_time = param7;
         this.street = param8;
         this.phone = param9;
         this.email = param10;
         this.host_id = param11;
         this.description = param12;
         this.privacy_type = param13;
         this.tagline = param14;
      }
   }
}
