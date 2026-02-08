package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.ValidationUtils;
   
   use namespace facebook_internal;
   
   public class DropObjectType extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["obj_type"];
      
      public static const METHOD_NAME:String = "data.dropObjectType";
       
      
      public var obj_type:String;
      
      public function DropObjectType(param1:String)
      {
         super(METHOD_NAME);
         if(param1.length > 32 || ValidationUtils.isDataObjectTypeValid(param1) == false)
         {
            throw new RangeError(InternalErrorMessages.DATA_INVALID_NAME_ERROR);
         }
         this.obj_type = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.obj_type);
         super.facebook_internal::initialize();
      }
   }
}
