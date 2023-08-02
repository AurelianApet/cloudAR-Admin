<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="nocutAR.Manager.login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Scripts/jquery-1.11.2.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <script type="text/javascript" language="javascript">
        var STR_LOGINID = "아이디";
        var STR_LOGINPWD = "12345678";
        $(document).ready(function () {
            $(".textEntry").focus(function () {
                var oldValue = $(this).attr("value");
                if (oldValue == STR_LOGINID) {
                    $(this).val("");
                }
            });
            $(".textEntry").blur(function () {
                var oldValue = $(this).attr("value");
                if (oldValue == "" || oldValue == STR_LOGINID) {
                    $(this).val(STR_LOGINID);
                }
            });
            $(".passwordEntry").focus(function () {
                var oldValue = $(this).attr("value");
                if (oldValue == STR_LOGINPWD) {
                    $(this).val("");
                }
            });

            $(".passwordEntry").blur(function () {
                var oldValue = $(this).attr("value");
                if (oldValue == "" || oldValue == STR_LOGINPWD) {
                    $(this).val(STR_LOGINPWD);
                    //$(this).css("color", "#CCCCCC");
                }
            });
            $(".textEntry").blur();
            $(".passwordEntry").blur();
        });
    </script>
    <title>로그인</title>
    <meta name="generator" content="Namo WebEditor v6.0" />
</head>
<body>
    <form id="form1" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%" height="100%">
            <tr>
                <td width="1307" height="100%" valign="middle">
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black" width="312" align="center">
                        <tr>
                            <td width="312" height="55">
                                <p align="center"><img src="img/top_logo.png" width="250" height="45" border="0"></p>
                            </td>
                        </tr>
                        <tr>
                            <td width="312" height="22">
                                <p align="center"><span style="font-size:10pt;"><font face="돋움" color="#9CA5B1">본 서비스를 이용하시려면 로그인 하셔야 합니다.</font></span></p>
                            </td>
                        </tr>
                        <tr>
                            <td width="312" height="19">&nbsp;</td>
                        </tr>
                        <tr>
                            <td width="312" height="166">
                                <table cellpadding="0" cellspacing="0" align="center">
                                    <tr>
                                        <td width="302" height="50">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#CCCCCC">
                                                <tr>
                                                    <td width="292" height="35" align="center">
                                                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry" MaxLength="20" Text=""></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="302" height="50">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#CCCCCC">
                                                <tr>
                                                    <td width="292" height="35" align="center">
                                                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password" MaxLength="12" Text="" ></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="302" height="60" align="center">
                                            <asp:Button ID="LoginButton" runat="server" CommandName="login" Text="로그인"
                                                ValidationGroup="LoginUserValidationGroup" Width="292px" Height="35px"
                                                Font-Bold="True" Font-Size="11pt" OnClick="btnLogin_Click"
                                                ForeColor="white" style="font-family:돋움; background-color:#0BBDEA"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="312" height="31">
                                <table cellpadding="0" cellspacing="0" align="center" width="287">
                                    <tr>
                                        <td width="50%" height="25" align="left">
                                            <asp:CheckBox ID="chkRememberMe" runat="server"/>
                                            <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="chkRememberMe" CssClass="inline" Font-Size="10pt" Font-Names="돋움" ForeColor="#CCCCCC">아이디저장</asp:Label>
                                        </td>
                                        <td width="50%" height="25" align="right">
                                            <asp:CheckBox ID="chkAutoLogin" runat="server"/>
                                            <asp:Label ID="Label1" runat="server" AssociatedControlID="chkAutoLogin" CssClass="inline" Font-Size="10pt" Font-Names="돋움" ForeColor="#CCCCCC">자동로그인</asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <span class="failureNotification">
                                    <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                                </span>
                                <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
                                        ValidationGroup="LoginUserValidationGroup"/>
                            </td>
                        </tr>
                    </table>
                    <p>&nbsp;</p>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
