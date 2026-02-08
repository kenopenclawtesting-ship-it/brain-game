package com.facebook.commands.data
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class RemoveAssociation extends FacebookCall
   {
      
      public static const SCHEMA:Array = ["name","obj_id1","obj_id2"];
      
      public static const METHOD_NAME:String = "data.removeAssociatedObjects";
       
      
      public var obj_id1:Number;
      
      public var name:String;
      
      public var obj_id2:Number;
      
      public function RemoveAssociation()
      {
         super(METHOD_NAME);
         this.name = this.name;
         this.obj_id1 = this.obj_id1;
         this.obj_id2 = this.obj_id2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.name,this.obj_id1,this.obj_id2);
         super.facebook_internal::initialize();
      }
   }
}
