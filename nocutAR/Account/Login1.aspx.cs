using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using nocutAR.Common;
using DataAccess;

namespace nocutAR.Account
{
    public partial class Login : Common.PageBase
    {
        protected override void Page_Init(object sender, EventArgs e)
        {
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            //ShowMessageBox(CryptSHA256.Decrypt("D4s3s9Sj+uw="));
            //아이디저장쿠키가 있다면
            if (!IsPostBack)
            {
                if (Request.Cookies[Constants.COOKIE_KEY_REMEBERID] != null)
                {
                    string strCookie = Request.Cookies[Constants.COOKIE_KEY_REMEBERID][Constants.COOKIE_KEY_REMEBERID];
                    strCookie = CryptSHA256.Decrypt(strCookie);
                    string[] arrTemp = strCookie.Split(';');
                    if (arrTemp.Length == 2)
                    {
                        tbxUserName.Text = arrTemp[1].ToString();
                        chkRememberMe.Checked = true;
                    }

                }
            }

            //자동로그인쿠키가 있다면
            if (Request.Cookies[Constants.COOKIE_KEY_AUTOLOGIN]  != null)
            {
                if (AuthUser != null)
                    Response.Redirect(Defines.URL_PREFIX_MEMBER + Defines.URL_DEFAULT);
            }



            //if (!IsPostBack)
            //{
            //    if (Session[Constants.SESSION_KEY_AUTOLOGOUT] != null)
            //    {
            //        ShowMessageBox(Resources.Msg.MSG_AUTO_LOGOUT);
            //        Session[Constants.SESSION_KEY_AUTOLOGOUT] = null;
            //    }
            //}
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (chkRememberMe.Checked)
            {
                isRememberMe = true;
            }
            else
            {
                isRememberMe = false;
            }
            if (chkAutoLogin.Checked)
            {
                isAutoLogin = true;
            }
            else
            {
                isAutoLogin = false;
            }
            if (string.IsNullOrEmpty(tbxUserName.Text))
            {
                ShowMessageBox(Resources.Err.ERR_LOGINID_INPUT);
                return;
            }
            if (string.IsNullOrEmpty(Password.Text))
            {
                ShowMessageBox(Resources.Err.ERR_LOGINPWD_INPUT);
                return;
            }

            if (!UserLogin(tbxUserName.Text, Password.Text))
            {
                ShowMessageBox(Resources.Err.ERR_LOGIN_FAILED);
                return;
            }
            else
            {
                Response.Redirect(Defines.URL_PREFIX_MEMBER + Defines.URL_DEFAULT);
            }
        }

    }
}
