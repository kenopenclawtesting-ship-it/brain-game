package com.playfish.coretech.platform.drivers.socialplatform.facebook
{
   import com.facebook.commands.batch.BatchRun;
   import com.facebook.commands.photos.*;
   import com.facebook.data.StringResultData;
   import com.facebook.data.application.GetPublicInfoData;
   import com.facebook.data.batch.BatchCollection;
   import com.facebook.data.batch.BatchResult;
   import com.facebook.data.photos.*;
   import com.facebook.events.FacebookEvent;
   import com.facebook.net.FacebookCall;
   import com.playfish.coretech.engine.PFEngine;
   import com.playfish.coretech.engine.core.PFCallbackEvent;
   import com.playfish.coretech.engine.core.PFDebug;
   import com.playfish.coretech.platform.natural.facebook.*;
   import com.playfish.coretech.platform.socialplatform.*;
   
   public class SocialPlatformPhotos_Facebook extends SocialPlatformPhotos
   {
       
      
      private var photoUploadCallbackHandler:Function;
      
      private var firstPrepareAttempt:Boolean;
      
      private var photoUploadCallbackPhotoRef:SocialPhoto;
      
      public function SocialPlatformPhotos_Facebook(param1:SocialPlatformPhotosSettings)
      {
         super(param1);
         firstPrepareAttempt = true;
      }
      
      private function onPhotoPostProcess(param1:FacebookEvent) : void
      {
         var _loc2_:Boolean = param1 == null ? true : param1.success;
         dispatchEvent(param1);
         if(photoUploadCallbackHandler != null)
         {
            photoUploadCallbackHandler(new PFCallbackEvent(_loc2_,param1));
         }
      }
      
      override public function prepare(param1:SocialPlatform, param2:SocialPlatformModuleSettings) : Boolean
      {
         super.prepare(param1,param2);
         if(platformBackRef.isPreparing(PREPARATION_MASK) || !param2.enable || isAvailable())
         {
            return true;
         }
         if(triggerRequest())
         {
            platformBackRef.onPrepareBegin(PREPARATION_MASK);
         }
         return true;
      }
      
      private function onUploadPhoto(param1:FacebookEvent) : void
      {
         var ev:SocialEventResult = null;
         var photoData:FacebookPhoto = null;
         var batch:BatchCollection = null;
         var getAlbums:GetAlbums = null;
         var fbTagCollection:PhotoTagCollection = null;
         var xpTag:SocialPhotoTag = null;
         var idx:uint = 0;
         var fbTag:TagData = null;
         var addTag:AddTag = null;
         var batchRun:FBCallBatchRun = null;
         var call:FacebookCall = null;
         var event:FacebookEvent = param1;
         try
         {
            ev = SocialPlatform_Facebook.getSocialEventSuccess(event);
            if(SocialPlatform_Facebook.isValidEventSuccess(ev))
            {
               photoData = event.data as FacebookPhoto;
               batch = new BatchCollection();
               if(!isPhotoAlbumAvailable() && !SocialPlatform.instance.application.isPermissionGranted(SocialPlatformApp.PERMISSION_PHOTOS_UPLOAD))
               {
                  getAlbums = new GetAlbums("",[photoData.aid]);
                  batch.addItem(getAlbums);
               }
               if(photoUploadCallbackPhotoRef.getTagCount() > 0)
               {
                  fbTagCollection = new PhotoTagCollection();
                  idx = 0;
                  while((xpTag = photoUploadCallbackPhotoRef.getTag(idx)) != null)
                  {
                     fbTag = new TagData();
                     fbTag.x = xpTag.x;
                     fbTag.y = xpTag.y;
                     fbTag.tag_uid = xpTag.tagRef;
                     fbTagCollection.addPhotoTag(fbTag);
                     idx++;
                  }
                  if(fbTagCollection.length > 0)
                  {
                     addTag = new AddTag(photoData.pid,null,null,0,0,fbTagCollection);
                     batch.addItem(addTag);
                  }
               }
               if(batch.length > 0)
               {
                  batchRun = new FBCallBatchRun(batch);
                  call = SocialPlatform_Facebook.facebook.post(batchRun);
                  call.addEventListener(FacebookEvent.COMPLETE,onPhotoPostProcess);
               }
               else
               {
                  onPhotoPostProcess(null);
               }
               photosAvailable = true;
            }
            else if(photoUploadCallbackHandler != null)
            {
               photoUploadCallbackHandler(new PFCallbackEvent(false));
            }
         }
         catch(error:Error)
         {
            if(photoUploadCallbackHandler != null)
            {
               photoUploadCallbackHandler(new PFCallbackEvent(false));
            }
         }
      }
      
      override public function isSupported() : Boolean
      {
         return true;
      }
      
      override public function uploadPhoto(param1:SocialPhoto, param2:Function = null) : Boolean
      {
         photoUploadCallbackHandler = param2;
         var _loc3_:FacebookCall = param1.build() as FacebookCall;
         photoUploadCallbackPhotoRef = param1;
         _loc3_.addEventListener(FacebookEvent.COMPLETE,onUploadPhoto);
         return true;
      }
      
      private function triggerRequest() : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:FBGetPublicInfo = null;
         var _loc1_:GetAlbums = new GetAlbums();
         var _loc2_:BatchCollection = new BatchCollection();
         if(photosAlbumName == null)
         {
            _loc5_ = PFEngine.instance.getParameterString("fb_sig_api_key");
            _loc6_ = new FBGetPublicInfo(null,_loc5_);
            _loc2_.addItem(_loc6_);
         }
         _loc2_.addItem(_loc1_);
         var _loc3_:BatchRun = new BatchRun(_loc2_);
         var _loc4_:FacebookCall;
         (_loc4_ = SocialPlatform_Facebook.facebook.post(_loc3_)).addEventListener(FacebookEvent.COMPLETE,onGetPhotoResponse);
         return true;
      }
      
      private function onGetPhotoResponse(param1:FacebookEvent) : void
      {
         var batchResults:BatchResult = null;
         var results:Array = null;
         var resultIdx:uint = 0;
         var fb_namespace:Namespace = null;
         var albumsData:GetAlbumsData = null;
         var albumData:AlbumData = null;
         var album:SocialPhotoAlbum_Facebook = null;
         var getPublicInfo:GetPublicInfoData = null;
         var resultXML:XML = null;
         var albumXML:XML = null;
         var albumXMLData:* = undefined;
         var i:int = 0;
         var event:FacebookEvent = param1;
         var ev:SocialEventResult = SocialPlatform_Facebook.getSocialEventSuccess(event);
         try
         {
            if(SocialPlatform_Facebook.isValidEventSuccess(ev))
            {
               batchResults = event.data as BatchResult;
               results = batchResults == null ? null : batchResults.results;
               if(batchResults != null && results != null)
               {
                  resultIdx = 0;
                  fb_namespace = SocialPlatform_Facebook.fb_namespace;
                  if(photosAlbumName == null)
                  {
                     getPublicInfo = results[resultIdx] as GetPublicInfoData;
                     if(getPublicInfo != null)
                     {
                        photosAlbumName = getPublicInfo.display_name;
                     }
                     else if(results[resultIdx] is StringResultData)
                     {
                        resultXML = new XML(results[resultIdx].value);
                        photosAlbumName = resultXML..fb_namespace::display_name.toString();
                     }
                     resultIdx++;
                  }
                  albumsData = results[resultIdx] as GetAlbumsData;
                  if(albumsData == null && results[resultIdx] is StringResultData)
                  {
                     albumXML = new XML(results[resultIdx].value);
                     for each(albumXMLData in albumXML..fb_namespace::album)
                     {
                        albumData = new AlbumData();
                        albumData.aid = albumXMLData..fb_namespace::aid.toString();
                        albumData.cover_pid = albumXMLData..fb_namespace::cover_pid.toString();
                        albumData.link = albumXMLData..fb_namespace::link.toString();
                        albumData.name = albumXMLData..fb_namespace::name.toString();
                        albumData.description = albumXMLData..fb_namespace::description.toString();
                        albumData.location = albumXMLData..fb_namespace::location.toString();
                        albumData.visible = albumXMLData..fb_namespace::visible.toString();
                        albumData.owner = albumXMLData..fb_namespace::aid.toString();
                        albumList.push(new SocialPhotoAlbum_Facebook(albumData));
                     }
                     available = true;
                  }
                  if(albumsData != null && albumsData.albumCollection != null)
                  {
                     i = 0;
                     while(i < albumsData.albumCollection.length)
                     {
                        albumData = albumsData.albumCollection.getItemAt(i) as AlbumData;
                        albumList.push(new SocialPhotoAlbum_Facebook(albumData));
                        i++;
                     }
                     available = true;
                  }
                  for each(album in albumList)
                  {
                     if(album.getName().indexOf(photosAlbumName) != -1)
                     {
                        currentAlbum = albumList[albumList.length - 1];
                        photosAvailable = true;
                        break;
                     }
                  }
                  resultIdx++;
               }
            }
            if(!available && firstPrepareAttempt && settings.immediateRetry)
            {
               firstPrepareAttempt = false;
               triggerRequest();
            }
            else
            {
               platformBackRef.onPrepareComplete(PREPARATION_MASK,this);
            }
         }
         catch(error:Error)
         {
            platformBackRef.onPrepareComplete(PREPARATION_MASK,this);
            PFDebug.trace(null,"Exception (photos):" + (error == null ? "Unknown" : error.message));
         }
      }
      
      override public function createPhoto() : SocialPhoto
      {
         return new SocialPhoto_Facebook();
      }
   }
}
