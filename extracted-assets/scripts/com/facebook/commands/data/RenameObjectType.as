package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   import com.facebook.utils.ValidationUtils;
   
   use namespace facebook_internal;
   
   public class RenameObjectType extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type","new_name"];
      
      public static const METHOD_NAME:String = "data.renameObjectType";
       
      
      public var new_name:String;
      
      public var obj_type:String;
      
      public function RenameObjectType(param1:String, param2:String)
      {
         super(METHOD_NAME);
         if(ValidationUtils.isDataObjectTypeValid(param1) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param1}));
         }
         if(ValidationUtils.isDataObjectTypeValid(param2) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param2}));
         }
         this.obj_type = param1;
         this.new_name = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type,this.new_name);
         super.facebook_internal::initialize();
      }
   }
}
