package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   import com.facebook.utils.ValidationUtils;
   
   use namespace facebook_internal;
   
   public class CreateObjectType extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name"];
      
      public static const METHOD_NAME:String = "data.createObjectType";
       
      
      public var name:String;
      
      public function CreateObjectType(param1:String)
      {
         super(METHOD_NAME);
         if(ValidationUtils.isDataObjectTypeValid(param1) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param1}));
         }
         this.name = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name);
         super.facebook_internal::initialize();
      }
   }
}
