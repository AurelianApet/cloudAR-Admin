<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true" CodeBehind="Notice.aspx.cs" Inherits="nocutAR.Account.Notice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .strContent 
        {
            background-color:transparent;
        }
    </style>
    <script>
        $(document).ready(function () {
            selTopMenu(1);
        });

        function onDetailNotice(title, content) {
            var content1 = $("#" + title).attr("title");
            content1 = content1.replace(/\n/g, "<br>");

            $("#spTitle").html($("#" + title).html());
            $("#spContent").html(content1);
            showPopup("dvNoticeDetail");
        }

        function replaceAll(find, replace, str) {
            return str.replace(new RegExp(find, 'g'), replace);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
    <table cellpadding="0" cellspacing="0" width="254">
        <tr>
            <td width="170" height="25" align="center" style="border-width:1px; border-color:rgb(201,206,208); border-style:solid;" >
                <asp:TextBox ID="txtSearchKey" CssClass="control clsSearchKey" MaxLength="20"  runat="server"></asp:TextBox>
            </td>
            <td width="84" height="27" align="center">
                <asp:Button runat="server" ID="btnSearch" Width="76" Height="27" 
                    CssClass="clsBigButton" Text="검색" onclick="btnSearch_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div>
<table cellpadding="0" cellspacing="0" width="1320" align="center" bgcolor="#F7F8F8" style="border-collapse:collapse;">
    <tr>
        <td width="1327" height="55" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;" valign="bottom">
            <table cellpadding="0" cellspacing="0" align="center" width="1263">
                <tr>
                    <td width="652" height="47">
                        <table cellpadding="0" cellspacing="0" width="630">
                            <tr>
                                <td width="26" height="37">&nbsp;</td>
                                <td width="115" height="37"><b><font face="돋움" color="#666666"><span style="font-size:12pt;">공지사항</span></font></b></td>
                                <td width="115" height="37">&nbsp;</td>
                                <td width="374" height="37">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td width="611" height="47" align="right">
                        <span style="font-size:11pt;"><b><font face="돋움" color="#666666"></font></b></span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="1327" height="339" valign="top" align="center" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
            <br /><br />
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
                        <ItemStyle HorizontalAlign="Center" Width="73px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="제목">
                        <ItemTemplate>
                            <span style="cursor:pointer" id='title_<%#Eval("id")%>' title='<%#Eval("notice")%>' onclick='onDetailNotice("title_<%#Eval("id")%>")'><%#cutString(Convert.ToString(Eval("title")),20)%></span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="317px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="내용">
                        <ItemTemplate>
                            <%#cutString(Convert.ToString(Eval("notice")),35)%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="555px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="날짜">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "regdate", "{0:yyyy-MM-dd HH:mm}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="142px" Wrap="false" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="clsGrid" Height="50px"/>
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
            <br /><br />
        </td>
    </tr>
</table>
</div>
<div id="dvNoticeDetail" class="clspopup" style="background-color:transparent">
<table cellpadding="0" cellspacing="0" width="500">
    <tr>
        <td width="25" height="330" align="right">
            <table cellpadding="0" cellspacing="0" width="20">
                <tr>
                    <td width="20" height="292" valign="top" align="right">
                        <img src="img/popup_cursor.png" width="14" height="26" border="0">
                    </td>
                </tr>
            </table>
        </td>
        <td width="473" height="330" style="background-color:White;border-width:1px; border-color:rgb(255,102,0); border-style:solid;" valign="top">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="433">
                <tr>
                    <td width="431" height="54" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="422">
                            <tr>
                                <td width="384" height="36"><b><font face="돋움" color="#4C4C4C"><span style="font-size:11pt;" id="spTitle"></span></font></b></td>
                                <td width="38" height="36" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="20" height="20" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="431" height="268" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="422">
                            <tr>
                                <td width="422" height="228" valign="top">
                                    <font face="돋움" color="#4C4C4C"><span style="font-size:11pt;" id="spContent"></span></font>
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
