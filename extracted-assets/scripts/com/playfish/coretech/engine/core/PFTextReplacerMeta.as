package com.playfish.coretech.engine.core
{
   public class PFTextReplacerMeta extends PFTextReplacer
   {
       
      
      private var token:String;
      
      private var replacement:String;
      
      public function PFTextReplacerMeta(param1:String, param2:String)
      {
         super();
         this.token = "%" + param1 + "%";
         this.replacement = param2;
      }
      
      override public function replaceText(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         return param1.replace(token,replacement);
      }
      
      override public function getReplaceToken() : Object
      {
         return token;
      }
      
      override public function replaceReplacement(param1:PFTextReplacer) : void
      {
         if(param1 is PFTextReplacerMeta)
         {
            replacement = (param1 as PFTextReplacerMeta).replacement;
         }
      }
   }
}
