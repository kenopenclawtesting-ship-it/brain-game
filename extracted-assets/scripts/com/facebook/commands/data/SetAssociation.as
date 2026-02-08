package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   import com.facebook.utils.ValidationUtils;
   
   use namespace facebook_internal;
   
   public class SetAssociation extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name","obj_id1","obj_id2","data","assoc_time"];
      
      public static const METHOD_NAME:String = "data.setAssociation";
       
      
      public var obj_id1:String;
      
      public var assoc_time:Date;
      
      public var data:String;
      
      public var name:String;
      
      public var obj_id2:String;
      
      public function SetAssociation(param1:String, param2:String, param3:String, param4:String = null, param5:Date = null)
      {
         super(method,args);
         if(ValidationUtils.validateLength(param4) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param4}));
         }
         this.name = param1;
         this.obj_id1 = param2;
         this.obj_id2 = param3;
         this.assoc_time = param5;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name,this.obj_id1,this.obj_id2,this.data,FacebookDataUtils.toDateString(this.assoc_time));
         super.facebook_internal::initialize();
      }
   }
}
