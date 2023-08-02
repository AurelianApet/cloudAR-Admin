using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace nocutAR.Common
{
    public class Constants
    {
        #region 쿠키 관련 상수
        public const string COOKIE_KEY_SITE = "NOCUTAR::COOKIE::KEY";
        public const string COOKIE_KEY_SITE_LANGUAGE = "NOCUTAR::COOKIE::KEY::SITE::LANGUAGE";
        public const string COOKIE_KEY_USERINFO = "NOCUTAR::COOKIE::KEY::USERINFO";
        public const string COOKIE_KEY_REMEBERID = "NOCUTAR::COOKIE::LOGIN::REMEMBERID";
        public const string COOKIE_KEY_AUTOLOGIN = "NOCUTAR::COOKIE::LOGIN::AUTOLOGIN";

        public const string COOKIE_KEY_MOBILETYPE = "NOCUTAR::COOKIE::KEY::MOBILETYPE";
        #endregion

        #region 세션 관련 상수
        public const string SESSION_KEY_USERINFO = "NOCUTAR::SESSION::KEY::USERINFO";
        public const string SESSION_KEY_AUTOLOGOUT = "NOCUTAR::SESSION::KEY::AUTOLOGOUT";
        public const string SESSION_KEY_MOBILETYPE = "NOCUTAR::SESSION::KEY::MOBILETYPE";
        #endregion

        #region 모바일기기 형태
        public const string MOBILE_IPHONE = "iPhone";
        public const string MOBILE_ANDROID = "Android";
        public const string MOBILE_IPAD = "iPad";

        // Japan Mobile
        public const string MOBILE_DOCOMO = "DoCoMo";
        public const string MOBILE_KDDI = "KDDI";
        public const string MOBILE_SOFTBANK = "SoftBank";
        public const string MOBILE_EMOBILE = "eMobile";
        public const string MOBILE_PHS = "PHS";
        public const string MOBILE_UNKNOWN = "Unknown";
        #endregion

        #region Stored Procedure 이름 정의
        public static string SP_GETUSER = "sp_getUser";
        public static string SP_CREATELOGIN = "sp_createLogin";
        public static string SP_UPDATEUSERINFO = "sp_updateUserInfo";
        public static string SP_UPDATELOGIN = "sp_updateLogin";
        public static string SP_GETMANAGEPERM = "sp_getManagePerm";
        public static string SP_GETCONFIG = "sp_getConfig";
        public static string SP_GETLOGINS = "sp_getLogins";
        public static string SP_GETNOTICELIST = "sp_getNoticeList";
        public static string SP_GETCONTENTSLIST = "sp_getContentsList";
        public static string SP_GETPROJECTSLIST = "sp_getProjectsList";
        public static string SP_ADDCONTENT = "sp_addContent";
        public static string SP_CREATEUSER = "sp_createUser";
        public static string SP_MODIFYUSER = "sp_modifyUser";
        public static string SP_GETMEMBERS = "sp_getMembers";
        public static string SP_CREATENOTICE = "sp_createNotice";
        public static string SP_MODIFYNOTICE = "sp_modifyNotice";
        public static string SP_DELETESELMEMBER = "sp_deleteSelMember";
        public static string SP_ADDPROJECT = "sp_addProject";
        public static string SP_DELETEPROJECT = "sp_deleteProject";
        public static string SP_DELETECONTENT = "sp_deleteContent";
        public static string SP_GETUNREADREQUEST = "sp_getUnreadRequest";
        public static string SP_MODIFYCONTENTNAME = "sp_modifyContentName";
        public static string SP_MODIFYPROJECTNAME = "sp_modifyProjectName";
        public static string SP_SEARCHEDPROJECT = "sp_getSearchedResult";
        public static string SP_GETCAMPAIGNPOPLIST = "sp_getCampaignPopList";
        public static string SP_GETPRODUCTLIST = "sp_getProductLists";
        public static string SP_CREATEPRODUCT = "sp_createProduct";
        public static string SP_MODIFYPRODUCT = "sp_modifyProduct";
        public static string SP_GETEVENTLOG = "sp_getEventLog";
        public static string SP_ADDEVENTLOG = "sp_addEventLog";        

        #endregion

        #region 사이트관련상수
        public const string SITE_SEPERATOR = ":";
        public const char SITE_SEPERATOR_CHAR = ':';

        public const int SITE_MAX_USERLEVEL = 10;       // 유저의 최대레벨값
        public const int SITE_RECENT_NOTICECOUNT = 5;        // 최근 게시글 개수

        public const string SITE_SELECTALL = "All";    // 검색시 전체선택값

        public const string EVENT_LOGIN = "로그인";
        public const string EVENT_LOGOUT = "로그아웃";
        public const string EVENT_ADDUSER = "계정추가";
        public const string EVENT_DELUSER = "계정삭제";
        public const string EVENT_MODUSER = "계정수정";
        public const string EVENT_ADDPRODUCT = "상품등록";
        public const string EVENT_DELPRODUCT = "상품삭제";
        public const string EVENT_MODPRODUCT = "상품수정";
        public const string EVENT_ADDNOTICE = "공지사항등록";
        public const string EVENT_DELNOTICE = "공지사항삭제";
        public const string EVENT_MODNOTICE = "공지사항수정";
        public const string EVENT_CHANGEPWD = "메인관리자 PWD 변경";

        public const string EVENT_ADDPROJECT = "켐페인그룹생성";
        public const string EVENT_DELPROJECT = "켐페인그룹삭제";
        public const string EVENT_ADDCAMPAIGN = "켐페인생성";
        public const string EVENT_DELCAMPAIGN = "켐페인삭제";
        public const string EVENT_MODCAMPAIGN = "켐페인수정";

        #endregion

        #region 뷰스테이트 관련 상수
        public const string VS_PAGENUMBER = "PageNumber";
        public const string VS_DATASOURCE = "DataSource";

        public const string VS_STARTDATE = "StartDate";
        public const string VS_ENDDATE = "EndDate";

        public const string VS_SORTCOLUMN = "SortColumn";
        public const string VS_SORTDIRECTION = "SortDirection";

        public const string VS_SEARCHDATE = "SearchDate";
        #endregion

        
    }
}