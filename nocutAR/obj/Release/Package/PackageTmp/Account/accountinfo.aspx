<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MemberShip.master" AutoEventWireup="true" CodeBehind="accountinfo.aspx.cs" Inherits="nocutAR.Account.accountinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .clsLabel 
        {
            color:#666666;
            font-size:11pt;
        }
    </style>
    <script>
        $(document).ready(function () {
            selLeftMenu(2);
        });

        function showPwdChange() {
            showPopup("dvChnagePwd");
        }

        function checkPwd() {
            if ($("#<%=tbxCurPwd.ClientID %>").val() == "") {
                alert("현재 패스워드를 입력하세요.");
                return false;
            }
            if ($("#<%=tbxNewPwd.ClientID %>").val() == "") {
                alert("새 패스워드를 입력하세요.");
                return false;
            }
            if ($("#<%=tbxConfirmPwd.ClientID %>").val() != $("#<%=tbxNewPwd.ClientID %>").val()) {
                alert("새 패스워드가 일치하지 않습니다.");
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div>
<table cellpadding="0" cellspacing="0" width="1091" align="center" bgcolor="#F7F8F8" style="border-width:1px; border-style:none; border-collapse:collapse;">
    <tr>
        <td width="1089" height="815" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;" valign="top">
            <table cellpadding="0" cellspacing="0" width="928">
                <tr>
                    <td width="56" height="68">&nbsp;</td>
                    <td width="135" height="68"></td>
                    <td width="737" height="68">&nbsp;</td>
                </tr>
                <tr>
                    <td width="56" height="50">&nbsp;</td>
                    <td width="135" height="50">
                        <b><span style="font-size:11pt;"><font face="돋움" color="#666666">회사명</font></span></b>
                    </td>
                    <td width="737" height="50" class="clsLabel">
                        <asp:Literal runat="server" ID="ltrCompany"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td width="56" height="50">&nbsp;</td>
                    <td width="135" height="50">
                        <b><span style="font-size:11pt;"><font face="돋움" color="#666666">관리자ID</font></span></b>
                    </td>
                    <td width="737" height="50" class="clsLabel">
                        <asp:Literal runat="server" ID="ltrLoginID"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td width="56" height="50">&nbsp;</td>
                    <td width="135" height="50">
                        <b><span style="font-size:11pt;"><font face="돋움" color="#666666">패스워드</font></span></b>
                    </td>
                    <td width="737" height="50">
                        <table cellpadding="0" cellspacing="0" width="319">
                            <tr>
                                <td width="149" height="36">
                                    <span style="font-size:9pt;"><font face="돋움" color="#999999">●●●●●●●</font></span>
                                </td>
                                <td width="170" height="36"  align="center">
                                    <input type="button" class="clsButton" value="패스워드 변경" onclick="showPwdChange()" style="font-weight:bold; width:130px; height:27px" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="56" height="25">&nbsp;</td>
                    <td width="135" height="25"><span style="font-size:11pt;"><font face="돋움">&nbsp;</font></span></td>
                    <td width="737" height="25"><span style="font-size:11pt;"><font face="돋움">&nbsp;</font></span></td>
                </tr>
                <tr>
                    <td width="56" height="40">&nbsp;</td>
                    <td width="135" height="40">
                        <b><span style="font-size:11pt;"><font face="돋움" color="#666666">이용중인 상품</font></span></b>
                    </td>
                    <td width="737" height="40" class="clsLabel">
                        <asp:Literal runat="server" ID="ltrProduct"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td width="56" height="40">&nbsp;</td>
                    <td width="135" height="40">
                        <b><span style="font-size:11pt;"><font face="돋움" color="#666666">이용기간</font></span></b>
                    </td>
                    <td width="737" height="40" class="clsLabel">
                        <asp:Literal runat="server" ID="ltrUseDate"></asp:Literal>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="903">
                <tr>
                    <td width="903" height="72">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div>
<div id="dvChnagePwd" class="clspopup">
    <table cellpadding="0" cellspacing="0" width="583" align="center" bgcolor="white" style="border-collapse:collapse;">
        <tr>
            <td width="581" height="310" style="border-width:1px; border-color:rgb(204,204,204); border-style:solid;">
                <table cellpadding="0" cellspacing="0" width="499" align="center">
                    <tr>
                        <td width="499" height="57">
                            <b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">&nbsp;&nbsp;패스워드 변경</span></font></b>
                        </td>
                    </tr>
                    <tr>
                        <td width="499" height="156">
                            <table cellpadding="0" cellspacing="0" width="473" align="center">
                                <tr>
                                    <td width="125" height="40"><span style="font-size:11pt;"><font face="돋움" color="#666666">현재 패스워드*</font></span></td>
                                    <td width="348" height="40">
                                        <asp:TextBox runat="server" ID="tbxCurPwd" Width="270px" MaxLength="20" TextMode="Password" CssClass="control"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" width="473" align="center">
                                <tr>
                                    <td width="125" height="40"><span style="font-size:11pt;"><font face="돋움" color="#666666">새로운 패스워드*</font></span></td>
                                    <td width="348" height="40">
                                        <asp:TextBox runat="server" ID="tbxNewPwd" Width="270px" MaxLength="20" TextMode="Password" CssClass="control"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" width="473" align="center">
                                <tr>
                                    <td width="125" height="40"><span style="font-size:11pt;"><font face="돋움" color="#666666">패스워드 재입력*</font></span></td>
                                    <td width="348" height="40">
                                        <asp:TextBox runat="server" ID="tbxConfirmPwd" Width="270px" MaxLength="20" TextMode="Password" CssClass="control"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="499" height="66" align="right">
                            <table cellpadding="0" cellspacing="0" width="251">
                                <tr>
                                    <td width="123" height="48" align="left">
                                        <input type="button" class="clsBigButton" onclick="closePopup()" value="취소" style="background-color:#7F7F7F; width:112px; height:33px">
                                    </td>
                                    <td width="128" height="48" align="left">
                                        <asp:Button runat="server" ID="btnChangePwd" CssClass="clsBigButton" 
                                            Width="107px" Height="33px" Text="등록" onclick="btnChangePwd_Click" OnClientClick="return checkPwd();" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
</asp:Content>
