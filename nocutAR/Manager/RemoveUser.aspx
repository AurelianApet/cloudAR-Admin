<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Account.master" AutoEventWireup="true" CodeBehind="RemoveUser.aspx.cs" Inherits="nocutAR.Manager.RemoveUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="javascript" type="text/jscript">
        $(document).ready(function () {
            selTopMenu(1);
            selLeftMenu(4);
        });
        function onRemoveUser(id) {
            $("#hdRemoveUserID").val(id);
            showPopup("dvRemove");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
    <table cellpadding="0" cellspacing="0" bgcolor="#4E5867" width="1010">
        <tr>
            <td width="1010" height="45">
                <table cellpadding="0" cellspacing="0" align="center" width="983">
                    <tr>
                        <td width="497" height="37">
                            <p><span style="font-size:12pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;</b></font></span><b><font face="돋움" color="white"><span style="font-size:11pt;">관리자 리스트</span></font></b></p>
                        </td>
                        <td width="486" height="37">
                            <div align="right">
                            <table cellpadding="0" cellspacing="0" width="323">
                                <tr>
                                    <td width="72" height="31" align="right">
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
            <asp:TemplateField HeaderText="상태">
                <ItemTemplate>
                    <asp:Literal ID="ltrStatus" runat="server">
                    </asp:Literal>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="58px" Wrap="false" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="회사(고객)명">
                <ItemTemplate>
                    <%#Eval("company") %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="127px" Wrap="false" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="로그인ID">
                <ItemTemplate>
                    <%#Eval("loginid") %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="100px" Wrap="false" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="담당자">
                <ItemTemplate>
                    <%#Eval("owner") %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="83px" Wrap="false" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="연락처">
                <ItemTemplate>
                    Tel  : <%#Eval("telephone") %>
                    <br></br>Email: <%#Eval("email") %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="186px" Wrap="false" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="계약기간">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "contract_start", "{0:yyyy/MM/dd}")%>
                    <br></br>
                    ~<%# DataBinder.Eval(Container.DataItem, "contract_end", "{0:yyyy/MM/dd}")%>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="157px" Wrap="false" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="이용상품">
                <ItemTemplate>
                    <%#Eval("use_productname") %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="107px" Wrap="false" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="삭제">
                <ItemTemplate>
                    <input type="button" style="width:125px;height:26px" class="clsButton" onclick='onRemoveUser(<%#Eval("id") %>)' value="삭제"/>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="190px" Wrap="false" />
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
    </div>
    <div id="dvRemove" class="clspopup">
        <input type="hidden" id="hdRemoveUserID" name="hdRemoveUserID" value="0" />
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="449" height="163" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" align="center" width="387">
                        <tr>
                            <td width="387" height="77" align="center">
                                <font face="돋움" color="#666666"><span style="font-size:12pt;"><b>선택하신 계정이 삭제됩니다.</b></span></font><br/><br/>
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
                                            <asp:Button ID="btnOk" runat="server" CssClass="clsBigButton" Width="107px" 
                                                Height="33px" Text="삭제" onclick="btnOk_Click" />
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
