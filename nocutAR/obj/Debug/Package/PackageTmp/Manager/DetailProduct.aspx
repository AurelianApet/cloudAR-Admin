<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailProduct.aspx.cs" Inherits="nocutAR.Manager.DetailProduct" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>상품관리</title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../Scripts/jquery-1.11.2.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/popup.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=9"/>
    <asp:Literal ID="ltlScript" runat="server" Text="" ></asp:Literal>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $('input[name="imgview_rd"]:radio').change(
                function () {
                    if (this.value == '0') {
                        $(".clsDDLProduct").removeAttr("disabled");
                    }
                    else if (this.value == '1') {
                        $(".clsDDLProduct").attr("disabled", "disabled");
                    }
            });
        });

    </script>
</head>
<body style="background-color:#fff">
    <form id="form1" runat="server">
    <div style="width:500px; height:530px; display:block;font-family:맑은 고딕;color: Black;">
        <table width="500px" height="auto" border="0" cellpadding="0" cellspacing="0">
            <tr height="60px" style="font-size:14pt; font-weight:900">
                <td align="left"  >
                    상품관리
                </td>
            </tr>
            <tr>
                <td style="height:1px; background-color:#000;"></td>
            </tr>
            <tr>
                <td style="height:10px;"></td>
            </tr>
            <tr style="height:250px" >
                <td style="height:250px;">
                    <table style="width:100%; height:250px">
                        <tr style="font-size:9pt; height:33px">
                            <td style="padding-left:35px;">
                                상품명
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="vGroup04" CssClass="error-message"
                                    ControlToValidate="txtProductNameA"
                                    ErrorMessage="중복된 상품명입니다."
                                    SetFocusOnError="True"
                                    Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                            <td >
                                <asp:TextBox ID="txtProductNameA" runat="server" CssClass="txtbox" style="width:320px; height:25px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:60px">
                            <td style="padding-left:35px">
                                상품옵션
                            </td>
                            <td >
                                <table style="width:320px">
                                    <tr>
                                        <td>
                                            <input id="imgview_rd1" type="radio" name="imgview_rd" value="0" checked />기존상품에서 선택
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:DropDownList ID="ddlOrgProductList" runat="server" Height="25px" AutoPostBack="true" CssClass="clsDDLProduct"
                                                Width="173px" onselectedindexchanged="ddlOrgProductList_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <input id="imgview_rd2" type="radio" name="imgview_rd" value="1" />신규등록
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                             마커수
                                             <asp:DropDownList ID="ddlMarkers" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="200개" Value="200"></asp:ListItem>
                                                <asp:ListItem Text="500개" Value="500"></asp:ListItem>
                                                <asp:ListItem Text="700개" Value="700"></asp:ListItem>
                                                <asp:ListItem Text="1000개" Value="1000"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="text-align: right;">
                                            하드용량
                                            <asp:DropDownList ID="ddlLimitHard" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="10G" Value="10"></asp:ListItem>
                                                <asp:ListItem Text="20G" Value="20"></asp:ListItem>
                                                <asp:ListItem Text="30G" Value="30"></asp:ListItem>
                                                <asp:ListItem Text="50G" Value="50"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            트래픽
                                            <asp:DropDownList ID="ddlTraffic" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="60G" Value="60"></asp:ListItem>
                                                <asp:ListItem Text="100G" Value="100"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="text-align: right;">
                                            API요청
                                            <asp:DropDownList ID="ddlAPI" runat="server" Height="25px" Width="95px">
                                                <asp:ListItem Text="10000회" Value="10000"></asp:ListItem>
                                                <asp:ListItem Text="20000회" Value="20000"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:33px">
                            <td style="padding-left:35px">
                                상품태그
                            </td>
                            <td>
                                <asp:TextBox ID="txtProductTag" CssClass="txtbox"  runat="server" style="width:320px; height:25px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:33px">
                            <td style="padding-left:35px">
                                기본 컨텐츠
                                <asp:CustomValidator ID="CustomValidator1" ErrorMessage="한개 이상의 기본 컨텐츠를 선택하셔야 합니다."
                                ValidationGroup="vGroup04"
                                Display="Dynamic"
                                Text="*"
                                ForeColor="Red" ClientValidationFunction="ValidateCheckBoxList" runat="server" />
                            </td>
                            <td class="tdchk">
                                <asp:CheckBoxList ID="chkObjects" CssClass="clschklist" runat="server"
                                    RepeatColumns="2" RepeatDirection="Horizontal"
                                    CellPadding="2" Width="100%" CellSpacing="2"  >
                                    <asp:ListItem Text="비디오" />
                                    <asp:ListItem Text="웹" />
                                    <asp:ListItem Text="이미지"/>
                                    <asp:ListItem Text="캡쳐"/>
                                </asp:CheckBoxList>
                                <asp:CheckBoxList ID="chkObjects2" CssClass="clschklist" runat="server"
                                    RepeatColumns="2" RepeatDirection="Horizontal"
                                    CellPadding="2" Width="100%" CellSpacing="2" >
                                    <asp:ListItem Text="3D모델" />
                                    <asp:ListItem Text="전화" />
                                    <asp:ListItem Text="Google" />
                                    <asp:ListItem Text="텍스트" />
                                    <asp:ListItem Text="BGM" />
                                    <asp:ListItem Text="크로마키" />
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:33px">
                            <td style="padding-left:35px">
                                3D 템플릿
                            </td>
                            <td >
                                <asp:RadioButtonList ID="rdThreeTemplate" runat="server" RepeatDirection="Horizontal" Width="300px">
                                    <asp:ListItem Text="사용함" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="사용안함" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height:50px">
                <td style="padding-left:150px" >
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vGroup04"
                        ShowMessageBox="false"
                        ShowSummary="true"
                        DisplayMode="BulletList" Font-Size="8pt" ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <td align="right" style="padding-right:35px">
                    <input type="button" value="취소" style="width:62px; height:33px; font-size:12pt; "
                        onclick="closeDivPop()" />
                    <asp:Button ID="btnModProductOK" runat="server" Text="확인" style="width:62px; height:33px; font-size:12pt; "
                        onclick="btnModProductOK_Click" OnClientClick="return confirm('상품을 바꾸시겠습니까?');" />
                </td>
            </tr>
        </table>
    </div>

    </form>
</body>
</html>
