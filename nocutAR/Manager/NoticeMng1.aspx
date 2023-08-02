<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="NoticeMng1.aspx.cs" Inherits="nocutAR.Manager.NoticeMng" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script>
    $(document).ready(function () {
        selTopMenu(4);

        $("#isReg").val("1");
        $("#iid").val("");

        $(".strTitle").val("");
        $(".strContent").val("");

        $(".strContent").on('keyup', function () {
            if ($(this).val().length + $(this).val().split(/\n/g).length >= 300) {
                alert("300자이상 입력할수 없습니다.");
                $(this).val($(this).val().substr(0, 300 - $(this).val().split(/\n/g).length + 1));
                return;
            }
        });
    });
    function OnDblCLick(param1) {
        $("#isReg").val("0");
        $("#iid").val(param1);
        $(".btnRegister").val("수정");
        $(".strTitle").val($("#title_" + param1).attr("title"));
        $(".strContent").val($("#notice_" + param1).attr("title"));

        //alert(id);
    }

    function OnCancel() {
        $(".btnRegister").val ("등록");
        $("#isReg").val("1");
        $("#iid").val("");
        $(".strTitle").val("");
        $(".strContent").val("");
    }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding-left:25px; background-color:#fff; height:100%">
        <div style="height:460px">
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="txtTitile" runat="server" CssClass="control strTitle" Width="940px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvBankNum" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                                    ControlToValidate="txtTitile"
                                    ErrorMessage="제목을 입력해주십시오."
                                    Display="None"></asp:RequiredFieldValidator>
                        <input id="iid" name="iid" type="hidden" />
                        <input id="isReg" name="isReg" type="hidden" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtContent" runat="server" CssClass="control strContent" Width="940px" Height="295px" TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                                    ControlToValidate="txtContent"
                                    ErrorMessage="내용을 입력해주십시오."
                                    Display="None"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <asp:ValidationSummary ID="vSummary01" runat="server" ValidationGroup="vGroup01"
                            ShowMessageBox="true"
                            ShowSummary="false"
                            DisplayMode="BulletList" />
                        <asp:Button ID="btnRegister" runat="server"  Text="등록" ValidationGroup="vGroup01" CssClass="btnRegister"
                            style="height:50px; width:100px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold;"
                            onclick="btnRegister_Click" ></asp:Button>&nbsp;
                        <asp:Button ID="btnCancel" runat="server"  Text="취소"  OnClientClick="return OnCancel()"
                            style="height:50px; width:100px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold; "
                            ></asp:Button>&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div>
        <table cellpadding="0" cellspacing="0" style="width:974px; background-color:#F6F6F6; height:54px; border-top-style:solid;border-bottom-style:solid;">
            <tr align="center" style="font-family:HY중고딕;font-size:12pt;">
                <td class="topfield_cell" width="78px">번호</td>
                <td class="topfield_cell" width="240px">제목</td>
                <td class="topfield_cell" width="430px">내용</td>
                <td class="topfield_cell" width="120px">날짜</td>
                <td class="topfield_cell" width="75px">
                    <asp:Button ID="btnDelSelected" runat="server"  CssClass="control" Width="85px"
                            Text="삭제" onclick="btnDelSelected_Click" OnClientClick="return confirm('선택하신 항목이 삭제 됩니다. 정말로 삭제 하시겠습니까?');"  ></asp:Button>
                </td>
            </tr>
        </table>
        <asp:GridView ID="gvContent" runat="server" CellPadding="0" CellSpacing="0"
            AllowPaging="true" AllowSorting="false"
            Width="974px"
            GridLines="Horizontal"
            ShowHeader="false"
            AutoGenerateColumns="false"
            OnRowCreated="gvContent_RowCreated"
            OnRowDataBound="gvContent_RowDataBound"
            OnPageIndexChanging="gvContent_PageIndexChange" CssClass="grdContent">
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
                        <span id='title_<%#Eval("id")%>' title='<%#Eval("title")%>'><%#cutString(Convert.ToString(Eval("title")),20)%></span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemStyle Width="430px" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <div id='notice_<%#Eval("id")%>' title='<%#Eval("notice")%>'><%#cutString(Convert.ToString(Eval("notice")),35)%></div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="regdate" DataFormatString="{0:yyyy-MM-dd HH:mm}"
                    ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField>
                    <ItemStyle Width="75px" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <input type="checkbox" style="height: auto;" name="chkDel" value='<%#Eval("id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

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
    </div>
</asp:Content>
