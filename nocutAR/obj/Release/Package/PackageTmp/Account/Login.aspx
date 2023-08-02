<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="nocutAR.Account.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Scripts/jquery-1.11.2.js"></script>
    <script type="text/javascript" language="javascript">
//        var STR_LOGINID = "아이디";
//        var STR_LOGINPWD = "12345678";
//        $(document).ready(function () {
//            $(".textEntry").focus(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == STR_LOGINID) {
//                    $(this).val("");
//                }
//            });
//            $(".textEntry").blur(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == "" || oldValue == STR_LOGINID) {
//                    $(this).val(STR_LOGINID);
//                }
//            });
//            $(".passwordEntry").focus(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == STR_LOGINPWD) {
//                    $(this).val("");
//                }
//            });

//            $(".passwordEntry").blur(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == "" || oldValue == STR_LOGINPWD) {
//                    $(this).val(STR_LOGINPWD);
//                    //$(this).css("color", "#CCCCCC");
//                }
//            });
//            $(".textEntry").blur();
//            $(".passwordEntry").blur();
//        });
    </script>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>로그인</title>
    <meta name="generator" content="Namo WebEditor v6.0" />
</head>
<body>
    <form id="form1" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%" height="100%" bgcolor="#CDD3DB">
            <tr>
                <td width="1307">
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black" width="377" align="center" bgcolor="#F6303E" style="border-collapse:collapse;">
                        <tr>
                            <td width="377" height="73" align="center" style="border-width:1px; border-top-color:rgb(199,27,40); border-right-color:rgb(199,27,40); border-bottom-color:black; border-left-color:rgb(199,27,40); border-top-style:solid; border-right-style:solid; border-bottom-style:none; border-left-style:solid;">
                                <img src="img/login_logo.png" width="114" height="45" border="0">
                            </td>
                        </tr>
                        <tr>
                            <td width="377" height="22" align="center" style="border-width:1px; border-top-color:black; border-right-color:rgb(199,27,40); border-bottom-color:black; border-left-color:rgb(199,27,40); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:solid;">
                                <span style="font-size:10pt;"><font face="돋움" color="white">본 서비스를 이용하시려면 로그인 하셔야 합니다.</font></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="377" height="19" style="border-width:1px; border-top-color:black; border-right-color:rgb(199,27,40); border-bottom-color:black; border-left-color:rgb(199,27,40); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:solid;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td width="377" height="166" style="border-width:1px; border-top-color:black; border-right-color:rgb(199,27,40); border-bottom-color:black; border-left-color:rgb(199,27,40); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:solid;">
                                <table cellpadding="0" cellspacing="0" align="center">
                                    <tr>
                                        <td width="302" height="50" >
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#EDEDED">
                                                <tr>
                                                    <td width="292" height="35" align="center" class="textinput">
                                                        <asp:TextBox ID="tbxUserName" runat="server" CssClass="textEntry" MaxLength="20" placeholder="아이디" Text=""></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="302" height="50" >
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#EDEDED">
                                                <tr>
                                                    <td width="292" height="35" align="center" class="textinput">
                                                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password" placeholder="패스워드"  MaxLength="12" Text="" ></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="302" height="60" align="center">
                                            <asp:Button ID="LoginButton" runat="server" CommandName="login" Text="로그인"
                                                ValidationGroup="LoginUserValidationGroup" Width="292px" Height="35px" CssClass="clsBigButton"
                                                OnClick="btnLogin_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="377" height="61" style="border-width:1px; border-top-color:black; border-right-color:rgb(199,27,40); border-bottom-color:rgb(199,27,40); border-left-color:rgb(199,27,40); border-top-style:none; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
                                <table cellpadding="0" cellspacing="0" align="center" width="287">
                                    <tr>
                                        <td width="192" height="25">
                                            <asp:CheckBox ID="chkRememberMe" runat="server"/>
                                            <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="chkRememberMe" CssClass="inline" Font-Size="10pt" Font-Names="돋움" ForeColor="#CCCCCC">아이디저장</asp:Label>
                                        </td>
                                        <td width="95" height="25">
                                            <asp:CheckBox ID="chkAutoLogin" runat="server"/>
                                            <asp:Label ID="Label1" runat="server" AssociatedControlID="chkAutoLogin" CssClass="inline" Font-Size="10pt" Font-Names="돋움" ForeColor="#CCCCCC">자동로그인</asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
