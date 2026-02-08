package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   import com.facebook.utils.ValidationUtils;
   
   use namespace facebook_internal;
   
   public class DefineObjectProperty extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type","prop_name","prop_type"];
      
      public static const METHOD_NAME:String = "data.defineObjectProperty";
       
      
      public var obj_type:String;
      
      public var prop_type:uint;
      
      public var prop_name:String;
      
      public function DefineObjectProperty(param1:String, param2:String, param3:uint)
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
         this.prop_name = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type,this.prop_name,this.prop_type);
         super.facebook_internal::initialize();
      }
   }
}
