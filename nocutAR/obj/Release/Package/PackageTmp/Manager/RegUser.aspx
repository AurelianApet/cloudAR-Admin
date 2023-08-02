<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="RegUser.aspx.cs" Inherits="nocutAR.Manager.RegUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script>

    $(document).ready(function () {
//        $("#popChkID").fadeIn("slow");
        selTopMenu(1);

    });
    function OnSearchID() {
        $("#btn_newContent").css("display", "block");
        $("#popSearchID").fadeIn("slow");
        $("#popBack").css({
            "opacity": "0.2"
        });
        $("#popBack").fadeIn("slow");

        return false;
    }
    function onChkDupLoginIDClick() {
        if ($("#txtSearchID").val() == "")
            return;
        $.ajax({
            type: "POST",
            url: "/getCheckDup.aspx?type=id&val=" + $("#txtSearchID").val(),
            dataType: "text",
            success: function (msg) {
                if (msg == "true") {
                    $("#popSearchID").css("display", "none");
                    $("#popChkID").fadeIn("slow");
                    $("#btn_newContent").css("display", "none");
                    $("#chkdupid-result").html('"' + $("#txtSearchID").val() + '" 는 사용하실수 없습니다.');
                } else {
                    $("#popSearchID").css("display", "none");
                    $("#popChkID").fadeIn("slow");
                    $("#chkdupid-result").html('"' + $("#txtSearchID").val() + '" 는 사용가능한 아이디입니다.');
                }
            }
        });

        return false;
    }
    function OnConfirmID() {
        $(".strLoginID").val($("#txtSearchID").val());
        closePopup();
    }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding-left:25px; background-color:#fff; height:100%">
        <table cellpadding="0" cellspacing="0" style="width:974px; background-color:#F6F6F6; border-top-style:solid;border-bottom-style:solid; ">
            <tr class="row_tr">
                <td class="field_cell">Master_id</td>
                <td class="value_cell"><asp:Literal ID="ltlMasterID" runat="server">M_00001</asp:Literal></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">회원가입일</td>
                <td class="value_cell"><asp:Literal ID="ltlRegdate" runat="server">2014.11.28</asp:Literal></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">아이디</td>
                <td class="value_cell">
                    <asp:TextBox ID="txtLoginID" CssClass="control strLoginID" MaxLength="20"  Width="300px" runat="server"></asp:TextBox>
                    <asp:Button ID="btnChkDuplicLoginID" runat="server"  CssClass="control"  Text="아이디 중복확인" OnClientClick="return OnSearchID()"></asp:Button>
                    <asp:RequiredFieldValidator ID="rfvLoginID" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                        ControlToValidate="txtLoginID"
                        ErrorMessage="<%$Resources:Err, ERR_LOGINID_INPUT %>"
                        Display="None"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revLoginID" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                        ControlToValidate="txtLoginID"
                        ErrorMessage="<%$Resources:Err, ERR_LOGINID_FORMAT %>"
                        Display="None"
                        ValidationExpression="<%$Resources:RegEx, REGEX_LOGINID %>"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">패스워드</td>
                <td class="value_cell">
                    <asp:TextBox ID="txtLoginPwd" CssClass="control" MaxLength="20" Width="300px" TextMode="Password" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvLoginPwd" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                        ControlToValidate="txtLoginPwd"
                        ErrorMessage="<%$Resources:Err, ERR_LOGINPWD_INPUT %>"
                        Display="None"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revLoginPwd" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                        ControlToValidate="txtLoginPwd"
                        ErrorMessage="<%$Resources:Err, ERR_LOGINPWD_FORMAT %>"
                        Display="None"
                        ValidationExpression="<%$Resources:RegEx, REGEX_LOGINPWD %>"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="rfvLoginPwdConfirm" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                        ControlToValidate="txtLoginPwdConfirm"
                        ErrorMessage="<%$Resources:Err, ERR_LOGINPWDCONF_INPUT %>"
                        Display="None"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvLoginPwdConfirm" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                        ControlToValidate="txtLoginPwdConfirm"
                        ControlToCompare="txtLoginPwd"
                        ErrorMessage="<%$Resources:Err, ERR_LOGINPWDCONF_FORMAT %>"
                        Display="None"></asp:CompareValidator>
                </td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">패스워드 확인</td>
                <td class="value_cell"><asp:TextBox ID="txtLoginPwdConfirm" CssClass="control" MaxLength="20" Width="300px" TextMode="Password" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">회사명(이름)</td>
                <td class="value_cell"><asp:TextBox ID="txtCompany" CssClass="control" MaxLength="50" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">사업자번호(주민번호뒷자리)</td>
                <td class="value_cell"><asp:TextBox ID="txtAuthNo" CssClass="control" MaxLength="20" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">주소</td>
                <td class="value_cell">
                    <asp:TextBox ID="txtAddress" CssClass="control" MaxLength="50" Width="300px" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSearchAddress" runat="server"  CssClass="control"  Text="주소검색"></asp:Button>
                </td>

            </tr>
            <tr class="row_tr">
                <td class="field_cell">담당자</td>
                <td class="value_cell"><asp:TextBox ID="txtOwner" CssClass="control" MaxLength="20" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">핸드폰</td>
                <td class="value_cell"><asp:TextBox ID="txtMobile" CssClass="control" MaxLength="20" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">회사전화</td>
                <td class="value_cell"><asp:TextBox ID="txtTel" CssClass="control" MaxLength="20" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">활용분야</td>
                <td class="value_cell">
                    <asp:DropDownList ID="ddlUseArea" CssClass="control" Width="200px" runat="server">
                        <asp:ListItem Value="0">출판</asp:ListItem>
                        <asp:ListItem Value="1">광고</asp:ListItem>
                        <asp:ListItem Value="2">업무</asp:ListItem>
                        <asp:ListItem Value="3">연구</asp:ListItem>
                        <asp:ListItem Value="4">서비스</asp:ListItem>
                        <asp:ListItem Value="5">보안</asp:ListItem>
                        <asp:ListItem Value="6">스포츠</asp:ListItem>
                        <asp:ListItem Value="개발"></asp:ListItem>
                        <asp:ListItem Value="8">교육</asp:ListItem>
                        <asp:ListItem Value="9">기타</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">테스트요청</td>
                <td class="value_cell">
                    <asp:CheckBox ID="chkboxTestReq" runat="server"></asp:CheckBox>
                    <asp:Literal ID="Literal1" runat="server" >테스트를 원하시면 체크하세요.</asp:Literal>
                </td>
            </tr>
            <tr class="row_tr">
                <td class="field_cell">메모</td>
                <td class="value_cell">
                    <asp:TextBox ID="txtComment" CssClass="control" MaxLength="100" Width="500px" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvBankNum" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                        ControlToValidate="txtLoginID"
                        ErrorMessage="<%$Resources:Err, ERR_LOGINPWD_FORMAT %>"
                        Display="None"></asp:RequiredFieldValidator>
                </td>

            </tr>
        </table>
        <div style="padding:50px; height:50px; text-align:center">
            <asp:ValidationSummary ID="vSummary01" runat="server" ValidationGroup="vGroup01"
                ShowMessageBox="true"
                ShowSummary="false"
                DisplayMode="BulletList" />
            <asp:Button ID="btnRegister" runat="server"  Text="등록" ValidationGroup="vGroup01"
                style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold; "
                onclick="btnRegister_Click" ></asp:Button>
        </div>

    </div>
    <div id="popChkID" class="clspopup" style="left: 500px; top: 250px; width: 400px; height: 190px; z-index:3000; font-family:맑은 고딕">
        <table width="390px" height="auto" border="0" cellpadding="0" cellspacing="0">
            <tr height="50px" style="font-size:14pt; font-weight:900">
                <td align="left"  >
                    아이디중복확인
                </td>
                <td  style="font-size:20pt;text-align: right;">
                    <a href="javascript:;" onclick="closePopup()">X</a>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height:1px; background-color:#000;"></td>
            </tr>
            <tr style="font-size:12pt" height="50px">
                <td colspan="2">
                    <span id="chkdupid-result"></span>
                </td>
            </tr>
            <tr height="90px">
                <td colspan="2" align="center">
                    <input type="button" ID="btn_newContent" value="사용하기" onclick="OnConfirmID()" style="width:183px; height:33px; font-size:12pt" />
                </td>
            </tr>
        </table>
        <input type="hidden" name="project_id" id="newcontent_projectid" value="" />
    </div>
    <div id="popSearchID" class="clspopup" style="left: 500px; top: 250px; width: 400px; height: 130px; z-index:3000; font-family:맑은 고딕">
        <table width="390px" height="auto" border="0" cellpadding="0" cellspacing="0">
            <tr height="50px" style="font-size:14pt; font-weight:900">
                <td align="left"  >
                    아이디중복확인
                </td>
                <td  style="font-size:20pt;text-align: right;">
                    <a href="javascript:;" onclick="closePopup()">X</a>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height:1px; background-color:#000;"></td>
            </tr>
            <tr style="font-size:12pt" height="85px">
                <td colspan="2">
                    <input id="txtSearchID" type="text" style="width:73%; height:28px; font-size:12pt; float:left"  />
                    <input type="button" id="btnSearchID" onclick="onChkDupLoginIDClick()" value="검색" style="width:25%; height:33px; font-size:12pt; float:right" ></input>
                </td>
            </tr>
        </table>
    </div>
    <div id="popBack"></div>
</asp:Content>
