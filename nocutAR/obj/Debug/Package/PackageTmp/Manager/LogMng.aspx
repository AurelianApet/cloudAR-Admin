<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="LogMng.aspx.cs" Inherits="nocutAR.Manager.LogMng" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        selTopMenu(3);

    });


</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="0" width="1320" bgcolor="white">
        <tr>
            <td width="250" height="100%" bgcolor="#2B3541" valign="top" align="center">
                &nbsp;
                <table cellpadding="0" cellspacing="0" width="225" bgcolor="#A5A7AB" style="border-collapse:collapse;">
                    <tr>
                        <td width="225" height="32" align="center" style="border-width:1px; border-color:rgb(32,40,50); border-style:solid;">
                            <b><span style="font-size:10pt;"><font face="돋움">로그관리</font></span></b>
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
                        <td width="976" height="813" valign="top" align="center">
                            &nbsp;
                            <table cellpadding="0" cellspacing="0" bgcolor="#4E5867" width="1010">
                                <tr>
                                    <td width="1010" height="45">
                                        <table cellpadding="0" cellspacing="0" align="center" width="983">
                                            <tr>
                                                <td width="497" height="37">
                                                    <span style="font-size:12pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;</b></font></span><b><font face="돋움" color="white"><span style="font-size:11pt;">로그관리</span></font></b>
                                                </td>
                                                <td width="486" height="37">
                                                    <div align="right">
                                                    <table cellpadding="0" cellspacing="0" width="323">
                                                        <tr>
                                                            <td width="72" height="31">
                                                                <asp:DropDownList ID="ddlSearchKey" CssClass="control" Width="72px" runat="server">
                                                                    <asp:ListItem Value="0">회사(고객명)</asp:ListItem>
                                                                    <asp:ListItem Value="1">로그인ID</asp:ListItem>
                                                                    <asp:ListItem Value="2">담당자</asp:ListItem>
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
                                    <asp:TemplateField HeaderText="로그인ID">
                                        <ItemTemplate>
                                            <%#Convert.ToInt32(Eval("ulevel")) == 10 ? "master": Eval("loginid") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="153px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="접속IP">
                                        <ItemTemplate>
                                            <%#Eval("user_ip") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="191px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="회사(고객)명">
                                        <ItemTemplate>
                                            <%#Eval("company") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="173px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="이벤트">
                                        <ItemTemplate>
                                            <%#Eval("event") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="193px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="이벤트시간">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "regdate", "{0:yyyy/MM/dd hh:mm:ss}")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="298px" Wrap="false" />
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
                        </td>
                    </tr>
                </table>
            &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
