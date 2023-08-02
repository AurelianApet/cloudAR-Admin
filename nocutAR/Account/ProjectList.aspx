<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true" CodeBehind="ProjectList.aspx.cs" Inherits="nocutAR.Account.ProjectList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        selTopMenu(2);
        $(".clsaccheader").click(function () {
            var nID = $(this).attr("id").split("_")[1];

             if ($("#divContents" + nID).css("display") == "none")
                $("#divContents" + nID).slideDown();
             else
                $("#divContents" + nID).slideUp();
        });
     });
     function onAddContent(project_id) {
         $("#newcontent_projectid").val(project_id);
         $(".clsContentName").val("");
         $("#isNew").val(1);
         $("#modifiy_contentid").val("");

         $("#input_div").fadeIn("slow");
         $("#popBack").css({
            "opacity": "0.7"
            });
         $("#popBack").fadeIn("slow");
         $("#newcontent_name").focus();
         $(".clsContentName").focus();
     }
     function addProject() {
         $(".clsProjectName").val("");
         $("#isNewProject").val(1);
         $("#modify_projectid").val("");
         $("#pop_addItem").fadeIn("slow");
         $("#popBack").css({
             "opacity": "0.7"
         });
         $("#popBack").fadeIn("slow");
         $(".clsProjectName").focus();
     }

     function onModifyContent(content_id) {
         $(".clsContentName").val($("#contentname_" + content_id).html());
         $("#isNew").val(0);
         $("#modifiy_contentid").val(content_id);

         $("#input_div").fadeIn("slow");
         $("#popBack").css({
             "opacity": "0.7"
         });
         $("#popBack").fadeIn("slow");
         $(".clsContentName").focus();
         return false;
     }
     function onModifyProject(project_id) {
         $(".clsProjectName").val($("#projectname_" + project_id).html());
         $("#isNewProject").val(0);
         $("#modify_projectid").val(project_id);

         $("#pop_addItem").fadeIn("slow");
         $("#popBack").css({
             "opacity": "0.7"
         });
         $("#popBack").fadeIn("slow");
         $(".clsProjectName").focus();

         return false;
     }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding-left:25px; padding-right:25px;">
        <div style="background-color:#fff; height:58px; border-top:solid 1px; font-weight:800" >
            <br />
            <span class="addcontent_menu" onclick="addProject()">프로젝트추가+</span>
        </div>
        <asp:Repeater ID="rptProjects" runat="server"
            onitemdatabound="rptProjects_ItemDataBound"
            onitemcommand="rptProjects_ItemCommand">
        <ItemTemplate>
            <div>
                <div class="clsaccheader" id='clsaccheader_<%#Eval("id") %>' title='<%#Eval("title") %>'>
                    <span id='projectname_<%#Eval("id")%>'><%# cutString(Convert.ToString(Eval("title")),35)%></span>
                    <span style="font-size:11pt; color:#AAAAAA" ><br /><%# Eval("regdate")%></span>
                    <div style="float:right">
                        <asp:ImageButton CssClass="clseditbtn" ID="btnEdit" runat="server" ImageUrl="~/img/btnedit.png" OnClientClick='<%#"return onModifyProject(" + Convert.ToString(Eval("id")) + ")"%>' />
                        <asp:ImageButton CssClass="clseditbtn" ID="btnDel" runat="server" ImageUrl="~/img/btndelete.png" OnClientClick="return confirm('프로젝트를 삭제 하시겠습니까? 프로젝트를 삭제하시면 아래의 캠페인도 모두 삭제 됩니다. 정말로 삭제 하시겠습니까? ');"  OnClick="onDeleteProject"  CommandArgument='<%# Eval("id")%>'/>
                    </div>
                </div>
                <div class="clsacccontent" style="display:none"  id='divContents<%#Eval("id") %>'>
                    <span class="addcontent_menu" onclick="onAddContent(<%# Eval("id")%>)">켐페인추가+</span>
                    <asp:Repeater ID="rptContents" runat="server">
                        <ItemTemplate>
                            <div class="contentbox">
                                <asp:ImageButton ID="btnEdit" CssClass="clsMarkerPreview" runat="server" ImageUrl='<%#"../markers/" + Convert.ToString(Eval("marker_url")) %>' OnClick="onEditContent" CommandArgument='<%# Eval("id")%>' style="width:162px; height:116px; float:left" />
                                <div style="float:left; padding-left:24px;">
                                    <div style="font-size:19pt; color:#000; font-family:맑은 고딕 " title='<%#Eval("title") %>'><span id='contentname_<%#Eval("id")%>'><%# cutString(Convert.ToString(Eval("title")),25)%></span></div>
                                    <span style="font-size:11pt; color:#AAAAAA"><%# Eval("regdate")%><br /><br /></span>
                                    <asp:ImageButton CssClass="clseditbtn" ID="btnEditName" runat="server" ImageUrl="~/img/btnedit.png" OnClientClick='<%#"return onModifyContent(" + Convert.ToString(Eval("id")) + ")"%>' />
                                    <asp:ImageButton CssClass="clseditbtn" ID="btnDel" runat="server" ImageUrl="~/img/btndelete.png" OnClick="onDeleteContent" OnClientClick="return confirm('삭제하시겠습니까?');" CommandArgument='<%# Eval("id")%>'  />
                                    <asp:ImageButton CssClass="clseditbtn" ID="btnSave" runat="server" ImageUrl="~/img/btnsave.png" OnClick="onSaveContent" Visible="false" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>
        </ItemTemplate>
        </asp:Repeater>

    </div>
    <div id="input_div" class="clspopup" style="left: 500px; top: 250px; width: 400px; height: 130px; z-index:3000;">
        <table width="390px" height="auto" border="0" cellpadding="0" cellspacing="0">
            <tr height="50px" style="font-size:14pt; font-weight:900">
                <td align="left" >
                    새로운 켐페인 명을 입력하세요.
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
                    <asp:Panel ID="AddCampaignPanel" runat="server" DefaultButton="btn_newContent">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="vGroup02" CssClass="error-message"
                            ControlToValidate="txtContentName"
                            Font-Size="8pt"
                            ErrorMessage="켐페인명을 입력해주세요."
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtContentName" CssClass="clsContentName" runat="server" style="width:73%; height:28px; font-size:12pt; float:left" ></asp:TextBox>
                        <asp:Button ID="btn_newContent" runat="server" Text="확인" style="width:25%; height:33px; font-size:12pt; "
                            onclick="btn_newContent_Click" ValidationGroup="vGroup02" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vGroup02"
                            ShowMessageBox="false"
                            ShowSummary="false"
                            DisplayMode="BulletList" />
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <input type="hidden" name="project_id" id="newcontent_projectid" value="" />
        <input type="hidden" name='content_id' id="modifiy_contentid" value=""/>
        <input type="hidden" name="isNew" id="isNew" value="1" />
    </div>
    <div id="pop_addItem" class="clspopup" style="left: 500px; top: 250px; width: 400px; height: 130px; z-index:3000; font-family:맑은 고딕">
        <table width="390px" height="auto" border="0" cellpadding="0" cellspacing="0">
            <tr height="50px" style="font-size:14pt; font-weight:900">
                <td align="left"  >
                    프로젝트명을 입력해주세요.
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
                     <asp:Panel ID="AddProjectPanel" runat="server" DefaultButton="btnOK">
                        <asp:RequiredFieldValidator ID="rfvProjectName" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                            ControlToValidate="txtProjectName"
                            Font-Size="8pt"
                            ErrorMessage="프로젝트명을 입력해주세요."
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtProjectName" CssClass="clsProjectName" runat="server" style="width:73%; height:28px; font-size:12pt; float:left"></asp:TextBox>
                        <asp:ValidationSummary ID="vSummary01" runat="server" ValidationGroup="vGroup01"
                            ShowMessageBox="false"
                            ShowSummary="false"
                            DisplayMode="BulletList" />
                        <asp:Button ID="btnOK" runat="server" Text="확인" style="width:25%; height:33px; font-size:12pt; "
                            onclick="btn_newProject_Click" ValidationGroup="vGroup01" />
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <input type="hidden" name='modify_projectid' id="modify_projectid" value=""/>
        <input type="hidden" name="isNewProject" id="isNewProject" value="1" />
    </div>

</asp:Content>
