package com.facebook.data.admin
{
   public class GetMetricsValues
   {
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_413:String = "canvas_page_views_http_code_413";
      
      public static const UNIQUE_UNBLOCKS:String = "unique_unblocks";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_0:String = "canvas_page_views_http_code_0";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_100:String = "canvas_page_views_http_code_100";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_422:String = "canvas_page_views_http_code_422";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_500:String = "canvas_page_views_http_code_500";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_303:String = "canvas_page_views_http_code_303";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_503:String = "canvas_page_views_http_code_503";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_505:String = "canvas_page_views_http_code_505";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_301:String = "canvas_page_views_http_code_301";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_302:String = "canvas_page_views_http_code_302";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_502:String = "canvas_page_views_http_code_502";
      
      public static const API_CALLS:String = "api_calls";
      
      public static const UNIQUE_BLOCKS:String = "unique_blocks";
      
      public static const CANVAS_HTTP_REQUEST_TIME_AVG:String = "canvas_http_request_time_avg";
      
      public static const UNIQUE_API_CALLS:String = "unique_api_calls";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_200ND:String = "canvas_page_views_http_code_200ND";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_200:String = "canvas_page_views_http_code_200";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_400:String = "canvas_page_views_http_code_400";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_401:String = "canvas_page_views_http_code_401";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_403:String = "canvas_page_views_http_code_403";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_404:String = "canvas_page_views_http_code_404";
      
      public static const CANVAS_PAGE_VIEWS_HTTP_CODE_405:String = "canvas_page_views_http_code_405";
      
      public static const CANVAS_PAGE_VIEWS:String = "canvas_page_views";
      
      public static const ALL_HTTP_METRICS:Array = [CANVAS_PAGE_VIEWS_HTTP_CODE_0,CANVAS_PAGE_VIEWS_HTTP_CODE_100,CANVAS_PAGE_VIEWS_HTTP_CODE_200,CANVAS_PAGE_VIEWS_HTTP_CODE_200ND,CANVAS_PAGE_VIEWS_HTTP_CODE_301,CANVAS_PAGE_VIEWS_HTTP_CODE_302,CANVAS_PAGE_VIEWS_HTTP_CODE_303,CANVAS_PAGE_VIEWS_HTTP_CODE_400,CANVAS_PAGE_VIEWS_HTTP_CODE_401,CANVAS_PAGE_VIEWS_HTTP_CODE_403,CANVAS_PAGE_VIEWS_HTTP_CODE_404,CANVAS_PAGE_VIEWS_HTTP_CODE_405,CANVAS_PAGE_VIEWS_HTTP_CODE_413,CANVAS_PAGE_VIEWS_HTTP_CODE_422,CANVAS_PAGE_VIEWS_HTTP_CODE_500,CANVAS_PAGE_VIEWS_HTTP_CODE_502,CANVAS_PAGE_VIEWS_HTTP_CODE_503,CANVAS_PAGE_VIEWS_HTTP_CODE_505];
      
      public static const CANVAS_FBML_RENDER_TIME_AVG:String = "canvas_fbml_render_time_avg";
      
      public static const ACTIVE_USERS:String = "active_users";
      
      public static const UNIQUE_CANVAS_PAGE_VIEWS:String = "unique_canvas_page_views";
      
      public static const ALL_USEAGE_VALUES:Array = [ACTIVE_USERS,API_CALLS,UNIQUE_API_CALLS,CANVAS_PAGE_VIEWS,UNIQUE_CANVAS_PAGE_VIEWS,CANVAS_HTTP_REQUEST_TIME_AVG,CANVAS_FBML_RENDER_TIME_AVG,UNIQUE_BLOCKS,UNIQUE_UNBLOCKS];
      
      public static const ALL_VALUES:Array = ALL_USEAGE_VALUES.slice().concat(ALL_HTTP_METRICS.slice());
       
      
      public function GetMetricsValues()
      {
         super();
      }
   }
}
