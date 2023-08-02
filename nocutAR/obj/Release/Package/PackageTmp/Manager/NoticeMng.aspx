<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="NoticeMng.aspx.cs" Inherits="nocutAR.Manager.NoticeMng" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .clsFont 
    {
        font-size:11pt;
        font-family:돋움;
        color:#666666;
    }
</style>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            selTopMenu(4);
        });

        function OnAddNotice() {
            $("#hdNoticeID").val("0");
            $("#<%=txtTitile.ClientID %>").val("");
            $("#<%=txtContent.ClientID %>").val("");
            $("#spTitle").html("공지사항 추가");
            showPopup("dvAddNotice");
        }

        function OnDetailNotice(id) {
            $("#spTitle").html("공지사항 관리");
            $("#hdNoticeID").val(id);
            $("#<%=txtTitile.ClientID %>").val($("#title_" + id).html());
            $("#<%=txtContent.ClientID %>").val($("#title_" + id).attr("title"));
            showPopup("dvAddNotice");
        }

        function onRemoveNotice(id) {
            $("#hdRemoveID").val(id);
            showPopup("dvRemoveNotice");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div>
    <table cellpadding="0" cellspacing="0" width="1320" bgcolor="white">
        <tr>
            <td width="250" height="100%" bgcolor="#2B3541" valign="top" align="center">
                &nbsp;
                <table cellpadding="0" cellspacing="0" width="225" bgcolor="#3F4956" style="border-collapse:collapse;">
                    <tr>
                        <td width="225" height="32" onclick="OnAddNotice()" align="center" style="border-width:1px; cursor:pointer; border-color:rgb(32,40,50); border-style:solid;">
                            <b><span style="font-size:10pt;"><font face="돋움" color="#A5A7AB">공지사항추가</font></span></b>
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="240" height="20"></td>
                    </tr>
                </table>
                &nbsp;
            </td>
            <td width="1070" height="100%" bgcolor="#EFEFEF">
                <table cellpadding="0" cellspacing="0" width="1020" align="center">
                    <tr>
                        <td width="976" height="915" valign="top" align="center">
                            &nbsp;
                            <table cellpadding="0" cellspacing="0" bgcolor="#4E5867" width="1010">
                                <tr>
                                    <td width="1010" height="45">
                                        <table cellpadding="0" cellspacing="0" align="center" width="983">
                                            <tr>
                                                <td width="497" height="37">
                                                    <span style="font-size:12pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;</b></font></span><b><font face="돋움" color="white"><span style="font-size:11pt;">공지사항 리스트</span></font></b>
                                                </td>
                                                <td width="486" height="37">
                                                    <div align="right">
                                                    <table cellpadding="0" cellspacing="0" width="323">
                                                        <tr>
                                                            <td width="72" height="31">
                                                                <asp:DropDownList ID="ddlSearchKey" CssClass="control" Width="72px" runat="server">
                                                                    <asp:ListItem Value="title">제목</asp:ListItem>
                                                                    <asp:ListItem Value="content">내용</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td width="170" height="31" align="center">
                                                                <asp:TextBox ID="txtSearchKey" CssClass="control" MaxLength="20"  Width="170px" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td width="81" height="31">
                                                                <table cellpadding="0" cellspacing="0" width="76" bgcolor="#33B5E5" align="center">
                                                                    <tr>
                                                                        <td width="76" height="22" align="center">
                                                                            <asp:Button ID="btnSearch" runat="server"  CssClass="clsButton" Width="76px" Text="검색" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="1010">&nbsp;</td>
                                </tr>
                            </table>
                            <asp:GridView ID="gvContent" runat="server" CellPadding="0" CellSpacing="0"
                                AllowPaging="true" AllowSorting="false"
                                Width="1008px"
                                GridLines="None"
                                AutoGenerateColumns="false"
                                OnRowDataBound="gvContent_RowDataBound"
                                OnPageIndexChanging="gvContent_PageIndexChange" CssClass="clsGrid">
                                <Columns>
                                    <asp:TemplateField HeaderText="번호">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="56px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="제목">
                                        <ItemTemplate>
                                            <span id='title_<%#Eval("id")%>' title='<%#Eval("notice")%>' >
                                                <%#cutString(Convert.ToString(Eval("title")),20)%>
                                            </span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="203px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="내용">
                                        <ItemTemplate>
                                            <%#cutString(Convert.ToString(Eval("notice")),35)%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="425px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="날짜">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "regdate", "{0:yyyy-MM-dd HH:mm}")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="152px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="갱신">
                                        <ItemTemplate>
                                            <input type="button" style="width:54px;height:25px" class="clsButton" onclick='OnDetailNotice(<%#Eval("id") %>)' value="갱신"/>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="84px" Wrap="false" />
                                        <HeaderStyle BackColor="#E47478" ForeColor="white" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="삭제">
                                        <ItemTemplate>
                                            <input type="button" style="width:54px;height:25px" class="clsButton" onclick='onRemoveNotice(<%#Eval("id") %>)' value="삭제"/>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="88px" Wrap="false" />
                                        <HeaderStyle BackColor="#E47478" ForeColor="white" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="clsGrid" Height="50px" />
                                <SelectedRowStyle CssClass="clsSelGrid" Height="50px" />
                                <AlternatingRowStyle CssClass="clsSelGrid" />
                                <HeaderStyle CssClass="clsGridHeader" Height="35px"/>
                                <EmptyDataRowStyle VerticalAlign="Middle" />
                                <EmptyDataTemplate>
                                    <table width="100%" border="0">
                                    <tr>
                                        <td class="clsemptyrow" style="height: 350px">
                                            <asp:Literal ID="Literal1" runat="server" Text="<%$Resources:Str, STR_NODATA %>"></asp:Literal>
                                        </td>
                                    </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <PagerSettings Mode="Numeric" Position="Bottom"
                                    FirstPageText="<%$Resources:Str, STR_FIRST %>"
                                    PreviousPageText="<%$Resources:Str, STR_PREV %>"
                                    NextPageText="<%$Resources:Str, STR_NEXT %>"
                                    LastPageText="&nbsp;<%$Resources:Str, STR_LAST %>"
                                    PageButtonCount="10" />
                                <PagerStyle CssClass="clspager" HorizontalAlign="Center" />
                            </asp:GridView>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            &nbsp;
            </td>
        </tr>
    </table>
</div>
    <div id="dvAddNotice" class="clspopup">
        <input type="hidden" id="hdNoticeID" name="hdNoticeID" value="0" />
        <table cellpadding="0" cellspacing="0" width="656" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="654" height="40" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#D8D8D8">
                    <table cellpadding="0" cellspacing="0" align="center" width="642">
                        <tr>
                            <td width="441" height="36"><b><font face="돋움" color="#4C4C4C"><span style="font-size:11pt;" id="spTitle">공지사항 추가</span></font></b></td>
                            <td width="201" height="36" align="right">
                                <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="20" height="20" border="0" name="image1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="654" height="394" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" width="603" align="center">
                        <tr>
                            <td width="55" height="40">
                                <span style="font-size:11pt;"><font face="돋움" color="#666666">제목</font></span>
                                <asp:RequiredFieldValidator ID="rfvBankNum" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                                    ControlToValidate="txtTitile"
                                    ErrorMessage="제목을 입력해주십시오."
                                    Display="None"></asp:RequiredFieldValidator>
                            </td>
                            <td width="548" height="40">
                                <asp:TextBox ID="txtTitile" runat="server" CssClass="control strTitle" Width="540px" MaxLength="255"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td width="55" height="237" valign="top">
                                <span style="font-size:11pt;"><font face="돋움" color="#666666">내용</font></span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                                    ControlToValidate="txtContent"
                                    ErrorMessage="내용을 입력해주십시오."
                                    Display="None"></asp:RequiredFieldValidator>
                            </td>
                            <td width="548" height="237">                        
                                <asp:TextBox ID="txtContent" runat="server" CssClass="control strContent" Width="540px" Height="195px" TextMode="MultiLine" MaxLength="300"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black" align="center">
                        <tr>
                            <td width="518" height="70" valign="bottom">
                                <asp:ValidationSummary ID="vSummary01" runat="server" ValidationGroup="vGroup01"
                                    ShowMessageBox="true"
                                    ShowSummary="false"
                                    DisplayMode="BulletList" />
                                <table cellpadding="0" cellspacing="0" width="234" align="center">
                                    <tr>
                                        <td width="113" height="48">
                                            <input type="button" class="clsBigButton" value="취소" style="width:107px; height:33px; background-color:#7F7F7F"
                                                onclick="closePopup()" />
                                        </td>
                                        <td width="121" height="48">
                                            <asp:Button ID="btnAddNoticeOK" runat="server" Text="등록" CssClass="clsBigButton" style="width:107px; height:33px;"
                                                onclick="btnAddNoticeOK_Click" ValidationGroup="vGroup01" />
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
    <div id="dvRemoveNotice" class="clspopup">
        <input type="hidden" id="hdRemoveID" name="hdRemoveID" value="0" />
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="449" height="163" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" align="center" width="387">
                        <tr>
                            <td width="387" height="77" align="center">
                                <font face="돋움" color="#666666"><span style="font-size:12pt;"><b>선택하신 공지사항이 삭제됩니다.</b></span></font><br/><br/>
                                <font face="돋움" color="#666666"><span style="font-size:12pt;"><b>정말로 삭제하시겠습니까?</b></span></font>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black" width="419" align="center">
                        <tr>
                            <td width="419" height="59" valign="bottom">
                                <div align="right">
                                <table cellpadding="0" cellspacing="0" width="234">
                                    <tr>
                                        <td width="113" height="48">
                                            <input type="button" style="width:107px;height:33px; background-color:#7F7F7F;" class="clsBigButton" value="취소" onclick="closePopup()" />
                                        </td>
                                        <td width="121" height="48">
                                            <asp:Button ID="btnRemoveOk" runat="server" CssClass="clsBigButton" Width="107px" 
                                                Height="33px" Text="삭제" onclick="btnRemoveOk_Click" />
                                        </td>
                                    </tr>
                                </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
