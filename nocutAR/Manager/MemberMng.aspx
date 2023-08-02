<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Account.Master" AutoEventWireup="true" CodeBehind="MemberMng.aspx.cs" Inherits="nocutAR.Manager.MemberMng" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            selTopMenu(1);
            selLeftMenu(1);
        });
    function onChkDupLoginIDClick() {
        if ($("#txtSearchID").val() == "")
            return;
        $.ajax({
            type: "POST",
            url: "/getCheckDup.aspx?type=id&val=" + $("#txtSearchID").val(),
            dataType: "text",
            success: function (msg) {
                if (msg == "true") {
                    closeSearchPop();
                    $("#popChkID").fadeIn("slow");
                    $("#btn_newContent").css("display", "none");
                    $("#chkdupid-result").html('"' + $("#txtSearchID").val() + '" 는 사용하실수 없습니다.');
                } else {
                    closeSearchPop();
                    $("#popChkID").fadeIn("slow");
                    $("#chkdupid-result").html('"' + $("#txtSearchID").val() + '" 는 사용가능한 아이디입니다.');
                }
            }
        });

        return false;
    }
    function OnConfirmID() {
        $(".strLoginID").val($("#txtSearchID").val());
        closeConfirmPop();

    }
    function closeSearchPop() {
        $("#popSearchID").fadeOut("slow");
    }
    function closeConfirmPop() {
        $("#popChkID").fadeOut("slow");
    }

    /*이용현황*/
    function OnShowUsedStatus(id, company, markers, usemakers, api_requests, usescans, traffic, usetraffic, hardused, usedhard) {
        $("#spCompany").html(company);
        $("#spMarkers").html(usemakers + "개 / " + markers + "개");

        $("#tdScans_div").html(usescans + "회/ " + api_requests + "회");
        var use_hard = (usedhard/1024).toFixed(3);
        var use_traffic = (usetraffic/1024).toFixed(3);
        $("#tdUseHard_div").html(use_hard + "G/ " + hardused + "G");
        $("#tdTraffic_div").html(use_traffic + "G/ " + traffic + "G");


        $("#tdScans").css("width", 323 * usescans / api_requests);
        $("#tdUseHard").css("width", 323 * use_hard / hardused);
        $("#tdTraffic").css("width", 323 * use_traffic / traffic);

        //api요청,하드용량,트래픽 프로그레스바 최대크기를 고정
        $("#tdScans").css("max-width", "323px");
        $("#tdUseHard").css("max-width", "323px");
        $("#tdTraffic").css("max-width", "323px");
        
        $("#detailUserid").val(id);
       showPopup("trafficstatus_div");
    }

    function onShowDetail() {
        window.location.href = "trafficdetail.aspx?id=" + $("#detailUserid").val();
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
                            <span style="font-size:12pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;</b></font></span><b><font face="돋움" color="white"><span style="font-size:11pt;">관리자 리스트</span></font></b>
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
            <asp:TemplateField HeaderText="이용현황">
                <ItemTemplate>
                    <input type="button" style="width:54px;height:25px" class="clsButton" onclick='OnShowUsedStatus(<%#Eval("id") %>, "<%#Eval("company") %>", <%#Eval("markers") %>, <%#Eval("usemakers") %>, <%#Eval("api_requests") %>, <%#Eval("usescans") %>, <%#Eval("traffic") %>, <%#Eval("usetraffic") %>, <%#Eval("hardused") %>, <%#Eval("usedhard") %>)' value="확인"/>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="95px" Wrap="false" />
                <HeaderStyle BackColor="#E47478" ForeColor="white" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="정보수정">
                <ItemTemplate>
                    <input type="button" style="width:54px;height:25px" class="clsButton" onclick='onModify(<%#Eval("id") %>, "<%#Eval("company") %>","<%#Eval("loginid") %>","<%#getRealPassword(Eval("loginpwd")) %>","<%#Eval("owner") %>","<%#Eval("telephone") %>","<%#Eval("email") %>","<%#Eval("use_product") %>","<%#Eval("contract_start") %>","<%#Eval("contract_end") %>")' value="수정" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="95px" Wrap="false" />
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

    <div id="popChkID" class="clspopup" style="left: 500px; top: 250px; width: 400px; height: 190px; z-index:3000; font-family:맑은 고딕">
        <table width="390px" height="auto" border="0" cellpadding="0" cellspacing="0">
            <tr height="50px" style="font-size:14pt; font-weight:900">
                <td align="left"  >
                    아이디중복확인
                </td>
                <td  style="font-size:20pt;text-align: right;">
                    <a href="javascript:;" onclick="closeConfirmPop()">X</a>
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
                    <a href="javascript:;" onclick="closeSearchPop()">X</a>
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
    <div id="trafficstatus_div" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="530" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="528" height="40" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#D8D8D8">
                    <table cellpadding="0" cellspacing="0" align="center" width="485">
                        <tr>
                            <td width="441" height="36"><b><font face="돋움" color="#4C4C4C"><span style="font-size:11pt;">이용현황</span></font></b></td>
                            <td width="44" height="36" align="right">
                                <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="20" height="20" border="0" name="image1">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="528" height="333" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" width="482" align="center">
                        <tr>
                            <td width="157" height="40"><span style="font-size:11pt;"><font face="돋움" color="#666666">회사명</font></span></td>
                            <td width="325" height="40"><span style="font-size:11pt;"><font face="돋움" color="#666666"><b><span id="spCompany"></sapn></b></font></span></td>
                        </tr>
                        <tr>
                            <td width="157" height="40"><span style="font-size:11pt;"><font face="돋움" color="#666666">등록된 마커</font></span></td>
                            <td width="325" height="40"><span style="font-size:11pt;"><font face="돋움" color="#666666"><b><span id="spMarkers"></sapn></b></font></span></td>
                        </tr>
                        <tr>
                            <td width="157" height="35"><span style="font-size:11pt;"><font face="돋움" color="#666666">API요청(금월)</font></span></td>
                            <td width="325" height="35">
                                <table cellpadding="0" cellspacing="0" width="323" style="border-collapse:collapse;">
                                    <tr>
                                        <td width="323" height="15" style="border-width:1px; border-color:rgb(191,192,195); border-style:solid;">
                                            <table id="tdScans" cellpadding="0" cellspacing="0" width="226">
                                                <tr>
                                                    <td width="100%" height="15" bgcolor="#BFC0C3"></td>
                                                    <span style="font-size:11pt;"><font face="돋움" color="#666666"><b><div id="tdScans_div" align="center" style="height:0px;"></div></b></font></span>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="157" height="35"><span style="font-size:11pt;"><font face="돋움" color="#666666">사용중인 하드용량</font></span></td>
                            <td width="325" height="35">
                                <table cellpadding="0" cellspacing="0" width="323" style="border-collapse:collapse;">
                                    <tr>
                                        <td width="323" height="15" style="border-width:1px; border-color:rgb(191,192,195); border-style:solid;">
                                            <table id="tdUseHard" cellpadding="0" cellspacing="0" width="173" >
                                                <tr>
                                                    <td width="100%" height="15" bgcolor="#BFC0C3"></td>
                                                    <span style="font-size:11pt;"><font face="돋움" color="#666666"><b><div id="tdUseHard_div" align="center" style="height:0px;"></div></b></font></span>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="157" height="35"><span style="font-size:11pt;"><font face="돋움" color="#666666">사용된 트레픽(금월)</font></span></td>
                            <td width="325" height="35">
                                <table cellpadding="0" cellspacing="0" width="323" style="border-collapse:collapse;">
                                    <tr>
                                        <td width="323" height="15" style="border-width:1px; border-color:rgb(191,192,195); border-style:solid;">
                                            <table id="tdTraffic" cellpadding="0" cellspacing="0" width="141">
                                                <tr>
                                                    <td width="100%" height="15" bgcolor="#BFC0C3"></td>
                                                    <span style="font-size:11pt;"><font face="돋움" color="#666666"><b><div id="tdTraffic_div" align="center" style="height:0px;"></div></b></font></span>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black">
                        <tr>
                            <td width="518" height="70" valign="bottom">
                                <table cellpadding="0" cellspacing="0" width="186" bgcolor="#33B5E5" align="center">
                                    <tr>
                                        <td width="186" height="40" align="center" class="clsBigButton" onclick="onShowDetail()">
                                            이용현황 상세
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input type="hidden" id="detailUserid"  value="0" />
    </div>
</asp:Content>
