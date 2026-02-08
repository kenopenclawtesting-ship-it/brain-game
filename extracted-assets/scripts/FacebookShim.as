package
{
   import com.adobe.crypto.MD5;
   import com.adobe.images.BitString;
   import com.adobe.images.JPGEncoder;
   import com.adobe.images.PNGEncoder;
   import com.adobe.serialization.json.JSON;
   import com.adobe.serialization.json.JSONDecoder;
   import com.adobe.serialization.json.JSONEncoder;
   import com.adobe.serialization.json.JSONParseError;
   import com.adobe.serialization.json.JSONToken;
   import com.adobe.serialization.json.JSONTokenType;
   import com.adobe.serialization.json.JSONTokenizer;
   import com.adobe.utils.IntUtil;
   import com.facebook.Facebook;
   import com.facebook.commands.admin.BanUsers;
   import com.facebook.commands.admin.GetAllocation;
   import com.facebook.commands.admin.GetAppProperties;
   import com.facebook.commands.admin.GetBannedUsers;
   import com.facebook.commands.admin.GetMetrics;
   import com.facebook.commands.admin.GetRestrictionInfo;
   import com.facebook.commands.admin.SetAppProperties;
   import com.facebook.commands.admin.SetRestrictionInfo;
   import com.facebook.commands.admin.UnbanUsers;
   import com.facebook.commands.application.GetPublicInfo;
   import com.facebook.commands.auth.CreateToken;
   import com.facebook.commands.auth.ExpireSession;
   import com.facebook.commands.auth.GetSession;
   import com.facebook.commands.auth.PromoteSession;
   import com.facebook.commands.auth.RevokeAuthorization;
   import com.facebook.commands.auth.RevokeExtendedPermission;
   import com.facebook.commands.batch.BatchRun;
   import com.facebook.commands.comments.AddComments;
   import com.facebook.commands.comments.GetComments;
   import com.facebook.commands.comments.RemoveComments;
   import com.facebook.commands.connect.GetUnconnectedFriendsCount;
   import com.facebook.commands.connect.RegisterUsers;
   import com.facebook.commands.connect.UnregisterUsers;
   import com.facebook.commands.data.CreateObject;
   import com.facebook.commands.data.CreateObjectType;
   import com.facebook.commands.data.DefineAssociation;
   import com.facebook.commands.data.DefineObjectProperty;
   import com.facebook.commands.data.DeleteObject;
   import com.facebook.commands.data.DeleteObjects;
   import com.facebook.commands.data.DropObjectType;
   import com.facebook.commands.data.GetAssociatedObjectCount;
   import com.facebook.commands.data.GetAssociatedObjectCounts;
   import com.facebook.commands.data.GetAssociatedObjects;
   import com.facebook.commands.data.GetAssociationDefinition;
   import com.facebook.commands.data.GetAssociationDefinitions;
   import com.facebook.commands.data.GetAssociations;
   import com.facebook.commands.data.GetCookies;
   import com.facebook.commands.data.GetCookiesData;
   import com.facebook.commands.data.GetHashValue;
   import com.facebook.commands.data.GetObject;
   import com.facebook.commands.data.GetObjectProperty;
   import com.facebook.commands.data.GetObjectType;
   import com.facebook.commands.data.GetObjectTypes;
   import com.facebook.commands.data.GetObjects;
   import com.facebook.commands.data.GetUserPreference;
   import com.facebook.commands.data.GetUserPreferences;
   import com.facebook.commands.data.IncHashValue;
   import com.facebook.commands.data.RemoveAssociatedObjects;
   import com.facebook.commands.data.RemoveAssociation;
   import com.facebook.commands.data.RemoveAssociations;
   import com.facebook.commands.data.RemoveHashKey;
   import com.facebook.commands.data.RemoveHashKeys;
   import com.facebook.commands.data.RenameAssociation;
   import com.facebook.commands.data.RenameObjectProperty;
   import com.facebook.commands.data.RenameObjectType;
   import com.facebook.commands.data.SetAssociation;
   import com.facebook.commands.data.SetAssociations;
   import com.facebook.commands.data.SetCookie;
   import com.facebook.commands.data.SetHashValue;
   import com.facebook.commands.data.SetObjectProperty;
   import com.facebook.commands.data.SetUserPreference;
   import com.facebook.commands.data.SetUserPreferences;
   import com.facebook.commands.data.UndefineAssociation;
   import com.facebook.commands.data.UndefineObjectProperty;
   import com.facebook.commands.data.UpdateObject;
   import com.facebook.commands.events.CancelEvent;
   import com.facebook.commands.events.CreateEvent;
   import com.facebook.commands.events.EditEvent;
   import com.facebook.commands.events.GetEvents;
   import com.facebook.commands.events.GetMembers;
   import com.facebook.commands.events.RSVP;
   import com.facebook.commands.fbml.DeleteCustomTags;
   import com.facebook.commands.fbml.GetCustomTags;
   import com.facebook.commands.fbml.RefreshImgSrc;
   import com.facebook.commands.fbml.RefreshRefUrl;
   import com.facebook.commands.fbml.RegisterCustomTags;
   import com.facebook.commands.fbml.SetRefHandle;
   import com.facebook.commands.feed.DeactivateTemplateBundleByID;
   import com.facebook.commands.feed.GetRegisteredTemplateBundleByID;
   import com.facebook.commands.feed.GetRegisteredTemplateBundles;
   import com.facebook.commands.feed.PublishTemplatizedAction;
   import com.facebook.commands.feed.PublishUserAction;
   import com.facebook.commands.feed.RegisterTemplateBundle;
   import com.facebook.commands.fql.FqlMultiquery;
   import com.facebook.commands.fql.FqlQuery;
   import com.facebook.commands.friends.AreFriends;
   import com.facebook.commands.friends.GetAppUsers;
   import com.facebook.commands.friends.GetFriends;
   import com.facebook.commands.friends.GetLists;
   import com.facebook.commands.friends.GetMutualFriends;
   import com.facebook.commands.groups.GetGroupMembers;
   import com.facebook.commands.groups.GetGroups;
   import com.facebook.commands.intl.GetTranslations;
   import com.facebook.commands.intl.UploadNativeStrings;
   import com.facebook.commands.links.GetLinks;
   import com.facebook.commands.links.PostLink;
   import com.facebook.commands.livemessage.SendLiveMessage;
   import com.facebook.commands.message.GetThreadsInFolder;
   import com.facebook.commands.notes.CreateNotes;
   import com.facebook.commands.notes.DeleteNotes;
   import com.facebook.commands.notes.EditNotes;
   import com.facebook.commands.notes.GetNotes;
   import com.facebook.commands.notifications.GetList;
   import com.facebook.commands.notifications.GetNotifications;
   import com.facebook.commands.notifications.MarkRead;
   import com.facebook.commands.notifications.SendEmail;
   import com.facebook.commands.notifications.SendNotification;
   import com.facebook.commands.pages.GetPageInfo;
   import com.facebook.commands.pages.IsAdmin;
   import com.facebook.commands.pages.IsAppAdded;
   import com.facebook.commands.pages.IsFan;
   import com.facebook.commands.photos.AddTag;
   import com.facebook.commands.photos.CreateAlbum;
   import com.facebook.commands.photos.GetAlbums;
   import com.facebook.commands.photos.GetPhotos;
   import com.facebook.commands.photos.GetTags;
   import com.facebook.commands.photos.UploadPhoto;
   import com.facebook.commands.photos.UploadPhotoTypes;
   import com.facebook.commands.profile.GetFBML;
   import com.facebook.commands.profile.GetInfoOptions;
   import com.facebook.commands.profile.ProfileGetInfo;
   import com.facebook.commands.profile.SetFBML;
   import com.facebook.commands.profile.SetInfo;
   import com.facebook.commands.profile.SetInfoOptions;
   import com.facebook.commands.sms.CanSendSMS;
   import com.facebook.commands.sms.SendSMS;
   import com.facebook.commands.status.GetStatus;
   import com.facebook.commands.status.SetStatus;
   import com.facebook.commands.stream.AddComment;
   import com.facebook.commands.stream.AddLike;
   import com.facebook.commands.stream.GetComments;
   import com.facebook.commands.stream.GetFilters;
   import com.facebook.commands.stream.GetStream;
   import com.facebook.commands.stream.PublishPost;
   import com.facebook.commands.stream.RemoveComment;
   import com.facebook.commands.stream.RemoveLike;
   import com.facebook.commands.stream.RemovePost;
   import com.facebook.commands.users.GetInfo;
   import com.facebook.commands.users.GetLoggedInUser;
   import com.facebook.commands.users.GetStandardInfo;
   import com.facebook.commands.users.HasAppPermission;
   import com.facebook.commands.users.IsAppUser;
   import com.facebook.commands.users.SetStatus;
   import com.facebook.commands.video.GetUploadLimits;
   import com.facebook.commands.video.UploadVideo;
   import com.facebook.commands.video.UploadVideoTypes;
   import com.facebook.data.ArrayResultData;
   import com.facebook.data.BooleanResultData;
   import com.facebook.data.FBJSData;
   import com.facebook.data.FacebookData;
   import com.facebook.data.FacebookEducationInfo;
   import com.facebook.data.FacebookErrorCodes;
   import com.facebook.data.FacebookErrorReason;
   import com.facebook.data.FacebookLocation;
   import com.facebook.data.FacebookNetwork;
   import com.facebook.data.FacebookWorkInfo;
   import com.facebook.data.InternalErrorMessages;
   import com.facebook.data.JSONResultData;
   import com.facebook.data.NumberResultData;
   import com.facebook.data.StringResultData;
   import com.facebook.data.XMLDataParser;
   import com.facebook.data.admin.GetAllocationData;
   import com.facebook.data.admin.GetAllocationValues;
   import com.facebook.data.admin.GetAppPropertiesData;
   import com.facebook.data.admin.GetMetricsData;
   import com.facebook.data.admin.GetMetricsPeriodValues;
   import com.facebook.data.admin.GetMetricsValues;
   import com.facebook.data.admin.MetricsData;
   import com.facebook.data.admin.MetricsDataCollection;
   import com.facebook.data.admin.RestrictionData;
   import com.facebook.data.application.GetPublicInfoData;
   import com.facebook.data.auth.ExtendedPermissionValues;
   import com.facebook.data.auth.GetSessionData;
   import com.facebook.data.batch.BatchCollection;
   import com.facebook.data.batch.BatchResult;
   import com.facebook.data.connect.ConnectAccountMapCollection;
   import com.facebook.data.connect.ConnectAccountMapData;
   import com.facebook.data.data.AssocInfoData;
   import com.facebook.data.data.AssocTypeValue;
   import com.facebook.data.data.GetObjectTypeData;
   import com.facebook.data.data.GetObjectTypesData;
   import com.facebook.data.data.GetUserPreferencesData;
   import com.facebook.data.data.NameValueCollection;
   import com.facebook.data.data.NameValueData;
   import com.facebook.data.data.ObjectTypesCollection;
   import com.facebook.data.data.ObjectTypesData;
   import com.facebook.data.data.PreferenceCollection;
   import com.facebook.data.data.PreferenceData;
   import com.facebook.data.data.SetAssociationsData;
   import com.facebook.data.data.SetAssociationsDataCollection;
   import com.facebook.data.events.CreateEventData;
   import com.facebook.data.events.EditEventData;
   import com.facebook.data.events.EventCategoriesValues;
   import com.facebook.data.events.EventCollection;
   import com.facebook.data.events.EventData;
   import com.facebook.data.events.EventPrivacyTypeValues;
   import com.facebook.data.events.EventSubCategoriesValues;
   import com.facebook.data.events.FacebookEventData;
   import com.facebook.data.events.FacebookEventDataCollection;
   import com.facebook.data.events.GetEventsData;
   import com.facebook.data.events.GetMembersData;
   import com.facebook.data.events.RSVPStatus;
   import com.facebook.data.events.RSVPStatusValues;
   import com.facebook.data.fbml.AbstractTagData;
   import com.facebook.data.fbml.AttributeCollection;
   import com.facebook.data.fbml.AttributeData;
   import com.facebook.data.fbml.ContainerTagData;
   import com.facebook.data.fbml.GetCustomTagsData;
   import com.facebook.data.fbml.LeafTagData;
   import com.facebook.data.fbml.TagCollection;
   import com.facebook.data.fbml.TagData;
   import com.facebook.data.feed.ActionLinkCollection;
   import com.facebook.data.feed.ActionLinkData;
   import com.facebook.data.feed.GetRegisteredTemplateBundleByIDData;
   import com.facebook.data.feed.GetRegisteredTemplateBundleData;
   import com.facebook.data.feed.StorySizeValues;
   import com.facebook.data.feed.TemplateBundleCollection;
   import com.facebook.data.feed.TemplateCollection;
   import com.facebook.data.feed.TemplateData;
   import com.facebook.data.friends.AreFriendsData;
   import com.facebook.data.friends.FriendsCollection;
   import com.facebook.data.friends.FriendsData;
   import com.facebook.data.friends.GetAppUserData;
   import com.facebook.data.friends.GetFriendsData;
   import com.facebook.data.friends.GetListsData;
   import com.facebook.data.friends.GetLoggedInUserData;
   import com.facebook.data.friends.ListsData;
   import com.facebook.data.groups.GetGroupData;
   import com.facebook.data.groups.GetMemberData;
   import com.facebook.data.groups.GroupCollection;
   import com.facebook.data.groups.GroupData;
   import com.facebook.data.notes.GetNotesData;
   import com.facebook.data.notes.NoteData;
   import com.facebook.data.notes.NotesCollection;
   import com.facebook.data.notifications.GetNotificationData;
   import com.facebook.data.notifications.GetNotificationValue;
   import com.facebook.data.notifications.NotificationCollection;
   import com.facebook.data.notifications.NotificationMessageData;
   import com.facebook.data.notifications.NotificationPokeData;
   import com.facebook.data.notifications.NotificationShareData;
   import com.facebook.data.pages.GenreData;
   import com.facebook.data.pages.GetPageInfoData;
   import com.facebook.data.pages.PageInfoCollection;
   import com.facebook.data.pages.PageInfoData;
   import com.facebook.data.pages.PageInfoFieldValues;
   import com.facebook.data.pages.PageTypeValue;
   import com.facebook.data.photos.AlbumCollection;
   import com.facebook.data.photos.AlbumData;
   import com.facebook.data.photos.FacebookPhoto;
   import com.facebook.data.photos.GetAlbumsData;
   import com.facebook.data.photos.GetCreateAlbumData;
   import com.facebook.data.photos.GetPhotosData;
   import com.facebook.data.photos.GetTagsData;
   import com.facebook.data.photos.PhotoCollection;
   import com.facebook.data.photos.PhotoData;
   import com.facebook.data.photos.PhotoTagCollection;
   import com.facebook.data.photos.PhotoVisibleValue;
   import com.facebook.data.photos.TagData;
   import com.facebook.data.profile.GetInfoOptionsData;
   import com.facebook.data.profile.InfoFieldsData;
   import com.facebook.data.profile.InfoItemCollection;
   import com.facebook.data.profile.InfoItemData;
   import com.facebook.data.profile.ProfileTypeValues;
   import com.facebook.data.profile.SetInfoTypeValue;
   import com.facebook.data.status.GetStatusData;
   import com.facebook.data.status.Status;
   import com.facebook.data.stream.AttachmentData;
   import com.facebook.data.stream.CommentsData;
   import com.facebook.data.stream.GetCommentsData;
   import com.facebook.data.stream.GetFiltersData;
   import com.facebook.data.stream.GetStreamData;
   import com.facebook.data.stream.LikesData;
   import com.facebook.data.stream.MediaTypes;
   import com.facebook.data.stream.PhotoMedia;
   import com.facebook.data.stream.PostCommentData;
   import com.facebook.data.stream.ProfileCollection;
   import com.facebook.data.stream.ProfileData;
   import com.facebook.data.stream.StoryType;
   import com.facebook.data.stream.StreamFilterCollection;
   import com.facebook.data.stream.StreamFilterData;
   import com.facebook.data.stream.StreamMediaData;
   import com.facebook.data.stream.StreamStoryCollection;
   import com.facebook.data.stream.StreamStoryData;
   import com.facebook.data.stream.VideoMedia;
   import com.facebook.data.users.AffiliationCollection;
   import com.facebook.data.users.AffiliationData;
   import com.facebook.data.users.FacebookUser;
   import com.facebook.data.users.FacebookUserCollection;
   import com.facebook.data.users.FriendsGetData;
   import com.facebook.data.users.GetInfoData;
   import com.facebook.data.users.GetInfoFieldValues;
   import com.facebook.data.users.GetStandardInfoData;
   import com.facebook.data.users.HasAppPermissionValues;
   import com.facebook.data.users.StatusData;
   import com.facebook.data.users.UserCollection;
   import com.facebook.data.users.UserData;
   import com.facebook.delegates.AbstractFileUploadDelegate;
   import com.facebook.delegates.DesktopDelegate;
   import com.facebook.delegates.IFacebookCallDelegate;
   import com.facebook.delegates.JSDelegate;
   import com.facebook.delegates.RequestHelper;
   import com.facebook.delegates.VideoUploadDelegate;
   import com.facebook.delegates.WebDelegate;
   import com.facebook.delegates.WebImageUploadDelegate;
   import com.facebook.errors.FacebookError;
   import com.facebook.events.FacebookEvent;
   import com.facebook.net.FacebookCall;
   import com.facebook.net.IUploadPhoto;
   import com.facebook.net.IUploadVideo;
   import com.facebook.session.DesktopSession;
   import com.facebook.session.IFacebookSession;
   import com.facebook.session.JSSession;
   import com.facebook.session.WebSession;
   import com.facebook.utils.EmailHashUtil;
   import com.facebook.utils.FBJSBridgeUtil;
   import com.facebook.utils.FacebookArrayCollection;
   import com.facebook.utils.FacebookConnectUtil;
   import com.facebook.utils.FacebookDataUtils;
   import com.facebook.utils.FacebookSessionUtil;
   import com.facebook.utils.FacebookStreamXMLParser;
   import com.facebook.utils.FacebookUserXMLParser;
   import com.facebook.utils.FacebookXMLParserUtils;
   import com.facebook.utils.IFacebookResultParser;
   import com.facebook.utils.JavascriptRequestHelper;
   import com.facebook.utils.PlayerUtils;
   import com.facebook.utils.PostRequest;
   import com.facebook.utils.ValidationUtils;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1573")]
   public class FacebookShim extends MovieClip
   {
       
      
      internal var setuserpreference:SetUserPreference;
      
      internal var facebookworkinfo:FacebookWorkInfo;
      
      internal var defineassociation:DefineAssociation;
      
      internal var getmetricsvalues:GetMetricsValues;
      
      internal var setinfo:SetInfo;
      
      internal var getgroupdata:GetGroupData;
      
      internal var getgroupmembers:GetGroupMembers;
      
      internal var stringresultdata:StringResultData;
      
      internal var geteventsdata:GetEventsData;
      
      internal var notescollection:NotesCollection;
      
      internal var publishuseraction:PublishUserAction;
      
      internal var getassociatedobjectcounts:GetAssociatedObjectCounts;
      
      internal var jsonresultdata:JSONResultData;
      
      internal var getregisteredtemplatebundlebyiddata:GetRegisteredTemplateBundleByIDData;
      
      internal var setassociationsdatacollection:SetAssociationsDataCollection;
      
      internal var attributedata:AttributeData;
      
      internal var fbjsdata:FBJSData;
      
      internal var videomedia:VideoMedia;
      
      internal var getuserpreferences:GetUserPreferences;
      
      internal var getuserpreferencesdata:GetUserPreferencesData;
      
      internal var getrestrictioninfo:GetRestrictionInfo;
      
      internal var setinfotypevalue:SetInfoTypeValue;
      
      internal var isadmin:IsAdmin;
      
      internal var fqlquery:FqlQuery;
      
      internal var arrayresultdata:ArrayResultData;
      
      internal var intutil:IntUtil;
      
      internal var getloggedinuserdata:GetLoggedInUserData;
      
      internal var sendnotification:SendNotification;
      
      internal var gettags:GetTags;
      
      internal var facebooklocation:FacebookLocation;
      
      internal var rsvpstatus:RSVPStatus;
      
      internal var cancelevent:CancelEvent;
      
      internal var associnfodata:AssocInfoData;
      
      internal var removehashkeys:RemoveHashKeys;
      
      internal var setinfooptions:SetInfoOptions;
      
      internal var defineobjectproperty:DefineObjectProperty;
      
      internal var getbannedusers:GetBannedUsers;
      
      internal var expiresession:ExpireSession;
      
      internal var gettagsdata:GetTagsData;
      
      internal var postlink:PostLink;
      
      internal var facebooknetwork:FacebookNetwork;
      
      internal var usercollection:UserCollection;
      
      internal var getgroups:GetGroups;
      
      internal var getmetrics:GetMetrics;
      
      internal var notificationpokedata:NotificationPokeData;
      
      internal var undefineobjectproperty:UndefineObjectProperty;
      
      internal var deleteobject:DeleteObject;
      
      internal var getallocation:GetAllocation;
      
      internal var renameobjecttype:RenameObjectType;
      
      internal var rsvp:RSVP;
      
      internal var listsdata:ListsData;
      
      internal var arefriends:AreFriends;
      
      internal var websession:WebSession;
      
      internal var phototagcollection:PhotoTagCollection;
      
      internal var eventcollection:EventCollection;
      
      internal var iuploadphoto:IUploadPhoto;
      
      internal var friendsgetdata:FriendsGetData;
      
      internal var webimageuploaddelegate:WebImageUploadDelegate;
      
      internal var pagetypevalue:PageTypeValue;
      
      internal var sendsms:SendSMS;
      
      internal var renameobjectproperty:RenameObjectProperty;
      
      internal var profiledata:ProfileData;
      
      internal var eventcategoriesvalues:EventCategoriesValues;
      
      internal var webdelegate:WebDelegate;
      
      internal var photodata:PhotoData;
      
      internal var jsontokentype:JSONTokenType;
      
      internal var getassociatedobjects:GetAssociatedObjects;
      
      internal var pageinfodata:PageInfoData;
      
      internal var json:com.adobe.serialization.json.JSON;
      
      internal var getloggedinuser:GetLoggedInUser;
      
      internal var facebookusercollection:FacebookUserCollection;
      
      internal var photomedia:PhotoMedia;
      
      internal var namevaluecollection:NameValueCollection;
      
      internal var createobjecttype:CreateObjectType;
      
      internal var getlist:GetList;
      
      internal var uploadphoto:UploadPhoto;
      
      internal var unbanusers:UnbanUsers;
      
      internal var isappuser:IsAppUser;
      
      internal var getmembers:GetMembers;
      
      internal var getinfo:GetInfo;
      
      internal var getobjects:GetObjects;
      
      internal var profilecollection:ProfileCollection;
      
      internal var deleteobjects:DeleteObjects;
      
      internal var getfiltersdata:GetFiltersData;
      
      internal var infofieldsdata:InfoFieldsData;
      
      internal var facebooksessionutil:FacebookSessionUtil;
      
      internal var getpageinfo:GetPageInfo;
      
      internal var batchrun:BatchRun;
      
      internal var getmemberdata:GetMemberData;
      
      internal var sendemail:SendEmail;
      
      internal var getregisteredtemplatebundles:GetRegisteredTemplateBundles;
      
      internal var templatebundlecollection:TemplateBundleCollection;
      
      internal var sendlivemessage:SendLiveMessage;
      
      internal var getunconnectedfriendscount:GetUnconnectedFriendsCount;
      
      internal var leaftagdata:LeafTagData;
      
      internal var getinfooptions:GetInfoOptions;
      
      internal var getnotes:GetNotes;
      
      internal var jssession:JSSession;
      
      internal var getobjecttypesdata:GetObjectTypesData;
      
      internal var revokeextendedpermission:RevokeExtendedPermission;
      
      internal var facebookeventdata:FacebookEventData;
      
      internal var removeassociatedobjects:RemoveAssociatedObjects;
      
      internal var eventdata:EventData;
      
      internal var registerusers:RegisterUsers;
      
      internal var setcookie:SetCookie;
      
      internal var updateobject:UpdateObject;
      
      internal var numberresultdata:NumberResultData;
      
      internal var setappproperties:SetAppProperties;
      
      internal var batchcollection:BatchCollection;
      
      internal var metricsdatacollection:MetricsDataCollection;
      
      internal var removecomment:RemoveComment;
      
      internal var getallocationvalues:GetAllocationValues;
      
      internal var getassociationdefinitions:GetAssociationDefinitions;
      
      internal var getalbumsdata:GetAlbumsData;
      
      internal var facebookconnectutil:FacebookConnectUtil;
      
      internal var getallocationdata:GetAllocationData;
      
      internal var getnotifications:GetNotifications;
      
      internal var likesdata:LikesData;
      
      internal var restrictiondata:RestrictionData;
      
      internal var setassociations:SetAssociations;
      
      internal var getfriends:GetFriends;
      
      internal var ifacebooksession:IFacebookSession;
      
      internal var affiliationcollection:AffiliationCollection;
      
      internal var ifacebookcalldelegate:IFacebookCallDelegate;
      
      internal var removehashkey:RemoveHashKey;
      
      internal var removeassociation:RemoveAssociation;
      
      internal var addcomments:AddComments;
      
      internal var desktopdelegate:DesktopDelegate;
      
      internal var getcookiesdata:GetCookiesData;
      
      internal var getfriendsdata:GetFriendsData;
      
      internal var setuserpreferences:SetUserPreferences;
      
      internal var emailhashutil:EmailHashUtil;
      
      internal var uploadvideotypes:UploadVideoTypes;
      
      internal var storytype:StoryType;
      
      internal var preferencecollection:PreferenceCollection;
      
      internal var tagcollection:TagCollection;
      
      internal var isfan:IsFan;
      
      internal var md5:MD5;
      
      internal var notificationcollection:NotificationCollection;
      
      internal var actionlinkcollection:ActionLinkCollection;
      
      internal var streamstorycollection:StreamStoryCollection;
      
      internal var getmetricsdata:GetMetricsData;
      
      internal var setrestrictioninfo:SetRestrictionInfo;
      
      internal var refreshimgsrc:RefreshImgSrc;
      
      internal var jsdelegate:JSDelegate;
      
      internal var markread:MarkRead;
      
      internal var postcommentdata:PostCommentData;
      
      internal var getappusers:GetAppUsers;
      
      internal var registercustomtags:RegisterCustomTags;
      
      internal var postrequest:PostRequest;
      
      internal var friendscollection:FriendsCollection;
      
      internal var userdata:UserData;
      
      internal var getcommentsdata:GetCommentsData;
      
      internal var getlists:GetLists;
      
      internal var assoctypevalue:AssocTypeValue;
      
      internal var getappuserdata:GetAppUserData;
      
      internal var streammediadata:StreamMediaData;
      
      internal var jsontoken:JSONToken;
      
      internal var pageinfocollection:PageInfoCollection;
      
      internal var getobject:GetObject;
      
      internal var infoitemcollection:InfoItemCollection;
      
      internal var getlinks:GetLinks;
      
      internal var getcomments1:com.facebook.commands.comments.GetComments;
      
      internal var ifacebookresultparser:IFacebookResultParser;
      
      internal var publishpost:PublishPost;
      
      internal var facebookarraycollection:FacebookArrayCollection;
      
      internal var facebookcall:FacebookCall;
      
      internal var jsonparseerror:JSONParseError;
      
      internal var getlistsdata:GetListsData;
      
      internal var getsessiondata:GetSessionData;
      
      internal var attributecollection:AttributeCollection;
      
      internal var removelike:RemoveLike;
      
      internal var gettranslations:GetTranslations;
      
      internal var uploadnativestrings:UploadNativeStrings;
      
      internal var tagdata:com.facebook.data.photos.TagData;
      
      internal var albumcollection:AlbumCollection;
      
      internal var photocollection:PhotoCollection;
      
      internal var jpgencoder:JPGEncoder;
      
      internal var hasapppermission:HasAppPermission;
      
      internal var setrefhandle:SetRefHandle;
      
      internal var publishtemplatizedaction:PublishTemplatizedAction;
      
      internal var facebookeventdatacollection:FacebookEventDataCollection;
      
      internal var groupcollection:GroupCollection;
      
      internal var uploadphototypes:UploadPhotoTypes;
      
      internal var facebookerrorcodes:FacebookErrorCodes;
      
      internal var getstream:GetStream;
      
      internal var notificationmessagedata:NotificationMessageData;
      
      internal var getassociations:GetAssociations;
      
      internal var getstandardinfodata:GetStandardInfoData;
      
      internal var tagdata1:com.facebook.data.fbml.TagData;
      
      internal var playerutils:PlayerUtils;
      
      internal var getstatusdata:GetStatusData;
      
      internal var undefineassociation:UndefineAssociation;
      
      internal var getthreadsinfolder:GetThreadsInFolder;
      
      internal var namevaluedata:NameValueData;
      
      internal var removecomments:RemoveComments;
      
      internal var getcookies:GetCookies;
      
      internal var getappproperties:GetAppProperties;
      
      internal var getsession:GetSession;
      
      internal var editeventdata:EditEventData;
      
      internal var getnotificationdata:GetNotificationData;
      
      internal var createtoken:CreateToken;
      
      internal var facebookuserxmlparser:FacebookUserXMLParser;
      
      internal var gethashvalue:GetHashValue;
      
      internal var getcustomtagsdata:GetCustomTagsData;
      
      internal var renameassociation:RenameAssociation;
      
      internal var templatecollection:TemplateCollection;
      
      internal var albumdata:AlbumData;
      
      internal var affiliationdata:AffiliationData;
      
      internal var statusdata:StatusData;
      
      internal var removeassociations:RemoveAssociations;
      
      internal var addcomment:AddComment;
      
      internal var streamstorydata:StreamStoryData;
      
      internal var streamfilterdata:StreamFilterData;
      
      internal var notedata:NoteData;
      
      internal var abstractfileuploaddelegate:AbstractFileUploadDelegate;
      
      internal var refreshrefurl:RefreshRefUrl;
      
      internal var groupdata:GroupData;
      
      internal var getinfodata:GetInfoData;
      
      internal var javascriptrequesthelper:JavascriptRequestHelper;
      
      internal var deactivatetemplatebundlebyid:DeactivateTemplateBundleByID;
      
      internal var containertagdata:ContainerTagData;
      
      internal var getpublicinfo:GetPublicInfo;
      
      internal var objecttypescollection:ObjectTypesCollection;
      
      internal var getalbums:GetAlbums;
      
      internal var setfbml:SetFBML;
      
      internal var pageinfofieldvalues:PageInfoFieldValues;
      
      internal var isappadded:IsAppAdded;
      
      internal var facebook:Facebook;
      
      internal var friendsdata:FriendsData;
      
      internal var getstatus:GetStatus;
      
      internal var getnotificationvalue:GetNotificationValue;
      
      internal var setstatus:com.facebook.commands.users.SetStatus;
      
      internal var editevent:EditEvent;
      
      internal var actionlinkdata:ActionLinkData;
      
      internal var getassociatedobjectcount:GetAssociatedObjectCount;
      
      internal var promotesession:PromoteSession;
      
      internal var registertemplatebundle:RegisterTemplateBundle;
      
      internal var setassociation:SetAssociation;
      
      internal var getcustomtags:GetCustomTags;
      
      internal var extendedpermissionvalues:ExtendedPermissionValues;
      
      internal var pngencoder:PNGEncoder;
      
      internal var metricsdata:MetricsData;
      
      internal var fqlmultiquery:FqlMultiquery;
      
      internal var getobjecttype:GetObjectType;
      
      internal var jsondecoder:JSONDecoder;
      
      internal var createalbum:CreateAlbum;
      
      internal var deletecustomtags:DeleteCustomTags;
      
      internal var setobjectproperty:SetObjectProperty;
      
      internal var editnotes:EditNotes;
      
      internal var hasapppermissionvalues:HasAppPermissionValues;
      
      internal var getobjecttypedata:GetObjectTypeData;
      
      internal var desktopsession:DesktopSession;
      
      internal var requesthelper:RequestHelper;
      
      internal var getstreamdata:GetStreamData;
      
      internal var cansendsms:CanSendSMS;
      
      internal var facebookerror:FacebookError;
      
      internal var preferencedata:PreferenceData;
      
      internal var getcreatealbumdata:GetCreateAlbumData;
      
      internal var sethashvalue:SetHashValue;
      
      internal var eventprivacytypevalues:EventPrivacyTypeValues;
      
      internal var getassociationdefinition:GetAssociationDefinition;
      
      internal var iuploadvideo:IUploadVideo;
      
      internal var inchashvalue:IncHashValue;
      
      internal var mediatypes:MediaTypes;
      
      internal var getobjectproperty:GetObjectProperty;
      
      internal var getinfofieldvalues:GetInfoFieldValues;
      
      internal var uploadvideo:UploadVideo;
      
      internal var setassociationsdata:SetAssociationsData;
      
      internal var storysizevalues:StorySizeValues;
      
      internal var createevent:CreateEvent;
      
      internal var templatedata:TemplateData;
      
      internal var getmembersdata:GetMembersData;
      
      internal var getapppropertiesdata:GetAppPropertiesData;
      
      internal var facebookphoto:FacebookPhoto;
      
      internal var jsonencoder:JSONEncoder;
      
      internal var jsontokenizer:JSONTokenizer;
      
      internal var dropobjecttype:DropObjectType;
      
      internal var profilegetinfo:ProfileGetInfo;
      
      internal var getpageinfodata:GetPageInfoData;
      
      internal var facebookdatautils:FacebookDataUtils;
      
      internal var objecttypesdata:ObjectTypesData;
      
      internal var profiletypevalues:ProfileTypeValues;
      
      internal var removepost:RemovePost;
      
      internal var getcomments:com.facebook.commands.stream.GetComments;
      
      internal var createnotes:CreateNotes;
      
      internal var attachmentdata:AttachmentData;
      
      internal var facebookeducationinfo:FacebookEducationInfo;
      
      internal var createobject:CreateObject;
      
      internal var getnotesdata:GetNotesData;
      
      internal var getmetricsperiodvalues:GetMetricsPeriodValues;
      
      internal var getstandardinfo:GetStandardInfo;
      
      internal var unregisterusers:UnregisterUsers;
      
      internal var addtag:AddTag;
      
      internal var getphotos:GetPhotos;
      
      internal var getmutualfriends:GetMutualFriends;
      
      internal var booleanresultdata:BooleanResultData;
      
      internal var photovisiblevalue:PhotoVisibleValue;
      
      internal var bitstring:BitString;
      
      internal var banusers:BanUsers;
      
      internal var notificationsharedata:NotificationShareData;
      
      internal var facebookdata:FacebookData;
      
      internal var getphotosdata:GetPhotosData;
      
      internal var getobjecttypes:GetObjectTypes;
      
      internal var getregisteredtemplatebundledata:GetRegisteredTemplateBundleData;
      
      internal var getregisteredtemplatebundlebyid:GetRegisteredTemplateBundleByID;
      
      internal var facebookuser:FacebookUser;
      
      internal var facebookevent:FacebookEvent;
      
      internal var streamfiltercollection:StreamFilterCollection;
      
      internal var getpublicinfodata:GetPublicInfoData;
      
      internal var commentsdata:CommentsData;
      
      internal var eventsubcategoriesvalues:EventSubCategoriesValues;
      
      internal var xmldataparser:XMLDataParser;
      
      internal var connectaccountmapdata:ConnectAccountMapData;
      
      internal var genredata:GenreData;
      
      internal var getuploadlimits:GetUploadLimits;
      
      internal var getfbml:GetFBML;
      
      internal var revokeauthorization:RevokeAuthorization;
      
      internal var internalerrormessages:InternalErrorMessages;
      
      internal var addlike:AddLike;
      
      internal var getuserpreference:GetUserPreference;
      
      internal var facebookxmlparserutils:FacebookXMLParserUtils;
      
      internal var getinfooptionsdata:GetInfoOptionsData;
      
      internal var facebookerrorreason:FacebookErrorReason;
      
      internal var videouploaddelegate:VideoUploadDelegate;
      
      internal var rsvpstatusvalues:RSVPStatusValues;
      
      internal var fbjsbridgeutil:FBJSBridgeUtil;
      
      internal var connectaccountmapcollection:ConnectAccountMapCollection;
      
      internal var validationutils:ValidationUtils;
      
      internal var batchresult:BatchResult;
      
      internal var createeventdata:CreateEventData;
      
      internal var abstracttagdata:AbstractTagData;
      
      internal var arefriendsdata:AreFriendsData;
      
      internal var getfilters:GetFilters;
      
      internal var getevents:GetEvents;
      
      internal var facebookstreamxmlparser:FacebookStreamXMLParser;
      
      internal var infoitemdata:InfoItemData;
      
      internal var setstatus1:com.facebook.commands.status.SetStatus;
      
      internal var deletenotes:DeleteNotes;
      
      internal var status:Status;
      
      public function FacebookShim()
      {
         super();
      }
   }
}
