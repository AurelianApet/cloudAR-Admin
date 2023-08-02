<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Login1.aspx.cs" Inherits="nocutAR.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
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
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="loginheader">
        <div style="height:162px"></div>
        <div style="padding-left:327px">
            <h2>
                NOCUT AR LOGIN
            </h2>
            <p style="color:#fff">
                본 서비스를 이용하시려면 로그인 하셔야 합니다.
                <%--<asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false">Register</asp:HyperLink> if you don't have an account.--%>
            </p>
        </div>
    </div>

    <div>
        <table>
            <tr>
                <td style="width:327px"></td>
                <td style="width:250px">
                    <div style="height:20px"></div>
                    <div style="height:60px">
                        <asp:TextBox ID="tbxUserName" runat="server" CssClass="textEntry" MaxLength="20" Text=""></asp:TextBox>
                    </div>
                    <div style="height:60px;">
                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password" MaxLength="12" Text="" ></asp:TextBox>
                    </div>
                    <div style="height:60px">
                        <asp:CheckBox ID="chkRememberMe" runat="server"/>
                        <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="chkRememberMe" CssClass="inline" Font-Bold="True" Font-Names="맑은 고딕" ForeColor="Black">아이디저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label>
                        <asp:CheckBox ID="chkAutoLogin" runat="server"/>
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="chkAutoLogin" CssClass="inline" Font-Names="맑은 고딕" Font-Bold="True" ForeColor="Black">자동로그인</asp:Label>
                    </div>
                </td>
                <td style="width:448px; padding-left:10px">
                    <div style="height:20px"></div>
                    <div style="height:120px">
                        <asp:Button ID="LoginButton" runat="server" CommandName="login" Text="로그인"
                            ValidationGroup="LoginUserValidationGroup" Width="115px" Height="115px"
                            Font-Bold="True" Font-Size="15pt" OnClick="btnLogin_Click"
                            ForeColor="#ED4512" style="font-family:맑은 고딕; background-color:#f7f7f7"/>

                    </div>
                    <div style="height:60px"></div>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <span class="failureNotification">
                        <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
                            ValidationGroup="LoginUserValidationGroup"/>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
