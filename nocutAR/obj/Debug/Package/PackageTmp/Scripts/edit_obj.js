$(function () {
    $(".clsColorBtn").mousedown(function () {
        $(".clsColorBtn").removeClass("clsColorBtnSel");
        $(this).addClass("clsColorBtnSel");
    });
    $(".clsColorBtnCopy").mousedown(function () {
        $(".clsColorBtnCopy").removeClass("clsColorBtnSel");
        $(this).addClass("clsColorBtnSel");
    });
    $(".clsModeBtn").mousedown(function () {
        $(".clsModeBtn").removeClass("clsColorBtnSel");
        $(this).addClass("clsColorBtnSel");
    });
    $(".clsBoardType").mousedown(function () {
        $(".clsBoardType").removeClass("clsBoardTypeSel");
        $(this).addClass("clsBoardTypeSel");
    });
    //            $(".clsBoardType").mouseout(function () {
    //                $(this).removeClass("clsBoardTypeSel").addClass("clsBoardType");
    //            });
    $(".clsSlideEmpty").mouseover(function () {
        $(this).find("span").html("+");
    });
    $(".clsSlideEmpty").mouseout(function () {
        $(this).find("span").html("");
    });
    $(".clsCaptureEmpty").mouseover(function () {
        $(this).find("span").html("+");
    });
    $(".clsCaptureEmpty").mouseout(function () {
        $(this).find("span").html("");
    });
    $(".rdbCapture").change(function () {
        if ($('.rdbCapture').find('input')[0].checked) {
            $('.clsCustomCaptureMode').css("display", "none");
            $('.clsNorCaptureMode').css("display", "");
        }
        else {
            $('.clsCustomCaptureMode').css("display", "");
            $('.clsNorCaptureMode').css("display", "none");
        }
    });
    $(".rdbWeb1").change(function () {
        if ($('.rdbWeb1').find('input')[0].checked) {
            $('.trNorWebMode').css("display", "");
            $('.trCustomWebMode').css("display", "none");
        }
        else {
            $('.trNorWebMode').css("display", "none");
            $('.trCustomWebMode').css("display", "");
        }
    });
    $(".rdbTel1").change(function () {
        if ($('.rdbTel1').find('input')[0].checked) {
            $('.trNorTelMode').css("display", "");
            $('.trCustomTelMode').css("display", "none");
        }
        else {
            $('.trNorTelMode').css("display", "none");
            $('.trCustomTelMode').css("display", "");
        }
    });
    $(".rdbGoogle1").change(function () {
        if ($('.rdbGoogle1').find('input')[0].checked) {
            $('.trNorGoogleMode').css("display", "");
            $('.trCustomGoogleMode').css("display", "none");
        }
        else {
            $('.trNorGoogleMode').css("display", "none");
            $('.trCustomGoogleMode').css("display", "");
        }
    });
    $(".rdbBGM1").change(function () {
        //$('#audio_file_text').val('');
        if ($('.rdbBGM1').find('input')[0].checked) {
            // 버튼 표시안함
            $('.trShowBGMMode').css("display", "none");
            $('.trCustomeBGMMode').css("display", "none");
        }
        else if ($('.rdbBGM1').find('input')[1].checked) {
            // 기본 버튼
            $('.trShowBGMMode').css("display", "");
            //$('.tblNorBGMMode').css("display", "");
            $('.trCustomBGMMode').css("display", "none");
            //$('.tblCustomBGMMode').css("display", "none");
        }
        else {
            // 커스텀 버튼
            $('.trShowBGMMode').css("display", "none");
            //$('.tblNorBGMMode').css("display", "none");
            //$('.tblCustomBGMMode').css("display", "");
            $('.trCustomBGMMode').css("display", "");
        }
    });
});

function onSelItem(id) {
    if ($("#leftmenu" + id).hasClass("leftmenu")) {
        for (var i = 1; i < 12; i++) {
            $("#leftmenu" + i).addClass("leftmenu").removeClass("leftmenu_sel");
        }
        $("#leftmenu" + id).removeClass("leftmenu").addClass("leftmenu_sel");
    }

    counter++;
    dropflag = 1;

    var empty_obj = "<div class='tempclass' style='width:192px; height:131px; position:absolute; min-height:60px;min-width:98px'>";
    empty_obj += "<div class='emptyobject' >";
    empty_obj += "<table cellpadding='0' cellspacing='0' width='100%' height='100%' align='center' style='border-collapse:collapse;'>";
    empty_obj += "	<tr>";
    empty_obj += "		<td width='100%' height='100%' align='center' valign='middle' bgcolor='#E7E7E7' style='border-width:1px; border-color:rgb(193,193,193); border-style:solid;'>                                                            ";
    empty_obj += "			<span >Video</span>";
    empty_obj += "		</td>";
    empty_obj += "	</tr>";
    empty_obj += "</table>";
    empty_obj += "</div>"

    var empty_obj2 = "<div class='tempclass' style='width:190px; height:40px; position:absolute;'>";
    empty_obj2 += "<div class='tempcontent' >";
    empty_obj2 += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
    empty_obj2 += "	<tr>";
    empty_obj2 += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
    empty_obj2 += "			<table cellpadding='0' cellspacing='0' width='175'>";
    empty_obj2 += "				<tr>";
    empty_obj2 += "					<td width='35' height='27' align='right'>";
    empty_obj2 += "						<img src='img/cam_icon09.png' width='19' height='19' border='0'>";
    empty_obj2 += "					</td>";
    empty_obj2 += "					<td width='140' height='27' align='center'>";
    empty_obj2 += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' >Chroma-key photo</span></font></b>";
    empty_obj2 += "					</td>";
    empty_obj2 += "				</tr>";
    empty_obj2 += "			</table>";
    empty_obj2 += "		</td>";
    empty_obj2 += "	</tr>";
    empty_obj2 += "</table>";
    empty_obj2 += "</div>";

    /*var panel_obj = "<div class='panel'>";
    panel_obj += "		<table cellpadding='0' cellspacing='0' align='center' width='100%'>";
    panel_obj += "			<tr>";
    panel_obj += "				<td width='30%' height='26' align='left'>";
    panel_obj += "					<img class='delete-btn' src='img/cam_icon_trash.png' width='18' height='21' border='0' name='image3'>";
    panel_obj += "				</td>";
    panel_obj += "				<td width='30%' height='26' align='center'>";
    panel_obj += "					<img class='3d-btn' src='img/cam_icon12_3d.png' width='25' height='21' border='0'>";
    panel_obj += "				</td>";
    panel_obj += "				<td width='30%' height='26' align='right'>";
    panel_obj += "					<img class='edit-btn' src='img/cam_icon_pen.png' width='18' height='21' border='0' name='image4'>";
    panel_obj += "				</td>";
    panel_obj += "			</tr>";
    panel_obj += "		</table>";
    panel_obj += "</div>";
    panel_obj += "</div>";*/

    /*var element = $(ui.draggable).clone();
    element.addClass("tempclass");*/

    switch (id) {
        case 1:
            //비디오
            empty_obj += panel_obj;
            jQuery(empty_obj).appendTo("#editframe");
            video_counter++;
            $(".tempclass").attr("id", "video_" + video_counter);
            $(".tempclass" + " span").html("비디오");
            $("#video_" + video_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#video_" + video_counter;
            break;
        case 2:
            //이미지
            empty_obj += panel_obj;
            jQuery(empty_obj).appendTo("#editframe");
            img_counter++;
            $(".tempclass").attr("id", "img_" + img_counter);
            $(".tempclass" + " span").html("이미지");
            $("#img_" + img_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#img_" + img_counter;
            break;
        case 3:
            //웹싸이트
            empty_obj2 += panel_obj;
            jQuery(empty_obj2).appendTo("#editframe");
            web_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon03.png");
            $(".tempcontent" + " span").html("Website");

            $(".tempclass").attr("id", "web_" + web_counter);
            $("#web_" + web_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#web_" + web_counter;
            break;
        case 4:
            //폰
            empty_obj2 += panel_obj;
            jQuery(empty_obj2).appendTo("#editframe");
            tel_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon04.png");
            $(".tempcontent" + " span").html("Phone number");
            $(".tempclass").attr("id", "tel_" + tel_counter);
            $("#tel_" + tel_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#tel_" + tel_counter;
            break;
        case 5:
            //구글맵
            empty_obj2 += panel_obj;
            jQuery(empty_obj2).appendTo("#editframe");

            googlemap_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon05.png");
            $(".tempcontent" + " span").html("Google map");
            $(".tempclass").attr("id", "googlemap_" + googlemap_counter);
            $("#googlemap_" + googlemap_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#googlemap_" + googlemap_counter;
            break;
        case 6:
            //텍스트
            empty_obj2 += panel_obj;
            jQuery(empty_obj2).appendTo("#editframe");

            notepad_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon06.png");
            $(".tempcontent" + " span").html("TEXT");
            $(".tempclass").attr("id", "notepad_" + notepad_counter);
            $("#notepad_" + notepad_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#notepad_" + notepad_counter;
            break;
        case 7:
            //배경음
            empty_obj2 += panel_obj;
            jQuery(empty_obj2).appendTo("#editframe");

            audio_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon07.png");
            $(".tempcontent" + " span").html("BGM");
            $(".tempclass").attr("id", "audio_" + audio_counter);
            $("#audio_" + audio_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#audio_" + audio_counter;
            break;
        case 8:
            //이미지슬라이드
            empty_obj += panel_obj;
            jQuery(empty_obj).appendTo("#editframe");
            slide_counter++;
            $(".tempclass").attr("id", "slide_" + slide_counter);
            $(".tempclass" + " span").html("이미지슬라이드");
            $("#slide_" + slide_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#slide_" + slide_counter;
            break;
        case 9:
            //캡쳐
            empty_obj2 += panel_obj;

            jQuery(empty_obj2).appendTo("#editframe");
            capture_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon09.png");
            $(".tempcontent" + " span").html("Chroma-key photo");
            $(".tempclass").attr("id", "capture_" + capture_counter);
            $("#capture_" + capture_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#capture_" + capture_counter;

            break;
        case 10:
            //크로마키비디오
            empty_obj += panel_obj;
            jQuery(empty_obj).appendTo("#editframe");

            chromakey_counter++;
            $(".tempclass").attr("id", "chromakey_" + chromakey_counter);
            $(".tempclass" + " span").html("Chroma-key video");
            $("#chromakey_" + chromakey_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#chromakey_" + chromakey_counter;
            break;
        case 11:
            //3DObj
            var angle = $("#front_angle").val();

            element = '<div id="temp" style="min-width:61px; min-height:55px;width:122px; height:110px; position:absolute">';
            //element += '<img style="width:100%; height:100%" src="img/3Dobject.png"></img>';

            if ((1 <= angle && angle <= 22) || (338 <= angle && angle <= 360)) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_360.png"></img>';
            } else if (23 <= angle && angle <= 67) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_45.png"></img>';
            } else if (68 <= angle && angle <= 112) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_90.png"></img>';
            } else if (113 <= angle && angle <= 157) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_135.png"></img>';
            } else if (158 <= angle && angle <= 202) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_180.png"></img>';
            } else if (203 <= angle && angle <= 247) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_225.png"></img>';
            } else if (248 <= angle && angle <= 292) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_270.png"></img>';
            } else if (293 <= angle && angle <= 337) {
                element += '<img style="width:100%; height:100%" src="img/3Dobject_315.png"></img>';
            }
			//패널추가
            empty_obj += panel_obj;

            jQuery(empty_obj).appendTo("#editframe");
            three_counter++;
            $(".tempclass").attr("id", "three_" + three_counter);
            $("#three_" + three_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#three_" + three_counter;
            break;
    }
    $(".tempclass").removeClass("tempclass");
    $(".tempcontent").removeClass("tempcontent");

    $(objName).css({ "left": $("#editframe").width() / 2 - $(objName).width() / 2, "top": $("#editframe").height() / 2 - $(objName).height() / 2, "z-index": counter + 1 });
    $(objName).draggable({
        containment: "parent"
    });
    if (id == 1 || id == 2 || id == 10 || id == 11) {
        $(objName).resizable({
            aspectRatio: true,
            containment: "parent"
        });
    }
    add_DoubleClickEvent();
}


function onAddDVCaptureItem(index, slide, width, height, posX, posY, unitX, unitY) {
    onSetDVCaptureItem(index, slide);
    if (slide != "") {
        var capsize_img = '<div id="controlcapprev' + index + '" style="position: absolute; width: 75px; height: 75px;">' +
                            '<img style="width:100%; height:100%"  src="' + slide + '" />' +
                            '</div>';
        jQuery(capsize_img).appendTo("#capture_detail_div");
        $("#controlcapprev" + index).css({ "width": width * unitX, "height": height * unitY });
        $("#controlcapprev" + index).css({ "left": posX * unitX, "top": posY * unitY });
        n_selectedprev = "#controlcapprev" + index;
        //capprevdrag(index);
        dragdrop2();
        capdropflag = 1;
    }
}

function onSetDVSlideItem(index, url) {
    if (url != "") {
        $("#tdSlide" + index + "Empty").css("display", "none");
        $("#tdSlide" + index + "Image").css("display", "");
        $("#tdSlide" + index + "Image " + ".slideImg").attr("src", url);
    }
    else {
        $("#tdSlide" + index + "Empty").css("display", "");
        $("#tdSlide" + index + "Image").css("display", "none");
        $("#tdSlide" + index + "Image " + ".slideImg").attr("src", url);
    }
}
function onSetDVCaptureItem(index, url) {
    if (url != "") {
        $("#tdCapture" + index + "Empty").css("display", "none");
        $("#tdCapture" + index + "Image").css("display", "");
        $("#capimgPrev" + index).attr("src", url);
    }
    else {
        $("#tdCapture" + index + "Empty").css("display", "");
        $("#tdCapture" + index + "Image").css("display", "none");
        $("#capimgPrev" + index).attr("src", url);
    }
}


function add_DoubleClickEvent() {
    //double click event 구현
    var dataToPass = { objid: "This is what I wanted to say" };
    var objectid;
    $(".dragged_object").click(dataToPass, function (event) {
        //해당 오브젝트밑의 패널만 보이게 한다.
        objectid = event.currentTarget.id;

        if ($("#" + objectid + " .panel").css("display") == "none") {
            showPanel(event.currentTarget.id);
            // 3d방식의 초기값을 설정한다.
            if (objectid.indexOf("video_") == 0) {
                var index = objectid.substr(6);
                $("#video_rd1")[0].checked = true;
                if (videoList[index] != null) {
                    if (videoList[index].type == 0)
                        $("#video_rd1")[0].checked = true;
                    else if (videoList[index].type == 1)
                        $("#video_rd2")[0].checked = true;
                    else if (videoList[index].type == 2)
                        $("#video_rd3")[0].checked = true;
                }
            }
            else if (objectid.indexOf("tel_") == 0) {
                var index = objectid.substr(4);
                $("#rdTel1")[0].checked = true;
                if (telList[index] != null) {
                    if (telList[index].threemode == 0)
                        $("#rdTel1")[0].checked = true;
                    else
                        $("#rdTel2")[0].checked = true;
                }
            }
            else if (objectid.indexOf("web_") == 0) {
            }
            else if (objectid.indexOf("img_") == 0) {
                var index = objectid.substr(4);
                $("#imgview_rd1")[0].checked = true;
                if (imgList[index] != null) {
                    if (imgList[index].type == 0)
                        $("#imgview_rd1")[0].checked = true;
                    else
                        $("#imgview_rd2")[0].checked = true;
                }
            }
            else if (objectid.indexOf("slide_") == 0) {
                var index = objectid.substr(6);
                $('.rdoSlideViewType').find('input')[0].checked = true;
                if (slideList[index] != null) {
                    $('.rdoSlideViewType').find('input')[slideList[index].type].checked = true;
                }

                onSetDVSlideItem(1, "");
                onSetDVSlideItem(2, "");
                onSetDVSlideItem(3, "");
                onSetDVSlideItem(4, "");
                onSetDVSlideItem(5, "");
                onSetDVSlideItem(6, "");
                onSetDVSlideItem(7, "");
                onSetDVSlideItem(8, "");
                onSetDVSlideItem(9, "");
                onSetDVSlideItem(10, "");

            }
            else if (objectid.indexOf("capture_") == 0) {
                var index = objectid.substr(8);
                $('.rdbCapture').find('input')[0].checked = true;
                $('.clsCustomCaptureMode').css("display", "none");
                $('.clsNorCaptureMode').css("display", "");

                onSetDVCaptureItem(1, ""); $("#controlcapprev1").remove();
                onSetDVCaptureItem(2, ""); $("#controlcapprev2").remove();
                onSetDVCaptureItem(3, ""); $("#controlcapprev3").remove();
                onSetDVCaptureItem(4, ""); $("#controlcapprev4").remove();
                onSetDVCaptureItem(5, ""); $("#controlcapprev5").remove();

            }
            else if (objectid.indexOf("three_") == 0) {
            }
            else if (objectid.indexOf("googlemap_") == 0) {
            }
            else if (objectid.indexOf("notepad_") == 0) {
                var index = objectid.substr(8);
                $("#notepad_rd1")[0].checked = true;
                if (notepadList[index] != null) {
                    if (notepadList[index].view == 0)
                        $("#notepad_rd1")[0].checked = true;
                    else
                        $("#notepad_rd2")[0].checked = true;
                }
            }
            else if (objectid.indexOf("audio_") == 0) {
                var index = objectid.substr(6);
                $("#audiobtn_rd1")[0].checked = true;
                if (audioList[index] != null) {
                    if (audioList[index].type == 0) {
                        $("#audiobtn_rd1")[0].checked = true;
                    }
                    else if (audioList[index].type == 1) {
                        $("#audiobtn_rd2")[0].checked = true;
                    }
                    else if (audioList[index].type == 2) {
                        $("#audiobtn_rd3")[0].checked = true;
                    }
                }
            }
            else if (objectid.indexOf("chromakey_") == 0) {
            }
        }
    });
    $(".delete-btn").click(objectid, function (event) {
        //alert("deleted");

        $("#del_objectid").val(objectid);
        showPopup("delpopup");
    });
    $(".3d-btn").click(objectid, function (event) {
        objName = "#" + objectid;
        if (objectid.indexOf("video_") == 0) {
            showPopup("dvVideo3D");
        }
        else if (objectid.indexOf("tel_") == 0) {
            showPopup("dvPhone3D");
        }
        else if (objectid.indexOf("web_") == 0) {
        }
        else if (objectid.indexOf("img_") == 0) {
            showPopup("dvImage3D");
        }
        else if (objectid.indexOf("slide_") == 0) {
            showPopup("dvSlide3D");
        }
        else if (objectid.indexOf("capture_") == 0) {
        }
        else if (objectid.indexOf("three_") == 0) {
        }
        else if (objectid.indexOf("googlemap_") == 0) {
        }
        else if (objectid.indexOf("notepad_") == 0) {
            showPopup("dvText3D");
        }
        else if (objectid.indexOf("audio_") == 0) {
            showPopup("dvBGM3D");
        }
        else if (objectid.indexOf("chromakey_") == 0) {
        }
    });
    $(".edit-btn").click(objectid, function (event) {
        //alert("edited");
        //세부옵션이 활성화되어야 한다. objectid를 문자열처리하여 video_ img_ web_와 같은 문자열에 따라 처리가 되어야 한다.
        objName = "#" + objectid;

        if (objectid.indexOf("video_") == 0) {
            var index = objectid.substr(6);
            if (videoList[index] == null) {
                $("#videorun_rd1")[0].checked = true;
            }
            else {
                if (videoList[index].run_opt == 0)
                    $("#videorun_rd1")[0].checked = true;
                else if (videoList[index].run_opt == 1)
                    $("#videorun_rd2")[0].checked = true;
            }
            showPopup("dvRegVideo");
        }
        else if (objectid.indexOf("web_") == 0) {
            var index = objectid.substr(4);
            if (webList[index] == null) {
                $('.rdbWeb1').find('input')[0].checked = true;
                $('.rdbWeb2').find('input')[0].checked = true;
                $("#web_url").val("");
                $('.trNorWebMode').css("display", "");
                $('.trCustomWebMode').css("display", "none");
                $("#tblWebPreviewBtn").css("background-color", "#F7F7F7");
                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdWebModeBtn1").addClass("clsColorBtnSel");
                $("#tdWebColorBtn1").addClass("clsColorBtnSel");
            }
            else {
                if (webList[index].type == 0) {
                    // 웹 디폴트
                    $('.rdbWeb1').find('input')[0].checked = true;
                    $('.trNorWebMode').css("display", "");
                    $('.trCustomWebMode').css("display", "none");
                    /*$("#webbtn_path").attr("disabled", "disabled");
                    $("#btnWebbtnBrowse").attr("disabled", "disabled");*/
                    var title = webList[index].title;
                    var color = webList[index].color;
                    var mode_index = webList[index].mode_index;
                    var color_index = webList[index].color_index;
                    $("#tblWebPreviewBtn").css("background-color", color);
                    $("#spWebPreviewText").html = (title == "" ? "Website" : title);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $("#tdWebModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdWebColorBtn" + color_index).addClass("clsColorBtnSel");
                }
                else {
                    // 커스텀형
                    $('.rdbWeb1').find('input')[1].checked = true;
                    $('.trNorWebMode').css("display", "none");
                    $('.trCustomWebMode').css("display", "");
                    /*$("#webbtn_path").removeAttr("disabled");
                    $("#btnWebbtnBrowse").removeAttr("disabled");*/
                }

                if (webList[index].view == 0) // 링크형
                    $('.rdbWeb2').find('input')[0].checked = true;
                else { //자체브라우저형
                    $('.rdbWeb2').find('input')[1].checked = true;
                }

                $("#web_url").val(decodeURIComponent(webList[index].url));
            }
            showPopup("dvWeb");
        }
        else if (objectid.indexOf("tel_") == 0) {
            var index = objectid.substr(4);
            if (telList[index] == null) {
                $("#tel_no").val("");
                $('.rdbTel1').find('input')[0].checked = true;
                $('.trNorTelMode').css("display", "");
                $('.trCustomTelMode').css("display", "none");
                $("#tblTelPreviewBtn").css("background-color", "#F7F7F7");
                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdTelModeBtn1").addClass("clsColorBtnSel");
                $("#tdTelColorBtn1").addClass("clsColorBtnSel");
            }
            else {
                if (telList[index].type == 0) {
                    $('.rdbTel1').find('input')[0].checked = true;
                    $('.trNorTelMode').css("display", "");
                    $('.trCustomTelMode').css("display", "none");
                    var title = telList[index].title;
                    var color = telList[index].color;
                    var mode_index = telList[index].mode_index;
                    var color_index = telList[index].color_index;
                    $("#tblTelPreviewBtn").css("background-color", color);
                    $("#spTelPreviewText").html = (title == "" ? "Phone number" : title);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $("#tdTelModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdTelColorBtn" + color_index).addClass("clsColorBtnSel");
                }
                else if (telList[index].type == 1) {
                    $('.rdbTel1').find('input')[1].checked = true;
                    $('.trNorTelMode').css("display", "none");
                    $('.trCustomTelMode').css("display", "");
                }
                $("#tel_no").val(telList[index].tel_no);
            }
            showPopup("dvPhone");
        }
        else if (objectid.indexOf("googlemap_") == 0) {
            var index = objectid.substr(10);
            if (googlemapList[index] == null) {
                $("#coordinate").val("");
                $('.rdbGoogle1').find('input')[0].checked = true;
                $('.trNorGoogleMode').css("display", "");
                $('.trCustomGoogleMode').css("display", "none");
                $("#tblGooglePreviewBtn").css("background-color", "#F7F7F7");
                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdGoogleModeBtn1").addClass("clsColorBtnSel");
                $("#tdGoogleColorBtn1").addClass("clsColorBtnSel");
            }
            else {
                if (googlemapList[index].type == 0) {
                    $('.rdbGoogle1').find('input')[0].checked = true;
                    $('.trNorGoogleMode').css("display", "");
                    $('.trCustomGoogleMode').css("display", "none");
                    var title = googlemapList[index].title;
                    var color = googlemapList[index].color;
                    var mode_index = googlemapList[index].mode_index;
                    var color_index = googlemapList[index].color_index;
                    $("#tblGooglePreviewBtn").css("background-color", color);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $("#tdGoogleModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdGoogleColorBtn" + color_index).addClass("clsColorBtnSel");
                    $("#spGooglePreviewText").html = (title == "" ? "Google Map" : title);
                }
                else if (googlemapList[index].type == 1) {
                    $('.rdbGoogle1').find('input')[1].checked = true;
                    $('.trNorGoogleMode').css("display", "none");
                    $('.trCustomGoogleMode').css("display", "");

                }
                $("#coordinate").val(googlemapList[index].coordinate);
            }
            showPopup("dvGoogleMap");
        }
        else if (objectid.indexOf("slide_") == 0) {
            var index = objectid.substr(6);

            $('.rdoSlideShowType').find('input')[0].checked = true;
            $('.rdoSlidePlayType').find('input')[0].checked = true;
            if (slideList[index] != null) {
                var type = slideList[index].type;     // 일반, 3D
                var showtype = slideList[index].showtype;     // 전환모드
                var playtype = slideList[index].playtype;     // 재생모드

                $('.rdoSlideShowType').find('input')[showtype].checked = true;
                $('.rdoSlidePlayType').find('input')[playtype].checked = true;
                onSetDVSlideItem(1, slideList[index].url1);
                onSetDVSlideItem(2, slideList[index].url2);
                onSetDVSlideItem(3, slideList[index].url3);
                onSetDVSlideItem(4, slideList[index].url4);
                onSetDVSlideItem(5, slideList[index].url5);
                onSetDVSlideItem(6, slideList[index].url6);
                onSetDVSlideItem(7, slideList[index].url7);
                onSetDVSlideItem(8, slideList[index].url8);
                onSetDVSlideItem(9, slideList[index].url9);
                onSetDVSlideItem(10, slideList[index].url10);
            }
            showPopup("dvSlide");
        }
        else if (objectid.indexOf("img_") == 0) {
            var index = objectid.substr(4);
            showPopup("dvImage");
        }
        else if (objectid.indexOf("capture_") == 0) {
            var index = objectid.substr(8);
            if (captureList[index] == null) {
                capCount = 0;
                $('.rdbCapture').find('input')[0].checked = true;
                $('.clsCustomCaptureMode').css("display", "none");
                $('.clsNorCaptureMode').css("display", "");
                capdropflag = 0;
                no_drop = false;
                //n_setteddprevs = 0;
            }
            else {
                var type = captureList[index].type; //기본버튼, 커스텀버튼
                if (captureList[index].type == 0) {
                    $('.rdbCapture').find('input')[0].checked = true;
                    $('.clsCustomCaptureMode').css("display", "none");
                    $('.clsNorCaptureMode').css("display", "");
                }
                else {
                    $('.rdbCapture').find('input')[1].checked = true;
                    $('.clsCustomCaptureMode').css("display", "");
                    $('.clsNorCaptureMode').css("display", "none");
                }
                var unitX2 = $("#capture_detail_div").width() / 100;
                var unitY2 = $("#capture_detail_div").height() / 100;
                var oX2 = $("#capture_detail_div").position().left;
                var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();

                onAddDVCaptureItem(1, captureList[index].slide1, captureList[index].width1, captureList[index].height1, captureList[index].posX1, captureList[index].posY1, unitX2, unitY2);
                onAddDVCaptureItem(2, captureList[index].slide2, captureList[index].width2, captureList[index].height2, captureList[index].posX2, captureList[index].posY2, unitX2, unitY2);
                onAddDVCaptureItem(3, captureList[index].slide3, captureList[index].width3, captureList[index].height3, captureList[index].posX3, captureList[index].posY3, unitX2, unitY2);
                onAddDVCaptureItem(4, captureList[index].slide4, captureList[index].width4, captureList[index].height4, captureList[index].posX4, captureList[index].posY4, unitX2, unitY2);
                onAddDVCaptureItem(5, captureList[index].slide5, captureList[index].width5, captureList[index].height5, captureList[index].posX5, captureList[index].posY5, unitX2, unitY2);

                //n_setteddprevs = captureList[index].prev_count;

                //capprevdrag();
                dragdrop2();
                capdropflag = 1;

                capCount = captureList[index].prev_count;
            }
            showPopup("dvCapture");
        }
        else if (objectid.indexOf("three_") == 0) {
            var index = objectid.substr(6);
            if (threeList[index] == null) {
                $('#front_angle').val("객체 정면 방향");
                $('#brightness').val("밝기");
                onSelBrightLess(1);
                $('.rdbThree').find('input')[0].checked = true;
            }
            else {
                if (threeList[index].type == 0) {
                    $('.rdbThree').find('input')[0].checked = true;
                }
                else if (threeList[index].type == 1) {
                    $('.rdbThree').find('input')[1].checked = true;
                }
                else if (threeList[index].type == 2) {
                    $('.rdbThree').find('input')[2].checked = true;
                }
                $("#front_angle").val(threeList[index].front_angle);
                onSelBrightLess(threeList[index].brightness);
                $("#run_times").val(threeList[index].run_times);
            }
            showPopup("dv3DObj");
        }
        else if (objectid.indexOf("notepad_") == 0) {
            var index = objectid.substr(8);
            if (notepadList[index] != null) {
                if (notepadList[index].view == 0) {
                    $("#notepad_rd1")[0].checked = true;
                }
                else if (notepadList[index].view == 1) {
                    $("#notepad_rd2")[0].checked = true;
                }
                var board_color = notepadList[index].boardcolor;
                var boardtype = notepadList[index].boardtype;
                var board_color_index = notepadList[index].board_color_index;
                var text_color_index = notepadList[index].text_color_index;

                $("#notepad_content").val(notepadList[index].content);
                $("#spNotepadPreview").html(notepadList[index].content);
                $("#spNotepadPreview").css("color", notepadList[index].color);

                $("#spBorderPreview").css("color", notepadList[index].boardcolor);
                $("#spBorderPreview").html(notepadList[index].boardtype);
                $('.rdoTextPlayMode').find('input')[notepadList[index].textplaymode].checked = true;

                $("#tblNotepadPreviewBtn").css("background-color", board_color);
                if (boardtype == 1) {
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "");
                }
                else if (boardtype == 2) {
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRadius").addClass("clsTableRightRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox0" + type + ".png");
                }
                else if (boardtype == 3) {
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").addClass("clsTableRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "");
                }
                else if (boardtype == 5) {
                    $("#tblNotepadPreviewBtn").css("background-color", "transparent");
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox0" + boardtype + "_" + board_color_index + ".png");
                }


                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdBoardTypeBtn" + boardtype).addClass("clsBoardTypeSel");
                $("#tdBoardColorBtn" + board_color_index).addClass("clsColorBtnSel");
                $("#tdNotepadColorBtn" + text_color_index).addClass("clsColorBtnSel");
            }
            else {
                $('.rdoTextPlayMode').find('input')[0].checked = true;
                $("#spNotepadPreview").html("텍스트를 입력해주세요.");
                $("#spNotepadPreview").css("color", "#999999");
                //                        $("#spBorderPreview").css("color", "#999999");
                $("#spBorderPreview").html("0");
                $("#notepad_rd1")[0].checked = true;

                $("#tblNotepadPreviewBtn").css("background-color", "#FFFFFF");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdBoardTypeBtn1").addClass("clsBoardTypeSel");
                $("#tdBoardColorBtn1").addClass("clsColorBtnSel");
                $("#tdNotepadColorBtn1").addClass("clsColorBtnSel");
            }
            showPopup("dvText");
        }
        else if (objectid.indexOf("audio_") == 0) {
            var index = objectid.substr(6);
            if (audioList[index] == null) {
                //$("#audio_file_text").val("사운드파일");
                $('.rdbBGM1').find('input')[0].checked = true;
                $('.trShowBGMMode').css("display", "none");
                $('.trCustomBGMMode').css("display", "none");
                //$('.tblNorBGMMode').css("display", "none");                        
            }
            else {
                // 일반형/3D사운드플레이형/....
                if (audioList[index].type == 0)
                    $("#audiobtn_rd1")[0].checked = true;
                else if (audioList[index].type == 1)
                    $("#audiobtn_rd2")[0].checked = true;
                else if (audioList[index].type == 2)
                    $("#audiobtn_rd3")[0].checked = true;
                // 실행옵션
                /*if (audioList[index].run_opt == 0) {
                $("#audiorun_rd1")[0].checked = true;
                }
                else if (audioList[index].run_opt == 1) {
                $("#audiorun_rd2")[0].checked = true;
                }*/
                var color_index = audioList[index].color_index;   // 
                var mode_index = audioList[index].mode_index;   // 

                var btnkind = audioList[index].btnkind;   // 표시안함, 기본버튼, 커스텀버튼
                var btntype = audioList[index].btntype;   // BGM, SOUND
                var color = audioList[index].color;       // 기본버튼 색상
                $('.rdbBGM1').find('input')[btnkind].checked = true;
                // 표시안함/기본버튼/커스텀버튼
                if (btnkind == 0) {
                    $('.trShowBGMMode').css("display", "none");
                    $('.trCustomBGMMode').css("display", "none");
                }
                else if (btnkind == 1) {
                    $('.trShowBGMMode').css("display", "");
                    $('.trCustomBGMMode').css("display", "none");
                }
                else {
                    $('.trShowBGMMode').css("display", "none");
                    $('.trCustomBGMMode').css("display", "");
                }
                $("#spNorBGMLabel").html(btntype == 1 ? "BGM" : "사운드");
                $("#spNorBGMLabel").css("color", color);
                $("#imgCustomBGM").attr("src", "img/icon_bgm0" + (btntype == 0 ? 1 : 2) + ".png");
                $("#hdBGMModeIndex").val(mode_index);

                //$("#audio_file_text").val(audioList[index].url);
            }
            showPopup("dvBGM");
        }
        else if (objectid.indexOf("chromakey_") == 0) {
            var index = objectid.substr(10);
            if (chromakeyList[index] == null) {
                $("#chromakeyview_rd1")[0].checked = true;
                $("#chromakeyrun_rd1")[0].checked = true;
            }
            else {
                if (chromakeyList[index].type == 0) {
                    $("#chromakeyview_rd1")[0].checked = true;
                }
                else if (chromakeyList[index].type == 1) {
                    $("#chromakeyview_rd2")[0].checked = true;
                }
                if (chromakeyList[index].run_opt == 0) {
                    $("#chromakeyrun_rd1")[0].checked = true;
                }
                else if (chromakeyList[index].run_opt == 1) {
                    $("#chromakeyrun_rd2")[0].checked = true;
                }
            }
            showPopup("dvChromaKey");
        }
    });
}
function showPanel(objectid) {
    $(".dragged_object .panel").css("display", "none");
    $("#" + objectid + " .panel").css("display", "block");

    $.ajax({
        url: "get3DTemplateInfo.aspx?id=" + USER_ID,
        dataType: 'json',
        type: 'POST',
        success: function (data) {
            var flag = parseInt(data.flag);
            if (flag == 0) {
                $("#" + objectid + " .3d-btn").css("display", "none");
            }
            else {
                if (objectid.indexOf("web_") == 0
                || objectid.indexOf("googlemap_") == 0
                || objectid.indexOf("chromakey_") == 0
                || objectid.indexOf("three_") == 0
                || objectid.indexOf("capture_") == 0) {
                    $("#" + objectid + " .3d-btn").css("display", "none");
                }
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("3D 탬플릿 사용정보 조회시 오유가 발생하였습니다.");
        }
    });
}
        