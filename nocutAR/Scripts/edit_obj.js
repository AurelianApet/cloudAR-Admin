$(function () {
    $(".clsColorBtn").mousedown(function () {
        $(".clsColorBtn").removeClass("clsColorBtnSel");
        $(this).addClass("clsColorBtnSel");
    });
    $(".clsTextColorBtn").mousedown(function () {
        $(".clsTextColorBtn").removeClass("clsTextColorBtnSel");
        $(this).addClass("clsTextColorBtnSel");
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
        for (var i = 1; i < 14; i++) {
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
            //3D object
            var empty_obj = '<div class="tempclass" style="min-width:61px; min-height:55px;width:122px; height:110px; position:absolute">';
            empty_obj += '<img style="width:100%; height:100%" src="img/3Dobject.png"></img>';
            empty_obj += panel_obj;

            jQuery(empty_obj).appendTo("#editframe");
            three_counter++;
            $(".tempclass").attr("id", "three_" + three_counter);
            $("#three_" + three_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#three_" + three_counter;
            break;
        case 12:
            //PDF viewer
            empty_obj2 += panel_obj;
            jQuery(empty_obj2).appendTo("#editframe");
            pdf_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon11.png");
            $(".tempcontent" + " span").html("PDF viewer");

            $(".tempclass").attr("id", "pdf_" + pdf_counter);
            $("#pdf_" + pdf_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#pdf_" + pdf_counter;
            break;
        case 13:
            //Link video
            empty_obj2 += panel_obj;
            jQuery(empty_obj2).appendTo("#editframe");
            linkvideo_counter++;
            $(".tempcontent" + " img").attr("src", "img/cam_icon11.png");
            $(".tempcontent" + " span").html("Link video");

            $(".tempclass").attr("id", "linkvideo_" + linkvideo_counter);
            $("#linkvideo_" + linkvideo_counter).removeClass("tempclass").addClass("dragged_object");
            objName = "#linkvideo_" + linkvideo_counter;
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
        else if (objectid.indexOf("linkvideo_") == 0) {
            showPopup("dvLinkVideo3D");
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
                $('.trNorVideoMode').css("display", "none");
                $('.trCustomVideoMode').css("display", "none");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdVideoModeBtn1").addClass("clsColorBtnSel");
                $("#tdVideoColorBtn11").addClass("clsColorBtnSel");
                $("#tdVideoTextColorBtn11").addClass("clsTextColorBtnSel");
            }
            else {
                if (videoList[index].run_opt == 0) {
                    $("#videorun_rd1")[0].checked = true;
                    $('.trNorVideoMode').css("display", "none");
                    $('.trCustomVideoMode').css("display", "none");
                }
                else if (videoList[index].run_opt == 1) {
                    $("#videorun_rd2")[0].checked = true;
                    $('.trNorVideoMode').css("display", "none");
                    $('.trCustomVideoMode').css("display", "none");
                }
                else if (videoList[index].run_opt == 2) {
                    $("#videorun_rd3")[0].checked = true;
                    $('.trNorVideoMode').css("display", "");
                    $('.trCustomVideoMode').css("display", "none");

                    var btn_title = $("#video_" + index + "_btn" + " span").html();
                    var btn_mode_index = videoList[index].btn_mode_index;
                    var btn_color = $("#video_" + index + "_btn" + " table").css("background-color");
                    var btn_color_index = videoList[index].btn_color_index;
                    var btn_textcolor = $("#video_" + index + "_btn" + " span").css("color");
                    var btn_textcolor_index = videoList[index].btn_textcolor_index;
                    $("#hdVideoModeIndex").val(btn_mode_index);
                    $("#hdVideoColorIndex").val(btn_color_index);
                    $("#hdVideoTextColorIndex").val(btn_textcolor_index);

                    $("#tblVideoPreviewBtn").css("background-color", btn_color);
                    $("#spVideoPreviewText").css("color", btn_textcolor);
                    $("#spVideoPreviewText").html(btn_title);

                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdVideoModeBtn" + btn_mode_index).addClass("clsColorBtnSel");
                    $("#tdVideoColorBtn" + btn_color_index).addClass("clsColorBtnSel");
                    $("#tdVideoTextColorBtn" + btn_textcolor_index).addClass("clsTextColorBtnSel");
                }
                else if (videoList[index].run_opt == 3) {
                    $("#videorun_rd4")[0].checked = true;
                    $('.trNorVideoMode').css("display", "none");
                    $('.trCustomVideoMode').css("display", "");
                }
            }
            showPopup("dvRegVideo");
        } else if (objectid.indexOf("linkvideo_") == 0) {
            var index = objectid.substr(10);
            if (linkvideoList[index] == null) {
                $("#linkvideorun_rd1")[0].checked = true;
            }
            else {
                if (linkvideoList[index].run_opt == 0) {
                    $("#linkvideorun_rd1")[0].checked = true;
                }
                else if (linkvideoList[index].run_opt == 1) {
                    $("#linkvideorun_rd2")[0].checked = true;
                }
                $("#txt_link").val(linkvideoList[index].link_url);
                $("#hd_link").val(linkvideoList[index].link_url);
            }
            showPopup("dvRegLinkVideo");
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
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdWebModeBtn1").addClass("clsColorBtnSel");
                $("#tdWebColorBtn11").addClass("clsColorBtnSel");
                $("#tdWebTextColorBtn11").addClass("clsTextColorBtnSel");
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
                    var textcolor = webList[index].textcolor;
                    var textcolor_index = webList[index].textcolor_index;

                    $("#hdWebModeIndex").val(mode_index);
                    $("#hdWebColorIndex").val(color_index);
                    $("#hdWebTextColorIndex").val(textcolor_index);

                    $("#tblWebPreviewBtn").css("background-color", color);
                    $("#spWebPreviewText").css("color", textcolor);
                    $("#spWebPreviewText").html = (title == "" ? "Website" : title);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdWebModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdWebColorBtn" + color_index).addClass("clsColorBtnSel");
                    $("#tdWebTextColorBtn" + textcolor_index).addClass("clsTextColorBtnSel");
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
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdTelModeBtn1").addClass("clsColorBtnSel");
                $("#tdTelColorBtn11").addClass("clsColorBtnSel");
                $("#tdTelTextColorBtn11").addClass("clsTextColorBtnSel");
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
                    var textcolor = telList[index].textcolor;
                    var textcolor_index = telList[index].textcolor_index;


                    $("#hdTelModeIndex").val(mode_index);
                    $("#hdTelColorIndex").val(color_index);
                    $("#hdTelTextColorIndex").val(textcolor_index);

                    $("#tblTelPreviewBtn").css("background-color", color);
                    $("#spTelPreviewText").css("color", textcolor);
                    $("#spTelPreviewText").html = (title == "" ? "Phone number" : title);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdTelModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdTelColorBtn" + color_index).addClass("clsColorBtnSel");
                    $("#tdTelTextColorBtn" + textcolor_index).addClass("clsTextColorBtnSel");

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
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdGoogleModeBtn1").addClass("clsColorBtnSel");
                $("#tdGoogleColorBtn11").addClass("clsColorBtnSel");
                $("#tdGoogleTextColorBtn11").addClass("clsTextColorBtnSel");
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
                    var textcolor = googlemapList[index].textcolor;
                    var textcolor_index = googlemapList[index].textcolor_index;

                    $("#hdGoogleModeIndex").val(mode_index);
                    $("#hdGoogleColorIndex").val(color_index);
                    $("#hdGoogleTextColorIndex").val(textcolor_index);

                    $("#tblGooglePreviewBtn").css("background-color", color);
                    $("#spGooglePreviewText").css("color", textcolor);
                    $("#spGooglePreviewText").html = (title == "" ? "Google Map" : title);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdGoogleModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdGoogleColorBtn" + color_index).addClass("clsColorBtnSel");
                    $("#tdGoogleTextColorBtn" + textcolor_index).addClass("clsTextColorBtnSel");
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

            if (slideList[index] == null) {
                $("#sliderun_rd1")[0].checked = true;
                $('.trNorSlideMode').css("display", "none");
                $('.trCustomSlideMode').css("display", "none");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdSlideModeBtn1").addClass("clsColorBtnSel");
                $("#tdSlideColorBtn11").addClass("clsColorBtnSel");
                $("#tdSlideTextColorBtn11").addClass("clsTextColorBtnSel");
            } else {
                var type = slideList[index].type;     // 일반, 3D
                var showtype = slideList[index].showtype;     // 전환모드
                var playtype = slideList[index].playtype;     // 재생모드

                $('.rdoSlideShowType').find('input')[showtype].checked = true;
                $('.rdoSlidePlayType').find('input')[playtype].checked = true;

                if (playtype == 0) {
                    $("#selTime").val(slideList[index].timediff);
                }

                if (slideList[index].run_opt == 0) {
                    $("#sliderun_rd1")[0].checked = true;
                    $('.trNorSlideMode').css("display", "none");
                    $('.trCustomSlideMode').css("display", "none");
                }
                else if (slideList[index].run_opt == 1) {
                    $("#sliderun_rd2")[0].checked = true;
                    $('.trNorSlideMode').css("display", "");
                    $('.trCustomSlideMode').css("display", "none");

                    var btn_title = $("#slide_" + index + "_btn" + " span").html();
                    var btn_mode_index = slideList[index].btn_mode_index;
                    var btn_color = $("#slide_" + index + "_btn" + " table").css("background-color");
                    var btn_color_index = slideList[index].btn_color_index;
                    var btn_textcolor = $("#slide_" + index + "_btn" + " span").css("color");
                    var btn_textcolor_index = slideList[index].btn_textcolor_index;
                    $("#hdSlideModeIndex").val(btn_mode_index);
                    $("#hdSlideColorIndex").val(btn_color_index);
                    $("#hdSlideTextColorIndex").val(btn_textcolor_index);

                    $("#tblSlidePreviewBtn").css("background-color", btn_color);
                    $("#spSlidePreviewText").css("color", btn_textcolor);
                    $("#spSlidePreviewText").html(btn_title);

                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdSlideModeBtn" + btn_mode_index).addClass("clsColorBtnSel");
                    $("#tdSlideColorBtn" + btn_color_index).addClass("clsColorBtnSel");
                    $("#tdSlideTextColorBtn" + btn_textcolor_index).addClass("clsTextColorBtnSel");
                }
                else if (slideList[index].run_opt == 2) {
                    $("#sliderun_rd3")[0].checked = true;
                    $('.trNorSlideMode').css("display", "none");
                    $('.trCustomSlideMode').css("display", "");
                }

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

            if (imgList[index] == null) {
                $("#imagerun_rd1")[0].checked = true;
                $('.trNorImageMode').css("display", "none");
                $('.trCustomImageMode').css("display", "none");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdImageModeBtn1").addClass("clsColorBtnSel");
                $("#tdImageColorBtn11").addClass("clsColorBtnSel");
                $("#tdImageTextColorBtn11").addClass("clsTextColorBtnSel");
            }
            else {
                if (imgList[index].run_opt == 0) {
                    $("#imagerun_rd1")[0].checked = true;
                    $('.trNorImageMode').css("display", "none");
                    $('.trCustomImageMode').css("display", "none");
                }
                else if (imgList[index].run_opt == 1) {
                    $("#imagerun_rd2")[0].checked = true;
                    $('.trNorImageMode').css("display", "");
                    $('.trCustomImageMode').css("display", "none");

                    var btn_title = $("#img_" + index + "_btn" + " span").html();
                    var btn_mode_index = imgList[index].btn_mode_index;
                    var btn_color = $("#img_" + index + "_btn" + " table").css("background-color");
                    var btn_color_index = imgList[index].btn_color_index;
                    var btn_textcolor = $("#img_" + index + "_btn" + " span").css("color");
                    var btn_textcolor_index = imgList[index].btn_textcolor_index;
                    $("#hdImageModeIndex").val(btn_mode_index);
                    $("#hdImageColorIndex").val(btn_color_index);
                    $("#hdImageTextColorIndex").val(btn_textcolor_index);

                    $("#tblImagePreviewBtn").css("background-color", btn_color);
                    $("#spImagePreviewText").css("color", btn_textcolor);
                    $("#spImagePreviewText").html(btn_title);

                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdImageModeBtn" + btn_mode_index).addClass("clsColorBtnSel");
                    $("#tdImageColorBtn" + btn_color_index).addClass("clsColorBtnSel");
                    $("#tdImageTextColorBtn" + btn_textcolor_index).addClass("clsTextColorBtnSel");
                }
                else if (imgList[index].run_opt == 2) {
                    $("#imagerun_rd3")[0].checked = true;
                    $('.trNorImageMode').css("display", "none");
                    $('.trCustomImageMode').css("display", "");
                }
            }

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

                $("#hdNotepadTextColorIndex").val(text_color_index);
                $("#hdNotepadColorIndex").val(board_color_index);
                $("#hdNotepadColor").val(board_color);
                $("#hdNotepadType").val(boardtype);

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
                else if (boardtype == 4) {
                    $("#tblNotepadPreviewBtn").css("background-color", "transparent");
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox0" + (boardtype - 1) + "_" + board_color_index + ".png");
                }

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsBoardTypeSel").removeClass("clsBoardTypeSel");
                $("#tdNotepadTypeBtn" + boardtype).addClass("clsBoardTypeSel");
                $("#tdNotepadTextColorBtn" + board_color_index).addClass("clsColorBtnSel");
                $("#tdNotepadColorBtn" + text_color_index).addClass("clsColorBtnSel");
            }
            else {
                $('.rdoTextPlayMode').find('input')[0].checked = true;
                $("#notepad_content").val("");
                $("#spNotepadPreview").html("텍스트를 입력해주세요.");
                $("#spNotepadPreview").css("color", "#999999");
                //                        $("#spBorderPreview").css("color", "#999999");
                $("#spBorderPreview").html("0");
                $("#notepad_rd1")[0].checked = true;

                $("#tblNotepadPreviewBtn").css("background-color", "#FFFFFF");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsBoardTypeSel").removeClass("clsBoardTypeSel");
                $("#tdNotepadTypeBtn1").addClass("clsBoardTypeSel");
                $("#tdNotepadTextColorBtn11").addClass("clsColorBtnSel");
                $("#tdNotepadColorBtn11").addClass("clsColorBtnSel");
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

                $("#tblBGMPreviewBtn").css("background-color", "#F7F7F7");
                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdBGMModeBtn1").addClass("clsColorBtnSel");
                $("#tdBGMColorBtn11").addClass("clsColorBtnSel");
                $("#tdBGMTextColorBtn11").addClass("clsTextColorBtnSel");
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

                var textcolor = audioList[index].textcolor;
                var textcolor_index = audioList[index].textcolor_index;

                $("#hdBGMModeIndex").val(mode_index);
                $("#hdBGMColorIndex").val(color_index);
                $("#hdBGMTextColorIndex").val(textcolor_index);

                $('.rdbBGM1').find('input')[btnkind].checked = true;
                // 표시안함/기본버튼/커스텀버튼
                if (btnkind == 0) {
                    $('.trShowBGMMode').css("display", "none");
                    $('.trCustomBGMMode').css("display", "none");
                }
                else if (btnkind == 1) {
                    $('.trShowBGMMode').css("display", "");
                    $('.trCustomBGMMode').css("display", "none");

                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdBGMModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdBGMColorBtn" + color_index).addClass("clsColorBtnSel");
                    $("#tdBGMTextColorBtn" + textcolor_index).addClass("clsTextColorBtnSel");

                }
                else {
                    $('.trShowBGMMode').css("display", "none");
                    $('.trCustomBGMMode').css("display", "");
                }

                $("#tblBGMPreviewBtn").css("background-color", color);
                $("#spNorBGMLabel").css("color", textcolor);
                $("#spNorBGMLabel").html(mode_index == 1 ? "BGM" : "사운드");

                if (mode_index == 1 || mode_index == 2) {
                    $("#tblBGMCustomPreviewBtn").css("display", "none");
                    $("#tblBGMNorPreviewBtn").css("display", "");
                }
                else {
                    $("#tblBGMCustomPreviewBtn").css("display", "");
                    $("#tblBGMNorPreviewBtn").css("display", "none");
                }
                $("#imgCustomBGM").attr("src", "img/icon_bgm0" + (mode_index == 3 ? 1 : 2) + ".png");

                //$("#audio_file_text").val(audioList[index].url);
            }
            showPopup("dvBGM");
        }
        else if (objectid.indexOf("chromakey_") == 0) {
            var index = objectid.substr(10);
            if (chromakeyList[index] == null) {
                $("#chromakeyview_rd1")[0].checked = true;
                $("#chromakeyrun_rd1")[0].checked = true;

                $('.trNorChromakeyMode').css("display", "none");
                $('.trCustomChromakeyMode').css("display", "none");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdChromakeyModeBtn1").addClass("clsColorBtnSel");
                $("#tdChromakeyColorBtn11").addClass("clsColorBtnSel");
                $("#tdChromakeyTextColorBtn11").addClass("clsTextColorBtnSel");
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
                    $('.trNorChromakeyMode').css("display", "none");
                    $('.trCustomChromakeyMode').css("display", "none");
                }
                else if (chromakeyList[index].run_opt == 1) {
                    $("#chromakeyrun_rd2")[0].checked = true;
                    $('.trNorChromakeyMode').css("display", "none");
                    $('.trCustomChromakeyMode').css("display", "none");
                }
                else if (chromakeyList[index].run_opt == 2) {
                    $("#chromakeyrun_rd3")[0].checked = true;
                    $('.trNorChromakeyMode').css("display", "");
                    $('.trCustomChromakeyMode').css("display", "none");

                    var btn_title = $("#chromakey_" + index + "_btn" + " span").html();
                    var btn_mode_index = chromakeyList[index].btn_mode_index;
                    var btn_color = $("#chromakey_" + index + "_btn" + " table").css("background-color");
                    var btn_color_index = chromakeyList[index].btn_color_index;
                    var btn_textcolor = $("#chromakey_" + index + "_btn" + " span").css("color");
                    var btn_textcolor_index = chromakeyList[index].btn_textcolor_index;
                    $("#hdChromakeyModeIndex").val(btn_mode_index);
                    $("#hdChromakeyColorIndex").val(btn_color_index);
                    $("#hdChromakeyTextColorIndex").val(btn_textcolor_index);

                    $("#tblChromakeyPreviewBtn").css("background-color", btn_color);
                    $("#spChromakeyPreviewText").css("color", btn_textcolor);
                    $("#spChromakeyPreviewText").html(btn_title);

                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdChromakeyModeBtn" + btn_mode_index).addClass("clsColorBtnSel");
                    $("#tdChromakeyColorBtn" + btn_color_index).addClass("clsColorBtnSel");
                    $("#tdChromakeyTextColorBtn" + btn_textcolor_index).addClass("clsTextColorBtnSel");
                }
                else if (chromakeyList[index].run_opt == 3) {
                    $("#chromakeyrun_rd4")[0].checked = true;
                    $('.trNorChromakeyMode').css("display", "none");
                    $('.trCustomChromakeyMode').css("display", "");
                }
            }
            showPopup("dvChromaKey");
        }
        else if (objectid.indexOf("pdf_") == 0) {
            var index = objectid.substr(4);

            if (pdfList[index] == null) {
                $("#pdfrun_rd1")[0].checked = true;
                $('.trNorPdfMode').css("display", "none");
                $('.trCustomPdfMode').css("display", "none");

                $("#hdPdfName").val("");
                $("#hdPdfSize").val("");
                $("#hdPdfPageCount").val("");

                $("#filepdf_text").val("");
                $("#pdf_file").val("");

                var element = "";
                element += "<tr><td width='100' height='120'><table cellpadding='0' cellspacing='0' style='border-collapse: collapse;' width='100' align='center'><tbody><tr><td width='100' height='120' style='border-width: 1; border-color: rgb(68,68,68); border-style: solid;' background='img/a_04_cimg01.png'></td></tr></tbody></table></td>";
                element += "<td width='100' height='120'><table cellpadding='0' cellspacing='0' align='center' style='border-collapse: collapse;' width='100'><tr><td width='100' height='120' style='border-width: 1; border-color: rgb(68,68,68); border-style: solid;' background='img/a_04_cimg01.png'></td></tr></table></td>";
                element += "<td width='100' height='120'><table cellpadding='0' cellspacing='0' align='center' style='border-collapse: collapse;' width='100'><tr><td width='100' height='120' style='border-width: 1; border-color: rgb(68,68,68); border-style: solid;' background='img/a_04_cimg01.png'></td></tr></table></td></tr>";

                $("#prev_tbl").html("");
                jQuery(element).appendTo("#prev_tbl");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                $("#tdPdfModeBtn1").addClass("clsColorBtnSel");
                $("#tdPdfColorBtn11").addClass("clsColorBtnSel");
                $("#tdPdfTextColorBtn11").addClass("clsTextColorBtnSel");
            }
            else {
                var name = pdfList[index].name;
                var objsize = pdfList[index].objsize;
                var pagecount = pdfList[index].pagecount;

                $("#hdPdfName").val(name);
                $("#hdPdfSize").val(objsize);
                $("#hdPdfPageCount").val(pagecount);

                var element = "";
                for (i = 0; i < pagecount; i++) {
                    element += '<td width="100" height="120">';
                    element += '<table cellpadding="0" cellspacing="0" style="border-collapse: collapse;" width="100" align="center">';
                    element += '<tbody><tr><td width="100" height="120" align="center" style="border-width: 1; border-color: rgb(68,68,68);border-style: solid;">';
                    element += '<img id="cat' + i + '" alt="catalog_preview" src="/uploads/pdf/' + name + '/' + (i + 1) + '.png' + '" style="height:100%; width: 100%;">';
                    element += '</td></tr></tbody>';
                    element += '</table></td>';
                }
                $("#prev_tbl").html("");
                jQuery(element).appendTo("#prev_tbl");

                if (pdfList[index].run_opt == 0) {
                    $("#pdfrun_rd1")[0].checked = true;
                    $('.trNorPdfMode').css("display", "none");
                    $('.trCustomPdfMode').css("display", "none");
                }
                else if (pdfList[index].run_opt == 1) {
                    $("#pdfrun_rd2")[0].checked = true;
                    $('.trNorPdfMode').css("display", "");
                    $('.trCustomPdfMode').css("display", "none");

                    var title = pdfList[index].title;
                    var mode_index = pdfList[index].mode_index;
                    var color = pdfList[index].color;
                    var color_index = pdfList[index].color_index;
                    var textcolor = pdfList[index].textcolor;
                    var textcolor_index = pdfList[index].textcolor_index;

                    $("#hdPdfModeIndex").val(mode_index);
                    $("#hdPdfColorIndex").val(color_index);
                    $("#hdPdfTextColorIndex").val(textcolor_index);

                    $("#tblPdfPreviewBtn").css("background-color", color);
                    $("#spPdfPreviewText").css("color", textcolor);
                    $("#spPdfPreviewText").html(title);

                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $(".clsTextColorBtnSel").removeClass("clsTextColorBtnSel");
                    $("#tdPdfModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdPdfColorBtn" + color_index).addClass("clsColorBtnSel");
                    $("#tdPdfTextColorBtn" + textcolor_index).addClass("clsTextColorBtnSel");
                }
                else if (pdfList[index].run_opt == 2) {
                    $("#pdfrun_rd3")[0].checked = true;
                    $('.trNorPdfMode').css("display", "none");
                    $('.trCustomPdfMode').css("display", "");
                }
            }
            showPopup("dvPdf");
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
                if (objectid.indexOf("web_") == 0 || objectid.indexOf("googlemap_") == 0 || objectid.indexOf("chromakey_") == 0 || objectid.indexOf("three_") == 0 || objectid.indexOf("capture_") == 0 || objectid.indexOf("pdf_") == 0) {
                    $("#" + objectid + " .3d-btn").css("display", "none");
                }
                else {
                    $("#" + objectid + " .3d-btn").css("display", "");
                }
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("3D 탬플릿 사용정보 조회시 오유가 발생하였습니다.");
        }
    });
}
        