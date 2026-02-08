package com.facebook.commands.data
{
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.data.data.AssocInfoData;
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   import com.facebook.utils.ValidationUtils;
   
   use namespace facebook_internal;
   
   public class DefineAssociation extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name","assoc_type","assoc_info1","assoc_info2","inverse"];
      
      public static const METHOD_NAME:String = "data.defineAssociation";
       
      
      protected var inverse:String;
      
      protected var assoc_type:Number;
      
      protected var assoc_info1:AssocInfoData;
      
      protected var assoc_info2:AssocInfoData;
      
      protected var name:String;
      
      public function DefineAssociation(param1:String, param2:Number, param3:AssocInfoData, param4:AssocInfoData, param5:String)
      {
         super(METHOD_NAME);
         if(ValidationUtils.isDataObjectTypeValid(param1) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param1}));
         }
         if(ValidationUtils.isDataObjectTypeValid(param5) == false)
         {
            throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR,{"propName":param5}));
         }
         this.name = param1;
         this.assoc_type = param2;
         this.assoc_info1 = param3;
         this.assoc_info2 = param4;
         this.inverse = param5;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name,this.assoc_type,this.assoc_info1,this.assoc_info2,this.inverse);
         super.facebook_internal::initialize();
      }
   }
}
