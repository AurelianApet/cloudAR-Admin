//OnApply Definitions.



var isFileChange = 0;
var isFileChange2 = 0;
var capdropflag = 0;
//var n_setteddprevs = 0;
var n_selectedprev;
var no_drop;

var panel_obj = "<div class='panel'>";
panel_obj += "		<table cellpadding='0' cellspacing='0' align='center' width='100%'>";
panel_obj += "			<tr>";
panel_obj += "				<td width='30%' height='26' align='left'>";
panel_obj += "					<img class='delete-btn' src='img/icon_trash.png' width='18' height='21' border='0' name='image3'>";
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
panel_obj += "</div>";

$(document).ready(function () {
    /*텍스트박스 초기값 및 캡션 설정부분 */
    $("#front_angle").focus(function () {
        var oldValue = $(this).val();
        if (oldValue == "객체 정면 방향") {
            $(this).val("");
        }
    });
    $("#front_angle").blur(function () {
        var oldValue = $(this).val();
        if (oldValue == "" || oldValue == "객체 정면 방향") {
            $(this).val("객체 정면 방향");
        }
    });
    $("#run_times").focus(function () {
        var oldValue = $(this).val();
        if (oldValue == "실행횟수") {
            $(this).val("");
        }
    });
    $("#run_times").blur(function () {
        var oldValue = $(this).val();
        if (oldValue == "" || oldValue == "실행횟수") {
            $(this).val("실행횟수");
        }
    });
    $("#notepad_content").keydown(function (e) {
        if (e.which == 13) {
            if ($(this).val().split("\n").length >= 4)
                return false;
        }
    });
    $("#notepad_content").on('keyup', function () {
        $("#spLimitCharacters").html(60 - $(this).val().length);
        if ($(this).val().length >= 60) {
            alert("60자 이상 입력하실수 없습니다");
        }
        $("#spNotepadPreview").html($(this).val().replace(/\n/g, "<br>"));
    });
    $("#front_angle").on('keyup', function () {
        if ($(this).val().length >= 4) {
            $(this).val($(this).val().substr(0, 3));
            return;
        }
    });
    $("#run_times").on('keyup', function () {
        if ($(this).val().length >= 4) {
            $(this).val($(this).val().substr(0, 3));
            return;
        }
    });
    $("#notepad_content").focus(function () {
        var oldValue = $(this).val();
        if (oldValue == "내용") {
            $(this).val("");
        }
    });
    $("#notepad_content").blur(function () {
        var oldValue = $(this).val();
        if (oldValue == "" || oldValue == "내용") {
            $(this).val("내용");
        }
    });

    $("#web_url").blur();
    $("#tel_no").blur();
    $("#front_angle").blur();
    $("#run_times").blur();
    $("#coordinate").blur();
    $("#notepad_content").blur();

    /***텍스트박스 초기값 및 캡션 설정부분 ***/

    /*세부옵션의 기본형과 제작형 절환시 파일 업로드버튼의 활성 비활성화*/
    /*$('.rdbWeb1').click(
    function (event) {
    if ($('.rdbWeb1').find('input:checked').val() == 1) {
    $("#webbtn_path").removeAttr("disabled");
    $("#btnWebbtnBrowse").removeAttr("disabled");
    $("#webbtn_path_text").removeAttr("disabled");
    //alert("enabled");
    }
    else {
    $("#webbtn_path").attr("disabled", "disabled");
    $("#btnWebbtnBrowse").attr("disabled", "disabled");
    $("#webbtn_path_text").attr("disabled", "disabled");
    }
    });*/
    $('.rdbCapture').click(
        function (event) {

            if ($('.rdbCapture').find('input:checked').val() == 1) {
                $("#capturebtn_path").removeAttr("disabled");
                $("#btnCaptureBrowse").removeAttr("disabled");
                $("#capturebtn_path_text").removeAttr("disabled");
            }
            else {
                $("#capturebtn_path").attr("disabled", "disabled");
                $("#btnCaptureBrowse").attr("disabled", "disabled");
                $("#capturebtn_path_text").attr("disabled", "disabled");
            }
        });

    $('input[name="rdTel"]:radio').change(
        function () {
            if (this.value == 'twoD') {
                //alert("내부 라디오 활성화");
                $("#rdCommon").removeAttr("disabled");
                $("#rdCustom").removeAttr("disabled");
                if ($("#rdCustom")[0].checked == true) {
                    $("#telbtn_path").removeAttr("disabled");
                    $("#btnTelbtnBrowse").removeAttr("disabled");
                    $("#telbtn_path_text").removeAttr("disabled");
                }
            }
            else if (this.value == 'threeD') {
                //alert("내부 라디오 비활성화");
                $("#rdCommon").attr("disabled", "disabled");
                $("#rdCustom").attr("disabled", "disabled");
                $("#telbtn_path").attr("disabled", "disabled");
                $("#btnTelbtnBrowse").attr("disabled", "disabled");
                $("#telbtn_path_text").attr("disabled", "disabled");
            }
        }
    );
    /*$('input[name="twoD"]:radio').change(
    function () {
    if (this.value == 'common') {
    //alert("파일input 비활성화");
    $("#telbtn_path").attr("disabled", "disabled");
    $("#btnTelbtnBrowse").attr("disabled", "disabled");
    $("#telbtn_path_text").attr("disabled", "disabled");
    }
    else if (this.value == 'custom') {
    //alert("파일 input 활성화");
    $("#telbtn_path").removeAttr("disabled");
    $("#btnTelbtnBrowse").removeAttr("disabled");
    $("#telbtn_path_text").removeAttr("disabled");
    }
    }
    );*/

    $('input[name="googlebtn_rd"]:radio').change(
        function () {
            if (this.value == 'common') {
                //alert("파일input 비활성화");
                $("#googlebtn_path").attr("disabled", "disabled");
                $("#btnGoogleBrowse").attr("disabled", "disabled");
                $("#googlebtn_path_text").attr("disabled", "disabled");
            }
            else if (this.value == 'custom') {
                //alert("파일 input 활성화");
                $("#googlebtn_path").removeAttr("disabled");
                $("#btnGoogleBrowse").removeAttr("disabled");
                $("#googlebtn_path_text").removeAttr("disabled");
            }
        }
    );

    /***세부옵션의 기본형과 제작형 절환시 파일 업로드버튼의 활성 비활성화***/

    //이미지 변환
    $('#image_file').bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#image_file").val().substr($("#image_file").val().length - 3)).toLowerCase();
        if (imgExtension != 'jpg' && imgExtension != 'png') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file = document.getElementById("image_file");
        var size = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (size > 3) {
            alert("3MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange = 1;
    });
    /***이미지 변환***/

    //이미지슬라이드 변환
    $('#slide_file').bind("change", function () {
        var file = this.files[0];
        if (file) {
            /*확장자체크*/
            var imgExtension = ($("#slide_file").val().substr($("#slide_file").val().length - 3)).toLowerCase();
            if (imgExtension != 'jpg' && imgExtension != 'png') {
                alert("파일형식이 바르지 않습니다.");
                return;
            }
            /***확장자체크***/

            /*용량제한*/
            if ((file.size / 1053317.6) > 3) {
                alert("3MB 이하의 파일만 업로드가능합니다.");
                return;
            }
            /***용량제한***/
            ShowProgress2();
            //create new FormData instance to transfer as Form Type
            var data = new FormData();
            // add the file intended to be upload to the created FormData instance
            data.append("upfile", file);
            $.ajax({
                url: 'PostUpload.aspx?type=3&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress2();
                    $("#slide_file").val('');
                    var index = $("#addSlideImgID").val();
                    onSetDVSlideItem(index, data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress2();
                    $("#slide_file").val('');
                    alert("슬라이드 등록과정에 오류가 발생하였습니다.");
                }
            });
        }
    });
    /***이미지슬라이드 변환***/
    /*캡쳐미리보기이미지 처리부분*/
    $('#capture_file').bind("change", function () {
        var file = this.files[0];
        if (file) {
            /*확장자체크*/
            var imgExtension = ($("#capture_file").val().substr($("#capture_file").val().length - 3)).toLowerCase();
            if (imgExtension != 'png') {
                alert("파일형식이 바르지 않습니다.");
                return;
            }
            /***확장자체크***/

            /*용량제한*/
            if ((file.size / 1053317.6) > 3) {
                alert("3MB 이하의 파일만 업로드가능합니다.");
                return;
            }
            /***용량제한***/
            ShowProgress2();
            //create new FormData instance to transfer as Form Type
            var data = new FormData();
            // add the file intended to be upload to the created FormData instance
            data.append("upfile", file);
            $.ajax({
                url: 'PostUpload.aspx?type=4&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress2();
                    capCount++;
                    capprevIndex++;
                    $("#capture_file").val('');
                    var index = $("#addCaptureImgID").val();
                    onSetDVCaptureItem(index, data);
                    onAddDVCaptureItem(index, data, 80, 95, 0, 0, 1, 1)

                    //capprevdrag(index);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress2();
                    $("#capture_file").val('');
                    alert("이미지 등록과정에 오류가 발생하였습니다.");
                }
            });
        }
    });
    /*캡쳐미리보기이미지 처리부분*/

    /*캡쳐버튼이미지업로드 처리부분*/
    $("#capturebtn_path").bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#capturebtn_path").val().substr($("#capturebtn_path").val().length - 3)).toLowerCase();
        if (imgExtension != 'png' && imgExtension != 'jpg') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/


        var file = document.getElementById("capturebtn_path");
        var btnsize = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (btnsize > 3) {
            alert("3MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/

        isFileChange = 1;
    });
    /***캡쳐버튼이미지업로드 처리부분***/

    /*비디오파일 처리부분*/
    $("#video_file").bind("change", function () {
        /*확장자체크*/
        if (!checkImgExtention("video_file", "video")) {
            alert("파일형식이 바르지 않습니다.");
            return;
        }

        //        var imgExtension = ($("#video_file").val().substr($("#video_file").val().length - 3)).toLowerCase();
        //        if (imgExtension != 'mp4') {
        //            alert("파일형식이 바르지 않습니다.");
        //            return;
        //        }
        /***확장자체크***/

        var file = document.getElementById("video_file");
        var size = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (size > 50) {
            alert("50MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange = 1;

    });
    /***비디오파일 처리부분***/

    /*오디오파일 처리부분*/
    $("#audio_file").bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#audio_file").val().substr($("#audio_file").val().length - 3)).toLowerCase();
        if (imgExtension != 'mp3') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file = document.getElementById("audio_file");
        var size = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (size > 50) {
            alert("50MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange = 1;

    });
    /***오디오파일 처리부분***/

    /*크로마키파일 처리부분*/
    $("#chromakey_file").bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#chromakey_file").val().substr($("#chromakey_file").val().length - 3)).toLowerCase();
        if (imgExtension != 'mov' && imgExtension != 'mp4') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file = document.getElementById("chromakey_file");
        var size = file.files[0].size / 1053317.6;

        /*용량제한*/
        if (size > 80) {
            alert("80MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange = 1;

    });
    /***크로마키파일 처리부분***/

    /*웹버튼이미지업로드 처리부분*/
    $("#webbtn_path").bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#webbtn_path").val().substr($("#webbtn_path").val().length - 3)).toLowerCase();
        if (imgExtension != 'png') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file = document.getElementById("webbtn_path");
        var size = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (size > 3) {
            alert("3MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange = 1;
    });
    /***웹버튼이미지업로드 처리부분***/

    /*폰버튼이미지업로드 처리부분*/
    $("#telbtn_path").bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#telbtn_path").val().substr($("#telbtn_path").val().length - 3)).toLowerCase();
        if (imgExtension != 'png') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file = document.getElementById("telbtn_path");
        var size = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (size > 3) {
            alert("3MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange = 1;
    });
    /***폰버튼이미지업로드 처리부분***/

    /*구글버튼이미지업로드 처리부분*/
    $("#googlebtn_path").bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#googlebtn_path").val().substr($("#googlebtn_path").val().length - 3)).toLowerCase();
        if (imgExtension != 'jpg' && imgExtension != 'png') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file = document.getElementById("googlebtn_path");
        var size = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (size > 3) {
            alert("3MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange = 1;
    });
    /***구글버튼이미지업로드 처리부분***/


    /*오디오버튼이미지업로드 처리부분*/
    $("#bgmbtn_path").bind("change", function () {
        /*확장자체크*/
        var imgExtension = ($("#bgmbtn_path").val().substr($("#bgmbtn_path").val().length - 3)).toLowerCase();
        if (imgExtension != 'jpg' && imgExtension != 'png') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file = document.getElementById("bgmbtn_path");
        var size = file.files[0].size / 1053317.6;
        /*용량제한*/
        if (size > 3) {
            alert("3MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange2 = 1;
    });
    /***오디오버튼이미지업로드 처리부분***/

    /*3D 오브젝트 업로드 처리부분*/
    $("#three_file1").bind("change", function () {
        /*확장자체크*/
        var imgExtension1 = ($("#three_file1").val().substr($("#three_file1").val().length - 7)).toLowerCase();
        if (imgExtension1 != 'unity3d') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file1 = document.getElementById("three_file1");
        var size1 = file1.files[0].size / 1053317.6;

        /*용량제한*/
        if (size1 > 50) {
            alert("50MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange++;
    });
    $("#three_file2").bind("change", function () {
        /*확장자체크*/
        var imgExtension2 = ($("#three_file2").val().substr($("#three_file2").val().length - 11)).toLowerCase();
        if (imgExtension2 != 'assetbundle') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
        /***확장자체크***/

        var file2 = document.getElementById("three_file2");
        var size2 = file2.files[0].size / 1053317.6;

        /*용량제한*/
        if (size2 > 50) {
            alert("50MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        isFileChange++;
    });
    /***3D 오브젝트 업로드 처리부분***/
});

function onRemoveSlideImage(index) {
    $("#delimg_id").val(index);
    showPopup("dvDelSlideItem");
}

function delPrevImg() {
    var index = $("#delimg_id").val();
    if (index < 11)
        onSetDVSlideItem(index, "");
    else
        delCapPrevImg(index);
    closeConfirmPopup();
    //$("#popBack").fadeOut("slow");
}

/**세부옵션의 활성화 비활성화 절환설정하는 부분**/
function delCapPrevImg(previmg_id) {
    var index = previmg_id - 10;
    onSetDVCaptureItem(index, "");
    $("#controlcapprev" + index).remove();
    if (capCount > 0)
        capCount--;
    /*if (n_setteddprevs > 0)
        n_setteddprevs--;*/
}

function onAddSlideImage(index) {
    $("#addSlideImgID").val(index);
    $("#slide_file").click();
}

function onAddCaptureImage(index) {
    $("#addCaptureImgID").val(index);
    $("#capture_file").click();
}

function capprevdrag(capprevIndex) {
    $("#capimgPrev" + capprevIndex).draggable({
        containment: "#detail_opt",
        revert: "invalid",
        helper: "clone",
        start: function (ui) { // 드래그 시작했을 때 한 번 호출

        },

        stop: function (ev, ui) { // 드래그 끝났을 때 한 번 호출
            if (no_drop)
                return;
            /*if (n_setteddprevs >= 5)
                return;*/
            if (capdropflag != 1 || capdropflag == 2)
                return;
            var pos = $(ui.helper).position();
            $(n_selectedprev + " img").css({ "width": "100%", "height": "100%" });
            $(n_selectedprev).css({ "left": ui.position.left - $("#capture_detail_div").offset().left, "top": ui.position.top - $("#capture_detail_div").offset().top });
            $(n_selectedprev).removeClass("clscapprev");   //클론되지 않게 해주는 코드이다.
            //n_setteddprevs++;
            dragdrop2();
        }
    });
}
function dragdrop2() {
    $(n_selectedprev).draggable({
        containment: "#capture_detail_div"
    });
    $(n_selectedprev).resizable({
        containment: "#capture_detail_div"
    });

}
function capprevdrop() {
    $("#capture_detail_div").droppable({
        accept: ".clscapprev",
        activeClass: "ui-state-default",
        hoverClass: "ui-state-hover",

        drop: function (event, ui) {
            /*if (n_setteddprevs >= 3) {
            return;
            }*/
            for (var i = 1; i <= 5; i++) {
                if ($("#controlcapprev" + i +" img").attr("src") == $(ui.draggable).clone().attr("src")) {
                    no_drop = true;
                    return;
                }
            }

            /*if ($(ui.draggable).clone().attr("src") == $("#controlcapprev1 img").attr("src") ||
               $(ui.draggable).clone().attr("src") == $("#controlcapprev2 img").attr("src") ||
               $(ui.draggable).clone().attr("src") == $("#controlcapprev3 img").attr("src") ||
               $(ui.draggable).clone().attr("src") == $("#controlcapprev4 img").attr("src") ||
               $(ui.draggable).clone().attr("src") == $("#controlcapprev5 img").attr("src")) {
                no_drop = true;
                return;
            }*/
            var index = 1;
            for (var i = 1; i <= 5; i++) {
                if ($("#capimgPrev" + i).attr("src") == $(ui.draggable).clone().attr("src")) {
                    index = i;
                    break;
                }
            }
            var element = $(ui.draggable).clone();
            var element_div;
            capdropflag = 1;
            no_drop = false;
            /*if ($("#controlcapprev1").length == 0) {
                element_div = '<div id="controlcapprev1" style="position:absolute; width:75px; height:75px"></div>';
                jQuery(element_div).appendTo("#capture_detail_div");
                $("#controlcapprev1").append(element);
                n_selectedprev = "#controlcapprev1";
                return;
            }
            else if ($("#controlcapprev2").length == 0) {
                element_div = '<div id="controlcapprev2" style="position:absolute; width:75px; height:75px"></div>';
                jQuery(element_div).appendTo("#capture_detail_div");
                $("#controlcapprev2").append(element);
                n_selectedprev = "#controlcapprev2";
                return;
            }
            else if ($("#controlcapprev3").length == 0) {
                element_div = '<div id="controlcapprev3" style="position:absolute; width:75px; height:75px"></div>';
                jQuery(element_div).appendTo("#capture_detail_div");
                $("#controlcapprev3").append(element);
                n_selectedprev = "#controlcapprev3";
                return;
            }*/
            element_div = '<div id="controlcapprev' + index +' style="position:absolute; width:75px; height:75px"></div>';
            jQuery(element_div).appendTo("#capture_detail_div");
            $("#controlcapprev" + index).append(element);
            n_selectedprev = "#controlcapprev" + index;
            return;

        }
    });
}
/*숫자만 입력하기*/
function num_only() {
    if ((event.keyCode < 48) || (event.keyCode > 57)) {
        event.returnValue = false;
    }
}
/***전화번호 숫자만 입력하기***/


/*구글좌표 숫자만 입력하기*/
function googlepos_only() {
    if ((((event.keyCode < 48) || (event.keyCode > 57)) && (event.keyCode != 44) && (event.keyCode != 46))) {
        event.returnValue = false;
    }
}
/***구글좌표 숫자만 입력하기***/

/*적용하기 버튼을 누를때 처리부*/
function OnVideoApply1() {
    var index = objName.substr(7);
    var val = 0;
    if ($("#video_rd2")[0].checked == true)
        val = 1;
    else if ($("#video_rd3")[0].checked == true)
        val = 2;
    var run_opt = 0;
    if ($("#videorun_rd2")[0].checked == true)
        run_opt = 1;

    if ($("#video_file").val().substr(0, 22) == "http://www.youtube.com") {
        var pos = $(objName).position();
        var element = '<div id="temp" style="width: 200px; height: auto; position:absolute"><video width="100%" height="100%" controls><source src="' + $("#video_file").val() + '"></video>';
        //패널 추가
        element += panel_obj;
        jQuery(element).appendTo("#editframe");
        if (videoList[index] != null) {
            $("#temp").css({ "width": $(objName).width(), "height": $(objName + " video").height() });
        }
        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": $(objName).css("z-index") });
        $(objName).remove();
        $("#temp").addClass("dragged_object");
        $("#temp").attr("id", "video_" + index);
        //크기조종
        $(objName).draggable({
            containment: "parent"
        });
        $(objName).resizable({
            aspectRatio: $(objName + " video").width() / $(objName + " video").height(),
            containment: "parent"
        });
        
        videoList[index] = { url: $("#video_file").val(), type: val, run_opt: run_opt, objsize: 0 };

        //패널사건추가
        add_DoubleClickEvent();
        //setMarkerImg(data);
    }
    if (isFileChange) {
        var file = document.getElementById("video_file");
        var size = file.files[0].size / 1053317.6;
        ShowProgress();
        //create new FormData instance to transfer as Form Type
        var data = new FormData();
        // add the file intended to be upload to the created FormData instance
        data.append("upfile", file.files[0]);
        $.ajax({
            url: 'PostUpload.aspx?type=1&content_id=' + CONTENT_ID,
            type: "post",
            data: data,
            // cache: false,
            processData: false,
            contentType: false,
            success: function (data, textStatus, jqXHR) {
                //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                //setTimeout(function () {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="width: 200px; height: auto; position:absolute"><video width="100% height="100%" controls><source src="' + data + '"></video>';
                    //패널 추가
                    element += panel_obj;

                    jQuery(element).appendTo("#editframe");
                    if (videoList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName + " video").height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName).resizable({
                        aspectRatio: $(objName).width() / $(objName + " video").height(),
                        containment: "parent"
                    });
                    var aspectRatio = $(objName).resizable("option", "aspectRatio");

                    videoList[index] = { url: server_url + data, type: val, run_opt: run_opt, objsize: size };

                    //패널사건추가
                    add_DoubleClickEvent();
                    //setMarkerImg(data);
                    $("#video_file").replaceWith($("#video_file").clone(true));
                //}, 3000);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                HideProgress();
                alert("비디오 등록과정에 오류가 발생하였습니다.");
            }
        });
        isFileChange = 0;

    }
    else {
        /*수정이면*/
        if (videoList[index] != null) {
            if (videoList[index].backurl == "none") {
                alert("비디오를 등록해주세요.");
                return;
            }
            pos = $(objName).position();
            element = '<div id="temp" style="width: 200px; height: auto; position:absolute"><video width="100%" height="100%" controls><source src="' + videoList[index].url + '"></video>';
            //패널 추가
            element += panel_obj;

            jQuery(element).appendTo("#editframe");
            $("#temp").css({ "width": $(objName).width(), "height": $(objName + " video").height() });
            $("#temp").css({ "left": pos.left, "top": pos.top });
            $("#temp").css({ "z-index": $(objName).css("z-index") });
            $(objName).remove();
            $("#temp").addClass("dragged_object");
            $("#temp").attr("id", "video_" + index);
            //크기조종
            $(objName).draggable({
                containment: "parent"
            });
            $(objName).resizable({
                aspectRatio: $(objName + " video").width() / $(objName + " video").height(),
                containment: "parent"
            });

            videoList[index] = { url: videoList[index].url, type: val, run_opt: run_opt, objsize: videoList[index].objsize };

            //패널사건추가
            add_DoubleClickEvent();
            //setMarkerImg(data);
        }
        /***수정***/

        /*새로 추가*/
        else {
            alert("비디오를 등록해주세요.");
            return;
        }
        /***새로 추가***/
    }
    closePopup();
}
function OnVideoApply2() {
    var index = objName.substr(7);
    var val = 0;
    if ($("#video_rd2")[0].checked == true)
        val = 1;
    else if ($("#video_rd3")[0].checked == true)
        val = 2;
    if (videoList[index] != null) {
        videoList[index].type = val;
    }
    closePopup();
}
function onChangeWebColor(color, index) {
    $("#tblWebPreviewBtn").css("background-color", color);
    $("#tdWebColorBtn" + index).addClass("clsColorBtnSel");
    $("#hdWebColorIndex").val(index);
}
function onChangeDefaultWebBtn(text, index) {
    $("#spWebPreviewText").html(text);
    $("#tdWebModeBtn" + index).addClass("clsColorBtnSel");
    $("#hdWebModeIndex").val(index);
}
function OnWebApply() {
    var index = objName.substr(5);

    var color_index = $("#hdWebColorIndex").val();
    var mode_index = $("#hdWebModeIndex").val();
    /*웹버튼이 기본형인 경우 처리부분*/
    if ($("#web_url").val() == "" || $("#web_url").val() == "URL") {
        alert("웹 URL을 입력해주세요.");
        return;
    }
    if ($("#web_url").val().substr(0, 7) != "http://" && $("#web_url").val().substr(0, 8) != "https://") {
        alert("URL은 http://example.com 형식으로 입력해주셔야 합니다.");
        return;
    }
    var empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
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

    if ($('.rdbWeb1').find('input:checked').val() == 0) {
        var pos = $(objName).position();

        /*var element = '<div id="temp" style="min-width:80px; width: 100px; height:auto; position:absolute;">';
        element += '<img style="width:100%; height:100%; border:1px solid Gray;" src="img/web_1.png"></img>';
        //패널 추가
        element += "<div class='panel'>";
        element += "<a class='delete-btn'>Delete</a>";
        element += "<a class='edit-btn'>Edit</a>";
        element += "</div>";*/
        var title = $("#spWebPreviewText").html();
        var color = $("#tblWebPreviewBtn").css("background-color");
        element = empty_obj2 + panel_obj;
        jQuery(element).appendTo("#editframe");
        $(".tempcontent" + " img").attr("src", "img/cam_icon03.png");
        $(".tempcontent" + " span").html(title);
        //$(".tempcontent" + " span").css("color", color);
        $(".tempcontent > table").css("background-color", color);
        $(".tempclass").removeClass("tempclass");
        $(".tempcontent").removeClass("tempcontent");

        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": $(objName).css("z-index") });
        //현재 선택된 오브젝트를 삭제한다.
        $(objName).remove();
        $("#temp").addClass("dragged_object");
        $("#temp").attr("id", objName.substr(1));
        //드래깅가능 설정
        $(objName).draggable({
            containment: "parent"
        });
        //디비에 등록
        var viewopt = $('.rdbWeb2').find('input:checked').val();
        webList[index] = { backurl: "none", url: encodeURIComponent($("#web_url").val()), view: viewopt, type: 0, title: title, color: color, color_index:color_index, mode_index:mode_index, objsize: 0 };
        //세부옵션 비활성화시키기
        //패널사건추가
        add_DoubleClickEvent();

    }
    /***웹버튼이 기본형인 경우 처리부분***/

    /*웹버튼이 제작형인 경우 처리부분*/
    else if ($('.rdbWeb1').find('input:checked').val() == 1) {
        if (isFileChange) {
            var file = document.getElementById("webbtn_path");
            var size = file.files[0].size / 1053317.6;
            ShowProgress();
            var data = new FormData();
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=2&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                    //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                    //패널 추가
                    element += panel_obj;

                    jQuery(element).appendTo("#editframe");
                    if (webList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName + " img").load(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    });
                    /*setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);*/
                    //디비에 등록
                    var viewopt = $('.rdbWeb2').find('input:checked').val();
                    webList[index] = { backurl: server_url + data, url: encodeURIComponent($("#web_url").val()), view: viewopt, type: 1, title: title, color: color, objsize: size };

                    //패널사건추가
                    add_DoubleClickEvent();

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("웹버튼등록과정에 오류가 발생하였습니다.");
                }
            });
            //파일컨트롤 초기화
            $("#webbtn_path").replaceWith($("#webbtn_path").clone(true));
            isFileChange = 0;
        }
        else {
            if (webList[index] != null) {
                if (webList[index].backurl == "none") {
                    alert("버튼이미지를 등록해주세요.");
                    return;
                }
                pos = $(objName).position();
                var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                element += '<img style="width:100%; height:100%" src="' + webList[index].backurl + '"></img>';
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                $("#temp").css({ "left": pos.left, "top": pos.top });
                $("#temp").css({ "z-index": $(objName).css("z-index") });
                //현재 선택된 오브젝트를 삭제한다.
                $(objName).remove();
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "web_" + index);
                //크기조종
                $("#web_" + index).draggable({
                    containment: "parent"
                });
                $("#web_" + index).resizable({
                    aspectRatio: true,
                    containment: "parent"
                });
                //디비에 등록
                viewopt = $('.rdbWeb2').find('input:checked').val();
                webList[index] = { backurl: webList[index].backurl, url: encodeURIComponent($("#web_url").val()), view: viewopt, type: 1, objsize: webList[index].objsize };

                //패널사건추가
                add_DoubleClickEvent();
            }
            else {
                alert("버튼이미지를 등록해주세요.");
                return;
            }
        }
    }
    closePopup();
    /***웹버튼이 제작형인 경우 처리부분***/
}
function OnImageApply1() {
    var index = objName.substr(5);

    var type = 0;
    if ($("#imgview_rd2")[0].checked == true)
        type = 1;

    if (isFileChange) {
        var file = document.getElementById("image_file");
        var size = file.files[0].size / 1053317.6;
        ShowProgress();
        //create new FormData instance to transfer as Form Type
        var data = new FormData();
        // add the file intended to be upload to the created FormData instance
        data.append("upfile", file.files[0]);
        $.ajax({
            url: 'PostUpload.aspx?type=11&content_id=' + CONTENT_ID,
            type: "post",
            data: data,
            // cache: false,
            processData: false,
            contentType: false,
            success: function (data, textStatus, jqXHR) {
                //빈오브젝트를 오브젝트로 바구어 주어야 한다.
                //setTimeout(function () {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                    //패널 추가
                    element += panel_obj;

                    jQuery(element).appendTo("#editframe");
                    if (imgList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName + " img").load(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    });
                    /*setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);*/

                    //디비에 등록
                    imgList[index] = { url: server_url + data, type: type, objsize: size };

                    //패널사건추가
                    add_DoubleClickEvent();
                    //setMarkerImg(data);
                    $("#image_file").replaceWith($("#image_file").clone(true));
                //}, 3000);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                HideProgress();
                alert("이미지 등록과정에 오류가 발생하였습니다.");
            }
        });
        isFileChange = 0;

    }
    else {
        if (imgList[index] != null) {
            if (imgList[index].url == "none") {
                alert("이미지를 선택해주세요.");
                return;
            }
            var pos = $(objName).position();
            var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
            element += '<img style="width:100%; height:100%" src="' + imgList[index].url + '"></img>';
            //패널 추가
            element += panel_obj;
            jQuery(element).appendTo("#editframe");
            $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
            $("#temp").css({ "left": pos.left, "top": pos.top });
            $("#temp").css({ "z-index": $(objName).css("z-index") });
            //현재 선택된 오브젝트를 삭제한다.
            $(objName).remove();
            $("#temp").addClass("dragged_object");
            $("#temp").attr("id", "img_" + index);
            //크기조종
            $("#img_" + index).draggable({
                containment: "parent"
            });
            $("#img_" + index).resizable({
                aspectRatio: true,
                containment: "parent"
            });
            //디비에 등록
            imgList[index] = { url: imgList[index].url, type: type, objsize: imgList[index].objsize };
            
            //패널사건추가
            add_DoubleClickEvent();
        }
        else {
            alert("이미지를 선택해주세요.");
            return;
        }
    }
    closePopup();
}
function OnImageApply2() {
    var index = objName.substr(5);

    var type = 0;
    if ($("#imgview_rd2")[0].checked == true)
        type = 1;
        
    if (imgList[index] != null) {
        imgList[index].type = type;
    }
    closePopup();
}
function OnSlideApply2() {
    var index = objName.substr(7);

    var type = 0;
    if( $('.rdoSlideViewType').find('input')[1].checked )
        type = 1;
        
    if (slideList[index] != null) {
        slideList[index].type = type;
    }
    closePopup();
}

function OnSlideApply1() {
    var index = objName.substr(7);
    var type = 0;
    if ($('.rdoSlideViewType').find('input')[1].checked) type = 1;

    var showtype = 0;
    if( $('.rdoSlideShowType').find('input')[1].checked) showtype = 1;
    if( $('.rdoSlideShowType').find('input')[2].checked) showtype = 2;

    var playtype = 0;
    if ($('.rdoSlidePlayType').find('input')[1].checked) playtype = 1;
    
    var dimension;
    var objsize = 0;
    var imageindex = 0;
    var prevArray = new Array();
    for (i = 1; i < 11; i++) {
        var imageitem = $("#tdSlide" + i + "Image .slideImg");
        if (imageitem.attr("src") != "") {
            prevArray[imageindex] = imageitem.attr("src");
            if(imageitem.attr("src").substr(0,4) != "http")
                prevArray[imageindex] = server_url + imageitem.attr("src");
            imageindex++;
            dimension = imageitem.naturalWidth / imageitem.naturalHeight;
            $.ajax({
                url: "getFileSize.aspx?imgurl=" + encodeURI(imageitem.attr("src")),
                type: 'POST',
                async: false,

                success: function (data) {
                    objsize += parseFloat(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    }
    if (prevArray.length == 0) {
        alert("한개 이상의 이미지를 등록하셔야 합니다.");
        return;
    }
    var prev_count = prevArray.length;
    for (i = prev_count; i < 10; i++) {
        prevArray[i] = "";
    }
    /*새로 추가 및 수정*/
    var pos = $(objName).position();
    var element = '<div id="temp" style="width: 150px;height:' + 150 / dimension + 'px; position:absolute; ">';
    element += '<img style="width:100%;height:100%" src="' + prevArray[0] + '"></img>';
    //패널 추가
    element += panel_obj;
    jQuery(element).appendTo("#editframe");
    if (slideList[index] != null) {
        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
    }
    $("#temp").css({ "left": pos.left, "top": pos.top });
    $("#temp").css({ "z-index": $(objName).css("z-index") });
    //현재 선택된 오브젝트를 삭제한다.
    $(objName).remove();
    $("#temp").addClass("dragged_object");
    $("#temp").attr("id", objName.substr(1));
    //크기조종
    $(objName).draggable({
        containment: "parent"
    });
    $(objName).resizable({
        aspectRatio: true,
        containment: "parent"
    });
    //디비에 등록

    slideList[index] = { type: type, showtype: showtype, playtype: playtype, prev_count: prevArray.length,
        url1: prevArray[0],
        url2: prevArray[1],
        url3: prevArray[2],
        url4: prevArray[3],
        url5: prevArray[4],
        url6: prevArray[5],
        url7: prevArray[6],
        url8: prevArray[7],
        url9: prevArray[8],
        url10: prevArray[9],
        objsize: objsize
    };
    //패널사건추가
    add_DoubleClickEvent();
    /***새로 추가 및 수정***/
    closePopup();
}

function onChangeCaptureType(type) {
    $("#hdCaptureType").val(type);
    $("#spCapture").html(type == 0 ? "Chroma-key photo" : "함께사진찍기");    
    $("#tdCaptureModeBtn" + (type + 1)).addClass("clsColorBtnSel");

}
function onChangeCaptureColor(color,index) {
    //$("#spCapture").css("color", color);
    $("#hdCaptureColorIndex").val(index);
    $("#tblCapturePreviewBtn").css("background-color", color);
}

function OnCaptureApply() {
    if (capCount == 0) {
        alert("한개 이상의 이미지를 등록하셔야 합니다.");
        return;
    }
    /*if (capCount != n_setteddprevs) {
        alert("모든 캡쳐이미지의 사이즈 및 위치를 지정해주셔야 합니다.");
        return;
    }*/
    var index = objName.substr(9);
    var objsize = 0;
    var prevArray = new Array();

    var buttontype = $("#hdCaptureType").val();
    var color_index = $("#hdCaptureColorIndex").val();
    var color = $("#tblCapturePreviewBtn").css("background-color");
    var title = $("#spCapture").html();

    var empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
    empty_obj2 += "<div class='tempcontent' style='width:100%;height:100%' >";
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
    
    //캡쳐미리보기 사이즈 및 위치 설정부분
    var unitX2 = $("#capture_detail_div").width() / 100;
    var unitY2 = $("#capture_detail_div").height() / 100;
    var oX2 = $("#capture_detail_div").position().left;
    var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();
    var slide1 = "", slide2 = "", slide3 = "", slide4 = "", slide5 = "";
    var width1 = 0, width2 = 0, width3 = 0, width4 = 0, width5 = 0;
    var height1 = 0, height2 = 0, height3 = 0, height4 = 0, height5 = 0;
    var posX1 = 0, posX2 = 0, posX3 = 0, posX4 = 0, posX5 = 0;
    var posY1 = 0, posY2 = 0, posY3 = 0, posY4 = 0, posY5 = 0;

    var imgpos = 1;
    for (i = 1; i <= 5; i++) {
        prevArray[i] = "";
    }
    for (i = 1; i <= 5; i++) {
        var imgurl = "";
        imgurl = $("#capimgPrev" + i).attr("src");
        if ($("#capimgPrev" + i).attr("src") != "" && $("#capimgPrev" + i).attr("src").substr(0, 4) != "http")
            imgurl = server_url + $("#capimgPrev" + i).attr("src");
        if (imgurl != "") {
            prevArray[imgpos] = imgurl;
            $.ajax({
                url: "getFileSize.aspx?imgurl=" + encodeURI(imgurl),
                type: 'POST',
                async: false,
                success: function (data) {
                    objsize += parseFloat(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            var ctrl = "controlcapprev" + i;
            switch (imgpos) {
                case 1:
                    slide1 = imgurl;
                    width1 = $("#" + ctrl).width() / unitX2;
                    height1 = $("#" + ctrl).height() / unitY2;
                    posX1 = $("#" + ctrl).position().left / unitX2;
                    posY1 = $("#" + ctrl).position().top / unitY2;
                    break;
                case 2:
                    slide2 = imgurl;
                    width2 = $("#" + ctrl).width() / unitX2;
                    height2 = $("#" + ctrl).height() / unitY2;
                    posX2 = $("#" + ctrl).position().left / unitX2;
                    posY2 = $("#" + ctrl).position().top / unitY2;
                    break;
                case 3:
                    slide3 = imgurl;
                    width3 = $("#" + ctrl).width() / unitX2;
                    height3 = $("#" + ctrl).height() / unitY2;
                    posX3 = $("#" + ctrl).position().left / unitX2;
                    posY3 = $("#" + ctrl).position().top / unitY2;
                    break;
                case 4:
                    slide4 = imgurl;
                    width4 = $("#" + ctrl).width() / unitX2;
                    height4 = $("#" + ctrl).height() / unitY2;
                    posX4 = $("#" + ctrl).position().left / unitX2;
                    posY4 = $("#" + ctrl).position().top / unitY2;
                    break;
                case 5:
                    slide5 = imgurl;
                    width5 = $("#" + ctrl).width() / unitX2;
                    height5 = $("#" + ctrl).height() / unitY2;
                    posX5 = $("#" + ctrl).position().left / unitX2;
                    posY5 = $("#" + ctrl).position().top / unitY2;
                    break;
            }
            imgpos++;
        }
    }
    /*새로 추가*/
    if (captureList[index] == null) {
        /*캡쳐버튼이 기본형일때*/
        if ($('.rdbCapture').find('input:checked').val() == 0) {
            var pos = $(objName).position();

            var element = empty_obj2;
            element += panel_obj;
            jQuery(element).appendTo("#editframe");

            $(".tempcontent" + " img").attr("src", "img/cam_icon04.png");
            $(".tempcontent" + " span").html(title);
            $(".tempcontent > table").css("background-color", color);
            $(".tempclass").removeClass("tempclass");
            $(".tempcontent").removeClass("tempcontent");

            $("#temp").css({ "left": pos.left, "top": pos.top });
            $("#temp").css({ "z-index": $(objName).css("z-index") });
            //현재 선택된 오브젝트를 삭제한다.
            $(objName).remove();
            $("#temp").addClass("dragged_object");
            $("#temp").attr("id", objName.substr(1));
            //크기조종
            $(objName).draggable({
                containment: "parent"
            });

            //패널사건추가
            add_DoubleClickEvent();
            
        }
        /***캡쳐버튼이 기본형일때***/
        /*캡쳐버튼이 제작형일때*/
        else {
            if (!isFileChange) {
                alert("버튼이미지를 등록해주세요.");
                return;
            }
            var file = document.getElementById("capturebtn_path");
            var btnsize = file.files[0].size / 1053317.6;

            ShowProgress();
            var data = new FormData();
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=4&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                    //패널 추가
                    element += panel_obj;
                    jQuery(element).appendTo("#editframe");
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName + " img").load(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    });

                    //패널사건추가
                    add_DoubleClickEvent();
                    

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("캡쳐버튼등록과정에 오류가 발생하였습니다.");
                }
            });
            $("#capturebtn_path").replaceWith($("#capturebtn_path").clone(true));
            isFileChange = 0;
        }
        /***캡쳐버튼이 제작형일때***/        
    }
    /***새로 추가***/
    /*수정*/
    else {
        /*캡쳐버튼이 기본형일때*/
        if ($('.rdbCapture').find('input:checked').val() == 0) {
            pos = $(objName).position();

            element = empty_obj2 + panel_obj;
            jQuery(element).appendTo("#editframe");
            $(".tempcontent" + " img").attr("src", "img/cam_icon09.png");
            $(".tempcontent" + " span").html(title);
            $(".tempcontent > table").css("background-color", color);
            $(".tempclass").removeClass("tempclass");
            $(".tempcontent").removeClass("tempcontent");

            $("#temp").css({ "left": pos.left, "top": pos.top });
            $("#temp").css({ "z-index": $(objName).css("z-index") });

            //현재 선택된 오브젝트를 삭제한다.
            $(objName).remove();
            $("#temp").addClass("dragged_object");
            $("#temp").attr("id", objName.substr(1));
            //크기조종
            $(objName).draggable({
                containment: "parent"
            });
            
            //패널사건추가
            add_DoubleClickEvent();
            
        }
        /***캡쳐버튼이 기본형일때***/
        /*캡쳐버튼이 제작형일때*/
        else {
            if (!isFileChange) {
                if (captureList[index].backurl == "none") {
                    alert("버튼이미지를 등록해주세요.");
                    return;
                }
                $(objName).css({ "width": $(objName).width(), "height": $(objName).height() });
                //디비에 등록

                captureList[index].type = 1;

                //패널사건추가
                add_DoubleClickEvent();
                capCount = 0;
                closePopup();
                return;
            }

            file = document.getElementById("capturebtn_path");
            btnsize = file.files[0].size / 1053317.6;

            ShowProgress();
            data = new FormData();
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=4&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                    element += '<img width="100%" height="100%" src="' + data + '"></img>';
                    //패널 추가
                    element += panel_obj;
                    jQuery(element).appendTo("#editframe");
                    //$("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName + " img").load(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    });

                    captureList[index].backurl = server_url + data;
                    captureList[index].type = 1;

                    //패널사건추가
                    add_DoubleClickEvent();
                    

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("캡쳐버튼등록과정에 오류가 발생하였습니다.");
                }
            });
            $("#capturebtn_path").replaceWith($("#capturebtn_path").clone(true));
            isFileChange = 0;
        }
        /***캡쳐버튼이 제작형일때***/        
    }
    /***수정***/
    captureList[index] = { backurl: (captureList[index] == null ? "none" : captureList[index].backurl), type: 0, prev_count: capCount,
        slide1: slide1, width1: width1, height1: height1, posX1: posX1, posY1: posY1,
        slide2: slide2, width2: width2, height2: height2, posX2: posX2, posY2: posY2,
        slide3: slide3, width3: width3, height3: height3, posX3: posX3, posY3: posY3,
        slide4: slide4, width4: width4, height4: height4, posX4: posX4, posY4: posY4,
        slide5: slide5, width5: width5, height5: height5, posX5: posX5, posY5: posY5,
        buttontype: buttontype, color_index: color_index, color: color, title: title,
        objsize: objsize, btnsize: 0
    };
    closePopup();
}
function onSelBrightLess(bright) {
    $(".brightless").find("img").css("display", "none");
    $("#tdBright" + bright + " img").css("display", "");
    $("#hdBright").val(bright);
}
function OnThreeApply() {
    if ($("#front_angle").val() == "객체 정면 방향" || $("#run_times").val() == "실행횟수") {
        alert("객체 방향각도,실행횟수정보를 입력해주세요.");
        return;
    }
    var index = objName.substr(7);
    var type = $('.rdbThree').find('input:checked').val();
    var front_angle = $("#front_angle").val();
    if (front_angle > 360 || front_angle < 1) {
        alert("객체 방향각도를 정확히 입력해주세요.");
        return;
    }
    var brightness = $("#hdBright").val();
    var run_times = $("#run_times").val();

    if (isFileChange == 2) {

        var file1 = document.getElementById("three_file1");
        var file2 = document.getElementById("three_file2");
        var size1 = file1.files[0].size / 1053317.6;
        var size2 = file2.files[0].size / 1053317.6;

        /*용량제한*/
        if (size1 > 50) {
            alert("50MB 이하의 파일만 업로드가능합니다.");
            return;
        }

        if (size2 > 50) {
            alert("50MB 이하의 파일만 업로드가능합니다.");
            return;
        }
        /***용량제한***/
        ShowProgress();

        //create new FormData instance to transfer as Form Type
        var data = new FormData();
        // add the file intended to be upload to the created FormData instance
        data.append("upfile1", file1.files[0]);
        data.append("upfile2", file2.files[0]);
        $.ajax({
            url: 'PostUpload.aspx?type=5&content_id=' + CONTENT_ID,
            type: "post",
            data: data,
            // cache: false,
            processData: false,
            contentType: false,
            success: function (data, textStatus, jqXHR) {
                //setTimeout(function () {
                HideProgress();
                var pos = $(objName).position();
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

                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                if (threeList[index] != null) {
                    $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                }
                $("#temp").css({ "left": pos.left, "top": pos.top });
                $("#temp").css({ "z-index": $(objName).css("z-index") });
                $(objName).remove();
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", objName.substr(1));
                //크기조종
                $(objName).draggable({
                    containment: "parent"
                });
                $(objName + " img").load(function () {
                    $(objName).resizable({
                        aspectRatio: $(objName).width() / $(objName + " img").height(),
                        containment: "#editframe"
                    });
                });
                /*setTimeout(function () {
                $(objName).resizable({
                aspectRatio: $(objName).width() / $(objName + " img").height(),
                containment: "#editframe"
                });
                }, 500);*/

                //디비에 등록
                threeList[index] = { url1: server_url + data.split(":")[0], url2: server_url + data.split(":")[1],
                    front_angle: front_angle,
                    brightness: brightness,
                    run_times: run_times, type: type, objsize: size1 + size2
                };

                //패널사건추가
                add_DoubleClickEvent();
                //setMarkerImg(data);

                //}, 3000);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                HideProgress();
                alert("3D 애니메이션등록과정에 오류가 발생하였습니다.");
            }
        });
        $("#three_file1").replaceWith($("#three_file1").clone(true));
        $("#three_file2").replaceWith($("#three_file2").clone(true));
        isFileChange = 0;
    }
    else {
        if (threeList[index] != null) {
            if (threeList[index].url1 == "none" || threeList[index].url2 == "none") {
                alert("3D 애니메이션파일을 등록해주세요.");
                return;
            }
            var pos = $(objName).position();
            var angle = parseInt($("#front_angle").val());

            element = '<div id="temp" style="min-width:61px; min-height:55px;width:122px; height:110px; position:absolute">';
            //element += '<img style="width:100%; height:100%" src="img/3Dobject.png"></img>';

            if ((1 <= angle && angle <= 22) || (338 <= angle && angle<= 360)) {
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
            //패널 추가
            element += panel_obj;
            jQuery(element).appendTo("#editframe");
            $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
            $("#temp").css({ "left": pos.left, "top": pos.top });
            $("#temp").css({ "z-index": $(objName).css("z-index") });
            $(objName).remove();
            $("#temp").addClass("dragged_object");
            $("#temp").attr("id", "three_" + index);
            //크기조종
            $(objName).draggable({
                containment: "parent"
            });
            $(objName + " img").load(function () {
                $(objName).resizable({
                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                    containment: "#editframe"
                });
            });
            /*setTimeout(function () {
                $(objName).resizable({
                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                    containment: "#editframe"
                });
            }, 500);*/

            //디비에 등록
            var val = $('.rdbThree').find('input:checked').val();
            threeList[index] = { url1: threeList[index].url1, url2: threeList[index].url2,
                front_angle: front_angle,
                brightness: brightness,
                run_times: run_times, type: type, objsize: threeList[index].objsize
            };

            //패널사건추가
            add_DoubleClickEvent();
        }
        else {
            alert("unity3d파일과 assetbundle을 모두 등록해주셔야 합니다.");
            return;
        }
    }
    closePopup();
}
function onChangeTelColor(color, index) {
    $("#tblTelPreviewBtn").css("background-color", color);
    $("#tdTelColorBtn" + index).addClass("clsColorBtnSel");
    $("#hdTelColorIndex").val(index);
}
function onChangeDefaultTelBtn(text, index) {
    $("#spTelPreviewText").html(text);
    $("#tdTelModeBtn" + index).addClass("clsColorBtnSel");
    $("#hdTelModeIndex").val(index);
}
function OnTelApply1() {
    if ($("#tel_no").val() == "" || $("#tel_no").val() == "전화번호 '-' 생략") {
        alert("전화번호를 입력해주세요.");
        return;
    }
    var index = objName.substr(5);

    var color_index = $("#hdTelColorIndex").val();
    var mode_index = $("#hdTelModeIndex").val();

    var empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
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

    var threemode = 0;
    if ($("#rdTel1")[0].checked == true)
        threemode = 0;
    else if ($("#rdTel2")[0].checked == true)
        threemode = 1;

    if ($('.rdbTel1').find('input:checked').val() == 0) {
        // 일반형인 경우
        var pos = $(objName).position();
        var title = $("#spTelPreviewText").html();
        var color = $("#tblTelPreviewBtn").css("background-color");       
        
        element = empty_obj2 + panel_obj;
        jQuery(element).appendTo("#editframe");
        $(".tempcontent" + " img").attr("src", "img/cam_icon04.png");
        $(".tempcontent" + " span").html(title);        
        $(".tempcontent > table").css("background-color", color);
        $(".tempclass").removeClass("tempclass");
        $(".tempcontent").removeClass("tempcontent");

        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": $(objName).css("z-index") });
        //현재 선택된 오브젝트를 삭제한다.
        $(objName).remove();
        $("#temp").addClass("dragged_object");
        $("#temp").attr("id", objName.substr(1));
        //드래깅가능 설정
        $(objName).draggable({
            containment: "parent"
        });
        //디비에 등록
        var viewopt = $('.rdbTel2').find('input:checked').val();
        telList[index] = { backurl: "none", tel_no: $("#tel_no").val(), type: 0, threemode: threemode, title: title, color: color, color_index:color_index, mode_index:mode_index, objsize: 0 };
        //패널사건추가
        add_DoubleClickEvent();
    }
    /*전화버튼이 제작형인 경우 처리부분*/
    else if ($('.rdbTel1').find('input:checked').val() == 1) {
        if (isFileChange) {
            var file = document.getElementById("telbtn_path");
            var size = file.files[0].size / 1053317.6;
            ShowProgress();
            var data = new FormData();
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=6&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                    //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                    //패널 추가
                    element += panel_obj;

                    jQuery(element).appendTo("#editframe");
                    if (telList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName + " img").load(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    });
                    /*setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);*/
                    //디비에 등록

                    telList[index] = { backurl: server_url + data, tel_no: $("#tel_no").val(), type: 1, title: title, threemode: threemode, color: color, objsize: size };
                    //패널사건추가
                    add_DoubleClickEvent();

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("웹버튼등록과정에 오류가 발생하였습니다.");
                }
            });
            //파일컨트롤 초기화
            $("#telbtn_path").replaceWith($("#telbtn_path").clone(true));
            isFileChange = 0;
        }
        else {
            if (telList[index] != null) {
                if (telList[index].backurl == "none") {
                    alert("버튼이미지를 등록해주세요.");
                    return;
                }
                pos = $(objName).position();
                var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                element += '<img style="width:100%; height:100%" src="' + telList[index].backurl + '"></img>';
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                $("#temp").css({ "left": pos.left, "top": pos.top });
                $("#temp").css({ "z-index": $(objName).css("z-index") });
                //현재 선택된 오브젝트를 삭제한다.
                $(objName).remove();
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "tel_" + index);
                //크기조종
                $("#tel_" + index).draggable({
                    containment: "parent"
                });
                $("#tel_" + index).resizable({
                    aspectRatio: true,
                    containment: "parent"
                });
                //디비에 등록
                telList[index] = { backurl: telList[index].backurl, tel_no: $("#tel_no").val(), type: 1, threemode: threemode, objsize: telList[index].objsize };
                //패널사건추가
                add_DoubleClickEvent();
            }
            else {
                alert("버튼이미지를 등록해주세요.");
                return;
            }
        }
    }
    closePopup();
}
function OnTelApply2() 
{
    var index = objName.substr(5);
    var threemode = 0;
    if ($("#rdTel1")[0].checked == true)
        threemode = 0;
    else if ($("#rdTel2")[0].checked == true)
        threemode = 1;
    if (telList[index] != null) {
        telList[index].threemode = threemode;
    }
    closePopup();
}

function onChangeGoogleColor(color,index) {
    $("#tblGooglePreviewBtn").css("background-color", color);
    $("#tdGoogleColorBtn" + index).addClass("clsColorBtnSel");
    $("#hdGoogleColorIndex").val(index);
}
function onChangeDefaultGoogleBtn(text,index) {
    $("#spGooglePreviewText").html(text);
    $("#tdGoogleModeBtn" + index).addClass("clsColorBtnSel");
    $("#hdGoogleModeIndex").val(index);
}
function OnGoogleMapApply() {
    if ($("#coordinate").val() == "" || $("#coordinate").val() == "좌표값:Lat,Lng") {
        alert("좌표값을 입력해주세요.");
        return;
    }
    var index = objName.substr(11);

    var color_index = $("#hdGoogleColorIndex").val();
    var mode_index = $("#hdGoogleModeIndex").val();

    var empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
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

    if ($('.rdbGoogle1').find('input:checked').val() == 0) {
        var pos = $(objName).position();

        var title = $("#spGooglePreviewText").html();
        var color = $("#tblGooglePreviewBtn").css("background-color");        
        element = empty_obj2 + panel_obj;
        jQuery(element).appendTo("#editframe");
        $(".tempcontent" + " img").attr("src", "img/cam_icon05.png");
        $(".tempcontent" + " span").html(title);
        $(".tempcontent > table").css("background-color", color);
        $(".tempclass").removeClass("tempclass");
        $(".tempcontent").removeClass("tempcontent");

        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": $(objName).css("z-index") });
        //현재 선택된 오브젝트를 삭제한다.
        $(objName).remove();
        $("#temp").addClass("dragged_object");
        $("#temp").attr("id", objName.substr(1));
        //드래깅가능 설정
        $(objName).draggable({
            containment: "parent"
        });
        //디비에 등록
        googlemapList[index] = { backurl: "none", coordinate: $("#coordinate").val(), type: 0, title: title, color: color, color_index: color_index, mode_index: mode_index, objsize: 0 };
        //패널사건추가
        add_DoubleClickEvent();

    }
    /***구글맵버튼이 기본형인 경우 처리부분***/

    /*구글맵버튼이 제작형인 경우 처리부분*/
    else if ($('.rdbGoogle1').find('input:checked').val() == 1) {
        if (isFileChange) {
            var file = document.getElementById("googlebtn_path");
            var size = file.files[0].size / 1053317.6;
            ShowProgress();
            var data = new FormData();
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=7&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                    //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                    //패널 추가
                    element += panel_obj;

                    jQuery(element).appendTo("#editframe");
                    if (googlemapList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName + " img").load(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    });
                    /*setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);*/
                    //디비에 등록
                    googlemapList[index] = { backurl: server_url + data, coordinate: $("#coordinate").val(), type: 1, title: title, color: color, objsize: size };
                    //패널사건추가
                    add_DoubleClickEvent();

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("구글맵버튼등록과정에 오류가 발생하였습니다.");
                }
            });
            //파일컨트롤 초기화
            $("#googlebtn_path").replaceWith($("#googlebtn_path").clone(true));
            isFileChange = 0;
        }
        else {
            if (googlemapList[index] != null) {
                if (googlemapList[index].backurl == "none") {
                    alert("버튼이미지를 등록해주세요.");
                    return;
                }
                pos = $(objName).position();
                var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                element += '<img style="width:100%; height:100%" src="' + googlemapList[index].backurl + '"></img>';
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                $("#temp").css({ "left": pos.left, "top": pos.top });
                $("#temp").css({ "z-index": $(objName).css("z-index") });
                //현재 선택된 오브젝트를 삭제한다.
                $(objName).remove();
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "googlemap_" + index);
                //크기조종
                $("#googlemap_" + index).draggable({
                    containment: "parent"
                });
                $("#googlemap_" + index).resizable({
                    aspectRatio: true,
                    containment: "parent"
                });
                //디비에 등록
                googlemapList[index] = { backurl: googlemapList[index].backurl, coordinate: $("#coordinate").val(), type: 1, objsize: googlemapList[index].objsize };

                //패널사건추가
                add_DoubleClickEvent();
            }
            else {
                alert("버튼이미지를 등록해주세요.");
                return;
            }
        }
    }
    closePopup();
}

function onChangeBoardType(type) {        
    //$("#spBorderPreview").html(type)
    $("#tdBoardTypeBtn" + (type + 1)).addClass("clsBoardTypeSel");
    var boardColor = $("#tdBoardColorBtn" + $("#hdTextColorBoardIndex").val() + " > table").css("background-color");
    $("#hdBoardIndex").val(type + 1);
    $("#tblNotepadPreviewBtn").css("background-color", boardColor);
    if (type == 0) {
        $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
        $("#tblNotepadPreviewBtn").attr("background", "");
    }
    else if (type == 1) {
        $("#tblNotepadPreviewBtn").removeClass("clsTableRadius").addClass("clsTableRightRadius");
        $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox0" + type + ".png");
    }
    else if (type == 2) {        
        $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").addClass("clsTableRadius");
        $("#tblNotepadPreviewBtn").attr("background", "");
    }
    else if (type == 3) {
        $("#tblNotepadPreviewBtn").css("background-color", "transparent");
        $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
        $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox0" + type + "_" + $("#hdTextColorBoardIndex").val() + ".png");
    }
}
//보드 배경 색상
function onChangeBoardColor(color, index) {
    var hdBoardType = $("#hdBoardIndex").val();
    if (hdBoardType == 5) {
        $("#tblNotepadPreviewBtn").css("background-color", "transparent");
        $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox04" + "_" + index + ".png");
    }
    else {
        $("#tblNotepadPreviewBtn").css("background-color", color);
    }
    $("#tdBoardColorBtn" + index).addClass("clsColorBtnSel");
    $("#hdTextColorBoardIndex").val(index);
}
//보드안의 텍스트 색상
function onChangeNotepadColor(color,index) {
    $("#spNotepadPreview").css("color", color);
    $("#tdNotepadColorBtn" + index).addClass("clsColorBtnSel");
    $("#hdTextColorTextIndex").val(index);
}

function OnNotepadApply1() {
    if ($("#notepad_content").val() == "" || $("#notepad_content").val() == "내용") {
        alert("내용을 입력해주세요.");
        return;
    }
    var index = objName.substr(9);

    var text_color_index = $("#hdTextColorTextIndex").val();
    var board_color_index = $("#hdTextColorBoardIndex").val();
    var board_type = $("#hdBoardIndex").val();

    /*$(objName).css({ "z-index": counter + 1 });
    */
    //디비에 등록
    var val = 0;
    if ($("#notepad_rd2")[0].checked == true)
        val = 1;
    var textplaymode = 0;
    if( $('.rdoTextPlayMode').find('input')[1].checked == true)
        textplaymode = 1;    

    var element = "<div id='temp' style='position:absolute; min-height:60px;min-width:98px'>";
    element += "<div class='tempcontent' style='width:100%;height:100%'>";
    element += "<table cellpadding='0' cellspacing='0' width='100%' height='100%' align='center' style='border-collapse:collapse;background-repeat:no-repeat;background-size:cover;'>";
    element += "	<tr>";
    element += "		<td width='100%' height='100%' align='center' valign='middle' style='border-style:none;color:" + $("#spNotepadPreview").css("color") + ";'>";
    element += "			<span style='word-break:break-word'>" + $("#notepad_content").val() + "</span>";
    element += "		</td>";
    element += "	</tr>";
    element += "</table>";
    element += "</div>"
    //패널 추가
    element += panel_obj;
    jQuery(element).appendTo("#editframe");
    var pos = $(objName).position();
    var board_color = $("#tblNotepadPreviewBtn").css("background-color");

    $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
    $("#temp").css({ "left": pos.left, "top": pos.top });

    if (board_type == 1) {
        $(".tempcontent > table").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
        $(".tempcontent > table").attr("background", "");
    }
    else if (board_type == 2) {
        $(".tempcontent > table").removeClass("clsTableRadius").addClass("clsTableRightRadius");
        $(".tempcontent > table").attr("background", "img/icon_textbox01.png");
    }
    else if (board_type == 3) {
        $(".tempcontent > table").removeClass("clsTableRightRadius").addClass("clsTableRadius");
        $(".tempcontent > table").attr("background", "");
    }
    else if (board_type == 4) {        
        $(".tempcontent > table").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
        $(".tempcontent > table").attr("background", "img/icon_textbox04_" + board_color_index + ".png");
    }
    $(".tempcontent > table").css("background-color", board_color);
    $("#temp").css({ "z-index": $(objName).css("z-index") });
    $(objName).remove();
    $("#temp").addClass("dragged_object");
    $("#temp").attr("id", "notepad_" + index);
    
    //$(".tempclass").removeClass("tempclass");
    $(".tempcontent").removeClass("tempcontent");

    $("#notepad_" + index).draggable({
        containment: "parent"
    });
    $("#notepad_" + index).resizable({
        aspectRatio: true,
        containment: "parent"
    });
    notepadList[index] = { content: $("#notepad_content").val(), color: $("#spNotepadPreview").css("color"), boardcolor: board_color, boardtype: board_type, text_color_index: text_color_index, board_color_index: board_color_index, textplaymode: textplaymode, view: val };
    /***새오브젝트 추가 및 수정***/
    add_DoubleClickEvent();
    closePopup();
}
function OnNotepadApply2() {
    var index = objName.substr(9);
    var val = 0;
    if ($("#notepad_rd2")[0].checked == true)
        val = 1;

    if (notepadList[index] != null) {
        notepadList[index].view = val;
    }
    closePopup();
}
function onChangeBGMColor(color,index) {
    $("#tblBGMPreviewBtn").css("background-color", color);
    $("#tdBGMColorBtn" + index).addClass("clsColorBtnSel");
    $("#hdBGMColorIndex").val(index);
}
function onChangeBGMType(type) {
    //$("#hdBGMType").val(type);
    $("#hdBGMModeIndex").val(type);
    $("#spNorBGMLabel").html(type == 1 ? "BGM" : "사운드");
    if (type == 1 || type == 2) {
        $("#tblBGMCustomPreviewBtn").css("display", "none");
        $("#tblBGMNorPreviewBtn").css("display", "");
    }
    else {
        $("#tblBGMCustomPreviewBtn").css("display", "");
        $("#tblBGMNorPreviewBtn").css("display", "none");
    }
    $("#imgCustomBGM").attr("src", "img/icon_bgm0" + (type == 3 ? 1 : 2) + ".png");
    $("#tdBGMModeBtn" + type).addClass("clsColorBtnSel");
}
function OnAudioApply2() {
    var index = objName.substr(7);
    var type = 0;
    if ($("#audiobtn_rd2")[0].checked == true)
        type = 1;
    else if ($("#audiobtn_rd3")[0].checked == true)
        type = 2;

    if (audioList[index] != null) {
        audioList[index].type = type;
    }
    closePopup();
}
function OnAudioApply1() {
    
    var index = objName.substr(7);

    var type = 0;
    if ($("#audiobtn_rd2")[0].checked == true) type = 1;
    else if ($("#audiobtn_rd3")[0].checked == true) type = 2;

    //var btntype = $("#hdBGMType").val();

    //색상번호
    var color_index = $("#hdBGMColorIndex").val();
    //버튼모양번호
    var mode_index = $("#hdBGMModeIndex").val();

    var btn_url="none";
    var url="none"

    //버튼종류번호
    var btnkind = 0;
    if ($('.rdbBGM1').find('input')[1].checked) btnkind = 1;
    else if ($('.rdbBGM1').find('input')[2].checked) btnkind = 2;

    var run_opt = (btnkind==0?1:0);

    var color = $("#tblBGMPreviewBtn").css("background-color");

    var empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
    if (mode_index == 1 || mode_index == 2) {
        empty_obj2 += "<div class='tempcontent' style='width:100%; height:100%'>";
        empty_obj2 += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
        empty_obj2 += "	<tr>";
        empty_obj2 += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
        empty_obj2 += "			<table cellpadding='0' cellspacing='0' width='175'>";
        empty_obj2 += "				<tr>";
        empty_obj2 += "					<td width='35' height='27' align='right'>";
        empty_obj2 += "						<img src='img/cam_icon09.png' width='19' height='19' border='0' />";
        empty_obj2 += "					</td>";
        empty_obj2 += "					<td width='140' height='27' align='center'>";
        empty_obj2 += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' ></span></font></b>";
        empty_obj2 += "					</td>";
        empty_obj2 += "				</tr>";
        empty_obj2 += "			</table>";
        empty_obj2 += "		</td>";
        empty_obj2 += "	</tr>";
        empty_obj2 += "</table>";
        empty_obj2 += "</div>";
    }
    else if (mode_index == 3 || mode_index == 4) {
        empty_obj2 += "<div class='tempcontent' style='width:100%; height:100%'>";
        empty_obj2 += "<img src='img/cam_icon09.png' width='50' height='50' border='0' />";
        empty_obj2 += "</div>";
    }

    /*새오브젝트 추가*/
    if (audioList[index] == null) {
        if (!isFileChange) {
            alert("사운드파일을 등록해주세요.");
            return;
        }
        var file = document.getElementById("audio_file");
        var size = file.files[0].size / 1053317.6;
        ShowProgress();

        //create new FormData instance to transfer as Form Type
        var data = new FormData();
        // add the file intended to be upload to the created FormData instance
        data.append("upfile", file.files[0]);
        $.ajax({
            url: 'PostUpload.aspx?type=9&content_id=' + CONTENT_ID,
            type: "post",
            data: data,
            // cache: false,
            processData: false,
            contentType: false,
            success: function (data, textStatus, jqXHR) {
                var audiotag = "<audio style='width:100%; height:100%;' controls>";
                audiotag += "<source src=" + data + ">";
                audiotag += "</audio>";

                var element = "<div id='temp' style='position:absolute'>";
                url = server_url + data;

                if (btnkind == 2) {
                    // 커스텀버튼                    
                    var file = document.getElementById("bgmbtn_path");
                    var size2 = file.files[0].size / 1053317.6;

                    var data = new FormData();
                    data.append("upfile", file.files[0]);
                    $.ajax({
                        url: 'PostUpload.aspx?type=2&content_id=' + CONTENT_ID,
                        type: "post",
                        data: data,
                        // cache: false,
                        processData: false,
                        contentType: false,
                        success: function (data, textStatus, jqXHR) {
                            HideProgress();
                            var pos = $(objName).position();
                            var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                            element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                            btn_url = server_url + data;

                            element += panel_obj;
                            jQuery(element).appendTo("#editframe");
                            if (audioList[index] != null) {
                                $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                            }
                            $("#temp").css({ "left": pos.left, "top": pos.top });
                            $("#temp").css({ "z-index": $(objName).css("z-index") });
                            //현재 선택된 오브젝트를 삭제한다.
                            $(objName).remove();
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", objName.substr(1));
                            //크기조종
                            $(objName).draggable({
                                containment: "parent"
                            });
                            $(objName + " img").load(function () {
                                $(objName).resizable({
                                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                                    containment: "#editframe"
                                });
                            });

                            audioList[index] = { url: url, btn_url: btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: size, color_index: color_index, mode_index: mode_index };

                            //패널사건추가
                            add_DoubleClickEvent();

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("오디오버튼등록과정에 오류가 발생하였습니다.");
                        }
                    });
                    //파일컨트롤 초기화
                    $("#bgmbtn_path").replaceWith($("#bgmbtn_path").clone(true));
                    isFileChange = 0;
                }
                else if (btnkind == 1) {
                    // 기본버튼
                    element = empty_obj2;
                }
                else {
                    element += audiotag;
                }
                //패널 추가
                if (btnkind != 2) {
                    element += panel_obj;
                    jQuery(element).appendTo("#editframe");

                    if (btnkind == 1) {
                        if (mode_index == 1 || mode_index == 2) {
                            $(".tempcontent" + " img").attr("src", "img/cam_icon07.png");
                            $(".tempcontent" + " span").html((mode_index == 1 || btnkind == 0) ? "BGM" : "사운드");
                            $(".tempcontent > table").css("background-color", color);
                            $(".tempclass").removeClass("tempclass");
                            $(".tempcontent").removeClass("tempcontent");
                        }
                        if (mode_index == 3) {
                            $(".tempcontent" + " img").attr("src", "img/icon_bgm01.png");
                            $(".tempclass").removeClass("tempclass");
                            $(".tempcontent").removeClass("tempcontent");
                        }
                        if (mode_index == 4) {
                            $(".tempcontent" + " img").attr("src", "img/icon_bgm02.png");
                            $(".tempclass").removeClass("tempclass");
                            $(".tempcontent").removeClass("tempcontent");
                        }
                    }
                    if (btnkind != 0) {
                        $("#temp" + " audio").css("display:none");
                    }
                    var pos = $(objName).position();
                    if (btnkind == 0)
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });

                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", "audio_" + index);
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    if (btnkind != 1) {
                        $(objName + " img").load(function () {
                            $(objName).resizable({
                                aspectRatio: $(objName).width() / $(objName + " img").height(),
                                containment: "#editframe"
                            });
                        });
                    }


                    audioList[index] = { url: server_url + data, btn_url: btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: size, color_index: color_index, mode_index: mode_index };

                    //패널사건추가
                    add_DoubleClickEvent();

                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                HideProgress();
                alert("사운드 등록과정에 오류가 발생하였습니다.");
            }
        });
        $("#audio_file").replaceWith($("#audio_file").clone(true));
        isFileChange = 0;

    }
    /***새오브젝트 추가***/

    /*수정*/
    else {
        if (isFileChange2 && !isFileChange) {
            var audiotag = "<audio style='width:100%; height:100%;' controls>";
            audiotag += "<source src=" + data + ">";
            audiotag += "</audio>";

            var element = "<div id='temp' style='position:absolute'>";
            if (btnkind == 2) {
                // 커스텀버튼                            
                var file = document.getElementById("bgmbtn_path");
                var size = file.files[0].size / 1053317.6;

                var data = new FormData();
                data.append("upfile", file.files[0]);
                $.ajax({
                    url: 'PostUpload.aspx?type=2&content_id=' + CONTENT_ID,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data, textStatus, jqXHR) {
                        HideProgress();
                        var pos = $(objName).position();
                        var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                        element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                        btn_url = server_url + data;
                        element += panel_obj;
                        jQuery(element).appendTo("#editframe");
                        if (audioList[index] != null) {
                            $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                        }
                        $("#temp").css({ "left": pos.left, "top": pos.top });
                        $("#temp").css({ "z-index": $(objName).css("z-index") });
                        //현재 선택된 오브젝트를 삭제한다.
                        $(objName).remove();
                        $("#temp").addClass("dragged_object");
                        $("#temp").attr("id", objName.substr(1));
                        //크기조종
                        $(objName).draggable({
                            containment: "parent"
                        });
                        $(objName + " img").load(function () {
                            $(objName).resizable({
                                aspectRatio: $(objName).width() / $(objName + " img").height(),
                                containment: "#editframe"
                            });
                        });

                        audioList[index] = { url: url, btn_url: btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: size, color_index: color_index, mode_index: mode_index };

                        //패널사건추가
                        add_DoubleClickEvent();

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("오디오버튼등록과정에 오류가 발생하였습니다.");
                    }
                });
                //파일컨트롤 초기화
                $("#bgmbtn_path").replaceWith($("#bgmbtn_path").clone(true));
                isFileChange = 0;
                isFileChange2 = 0;
            }
            else if (btnkind == 1) {
                // 기본버튼
                element = empty_obj2;
            }
            else {
                element += audiotag;
            }
            //패널 추가
            if (btnkind != 2) {
                element += panel_obj;
                jQuery(element).appendTo("#editframe");

                if (btnkind == 1) {
                    if (mode_index == 1 || mode_index == 2) {
                        $(".tempcontent" + " img").attr("src", "img/cam_icon07.png");
                        $(".tempcontent" + " span").html((mode_index == 1 || btnkind == 0) ? "BGM" : "사운드");
                        $(".tempcontent > table").css("background-color", color);
                        $(".tempclass").removeClass("tempclass");
                        $(".tempcontent").removeClass("tempcontent");
                    }
                    if (mode_index == 3) {
                        $(".tempcontent" + " img").attr("src", "img/icon_bgm01.png");
                        $(".tempclass").removeClass("tempclass");
                        $(".tempcontent").removeClass("tempcontent");
                    }
                    if (mode_index == 4) {
                        $(".tempcontent" + " img").attr("src", "img/icon_bgm02.png");
                        $(".tempclass").removeClass("tempclass");
                        $(".tempcontent").removeClass("tempcontent");
                    }
                }
                if (btnkind != 0) {
                    $("#temp" + " audio").css("display:none");
                }
                var pos = $(objName).position();
                if (btnkind == 2) {
                    $("#temp").css({ "width": $(objName).width(), "height": mode_index == 1 ? $(objName).width() * 42 / 50 : $(objName).width() * 42 / 33 });
                }
                else if (btnkind == 0) {
                    $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                }
                $("#temp").css({ "left": pos.left, "top": pos.top });
                $("#temp").css({ "z-index": $(objName).css("z-index") });

                $(objName).remove();
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "audio_" + index);
                //크기조종
                $(objName).draggable({
                    containment: "parent"
                });
                if (btnkind == 0) {
                    $(objName).resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });
                }
                if (btnkind != 1) {
                    $("#audio_" + i).resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });
                }

                audioList[index] = { url: server_url + data, btn_url: btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: size, color_index: color_index, mode_index: mode_index };

                //패널사건추가
                add_DoubleClickEvent();
            }
            $("#audio_file").replaceWith($("#audio_file").clone(true));
            isFileChange = 0;

        }
        if (isFileChange2 && isFileChange) {
            file = document.getElementById("audio_file");
            size = file.files[0].size / 1053317.6;
            ShowProgress();

            //create new FormData instance to transfer as Form Type
            data = new FormData();
            // add the file intended to be upload to the created FormData instance
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=9&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {                    
                        HideProgress();

                        var audiotag = "<audio style='width:100%; height:100%;' controls>";
                        audiotag += "<source src=" + data + ">";
                        audiotag += "</audio>";

                        var element = "<div id='temp' style='position:absolute'>";
                        if (btnkind == 2) {
                            // 커스텀버튼                            
                            var file = document.getElementById("bgmbtn_path");
                            var size = file.files[0].size / 1053317.6;
                                
                            var data = new FormData();
                            data.append("upfile", file.files[0]);
                            $.ajax({
                                url: 'PostUpload.aspx?type=2&content_id=' + CONTENT_ID,
                                type: "post",
                                data: data,
                                // cache: false,
                                processData: false,
                                contentType: false,
                                success: function (data, textStatus, jqXHR) {
                                    HideProgress();
                                    var pos = $(objName).position();
                                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                                    btn_url = server_url + data;
                                    element += panel_obj;
                                    jQuery(element).appendTo("#editframe");
                                    if (audioList[index] != null) {
                                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                                    }
                                    $("#temp").css({ "left": pos.left, "top": pos.top });
                                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                                    //현재 선택된 오브젝트를 삭제한다.
                                    $(objName).remove();
                                    $("#temp").addClass("dragged_object");
                                    $("#temp").attr("id", objName.substr(1));
                                    //크기조종
                                    $(objName).draggable({
                                        containment: "parent"
                                    });
                                    $(objName + " img").load(function () {
                                        $(objName).resizable({
                                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                                            containment: "#editframe"
                                        });
                                    });

                                    audioList[index] = { url: url, btn_url:btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: size, color_index: color_index, mode_index: mode_index };                               

                                    //패널사건추가
                                    add_DoubleClickEvent();

                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    HideProgress();
                                    alert("오디오버튼등록과정에 오류가 발생하였습니다.");
                                }
                            });
                            //파일컨트롤 초기화
                            $("#bgmbtn_path").replaceWith($("#bgmbtn_path").clone(true));
                            isFileChange = 0;
                        }
                        else if (btnkind == 1) {
                            // 기본버튼
                            element = empty_obj2;
                        }
                        else {
                            element += audiotag;
                        }
                        //패널 추가
                        if(btnkind!=2)
                        {
                            element += panel_obj;
                            jQuery(element).appendTo("#editframe");

                            if (btnkind == 1) {
                                if (mode_index == 1 || mode_index == 2) {
                                    $(".tempcontent" + " img").attr("src", "img/cam_icon07.png");
                                    $(".tempcontent" + " span").html((mode_index == 1 || btnkind == 0) ? "BGM" : "사운드");
                                    $(".tempcontent > table").css("background-color", color);
                                    $(".tempclass").removeClass("tempclass");
                                    $(".tempcontent").removeClass("tempcontent");
                                }
                                if (mode_index == 3) {
                                    $(".tempcontent" + " img").attr("src", "img/icon_bgm01.png");
                                }
                                if (mode_index == 4) {
                                    $(".tempcontent" + " img").attr("src", "img/icon_bgm02.png");
                                }
                            }
                            if (btnkind != 0) {
                                $("#temp" + " audio").css("display:none");
                            }
                            var pos = $(objName).position();
                            if (btnkind == 2) {
                                $("#temp").css({ "width": $(objName).width(), "height": mode_index == 1 ? $(objName).width() * 42 / 50 : $(objName).width() * 42 / 33 });
                            }
                            else if (btnkind == 0) {
                                $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                            }
                            $("#temp").css({ "left": pos.left, "top": pos.top });
                            $("#temp").css({ "z-index": $(objName).css("z-index") });

                            $(objName).remove();
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "audio_" + index);
                            //크기조종
                            $(objName).draggable({
                                containment: "parent"
                            });
                            if (btnkind == 0) {
                                $(objName).resizable({
                                    aspectRatio: true,
                                    containment: "parent"
                                });
                            }
                            if (btnkind != 1) {
                                $("#audio_" + i).resizable({
                                    aspectRatio: true,
                                    containment: "parent"
                                });
                            }

                            audioList[index] = { url: server_url + data, btn_url:btn_url,  type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: size, color_index:color_index, mode_index:mode_index };

                            //패널사건추가
                            add_DoubleClickEvent();
                        }
                        
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("사운드 등록과정에 오류가 발생하였습니다.");
                }
            });
            $("#audio_file").replaceWith($("#audio_file").clone(true));
            isFileChange = 0;
        }
        else {
            //디비에 등록

            var audiotag = "<audio style='width:100%; height:100%;' controls>";
            audiotag += "<source src=" + audioList[index].url + ">";
            audiotag += "</audio>";

            var element = "<div id='temp' style='position:absolute'>";

            if (btnkind == 2) {
                // 커스텀버튼
                if (isFileChange) {
                    var file = document.getElementById("bgmbtn_path");
                    var size = file.files[0].size / 1053317.6;
                    
                    var data = new FormData();
                    data.append("upfile", file.files[0]);
                    $.ajax({
                        url: 'PostUpload.aspx?type=2&content_id=' + CONTENT_ID,
                        type: "post",
                        data: data,
                        // cache: false,
                        processData: false,
                        contentType: false,
                        success: function (data, textStatus, jqXHR) {
                            HideProgress();
                            var pos = $(objName).position();
                            var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                            element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                            btn_url = server_url + data;
                            element += panel_obj;
                            jQuery(element).appendTo("#editframe");
                            if (audioList[index] != null) {
                                $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                            }
                            $("#temp").css({ "left": pos.left, "top": pos.top });
                            $("#temp").css({ "z-index": $(objName).css("z-index") });
                            //현재 선택된 오브젝트를 삭제한다.
                            $(objName).remove();
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", objName.substr(1));
                            //크기조종
                            $(objName).draggable({
                                containment: "parent"
                            });
                            $(objName + " img").load(function () {
                                $(objName).resizable({
                                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                                    containment: "#editframe"
                                });
                            });

                            audioList[index] = { url: url, btn_url:btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: size, color_index: color_index, mode_index: mode_index };                               

                            //패널사건추가
                            add_DoubleClickEvent();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("오디오버튼등록과정에 오류가 발생하였습니다.");
                        }
                    });
                    //파일컨트롤 초기화
                    $("#bgmbtn_path").replaceWith($("#bgmbtn_path").clone(true));
                    isFileChange = 0;
                }                            
//                element = "<div id='temp' style='position:absolute; min-height:42px;min-width:" + (btntype == 0 ? "50" : "33") + "px'>";
//                element += '<img width="100%" height="100%" src="img/icon_bgm0' + (btntype == 0 ? 1 : 2) + '.png">';
            }
            else if (btnkind == 1) {
                element = empty_obj2;
            }
            else {
                element += audiotag;
            }
            //패널 추가
            if(btnkind!=2)
            {
                element += panel_obj;
                jQuery(element).appendTo("#editframe");

                if (btnkind == 1) {
                    if (mode_index == 1 || mode_index == 2) {
                        $(".tempcontent" + " img").attr("src", "img/cam_icon07.png");
                        $(".tempcontent" + " span").html((mode_index == 1 || btnkind == 0) ? "BGM" : "사운드");
                        $(".tempcontent > table").css("background-color", color);
                        $(".tempclass").removeClass("tempclass");
                        $(".tempcontent").removeClass("tempcontent");
                    }
                    if (mode_index == 3) {
                        $(".tempcontent" + " img").attr("src", "img/icon_bgm01.png");
                    }
                    if (mode_index == 4) {
                        $(".tempcontent" + " img").attr("src", "img/icon_bgm02.png");
                    }
                }
                if (btnkind != 0) {
                    $("#temp" + " audio").css("display:none");
                }
                var pos = $(objName).position();
                if (btnkind == 2) {
                    $("#temp").css({ "width": $(objName).width(), "height": mode_index == 0 ? $(objName).width() * 42 / 50 : $(objName).width() * 42 / 33 });
                }
                else if (btnkind == 0) {
                    $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                }
                $("#temp").css({ "left": pos.left, "top": pos.top });
                $("#temp").css({ "z-index": $(objName).css("z-index") });

                $(objName).remove();
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "audio_" + index);
                //크기조종
                $(objName).draggable({
                    containment: "parent"
                });
                if (btnkind != 1) {
                    $(objName).resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });
                }

                audioList[index] = { url: audioList[index].url, btn_url:btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: audioList[index].objsize, color_index:color_index, mode_index:mode_index };

                //HideProgress();

                add_DoubleClickEvent();
            }
        }
    }
    closePopup();
}

function OnChromakeyApply() {
    var index = objName.substr(11);
    /*새오브젝트 추가*/
    if (chromakeyList[index] == null) {
        if (!isFileChange) {
            alert("크로마키비디오 파일을 등록해주세요.");
            return;
        }
        var file = document.getElementById("chromakey_file");
        var size = file.files[0].size / 1053317.6;

        ShowProgress();
        //create new FormData instance to transfer as Form Type
        var data = new FormData();
        // add the file intended to be upload to the created FormData instance
        data.append("upfile", file.files[0]);
        $.ajax({
            url: 'PostUpload.aspx?type=10&content_id=' + CONTENT_ID,
            type: "post",
            data: data,
            // cache: false,
            processData: false,
            contentType: false,
            success: function (data, textStatus, jqXHR) {
                //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                //setTimeout(function () {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="width:150px; height:auto; position:absolute">';
                    element += '<video style="width:100%; height:auto" controls><source src="' + data + '"></video>';
                    //패널 추가
                    element += panel_obj;
                    jQuery(element).appendTo("#editframe");
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": $(objName).css("z-index") });
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    $(objName).resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });

                    //디비에 등록
                    var type = 0;
                    var run_opt = 0;
                    if ($("#chromakeyview_rd2")[0].checked == true)
                        type = 1;
                    if ($("#chromakeyrun_rd2")[0].checked == true)
                        run_opt = 1;
                    chromakeyList[index] = { url: server_url + data, type: type, run_opt: run_opt, objsize: size };

                    //패널사건추가
                    add_DoubleClickEvent();
                    //setMarkerImg(data);

                //}, 3000);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                HideProgress();
                alert("크로마키 등록과정에 오류가 발생하였습니다.");
            }
        });
        $("#chromakey_file").replaceWith($("#chromakey_file").clone(true));
        isFileChange = 0;

    }
    /***새오브젝트 추가***/

    /*수정*/
    else {
        if (isFileChange) {
            file = document.getElementById("chromakey_file");
            size = file.files[0].size / 1053317.6;

            ShowProgress();
            //create new FormData instance to transfer as Form Type
            data = new FormData();
            // add the file intended to be upload to the created FormData instance
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=10&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                    //setTimeout(function () {
                        HideProgress();
                        var pos = $(objName).position();
                        var element = '<div id="temp" style="width: 150px; height: auto; position:absolute">';
                        element += '<video style="width:100%; height:auto" controls><source src="' + data + '"></video>';
                        //패널 추가
                        element += panel_obj;
                        jQuery(element).appendTo("#editframe");
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                        $("#temp").css({ "left": pos.left, "top": pos.top });
                        $("#temp").css({ "z-index": $(objName).css("z-index") });
                        $(objName).remove();
                        $("#temp").addClass("dragged_object");
                        $("#temp").attr("id", objName.substr(1));
                        //크기조종
                        $(objName).draggable({
                            containment: "parent"
                        });
                        $(objName).resizable({
                            aspectRatio: true,
                            containment: "parent"
                        });

                        //디비에 등록
                        var type = 0;
                        var run_opt = 0;
                        if ($("#chromakeyview_rd2")[0].checked == true)
                            type = 1;
                        if ($("#chromakeyrun_rd2")[0].checked == true)
                            run_opt = 1;
                        chromakeyList[index] = { url: server_url + data, type: type, run_opt: run_opt, objsize: size };

                        //패널사건추가
                        add_DoubleClickEvent();
                        //setMarkerImg(data);

                    //}, 3000);

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("크로마키 등록과정에 오류가 발생하였습니다.");
                }
            });
            $("#chromakey_file").replaceWith($("#chromakey_file").clone(true));
            isFileChange = 0;
        }
        else {
            //디비에 등록

            var type = 0;
            var run_opt = 0;
            if ($("#chromakeyview_rd2")[0].checked == true)
                type = 1;
            if ($("#chromakeyrun_rd2")[0].checked == true)
                run_opt = 1;
            chromakeyList[index] = { url: chromakeyList[index].url, type: type, run_opt: run_opt, objsize: chromakeyList[index].objsize };

            HideProgress();
        }
    }
    closePopup();
}
/***적용하기 버튼을 누를때 처리부***/

/*비디오파일 추가하는 부분*/
function OnAddVideo() {
    $("#video_file").click();

}
/***비디오파일 추가하는 부분***/

/*웹버튼이미지 추가하는 부분*/
function OnAddWebbtnImage() {
    $("#webbtn_path").click();

}
/***웹버튼이미지 추가하는 부분***/

/*3d 추가하는 부분*/
function OnAddThree1() {
    $("#three_file1").click();

}
function OnAddThree2() {
    $("#three_file2").click();

}
/***3d 추가하는 부분***/


/*텔버튼이미지 추가하는 부분*/
function OnAddTelbtn() {
    $("#telbtn_path").click();

}
/***텔버튼이미지 추가하는 부분***/

/*캡쳐버튼이미지 추가하는 부분*/
function OnAddCaptureBtn() {
    $("#capturebtn_path").click();

}
/***캡쳐버튼이미지 추가하는 부분***/
/*Google버튼이미지 추가하는 부분*/
function OnAddGoogleBtn() {
    $("#googlebtn_path").click();

}
/***Google버튼이미지 추가하는 부분***/
/*Google버튼이미지 추가하는 부분*/
function OnAddAudioFile() {
    $("#audio_file").click();

}
/***Google버튼이미지 추가하는 부분***/

/*Google버튼이미지 추가하는 부분*/
function OnAddChromakeyFile() {
    $("#chromakey_file").click();

}
/***Google버튼이미지 추가하는 부분***/