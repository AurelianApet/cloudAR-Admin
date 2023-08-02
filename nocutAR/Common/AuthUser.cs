using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace nocutAR.Common
{
    /// <summary>
    /// Summary description for AuthUser
    /// </summary>
    public class AuthUser
    {
        protected long _id = 0;
        public long ID
        {
            get { return _id; }
        }

        protected string _loginid = null;
        public string LoginID
        {
            get { return _loginid; }
        }

        protected string _loginpwd = null;
        public string LoginPwd
        {
            get { return _loginpwd; }
            set { _loginpwd = value; }
        }

        protected string _nickname = null;
        public string NickName
        {
            get { return _nickname; }
            set { _nickname = value; }
        }

        protected int _ulevel = 0;
        public int ULevel
        {
            get { return _ulevel; }
            set { _ulevel = value; }
        }
        public bool IsAdmin
        {
            get { return _ulevel >= Constants.SITE_MAX_USERLEVEL; }
        }
        public AuthUser()
        {
            _id = 0;
            _loginid = null;
            _loginpwd = null;
            _nickname = null;
        }

        public AuthUser(
            long lID,
            string strLoginID,
            string strLoginPwd,
            string strNickName,
            int iULevel)
        {
            _id = lID;
            _loginid = strLoginID;
            _loginpwd = strLoginPwd;
            _nickname = strNickName;
            _ulevel = iULevel;
        }
    }
}