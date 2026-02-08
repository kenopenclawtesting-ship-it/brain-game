package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   import com.facebook.utils.ValidationUtils;
   
   use namespace facebook_internal;
   
   public class RenameAssociation extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name","new_name","new_alias1","new_alias2"];
      
      public static const METHOD_NAME:String = "data.renameAssociation";
       
      
      public var new_alias1:String;
      
      public var new_alias2:String;
      
      public var new_name:String;
      
      public var name:String;
      
      public function RenameAssociation(param1:String, param2:String = "", param3:String = "", param4:String = "")
      {
         super(METHOD_NAME);
         if(ValidationUtils.isDataObjectTypeValid(param2) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param2}));
         }
         if(ValidationUtils.isDataObjectTypeValid(param3) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param3}));
         }
         if(ValidationUtils.isDataObjectTypeValid(param4) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param4}));
         }
         this.name = param1;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name,this.new_name,this.new_alias1,this.new_alias2);
         super.facebook_internal::initialize();
      }
   }
}
