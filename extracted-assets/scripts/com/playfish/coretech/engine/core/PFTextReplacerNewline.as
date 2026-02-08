package com.playfish.coretech.engine.core
{
   public class PFTextReplacerNewline extends PFTextReplacer
   {
       
      
      public function PFTextReplacerNewline()
      {
         super();
      }
      
      override public function replaceText(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         return param1.replace(/\\n/g,"\n");
      }
   }
}
