<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="ProductMng.aspx.cs" Inherits="nocutAR.Manager.ProductMng" %>

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
            selTopMenu(2);
            $(".clsDDLProduct").attr("disabled", "disabled");
            $('input[name="imgview_rd"]:radio').change(
                function () {
                    if (this.value == '0') {
                        $(".clsDDLProduct").removeAttr("disabled");
                        setOrgInfo();
                    }
                    else if (this.value == '1') {
                        $(".clsDDLProduct").attr("disabled", "disabled");
                    }
                }
            );
            $("#<%= ddlOrgProductList.ClientID %>").change(
                function () {
                    setOrgInfo();
                }
            )

        });

        function setOrgInfo() {
            var strVals = $("#<%= ddlOrgProductList.ClientID %>").val();
            var arrVals = strVals.split(":");
            $("#<%=ddlMarkers.ClientID %> option[value='" + arrVals[1] + "']").prop('selected', true);
            $("#<%=ddlAPI.ClientID %> option[value='" + arrVals[3] + "']").prop('selected', true);
            $("#<%=ddlTraffic.ClientID %> option[value='" + arrVals[4] + "']").prop('selected', true);
            $("#<%=ddlLimitHard.ClientID %> option[value='" + arrVals[2] + "']").prop('selected', true);

            setCheck("<%= cbxVideo.ClientID%>", arrVals[5]);
            setCheck("<%= cbxWebSite.ClientID%>", arrVals[6]);
            setCheck("<%= cbxImageSlide.ClientID%>", arrVals[7]);
            setCheck("<%= cbxImage.ClientID%>", arrVals[8]);
            setCheck("<%= cbxChromakeyPhoto.ClientID%>", arrVals[9]);
            setCheck("<%= cbx3DObj.ClientID%>", arrVals[10]);
            setCheck("<%= cbxTel.ClientID%>", arrVals[11]);
            setCheck("<%= cbxGoogleMap.ClientID%>", arrVals[12]);
            setCheck("<%= cbxText.ClientID%>", arrVals[13]);
            setCheck("<%= cbxBGM.ClientID%>", arrVals[14]);
            setCheck("<%= cbxChromakeyVideo.ClientID%>", arrVals[15]);
            setCheck("<%= rdo3DTemp1.ClientID%>", arrVals[16]);
            var arrVal16 = arrVals[16]*1;
            setCheck("<%= rdo3DTemp2.ClientID%>", (arrVal16 + 1) % 2);
        }

    function OnAddProduct() {
        $("#hdProductID").val("0");
        $("#<%=txtProductName.ClientID %>").val("");
        $("#<%=txtProductTag.ClientID %>").val("");
        setCheck("<%= rdo3DTemp1.ClientID%>", 1);
        setCheck("<%= rdo3DTemp2.ClientID%>", 0);
        setCheck("<%= cbxVideo.ClientID%>", 0);
        setCheck("<%= cbxWebSite.ClientID%>", 0);
        setCheck("<%= cbxImage.ClientID%>", 0);
        setCheck("<%= cbxImageSlide.ClientID%>", 0);
        setCheck("<%= cbxBGM.ClientID%>", 0);
        setCheck("<%= cbxTel.ClientID%>", 0);
        setCheck("<%= cbxGoogleMap.ClientID%>", 0);
        setCheck("<%= cbxText.ClientID%>", 0);
        setCheck("<%= cbxChromakeyPhoto.ClientID%>", 0);
        setCheck("<%= cbxChromakeyVideo.ClientID%>", 0);
        setCheck("<%= cbx3DObj.ClientID%>", 0);
        setCheck("imgview_rd1", 0);
        setCheck("imgview_rd2", 1);
        $(".clsDDLProduct").attr("disabled", "disabled");
        $("#spTitle").html("상품추가");
        showPopup("dvAddProduct");
    }

    function setCheck(ctrl, value) {
        //value == 1 ? $('#' + ctrl).attr('checked', 'checked') : $('#' + ctrl).removeAttr('checked');
        $('#' + ctrl).prop('checked', value == 1); 
    }

    function OnDetailProduct(id, product_name, markers, hardused, traffic, api_requests, product_tag, three_template, video_obj ,web_obj,slide_obj,image_obj,capture_obj,three_model_obj,tel_obj,googlemap_obj,notepad_obj,bgm_obj,chromakey_obj) {
        $("#spTitle").html("상품관리");
        $("#hdProductID").val(id);
        $("#<%=txtProductName.ClientID %>").val(product_name);
        $("#<%=ddlMarkers.ClientID %> option[value='" + markers + "']").prop('selected', true);
        $("#<%=ddlAPI.ClientID %> option[value='" + api_requests + "']").prop('selected', true);
        $("#<%=ddlTraffic.ClientID %> option[value='" + traffic + "']").prop('selected', true);
        $("#<%=ddlLimitHard.ClientID %> option[value='" + hardused + "']").prop('selected', true);
        $("#<%=txtProductTag.ClientID %>").val(product_tag);

        setCheck("<%= rdo3DTemp1.ClientID%>", three_template);
        setCheck("<%= rdo3DTemp2.ClientID%>", (three_template+1)%2);
        setCheck("<%= cbxVideo.ClientID%>", video_obj);
        setCheck("<%= cbxWebSite.ClientID%>", web_obj);
        setCheck("<%= cbxImage.ClientID%>", image_obj);
        setCheck("<%= cbxImageSlide.ClientID%>", slide_obj);
        setCheck("<%= cbxBGM.ClientID%>", bgm_obj);
        setCheck("<%= cbxTel.ClientID%>", tel_obj);
        setCheck("<%= cbxGoogleMap.ClientID%>", googlemap_obj);
        setCheck("<%= cbxText.ClientID%>", notepad_obj);
        setCheck("<%= cbxChromakeyPhoto.ClientID%>", capture_obj);
        setCheck("<%= cbxChromakeyVideo.ClientID%>", chromakey_obj);
        setCheck("<%= cbx3DObj.ClientID%>", three_model_obj);
        setCheck("imgview_rd1", 0);
        setCheck("imgview_rd2", 1);
        $(".clsDDLProduct").attr("disabled", "disabled");
        showPopup("dvAddProduct");
    }

    function onRemoveProduct(id) {
        $("#hdRemoveID").val(id);
        showPopup("dvRemoveProduct");
    }

    function ValidateCheckBoxList(sender, args) {
        args.IsValid = ($('#<%= cbxVideo.ClientID%>').prop('checked') ||
            $('#<%= cbxWebSite.ClientID%>').prop('checked') ||
            $('#<%= cbxImage.ClientID%>').prop('checked') ||
            $('#<%= cbxImageSlide.ClientID%>').prop('checked') ||
            $('#<%= cbxBGM.ClientID%>').prop('checked') ||
            $('#<%= cbxTel.ClientID%>').prop('checked') ||
            $('#<%= cbxGoogleMap.ClientID%>').prop('checked') ||
            $('#<%= cbxText.ClientID%>').prop('checked') ||
            $('#<%= cbxChromakeyPhoto.ClientID%>').prop('checked') ||
            $('#<%= cbxChromakeyVideo.ClientID%>').prop('checked') ||
            $('#<%= cbx3DObj.ClientID%>').prop('checked'));
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
                        <td width="225" height="32" onclick="OnAddProduct()" align="center" style="border-width:1px; cursor:pointer; border-color:rgb(32,40,50); border-style:solid;">
                            <b><span style="font-size:10pt;"><font face="돋움" color="#A5A7AB">상품추가</font></span></b>
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
                                                    <span style="font-size:12pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;</b></font></span><b><font face="돋움" color="white"><span style="font-size:11pt;">상품관리</span></font></b>
                                                </td>
                                                <td width="486" height="37">
                                                    <div align="right">
                                                        &nbsp;
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
                                    <asp:TemplateField HeaderText="상품명">
                                        <ItemTemplate>
                                            <%#Eval("product_name")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="114px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="마커수">
                                        <ItemTemplate>
                                            <%#Eval("markers")%>개
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="105px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="하드사용용량(월)">
                                        <ItemTemplate>
                                            <%#Eval("hardused")%>G
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="136px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="트래픽(월)">
                                        <ItemTemplate>
                                            <%#Eval("traffic")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="128px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="API요청(월)">
                                        <ItemTemplate>
                                            <%#Eval("api_requests")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="144px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="상품태그">
                                        <ItemTemplate>
                                            <%#Eval("product_tag")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="108px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="3D템플릿">
                                        <ItemTemplate>
                                            <%# Convert.ToByte(Eval("three_template")) == 0 ? "사용안함" :"사용함" %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="103px" Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="관리">
                                        <ItemTemplate>
                                            <input type="button" style="width:54px;height:25px" class="clsButton" onclick='OnDetailProduct(<%#Eval("id") %>, "<%#Eval("product_name") %>",<%#Eval("markers") %>,<%#Eval("hardused") %>,<%#Eval("traffic") %>,<%#Eval("api_requests") %>,"<%#Eval("product_tag") %>",<%#Eval("three_template") %>,<%#Eval("video_obj") %>,<%#Eval("web_obj") %>,<%#Eval("slide_obj") %>,<%#Eval("image_obj") %>,<%#Eval("capture_obj") %>,<%#Eval("three_model_obj") %>,<%#Eval("tel_obj") %>,<%#Eval("googlemap_obj") %>,<%#Eval("notepad_obj") %>,<%#Eval("bgm_obj") %>,<%#Eval("chromakey_obj") %>)' value="관리"/>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="89px" Wrap="false" />
                                        <HeaderStyle BackColor="#E47478" ForeColor="white" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="상품삭제">
                                        <ItemTemplate>
                                            <input type="button" style="width:54px;height:25px" class="clsButton" onclick='onRemoveProduct(<%#Eval("id") %>)' value="삭제"/>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="81px" Wrap="false" />
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
    <div id="dvAddProduct" class="clspopup">
        <input type="hidden" id="hdProductID" name="hdProductID" value="0" />
        <table cellpadding="0" cellspacing="0" width="530" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="528" height="40" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#D8D8D8">
                    <table cellpadding="0" cellspacing="0" align="center" width="485">
                        <tr>
                            <td width="441" height="36"><b><font face="돋움" color="#4C4C4C"><span style="font-size:11pt;" id="spTitle">상품관리</span></font></b></td>
                            <td width="44" height="36" align="right">
                                <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="20" height="20" border="0" name="image1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="528" height="661" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" width="483" align="center">
                        <tr>
                            <td width="97" height="40" class="clsFont">
                                상품명*
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="vGroup04" CssClass="error-message"
                                    ControlToValidate="txtProductName"
                                    ErrorMessage="상품명을 입력해주세요."
                                    SetFocusOnError="True"
                                    Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                            <td width="385" height="40">
                                <asp:TextBox ID="txtProductName" runat="server" CssClass="txtbox" style="width:320px; height:25px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td width="97" height="40" class="clsFont">상품옵션*</td>
                            <td width="385" height="40">
                                <table cellpadding="0" cellspacing="0" width="377">
                                    <tr>
                                        <td width="185" height="30" class="clsFont">
                                            <input id="imgview_rd1" type="radio" name="imgview_rd" value="0"  />
                                            기존상품에서 선택
                                        </td>
                                        <td width="192" height="30">
                                            <asp:DropDownList ID="ddlOrgProductList" runat="server" Height="25px" CssClass="clsDDLProduct"
                                                Width="173px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="97" height="40">&nbsp;</td>
                            <td width="385" height="40">
                                <table cellpadding="0" cellspacing="0" width="377">
                                    <tr>
                                        <td width="185" height="30" class="clsFont">
                                            <input id="imgview_rd2" type="radio" name="imgview_rd" value="1"  checked/>
                                            신규등록
                                        </td>
                                        <td width="192" height="30">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="97" height="20">&nbsp;</td>
                            <td width="385" height="40">
                                <table cellpadding="0" cellspacing="0" width="377">
                                    <tr>
                                        <td width="185" height="30" class="clsFont">
                                            &nbsp;마커수 
                                            <asp:DropDownList ID="ddlMarkers" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="200개" Value="200"></asp:ListItem>
                                                <asp:ListItem Text="500개" Value="500"></asp:ListItem>
                                                <asp:ListItem Text="700개" Value="700"></asp:ListItem>
                                                <asp:ListItem Text="1000개" Value="1000"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td width="192" height="30" class="clsFont">
                                            API요청&nbsp;&nbsp;&nbsp; 
                                            <asp:DropDownList ID="ddlAPI" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="10000회" Value="10000"></asp:ListItem>
                                                <asp:ListItem Text="20000회" Value="20000"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>                     
                            </td>
                        </tr>
                        <tr>
                            <td width="97" height="20">&nbsp;</td>
                            <td width="385" height="40">
                                <table cellpadding="0" cellspacing="0" width="377">
                                    <tr>
                                        <td width="185" height="30" class="clsFont">
                                            &nbsp;트래픽 
                                            <asp:DropDownList ID="ddlTraffic" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="60G" Value="60"></asp:ListItem>
                                                <asp:ListItem Text="100G" Value="100"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td width="192" height="30" class="clsFont">
                                            하드용량&nbsp; 
                                            <asp:DropDownList ID="ddlLimitHard" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="10G" Value="10"></asp:ListItem>
                                                <asp:ListItem Text="20G" Value="20"></asp:ListItem>
                                                <asp:ListItem Text="30G" Value="30"></asp:ListItem>
                                                <asp:ListItem Text="50G" Value="50"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" width="482" align="center">
                        <tr>
                            <td width="97" height="40" class="clsFont">상품태그</td>
                            <td width="385" height="40">
                                <asp:TextBox ID="txtProductTag" CssClass="txtbox"  runat="server" style="width:320px; height:25px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td width="97" height="229" valign="top" class="clsFont">
                                기본콘텐츠
                                <asp:CustomValidator ID="CustomValidator1" ErrorMessage="한개 이상의 기본 컨텐츠를 선택하셔야 합니다."
                                    ValidationGroup="vGroup04"
                                    Display="Dynamic"
                                    Text="*"
                                    ForeColor="Red" ClientValidationFunction="ValidateCheckBoxList" runat="server" />
                            </td>
                            <td width="385" height="229">
                                <table cellpadding="0" cellspacing="0" width="376">
                                    <tr>
                                        <td width="48" height="35">
                                            <asp:CheckBox runat="server" ID="cbxVideo" />
                                        </td>
                                        <td width="140" height="35" class="clsFont">
                                            비디오
                                        </td>
                                        <td width="48" height="35">
                                            <asp:CheckBox runat="server" ID="cbxWebSite" />
                                        </td>
                                        <td width="140" height="35" class="clsFont">웹사이트</td>
                                    </tr>
                                    <tr>
                                        <td width="48" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;">
                                           <asp:CheckBox runat="server" ID="cbxImage" />
                                        </td>
                                        <td width="140" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;" class="clsFont">
                                            이미지
                                        </td>
                                        <td width="48" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;">
                                            <asp:CheckBox runat="server" ID="cbxImageSlide" />
                                        </td>
                                        <td width="140" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;" class="clsFont">이미지슬라이드</td>
                                    </tr>
                                    <tr>
                                        <td width="48" height="35">
                                            <asp:CheckBox runat="server" ID="cbxBGM" />
                                        </td>
                                        <td width="140" height="35" class="clsFont">BGM</td>
                                        <td width="48" height="35">
                                            <asp:CheckBox runat="server" ID="cbxTel" />
                                        </td>
                                        <td width="140" height="35" class="clsFont">전화</td>
                                    </tr>
                                    <tr>
                                        <td width="48" height="35">
                                            <asp:CheckBox runat="server" ID="cbxGoogleMap" />
                                        </td>
                                        <td width="140" height="35" class="clsFont">Google Map</td>
                                        <td width="48" height="35">
                                            <asp:CheckBox runat="server" ID="cbxText" />
                                        </td>
                                        <td width="140" height="35" class="clsFont">텍스트</td>
                                    </tr>
                                    <tr>
                                        <td width="48" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;">
                                            <asp:CheckBox runat="server" ID="cbxChromakeyPhoto" />
                                        </td>
                                        <td width="140" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;" class="clsFont">
                                            크로마키 포토
                                        </td>
                                        <td width="48" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;">
                                            <asp:CheckBox runat="server" ID="cbxChromakeyVideo" />
                                        </td>
                                        <td width="140" height="35" style="border-bottom-width:1px; border-bottom-color:rgb(219,219,219); border-bottom-style:solid;" class="clsFont">
                                            크로마키 비디오
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="48" height="17">
                                            <asp:CheckBox runat="server" ID="cbx3DObj" />
                                        </td>
                                        <td width="140" height="35" class="clsFont">3D object</td>
                                        <td width="48" height="35" class="clsFont">&nbsp;</td>
                                        <td width="140" height="35" class="clsFont">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="48" height="6"></td>
                                        <td width="140" height="6"></td>
                                        <td width="48" height="6"></td>
                                        <td width="140" height="6"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="97" height="40" class="clsFont">3D템플릿</td>
                            <td width="385" height="40">
                                <table cellpadding="0" cellspacing="0" width="377">
                                    <tr>
                                        <td width="185" height="30">
                                            <asp:RadioButton runat="server" ID="rdo3DTemp1" GroupName="rdo3DTemp" Checked="true" CssClass="clsFont" Text=" 사용함" />
                                        </td>
                                        <td width="192" height="30">
                                            <asp:RadioButton runat="server" ID="rdo3DTemp2" GroupName="rdo3DTemp" Checked="false" CssClass="clsFont" Text=" 사용안함" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black" width="512">
                        <tr>
                            <td width="512" height="78" valign="bottom">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vGroup04"
                                    ShowMessageBox="false"
                                    ShowSummary="true"
                                    CssClass="validation-summary-errors"
                                    DisplayMode="BulletList" Font-Size="8pt" ForeColor="Red" />
                                <div align="right">
                                <table cellpadding="0" cellspacing="0" width="234">
                                    <tr>
                                        <td width="113" height="48">
                                            &nbsp;
                                        </td>
                                        <td width="121" height="48">
                                            <asp:Button ID="btnOk" runat="server" CssClass="clsBigButton" Width="107px" 
                                                Height="33px" Text="등록" onclick="btnAddProductOK_Click" ValidationGroup="vGroup04" />
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
    <div id="dvRemoveProduct" class="clspopup">
        <input type="hidden" id="hdRemoveID" name="hdRemoveID" value="0" />
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="449" height="163" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" align="center" width="387">
                        <tr>
                            <td width="387" height="77" align="center">
                                <font face="돋움" color="#666666"><span style="font-size:12pt;"><b>선택하신 상품이 삭제됩니다.</b></span></font><br/><br/>
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
