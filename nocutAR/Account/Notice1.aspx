<%@ Page Title="Notice" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true" CodeBehind="Notice1.aspx.cs" Inherits="nocutAR.Account.Notice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script>
    $(document).ready(function () {
        selTopMenu(1);
    });
    function OnDblCLick(param1) {
        var content1 = $("#notice_" + param1).attr("title");
        content1 = content1.replace(/\n/g, "<br>");
        $("#notice_content").html(content1);
        $("#notice_title").html($("#title_" + param1).attr("title"));
        $("#pop_NoticeDetail").fadeIn("slow");
        $("#popBack").css({
            "opacity": "0.2"
        });
        $("#popBack").fadeIn("slow");
        //alert(id);
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div style="padding-left:25px; background-color:#fff; height:100%">
        <table cellpadding="0" cellspacing="0" style="width:974px; background-color:#F6F6F6; height:54px; border-color:#d2d2d2; border-top:2px solid;border-bottom:1px solid;">
            <tr align="center" style="font-family:HY중고딕;font-size:12pt; color:#000">
                <td class="topfield_cell" width="78px">번호</td>
                <td class="topfield_cell" width="240px">제목</td>
                <td class="topfield_cell" width="500px">내용</td>
                <td class="topfield_cell" width="126px">날짜</td>
            </tr>
        </table>
        <asp:GridView ID="gvContent" runat="server" CellPadding="0" CellSpacing="0"
            AllowPaging="true" AllowSorting="false"
            Width="974px"
            GridLines="Horizontal"
            ShowHeader="false"
            AutoGenerateColumns="false"
            CssClass="grdContent"
            OnPageIndexChanging="gvContent_PageIndexChange"
             onrowdatabound="gvContent_RowDataBound"
             onrowcreated="gvContent_RowCreated">
            <Columns>
                <asp:TemplateField>
                    <ItemStyle Width="78px" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%#Container.DataItemIndex + 1%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemStyle Width="240px" HorizontalAlign="Center" Font-Bold="true" />
                    <ItemTemplate>
                        <span id='title_<%#Eval("id")%>' title='<%#Eval("title")%>'><%#cutString(Convert.ToString(Eval("title")), 20)%></span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemStyle Width="500px" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <div id='notice_<%#Eval("id")%>' title='<%#Eval("notice")%>'><%#cutString(Convert.ToString(Eval("notice")),35)%></div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="regdate" DataFormatString="{0:yyyy-MM-dd}"
                    ItemStyle-Width="126px" ItemStyle-HorizontalAlign="Center" />
            </Columns>
            <RowStyle Height="52px" />
            <HeaderStyle Height="28px" BackColor="#cccccc" Font-Bold="true" />
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
     </div>
     <div id="pop_NoticeDetail" class="clspopup" style=" left:50%; top:50%; margin-top:-100px; margin-left:-200px; width: 400px; height: auto; z-index:3000; font-family:맑은 고딕">
        <table width="390px" height="auto" border="0" cellpadding="0" cellspacing="0">
            <tr height="50px" style="font-size:14pt; font-weight:900">
                <td align="left"  >
                    <div style="word-break:break-all" id="notice_title"></div>
                </td>
                <td  style="padding-left:20px;font-size:20pt; text-align: right;" valign="top">
                    <a href="javascript:;" onclick="closePopup()" >X</a>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height:1px; background-color:#000;"></td>
            </tr>
            <tr style="font-size:12pt" height="50px">
                <td colspan="2" style="padding-right:30pt">
                    <div style="word-break:break-all; overflow-y:auto; max-height:300px; padding-left:30px; padding-bottom:30px" id="notice_content"></div>
                </td>
            </tr>
        </table>
     </div>
</asp:Content>
