var isFileChange = 0;
var capdropflag = 0;
var n_setteddprevs = 0;
var n_selectedprev;
var no_drop;

$(document).ready(function () {
    /*텍스트박스 초기값 및 캡션 설정부분 */
    $("#web_url").focus(function () {
        var oldValue = $(this).val();
        if (oldValue == "URL") {
            $(this).val("");
        }
    });
    $("#web_url").blur(function () {
        var oldValue = $(this).val();
        if (oldValue == "" || oldValue == "URL") {
            $(this).val("URL");
        }
    });
    $("#tel_no").focus(function () {
        var oldValue = $(this).val();
        if (oldValue == "전화번호 '-' 생략") {
            $(this).val("");
        }
    });
    $("#tel_no").blur(function () {
        var oldValue = $(this).val();
        if (oldValue == "" || oldValue == "전화번호 '-' 생략") {
            $(this).val("전화번호 '-' 생략");
        }
    });
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
    $("#brightness").focus(function () {
        var oldValue = $(this).val();
        if (oldValue == "밝기") {
            $(this).val("");
        }
    });
    $("#brightness").blur(function () {
        var oldValue = $(this).val();
        if (oldValue == "" || oldValue == "밝기") {
            $(this).val("밝기");
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
    $("#coordinate").focus(function () {
        var oldValue = $(this).val();
        if (oldValue == "좌표값:Lat,Lng") {
            $(this).val("");
        }
    });
    $("#coordinate").blur(function () {
        var oldValue = $(this).val();
        if (oldValue == "" || oldValue == "좌표값:Lat,Lng") {
            $(this).val("좌표값:Lat,Lng");
        }
    });
    $("#notepad_content").on('keyup', function () {
        if ($(this).val().length >= 20) {
            alert("20자 이상 입력할수 없습니다");
        }
    });
    $("#front_angle").on('keyup', function () {
        if ($(this).val().length >= 4) {
            $(this).val($(this).val().substr(0, 3));
            return;
        }
    });
    $("#brightness").on('keyup', function () {
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
    $("#brightness").blur();
    $("#run_times").blur();
    $("#coordinate").blur();
    $("#notepad_content").blur();

    /***텍스트박스 초기값 및 캡션 설정부분 ***/

    /*세부옵션의 기본형과 제작형 절환시 파일 업로드버튼의 활성 비활성화*/
    $('.rdbWeb1').click(
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
        });
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
    $('input[name="twoD"]:radio').change(
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
    );

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

    disable_applybtn();
    /***세부옵션의 기본형과 제작형 절환시 파일 업로드버튼의 활성 비활성화***/

    //이미지슬라이드 변환
    $('#image_file').bind("change", function () {
        var file = this.files[0];
        if (file) {
            /*확장자체크*/
            var imgExtension = ($("#image_file").val().substr($("#image_file").val().length - 3)).toLowerCase();
            if (imgExtension != 'jpg' && imgExtension != 'png') {
                alert("파일형식이 바르지 않습니다.");
                return;
            }
            /***확장자체크***/

            /*용량제한*/
            if ((file.size / 1053317.6) > 3) {
                alert("30MB 이하의 파일만 업로드가능합니다.");
                return;
            }
            /***용량제한***/
            ShowProgress();
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
                    HideProgress();
                    addIndex++;
                    prevIndex++;
                    $("#image_file").val('');
                    var prev_element = '<div id="prev_div' + prevIndex + '" style="width: 80px; height:95px;float:left">';
                    prev_element += '<img id="imgPrev' + prevIndex + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + data + '" />';
                    prev_element += '<div style="height:25px;background-color:#cfcfcf;width:75px">';
                    prev_element += '<a class="cap_delete-btn" onclick="On_delPrev_img(' + prevIndex + ')">Delete</a>';
                    prev_element += '</div>';
                    prev_element += '</div>';
                    jQuery(prev_element).appendTo("#prevcontainer_div");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    $("#image_file").val('');
                    alert("이미지 등록과정에 오류가 발생하였습니다.");
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
            ShowProgress();
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
                    HideProgress();
                    capCount++;
                    capprevIndex++;
                    $("#capture_file").val('');
                    var prev_element = '<div id="capprev_div' + capprevIndex + '" style="width: 80px; height:95px;float:left">';
                    prev_element += '<img class="clscapprev" id="capimgPrev' + capprevIndex + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + data + '" />';
                    prev_element += '<div style="height:25px;background-color:#cfcfcf;width:75px">';
                    prev_element += '<a class="cap_delete-btn" onclick="OnRemoveCapPrev(' + capprevIndex + ')">Delete</a>';
                    prev_element += '</div>';
                    prev_element += '</div>';
                    jQuery(prev_element).appendTo("#capcontainer_div");


                    capprevdrag(capprevIndex);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
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
        var imgExtension = ($("#video_file").val().substr($("#video_file").val().length - 3)).toLowerCase();
        if (imgExtension != 'mp4') {
            alert("파일형식이 바르지 않습니다.");
            return;
        }
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
            if (n_setteddprevs >= 3)
                return;
            if (capdropflag != 1 || capdropflag == 2)
                return;
            var pos = $(ui.helper).position();
            $(n_selectedprev + " img").css({ "width": "100%", "height": "100%" });
            $(n_selectedprev).css({ "left": ui.position.left - $("#capture_detail_div").offset().left, "top": ui.position.top - $("#capture_detail_div").offset().top });
            $(n_selectedprev).removeClass("clscapprev");   //클론되지 않게 해주는 코드이다.
            n_setteddprevs++;
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
            //            if (capdropflag == 1 || capdropflag == 2) {
            //                $("#controlcapprev1 img").attr("src", ui.helper.attr("src"));
            //                capdropflag = 2;
            //                return;
            //            }
            if (n_setteddprevs >= 3) {
                return;
            }
            if ($(ui.draggable).clone().attr("src") == $("#controlcapprev1 img").attr("src") ||
               $(ui.draggable).clone().attr("src") == $("#controlcapprev2 img").attr("src") ||
               $(ui.draggable).clone().attr("src") == $("#controlcapprev3 img").attr("src")) {
                no_drop = true;
                return;
            }
            var element = $(ui.draggable).clone();
            var element_div;
            capdropflag = 1;
            no_drop = false;
            if ($("#controlcapprev1").length == 0) {
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
            }

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
function OnVideoApply() {
    var index = objName.substr(7);
    if ($("#video_path").val().substr(0, 22) == "http://www.youtube.com") {
        var index = objName.substr(7);
        var pos = $(objName).position();
        var element = '<div id="temp" style="width: 200px; height: auto; position:absolute"><video width="100%" height="100%" controls><source src="' + $("#video_path").val() + '"></video>';
        //패널 추가
        element += "<div class='panel'>";
        element += "<a class='delete-btn'>Delete</a>";
        element += "<a class='edit-btn'>Edit</a>";
        element += "</div>";

        element += "</div>";
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
            aspectRatio: $(objName).width() / $(objName + " video").height(),
            containment: "parent"
        });

        disable_applybtn();

        //디비에 등록
        //var val = $('.rdbVideo').find('input:checked').val();
        var val = 0;
        var run_opt = 0;
        if ($("#video_rd2")[0].checked == true)
            val = 1;
        else if ($("#video_rd3")[0].checked == true)
            val = 2;
        if ($("#videorun_rd2")[0].checked == true)
            run_opt = 1;
        videoList[index] = { url: $("#video_path").val(), type: val, run_opt: run_opt, objsize: 0 };

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
                setTimeout(function () {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="width: 200px; height: auto; position:absolute"><video width="100% height="100%" controls><source src="' + data + '"></video>';
                    //패널 추가
                    element += "<div class='panel'>";
                    element += "<a class='delete-btn'>Delete</a>";
                    element += "<a class='edit-btn'>Edit</a>";
                    element += "</div>";

                    element += "</div>";
                    jQuery(element).appendTo("#editframe");
                    if (videoList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName + " video").height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": counter + 1 });
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
                    disable_applybtn();

                    //디비에 등록
                    var val = 0;
                    var run_opt = 0;
                    if ($("#video_rd2")[0].checked == true)
                        val = 1;
                    else if ($("#video_rd3")[0].checked == true)
                        val = 2;
                    if ($("#videorun_rd2")[0].checked == true)
                        run_opt = 1;
                    videoList[index] = { url: server_url + data, type: val, run_opt: run_opt, objsize: size };

                    //패널사건추가
                    add_DoubleClickEvent();
                    //setMarkerImg(data);
                    $("#video_file").replaceWith($("#video_file").clone(true));
                }, 3000);

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
            var pos = $(objName).position();
            var element = '<div id="temp" style="width: 200px; height: auto; position:absolute"><video width="100%" height="100%" controls><source src="' + videoList[index].url + '"></video>';
            //패널 추가
            element += "<div class='panel'>";
            element += "<a class='delete-btn'>Delete</a>";
            element += "<a class='edit-btn'>Edit</a>";
            element += "</div>";

            element += "</div>";
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
                aspectRatio: $(objName).width() / $(objName + " video").height(),
                containment: "parent"
            });

            disable_applybtn();

            //디비에 등록
            var val = 0;
            var run_opt = 0;
            if ($("#video_rd2")[0].checked == true)
                val = 1;
            else if ($("#video_rd3")[0].checked == true)
                val = 2;
            if ($("#videorun_rd2")[0].checked == true)
                run_opt = 1;
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
}
function OnWebApply() {
    var index = objName.substr(5);
    /*웹버튼이 기본형인 경우 처리부분*/
    if ($("#web_url").val() == "" || $("#web_url").val() == "URL") {
        alert("웹 URL을 입력해주세요.");
        return;
    }
    if ($("#web_url").val().substr(0, 7) != "http://" && $("#web_url").val().substr(0, 8) != "https://") {
        alert("URL은 http://example.com 형식으로 입력해주셔야 합니다.");
        return;
    }
    if ($('.rdbWeb1').find('input:checked').val() == 0) {
        var pos = $(objName).position();
        var element = '<div id="temp" style="min-width:80px; width: 100px; height:auto; position:absolute;">';
        element += '<img style="width:100%; height:100%; border:1px solid Gray;" src="img/web_1.png"></img>';
        //패널 추가
        element += "<div class='panel'>";
        element += "<a class='delete-btn'>Delete</a>";
        element += "<a class='edit-btn'>Edit</a>";
        element += "</div>";

        element += "</div>";
        jQuery(element).appendTo("#editframe");
        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": counter + 1 });
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
        webList[index] = { backurl: "none", url: $("#web_url").val(), view: viewopt, type: 0, objsize: 0 };
        //세부옵션 비활성화시키기
        disable_applybtn();
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
                    var element = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                    //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                    //패널 추가
                    element += "<div class='panel'>";
                    element += "<a class='delete-btn'>Delete</a>";
                    element += "<a class='edit-btn'>Edit</a>";
                    element += "</div>";

                    element += "</div>";
                    jQuery(element).appendTo("#editframe");
                    if (videoList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": counter + 1 });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);
                    //디비에 등록
                    var viewopt = $('.rdbWeb2').find('input:checked').val();
                    webList[index] = { backurl: server_url + data, url: $("#web_url").val(), view: viewopt, type: 1 , objsize:size};
                    //세부옵션 비활성화시키기
                    disable_applybtn();
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
                var pos = $(objName).position();
                var element = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top: 0px; text-align:center">웹사이트</p>';
                element += '<img style="width:100%; height:100%" src="' + webList[index].backurl + '"></img>';
                //패널 추가
                element += "<div class='panel'>";
                element += "<a class='delete-btn'>Delete</a>";
                element += "<a class='edit-btn'>Edit</a>";
                element += "</div>";

                element += "</div>";
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
                var viewopt = $('.rdbWeb2').find('input:checked').val();
                webList[index] = { backurl: webList[index].backurl, url: $("#web_url").val(), view: viewopt, type: 1, objsize: webList[index].objsize };
                //세부옵션 비활성화시키기
                disable_applybtn();
                //패널사건추가
                add_DoubleClickEvent();
            }
            else {
                alert("버튼이미지를 등록해주세요.");
                return;
            }
        }
    }
    /***웹버튼이 제작형인 경우 처리부분***/
}
function OnImageApply() {
    if (addIndex == 0) {
        alert("한개 이상의 이미지를 등록하셔야 합니다.");
        return;
    }
    var dimension;
    var index = objName.substr(5);
    var objsize = 0;
    var prevArray = new Array();
    for (i = 0; i < 9; i++) {
        if ($("#prevcontainer_div")[0].children[i] != null) {
            prevArray[i] = $("#prevcontainer_div")[0].children[i].children[0].src;
            dimension = $("#prevcontainer_div")[0].children[0].children[0].naturalWidth / $("#prevcontainer_div")[0].children[0].children[0].naturalHeight;
            $.ajax({
                url: "getFileSize.aspx?imgurl=" + encodeURI($("#prevcontainer_div")[0].children[i].children[0].src),
                type: 'POST',
                async: false,

                success: function (data) {
                    objsize += parseFloat(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        else
            prevArray[i] = "none";
    }
    /*새로 추가 및 수정*/
    var pos = $(objName).position();
    var element = '<div id="temp" style="width: 150px;height:' + 150/dimension +  'px; position:absolute; ">';
    element += '<img style="width:100%;height:100%" src="' + prevArray[0] + '"></img>';
    //패널 추가
    element += "<div class='panel'>";
    element += "<a class='delete-btn'>Delete</a>";
    element += "<a class='edit-btn'>Edit</a>";
    element += "</div>";

    element += "</div>";
    jQuery(element).appendTo("#editframe");
    if (imgList[index] != null) {
        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
    }
    $("#temp").css({ "left": pos.left, "top": pos.top });
    $("#temp").css({ "z-index": counter + 1 });
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

    var type = 0;

    if ($("#imgview_rd2")[0].checked == true)
        type = 1;

	
    imgList[index] = { type:type, prev_count:addIndex,
        url1: prevArray[0],
        url2: prevArray[1],
        url3: prevArray[2],
        url4: prevArray[3],
        url5: prevArray[4],
	    url6: prevArray[5],
	    url7: prevArray[6],
	    url8: prevArray[7],
	    url9: prevArray[8], objsize:objsize
    };
    //세부옵션 비활성화시키기
    disable_applybtn();
    //패널사건추가
    add_DoubleClickEvent();
    addIndex = 0;
    /***새로 추가 및 수정***/
}
function OnCaptureApply() {
    if (capCount == 0) {
        alert("한개 이상의 이미지를 등록하셔야 합니다.");
        return;
    }
    if (capCount != n_setteddprevs) {
        alert("모든 캡쳐이미지의 사이즈 및 위치를 지정해주셔야 합니다.");
        return;
    }
    var index = objName.substr(9);
    var objsize = 0;
    var prevArray = new Array();
    for (i = 0; i < 3; i++) {
        if ($("#capcontainer_div")[0].children[i] != null) {
            prevArray[i] = $("#capcontainer_div")[0].children[i].children[0].src;
            $.ajax({
                url: "getFileSize.aspx?imgurl=" + encodeURI($("#capcontainer_div")[0].children[i].children[0].src),
                type: 'POST',
                async: false,
                success: function (data) {
                    objsize += parseFloat(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }
        else
            prevArray[i] = "none";
    }
    /*새로 추가*/
    if (captureList[index] == null) {
        /*캡쳐버튼이 기본형일때*/
        if ($('.rdbCapture').find('input:checked').val() == 0) {
            var pos = $(objName).position();
            var element = '<div id="temp" style="width: 123px; height:49px; position:absolute">';
            element += '<img style="width:100%; height:100%;" src="img/capturebtn.png"></img>';
            //패널 추가
            element += "<div class='panel'>";
            element += "<a class='delete-btn'>Delete</a>";
            element += "<a class='edit-btn'>Edit</a>";
            element += "</div>";

            element += "</div>";
            jQuery(element).appendTo("#editframe");
            $("#temp").css({ "left": pos.left, "top": pos.top });
            $("#temp").css({ "z-index": counter + 1 });
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
            //캡쳐미리보기 사이즈 및 위치 설정부분
            var unitX2 = $("#capture_detail_div").width() / 100;
            var unitY2 = $("#capture_detail_div").height() / 100;
            var oX2 = $("#capture_detail_div").position().left;
            var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();
            var width1 = 0, width2 = 0, width3 = 0;
            var height1 = 0, height2 = 0, height3 = 0;
            var posX1 = 0, posX2 = 0, posX3 = 0;
            var posY1 = 0, posY2 = 0, posY3 = 0;
            if ($("#controlcapprev1 img").length != 0) {
                if (prevArray[0].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                    width1 = $("#controlcapprev1").width() / unitX2;
                    height1 = $("#controlcapprev1").height() / unitY2;
                    posX1 = $("#controlcapprev1").position().left / unitX2;
                    posY1 = $("#controlcapprev1").position().top / unitY2;
                }
                if (prevArray[1].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                    width2 = $("#controlcapprev1").width() / unitX2;
                    height2 = $("#controlcapprev1").height() / unitY2;
                    posX2 = $("#controlcapprev1").position().left / unitX2;
                    posY2 = $("#controlcapprev1").position().top / unitY2;
                }
                if (prevArray[2].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                    width3 = $("#controlcapprev1").width() / unitX2;
                    height3 = $("#controlcapprev1").height() / unitY2;
                    posX3 = $("#controlcapprev1").position().left / unitX2;
                    posY3 = $("#controlcapprev1").position().top / unitY2;
                }
            }
            if ($("#controlcapprev2 img").length != 0) {
                if (prevArray[0].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                    width1 = $("#controlcapprev2").width() / unitX2;
                    height1 = $("#controlcapprev2").height() / unitY2;
                    posX1 = $("#controlcapprev2").position().left / unitX2;
                    posY1 = $("#controlcapprev2").position().top / unitY2;
                }
                if (prevArray[1].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                    width2 = $("#controlcapprev2").width() / unitX2;
                    height2 = $("#controlcapprev2").height() / unitY2;
                    posX2 = $("#controlcapprev2").position().left / unitX2;
                    posY2 = $("#controlcapprev2").position().top / unitY2;
                }
                if (prevArray[2].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                    width3 = $("#controlcapprev2").width() / unitX2;
                    height3 = $("#controlcapprev2").height() / unitY2;
                    posX3 = $("#controlcapprev2").position().left / unitX2;
                    posY3 = $("#controlcapprev2").position().top / unitY2;
                }
            }
            if ($("#controlcapprev3 img").length != 0) {
                if (prevArray[0].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                    width1 = $("#controlcapprev3").width() / unitX2;
                    height1 = $("#controlcapprev3").height() / unitY2;
                    posX1 = $("#controlcapprev3").position().left / unitX2;
                    posY1 = $("#controlcapprev3").position().top / unitY2;
                }
                if (prevArray[1].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                    width2 = $("#controlcapprev3").width() / unitX2;
                    height2 = $("#controlcapprev3").height() / unitY2;
                    posX2 = $("#controlcapprev3").position().left / unitX2;
                    posY2 = $("#controlcapprev3").position().top / unitY2;
                }
                if (prevArray[2].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                    width3 = $("#controlcapprev3").width() / unitX2;
                    height3 = $("#controlcapprev3").height() / unitY2;
                    posX3 = $("#controlcapprev3").position().left / unitX2;
                    posY3 = $("#controlcapprev3").position().top / unitY2;
                }
            }
            captureList[index] = { backurl: "none", type: 0, prev_count: capCount,
                slide1: prevArray[0],
                slide2: prevArray[1],
                slide3: prevArray[2], objsize: objsize, btnsize: 0,
                width1: width1,
                height1: height1,
                posX1: posX1,
                posY1: posY1,
                width2: width2,
                height2: height2,
                posX2: posX2,
                posY2: posY2,
                width3: width3,
                height3: height3,
                posX3: posX3,
                posY3: posY3
            };
            //세부옵션 비활성화시키기
            disable_applybtn();
            //패널사건추가
            add_DoubleClickEvent();
            capCount = 0;
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
                    var element = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                    element += '<img style="width:100%; height:100%" src="' + data + '"></img>';
                    //패널 추가
                    element += "<div class='panel'>";
                    element += "<a class='delete-btn'>Delete</a>";
                    element += "<a class='edit-btn'>Edit</a>";
                    element += "</div>";

                    element += "</div>";
                    jQuery(element).appendTo("#editframe");
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": counter + 1 });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);

                    //디비에 등록
                    var unitX2 = $("#capture_detail_div").width() / 100;
                    var unitY2 = $("#capture_detail_div").height() / 100;
                    var oX2 = $("#capture_detail_div").position().left;
                    var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();

                    //캡쳐미리보기 사이즈 위치 및 크기 설정부분
                    var width1 = 0, width2 = 0, width3 = 0;
                    var height1 = 0, height2 = 0, height3 = 0;
                    var posX1 = 0, posX2 = 0, posX3 = 0;
                    var posY1 = 0, posY2 = 0, posY3 = 0;
                    if ($("#controlcapprev1 img").length != 0) {
                        if (prevArray[0].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                            width1 = $("#controlcapprev1").width() / unitX2;
                            height1 = $("#controlcapprev1").height() / unitY2;
                            posX1 = $("#controlcapprev1").position().left / unitX2;
                            posY1 = $("#controlcapprev1").position().top / unitY2;
                        }
                        if (prevArray[1].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                            width2 = $("#controlcapprev1").width() / unitX2;
                            height2 = $("#controlcapprev1").height() / unitY2;
                            posX2 = $("#controlcapprev1").position().left / unitX2;
                            posY2 = $("#controlcapprev1").position().top / unitY2;
                        }
                        if (prevArray[2].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                            width3 = $("#controlcapprev1").width() / unitX2;
                            height3 = $("#controlcapprev1").height() / unitY2;
                            posX3 = $("#controlcapprev1").position().left / unitX2;
                            posY3 = $("#controlcapprev1").position().top / unitY2;
                        }
                    }
                    if ($("#controlcapprev2 img").length != 0) {
                        if (prevArray[0].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                            width1 = $("#controlcapprev2").width() / unitX2;
                            height1 = $("#controlcapprev2").height() / unitY2;
                            posX1 = $("#controlcapprev2").position().left / unitX2;
                            posY1 = $("#controlcapprev2").position().top / unitY2;
                        }
                        if (prevArray[1].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                            width2 = $("#controlcapprev2").width() / unitX2;
                            height2 = $("#controlcapprev2").height() / unitY2;
                            posX2 = $("#controlcapprev2").position().left / unitX2;
                            posY2 = $("#controlcapprev2").position().top / unitY2;
                        }
                        if (prevArray[2].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                            width3 = $("#controlcapprev2").width() / unitX2;
                            height3 = $("#controlcapprev2").height() / unitY2;
                            posX3 = $("#controlcapprev2").position().left / unitX2;
                            posY3 = $("#controlcapprev2").position().top / unitY2;
                        }
                    }
                    if ($("#controlcapprev3 img").length != 0) {
                        if (prevArray[0].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                            width1 = $("#controlcapprev3").width() / unitX2;
                            height1 = $("#controlcapprev3").height() / unitY2;
                            posX1 = $("#controlcapprev3").position().left / unitX2;
                            posY1 = $("#controlcapprev3").position().top / unitY2;
                        }
                        if (prevArray[1].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                            width2 = $("#controlcapprev3").width() / unitX2;
                            height2 = $("#controlcapprev3").height() / unitY2;
                            posX2 = $("#controlcapprev3").position().left / unitX2;
                            posY2 = $("#controlcapprev3").position().top / unitY2;
                        }
                        if (prevArray[2].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                            width3 = $("#controlcapprev3").width() / unitX2;
                            height3 = $("#controlcapprev3").height() / unitY2;
                            posX3 = $("#controlcapprev3").position().left / unitX2;
                            posY3 = $("#controlcapprev3").position().top / unitY2;
                        }
                    }
                    captureList[index] = { backurl: server_url + data, type: 1, prev_count: capCount,
                        slide1: prevArray[0],
                        slide2: prevArray[1],
                        slide3: prevArray[2], objsize: objsize + btnsize, btnsize: btnsize,
                        width1: width1,
                        height1: height1,
                        posX1: posX1,
                        posY1: posY1,
                        width2: width2,
                        height2: height2,
                        posX2: posX2,
                        posY2: posY2,
                        width3: width3,
                        height3: height3,
                        posX3: posX3,
                        posY3: posY3
                    };

//                    width2 = $("#controlcapprev").width() / unitX2;
//                    height2 = $("#controlcapprev").height() / unitY2;
//                    posX2 = $("#controlcapprev").position().left / unitX2;
//                    posY2 = $("#controlcapprev").position().top / unitY2;

//                    captureList[index] = { backurl: server_url + data, type: 1, prev_count: capCount,
//                        slide1: prevArray[0],
//                        slide2: prevArray[1],
//                        slide3: prevArray[2], objsize: objsize + btnsize, btnsize: btnsize,
//                        width2: width2,
//                        height2: height2,
//                        posX2: posX2,
//                        posY2: posY2
//                    };
                    //세부옵션 비활성화시키기
                    disable_applybtn();
                    //패널사건추가
                    add_DoubleClickEvent();
                    capCount = 0;

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
            var pos = $(objName).position();
            var element = '<div id="temp" style="width: 123px; height:49px; position:absolute">';
            element += '<img style="width:100%; height:100%;" src="img/capturebtn.png"></img>';
            //패널 추가
            element += "<div class='panel'>";
            element += "<a class='delete-btn'>Delete</a>";
            element += "<a class='edit-btn'>Edit</a>";
            element += "</div>";

            element += "</div>";
            jQuery(element).appendTo("#editframe");
            $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
            $("#temp").css({ "left": pos.left, "top": pos.top });
            $("#temp").css({ "z-index": counter + 1 });
            //현재 선택된 오브젝트를 삭제한다.
            $(objName).remove();
            $("#temp").addClass("dragged_object");
            $("#temp").attr("id", objName.substr(1));
            //크기조종
            $(objName).draggable({
                containment: "parent"
            });
            setTimeout(function () {
                $(objName).resizable({
                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                    containment: "#editframe"
                });
            }, 500);
            //디비에 등록
            var unitX2 = $("#capture_detail_div").width() / 100;
            var unitY2 = $("#capture_detail_div").height() / 100;
            var oX2 = $("#capture_detail_div").position().left;
            var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();

            //캡쳐미리보기 사이즈 위치 및 크기 설정부분
            var width1 = 0, width2 = 0, width3 = 0;
            var height1 = 0, height2 = 0, height3 = 0;
            var posX1 = 0, posX2 = 0, posX3 = 0;
            var posY1 = 0, posY2 = 0, posY3 = 0;
            if ($("#controlcapprev1 img").length != 0) {
                if (prevArray[0].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                    width1 = $("#controlcapprev1").width() / unitX2;
                    height1 = $("#controlcapprev1").height() / unitY2;
                    posX1 = $("#controlcapprev1").position().left / unitX2;
                    posY1 = $("#controlcapprev1").position().top / unitY2;
                }
                if (prevArray[1].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                    width2 = $("#controlcapprev1").width() / unitX2;
                    height2 = $("#controlcapprev1").height() / unitY2;
                    posX2 = $("#controlcapprev1").position().left / unitX2;
                    posY2 = $("#controlcapprev1").position().top / unitY2;
                }
                if (prevArray[2].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                    width3 = $("#controlcapprev1").width() / unitX2;
                    height3 = $("#controlcapprev1").height() / unitY2;
                    posX3 = $("#controlcapprev1").position().left / unitX2;
                    posY3 = $("#controlcapprev1").position().top / unitY2;
                }
            }
            if ($("#controlcapprev2 img").length != 0) {
                if (prevArray[0].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                    width1 = $("#controlcapprev2").width() / unitX2;
                    height1 = $("#controlcapprev2").height() / unitY2;
                    posX1 = $("#controlcapprev2").position().left / unitX2;
                    posY1 = $("#controlcapprev2").position().top / unitY2;
                }
                if (prevArray[1].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                    width2 = $("#controlcapprev2").width() / unitX2;
                    height2 = $("#controlcapprev2").height() / unitY2;
                    posX2 = $("#controlcapprev2").position().left / unitX2;
                    posY2 = $("#controlcapprev2").position().top / unitY2;
                }
                if (prevArray[2].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                    width3 = $("#controlcapprev2").width() / unitX2;
                    height3 = $("#controlcapprev2").height() / unitY2;
                    posX3 = $("#controlcapprev2").position().left / unitX2;
                    posY3 = $("#controlcapprev2").position().top / unitY2;
                }
            }
            if ($("#controlcapprev3 img").length != 0) {
                if (prevArray[0].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                    width1 = $("#controlcapprev3").width() / unitX2;
                    height1 = $("#controlcapprev3").height() / unitY2;
                    posX1 = $("#controlcapprev3").position().left / unitX2;
                    posY1 = $("#controlcapprev3").position().top / unitY2;
                }
                if (prevArray[1].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                    width2 = $("#controlcapprev3").width() / unitX2;
                    height2 = $("#controlcapprev3").height() / unitY2;
                    posX2 = $("#controlcapprev3").position().left / unitX2;
                    posY2 = $("#controlcapprev3").position().top / unitY2;
                }
                if (prevArray[2].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                    width3 = $("#controlcapprev3").width() / unitX2;
                    height3 = $("#controlcapprev3").height() / unitY2;
                    posX3 = $("#controlcapprev3").position().left / unitX2;
                    posY3 = $("#controlcapprev3").position().top / unitY2;
                }
            }
            captureList[index] = { backurl: "none", type: 0, prev_count: capCount,
                slide1: prevArray[0],
                slide2: prevArray[1],
                slide3: prevArray[2], objsize: objsize, btnsize: 0,
                width1: width1,
                height1: height1,
                posX1: posX1,
                posY1: posY1,
                width2: width2,
                height2: height2,
                posX2: posX2,
                posY2: posY2,
                width3: width3,
                height3: height3,
                posX3: posX3,
                posY3: posY3
            };
            //세부옵션 비활성화시키기
            disable_applybtn();
            //패널사건추가
            add_DoubleClickEvent();
            capCount = 0;
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

                captureList[index] = {backurl:captureList[index].backurl, type: 1, prev_count: capCount,
                    slide1: prevArray[0],
                    slide2: prevArray[1],
                    slide3: prevArray[2], objsize: objsize + captureList[index].btnsize, btnsize: captureList[index].btnsize
                };
                //세부옵션 비활성화시키기
                disable_applybtn();
                //패널사건추가
                add_DoubleClickEvent();
                capCount = 0;
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
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                    element += '<img width="100%" height="100%" src="' + data + '"></img>';
                    //패널 추가
                    element += "<div class='panel'>";
                    element += "<a class='delete-btn'>Delete</a>";
                    element += "<a class='edit-btn'>Edit</a>";
                    element += "</div>";

                    element += "</div>";
                    jQuery(element).appendTo("#editframe");
                    $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": counter + 1 });
                    //현재 선택된 오브젝트를 삭제한다.
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });

                    setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);
                    //디비에 등록
                    var unitX2 = $("#capture_detail_div").width() / 100;
                    var unitY2 = $("#capture_detail_div").height() / 100;
                    var oX2 = $("#capture_detail_div").position().left;
                    var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();

                    //캡쳐미리보기 사이즈 위치 및 크기 설정부분
                    var width1 = 0, width2 = 0, width3 = 0;
                    var height1 = 0, height2 = 0, height3 = 0;
                    var posX1 = 0, posX2 = 0, posX3 = 0;
                    var posY1 = 0, posY2 = 0, posY3 = 0;
                    if ($("#controlcapprev1 img").length != 0) {
                        if (prevArray[0].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                            width1 = $("#controlcapprev1").width() / unitX2;
                            height1 = $("#controlcapprev1").height() / unitY2;
                            posX1 = $("#controlcapprev1").position().left / unitX2;
                            posY1 = $("#controlcapprev1").position().top / unitY2;
                        }
                        if (prevArray[1].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                            width2 = $("#controlcapprev1").width() / unitX2;
                            height2 = $("#controlcapprev1").height() / unitY2;
                            posX2 = $("#controlcapprev1").position().left / unitX2;
                            posY2 = $("#controlcapprev1").position().top / unitY2;
                        }
                        if (prevArray[2].indexOf($("#controlcapprev1 img").attr("src")) >= 0) {
                            width3 = $("#controlcapprev1").width() / unitX2;
                            height3 = $("#controlcapprev1").height() / unitY2;
                            posX3 = $("#controlcapprev1").position().left / unitX2;
                            posY3 = $("#controlcapprev1").position().top / unitY2;
                        }
                    }
                    if ($("#controlcapprev2 img").length != 0) {
                        if (prevArray[0].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                            width1 = $("#controlcapprev2").width() / unitX2;
                            height1 = $("#controlcapprev2").height() / unitY2;
                            posX1 = $("#controlcapprev2").position().left / unitX2;
                            posY1 = $("#controlcapprev2").position().top / unitY2;
                        }
                        if (prevArray[1].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                            width2 = $("#controlcapprev2").width() / unitX2;
                            height2 = $("#controlcapprev2").height() / unitY2;
                            posX2 = $("#controlcapprev2").position().left / unitX2;
                            posY2 = $("#controlcapprev2").position().top / unitY2;
                        }
                        if (prevArray[2].indexOf($("#controlcapprev2 img").attr("src")) >= 0) {
                            width3 = $("#controlcapprev2").width() / unitX2;
                            height3 = $("#controlcapprev2").height() / unitY2;
                            posX3 = $("#controlcapprev2").position().left / unitX2;
                            posY3 = $("#controlcapprev2").position().top / unitY2;
                        }
                    }
                    if ($("#controlcapprev3 img").length != 0) {
                        if (prevArray[0].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                            width1 = $("#controlcapprev3").width() / unitX2;
                            height1 = $("#controlcapprev3").height() / unitY2;
                            posX1 = $("#controlcapprev3").position().left / unitX2;
                            posY1 = $("#controlcapprev3").position().top / unitY2;
                        }
                        if (prevArray[1].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                            width2 = $("#controlcapprev3").width() / unitX2;
                            height2 = $("#controlcapprev3").height() / unitY2;
                            posX2 = $("#controlcapprev3").position().left / unitX2;
                            posY2 = $("#controlcapprev3").position().top / unitY2;
                        }
                        if (prevArray[2].indexOf($("#controlcapprev3 img").attr("src")) >= 0) {
                            width3 = $("#controlcapprev3").width() / unitX2;
                            height3 = $("#controlcapprev3").height() / unitY2;
                            posX3 = $("#controlcapprev3").position().left / unitX2;
                            posY3 = $("#controlcapprev3").position().top / unitY2;
                        }
                    }
                    captureList[index] = { backurl: server_url + data, type: 1, prev_count: capCount,
                        slide1: prevArray[0],
                        slide2: prevArray[1],
                        slide3: prevArray[2], objsize: objsize + btnsize, btnsize: btnsize,
                        width1: width1,
                        height1: height1,
                        posX1: posX1,
                        posY1: posY1,
                        width2: width2,
                        height2: height2,
                        posX2: posX2,
                        posY2: posY2,
                        width3: width3,
                        height3: height3,
                        posX3: posX3,
                        posY3: posY3
                    };
                    //세부옵션 비활성화시키기
                    disable_applybtn();
                    //패널사건추가
                    add_DoubleClickEvent();
                    capCount = 0;

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
}
function OnThreeApply() {
    if ($("#front_angle").val() == "객체 정면 방향" || $("#run_times").val() == "실행횟수" || $("#brightness").val() == "밝기" ) {
        alert("객체 방향각도,실행횟수, 밝기 정보를 입력해주세요.");
        return;
    }
    if ($("#brightness").val() > 100) {
        alert("밝기는 1~100사이의 값을 입력하세요.");
        return;
    }
    var index = objName.substr(7);
    if (isFileChange == 2 ) {

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
                setTimeout(function () {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="width: 150px; height: auto; position:absolute">';

                    element += '<img width="100%" height="100%" src="' + "/img/three_backurl.png" + '"/>';
                    //패널 추가
                    element += "<div class='panel'>";
                    element += "<a class='delete-btn'>Delete</a>";
                    element += "<a class='edit-btn'>Edit</a>";
                    element += "</div>";

                    element += "</div>";
                    jQuery(element).appendTo("#editframe");
                    if (threeList[index] != null) {
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                    }
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": counter + 1 });
                    $(objName).remove();
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", objName.substr(1));
                    //크기조종
                    $(objName).draggable({
                        containment: "parent"
                    });
                    setTimeout(function () {
                        $(objName).resizable({
                            aspectRatio: $(objName).width() / $(objName + " img").height(),
                            containment: "#editframe"
                        });
                    }, 500);

                    disable_applybtn();

                    //디비에 등록
                    var val = $('.rdbThree').find('input:checked').val();
                    threeList[index] = { url1: server_url + data.split(":")[0], url2: server_url + data.split(":")[1], front_angle: $("#front_angle").val(),
                        brightness: $("#brightness").val(),
                        run_times: $("#run_times").val(), type: val, objsize: size1 + size2
                    };

                    //패널사건추가
                    add_DoubleClickEvent();
                    //setMarkerImg(data);

                }, 3000);

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
    else
    {
        if (threeList[index] != null) {
            if (threeList[index].url1 == "none" || threeList[index].url2 == "none") {
                alert("3D 애니메이션파일을 등록해주세요.");
                return;
            }
            var pos = $(objName).position();
            var element = '<div id="temp" style="width: 150px; height: auto; position:absolute">';
            element += '<img width="100%" height="100%" src="' + "/img/three_backurl.png" + '"/>';
            //패널 추가
            element += "<div class='panel'>";
            element += "<a class='delete-btn'>Delete</a>";
            element += "<a class='edit-btn'>Edit</a>";
            element += "</div>";

            element += "</div>";
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
            setTimeout(function () {
                $(objName).resizable({
                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                    containment: "#editframe"
                });
            }, 500);

            disable_applybtn();

            //디비에 등록
            var val = $('.rdbThree').find('input:checked').val();
            threeList[index] = { url1: threeList[index].url1, url2: threeList[index].url2, front_angle: $("#front_angle").val(),
                brightness: $("#brightness").val(),
                run_times: $("#run_times").val(),
                type: val , objsize:threeList[index].objsize};

            //패널사건추가
            add_DoubleClickEvent();
        }
        else {
            alert("unity3d파일과 assetbundle을 모두 등록해주셔야 합니다.");
            return;
        }
    }
}
function OnTelApply() {
    if ($("#tel_no").val() == "" || $("#tel_no").val() == "전화번호 '-' 생략") {
        alert("전화번호를 입력해주세요.");
        return;
    }
    //버튼이 2D이미지 일반형 경우
    if ($("#rdTel1")[0].checked == true && $("#rdCommon")[0].checked == true) {
        var pos = $(objName).position();
        var element = '<div id="temp" style="min-width:80px; height:auto; position:absolute;">';
        element += '<img style="width:100%; height:100%;border:1px solid Gray" src="img/tel_1.png"></img>';
        //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top:0px; text-align:center">' + $("#tel_no").val() + '</p>';
        //패널 추가
        element += "<div class='panel'>";
        element += "<a class='delete-btn'>Delete</a>";
        element += "<a class='edit-btn'>Edit</a>";
        element += "</div>";

        element += "</div>";
        jQuery(element).appendTo("#editframe");
        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": counter + 1 });
        $(objName).remove();
        $("#temp").addClass("dragged_object");
        $("#temp").attr("id", objName.substr(1));
        //드래깅 기능 설정
        $(objName).draggable({
            containment: "parent"
        });

        disable_applybtn();

        //디비에 등록
        var val = 0;
        telList[objName.substr(5)] = { tel_no: $("#tel_no").val(), type: val, backurl: "none" , objsize:0};

        //패널사건추가
        add_DoubleClickEvent();
    }
    //버튼이 2D이미지 제작형 경우
    else if ($("#rdTel1")[0].checked == true && $("#rdCustom")[0].checked == true) {
        if ($("#telbtn_path").val() != "") {
            /*확장자체크*/
            var imgExtension = ($("#telbtn_path").val().substr($("#telbtn_path").val().length - 3)).toLowerCase();
            if (imgExtension != 'jpg' && imgExtension != 'png') {
                alert("파일형식이 바르지 않습니다.");
                return;
            }
            /***확장자체크***/

            var file = document.getElementById("telbtn_path");
            var size = file.files[0].size / 1053317.6;
            /*용량제한*/
            if (size > 50) {
                alert("50MB 이하의 파일만 업로드가능합니다.");
                return;
            }
            /***용량제한***/
            ShowProgress();
            //create new FormData instance to transfer as Form Type
            var data = new FormData();
            // add the file intended to be upload to the created FormData instance
            data.append("upfile", file.files[0]);
            $.ajax({
                url: 'PostUpload.aspx?type=6&content_id=' + CONTENT_ID,
                type: "post",
                data: data,
                // cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus, jqXHR) {
                    //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                    setTimeout(function () {
                        HideProgress();
                        var pos = $(objName).position();
                        var element = '<div id="temp" style="width:150px; height: auto; position:absolute">';
                        //element += '<div style="width:100%;background-color:#0099FF; margin-bottom:0px; margin-top:0px; text-align:center">' + $("#tel_no").val() + '</div>';
                        element += '<img width="100%" height="100%" src=' + data + '>';

                        //패널 추가
                        element += "<div class='panel'>";
                        element += "<a class='delete-btn'>Delete</a>";
                        element += "<a class='edit-btn'>Edit</a>";
                        element += "</div>";

                        element += "</div>";
                        jQuery(element).appendTo("#editframe");
                        $("#temp").css({ "left": pos.left, "top": pos.top });
                        $("#temp").css({ "z-index": counter + 1 });
                        $(objName).remove();
                        $("#temp").addClass("dragged_object");
                        $("#temp").attr("id", objName.substr(1));
                        //드래깅 기능 설정
                        $(objName).draggable({
                            containment: "parent"
                        });
                        setTimeout(function () {
                            $(objName).resizable({
                                aspectRatio: $(objName).width() / $(objName + " img").height(),
                                containment: "#editframe"
                            });
                        }, 500);

                        disable_applybtn();

                        //디비에 등록
                        var val = 1;
                        telList[objName.substr(5)] = { tel_no: $("#tel_no").val(), type: val, backurl: server_url + data , objsize:size};

                        //패널사건추가
                        add_DoubleClickEvent();
                        //setMarkerImg(data);

                    }, 3000);

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("전화하기버튼 등록과정에 오류가 발생하였습니다.");
                }
            });
        }
        else {
            var index = objName.substr(5);
            if (telList[index] != null) {
                if (telList[index].backurl == "none") {
                    alert("버튼이미지를 등록해주세요.");
                    return;
                }
                var pos = $(objName).position();
                var element = '<div id="temp" style="width: 150px; height: auto; position:absolute">';
                //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top:0px; text-align:center">' + $("#tel_no").val() + '</p>';
                element += '<img width="100%" height="100%" src=' + telList[index].backurl + '>';

                //패널 추가
                element += "<div class='panel'>";
                element += "<a class='delete-btn'>Delete</a>";
                element += "<a class='edit-btn'>Edit</a>";
                element += "</div>";

                element += "</div>";
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "left": pos.left, "top": pos.top });
                $("#temp").css({ "z-index": $(objName).css("z-index") });
                $(objName).remove();
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "tel_" + index);
                //드래깅 기능 설정
                $(objName).draggable({
                    containment: "parent"
                });
                setTimeout(function () {
                    $(objName).resizable({
                        aspectRatio: $(objName).width() / $(objName + " img").height(),
                        containment: "#editframe"
                    });
                }, 500);

                disable_applybtn();

                //디비에 등록
                var val = 1;
                telList[index] = { tel_no: $("#tel_no").val(), type: val, backurl: telList[index].backurl, objsize: telList[index].objsize };

                //패널사건추가
                add_DoubleClickEvent();
            }
            else {
                alert("버튼이미지를 등록해주세요.");
                return;
            }
        }

    }
    //버튼이 3D이미지인 경우
    else if ($("#rdTel2")[0].checked == true) {
        var pos = $(objName).position();
        var element = '<div id="temp" style="width:auto; height:auto; position:absolute;">';
        element += '<img style="width:100%; height:100%;border:1px solid Gray" src="img/tel_1.png"></img>';
        //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top:0px; text-align:center">' + $("#tel_no").val() + '</p>';
        //패널 추가
        element += "<div class='panel'>";
        element += "<a class='delete-btn'>Delete</a>";
        element += "<a class='edit-btn'>Edit</a>";
        element += "</div>";

        element += "</div>";
        jQuery(element).appendTo("#editframe");
        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": counter + 1 });
        $(objName).remove();
        $("#temp").addClass("dragged_object");
        $("#temp").attr("id", objName.substr(1));
        //드래깅 기능 설정
        $(objName).draggable({
            containment: "parent"
        });
        setTimeout(function () {
            $(objName).resizable({
                aspectRatio: $(objName).width() / $(objName + " img").height(),
                containment: "#editframe"
            });
        }, 500);
        disable_applybtn();

        //디비에 등록
        var val = 2;
        telList[objName.substr(5)] = { tel_no: $("#tel_no").val(), type: val, backurl: "none" , objsize:0};

        //패널사건추가
        add_DoubleClickEvent();
    }
}

function OnGoogleMapApply() {
    if ($("#coordinate").val() == "" || $("#coordinate").val() == "좌표값:Lat,Lng") {
        alert("좌표값을 입력해주세요.");
        return;
    }
    var index = objName.substr(11);
    //버튼이 일반형 경우(수정포함)
    if ($("#googlebtn_rd1")[0].checked == true) {
        var pos = $(objName).position();
        var element = '<div id="temp" style="min-width:80px; height:auto; position:absolute;">';
        element += '<img style="width:100%; height:100%; border:1px solid Gray" src="img/google_1.png"></img>';
        //element += '<p style="background-color:#0099FF; margin-bottom:0px; margin-top:0px; text-align:center">구글맵</p>';
        //element += '<p>' + $("#coordinate").val() + '</p>';
        //패널 추가
        element += "<div class='panel'>";
        element += "<a class='delete-btn'>Delete</a>";
        element += "<a class='edit-btn'>Edit</a>";
        element += "</div>";

        element += "</div>";
        jQuery(element).appendTo("#editframe");
        $("#temp").css({ "left": pos.left, "top": pos.top });
        $("#temp").css({ "z-index": counter + 1 });
        $(objName).remove();
        $("#temp").addClass("dragged_object");
        $("#temp").attr("id", objName.substr(1));
        //패널사건추가
        add_DoubleClickEvent();
        //드래깅 기능 설정
        $(objName).draggable({
            containment: "parent"
        });

        disable_applybtn();

        //디비에 등록
        var val = 0;
        googlemapList[index] = { coordinate: $("#coordinate").val(), type: val, backurl: "none", objsize:0 };
    }
    /*버튼이 제작형 경우*/
    else if ($("#googlebtn_rd2")[0].checked == true) {
        /*수정*/
        if (googlemapList[index] != null) {
            if (isFileChange) {
                var file = document.getElementById("googlebtn_path");
                var size = file.files[0].size / 1053317.6;
                ShowProgress();

                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
                $.ajax({
                    url: 'PostUpload.aspx?type=7&content_id=' + CONTENT_ID,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data, textStatus, jqXHR) {
                        //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                        setTimeout(function () {
                            HideProgress();
                            var pos = $(objName).position();
                            var element = '<div id="temp" style="width:150px; height: auto; position:absolute">';
                            element += '<img style="width:100%; height:100%" src=' + data + '>';

                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                            $("#temp").css({ "left": pos.left, "top": pos.top });
                            $("#temp").css({ "z-index": counter + 1 });
                            $(objName).remove();
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", objName.substr(1));
                            //패널사건추가
                            add_DoubleClickEvent();
                            //드래깅 기능 설정
                            $(objName).draggable({
                                containment: "parent"
                            });
                            setTimeout(function () {
                                $(objName).resizable({
                                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                                    containment: "#editframe"
                                });
                            }, 500);

                            disable_applybtn();

                            //디비에 등록
                            var val = 1;
                            googlemapList[index] = { coordinate: $("#coordinate").val(), type: val, backurl: server_url + data , objsize:size};

                        }, 1000);

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("구글맵버튼 등록과정에 오류가 발생하였습니다.");
                    }
                });
                $("#googlebtn_path").replaceWith($("#googlebtn_path").clone(true));
                isFileChange = 0;
            }
            else {
                if (googlemapList[index].backurl == "none") {
                    alert("버튼이미지를 등록해주세요.");
                    return;
                }
                googlemapList[index] = { coordinate: $("#coordinate").val(), type: 1, backurl: googlemapList[index].backurl };
                disable_applybtn();
            }
        }
        /***수정***/

        /*새오브젝트*/
        else {
            if (isFileChange) {
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
                ShowProgress();

                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
                $.ajax({
                    url: 'PostUpload.aspx?type=7&content_id=' + CONTENT_ID,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data, textStatus, jqXHR) {
                        //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                        setTimeout(function () {
                            HideProgress();
                            var pos = $(objName).position();
                            var element = '<div id="temp" style="width:150px; height: auto; position:absolute">';
                            element += '<img style="width:100%; height:100%" src=' + data + '>';

                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "left": pos.left, "top": pos.top });
                            $("#temp").css({ "z-index": counter + 1 });
                            $(objName).remove();
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", objName.substr(1));
                            //패널사건추가
                            add_DoubleClickEvent();
                            //드래깅 기능 설정
                            $(objName).draggable({
                                containment: "parent"
                            });
                            setTimeout(function () {
                                $(objName).resizable({
                                    aspectRatio: $(objName).width() / $(objName + " img").height(),
                                    containment: "#editframe"
                                });
                            }, 500);

                            disable_applybtn();

                            //디비에 등록
                            var val = 1;
                            googlemapList[index] = { coordinate: $("#coordinate").val(), type: val, backurl: server_url + data, objsize:size };
                        }, 1000);

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("구글맵버튼 등록과정에 오류가 발생하였습니다.");
                    }
                });
                $("#googlebtn_path").replaceWith($("#googlebtn_path").clone(true));
                isFileChange = 0;
            }
            else {
                alert("버튼이미지를 등록해주세요.");
                return;
            }
            /***새오브젝트***/
        }
    }
    /***버튼이 제작형 경우***/
}

function OnNotepadApply() {
    if ($("#notepad_content").val() == "" || $("#notepad_content").val() == "내용") {
        alert("내용을 입력해주세요.");
        return;
    }
    var index = objName.substr(9);
    $(objName).css({ "z-index": counter + 1 });
    $(objName).resizable({
        aspectRatio: true,
        containment: "parent"
    });
    disable_applybtn();
    //디비에 등록
    var val = 0;
    if ($("#notepad_rd2")[0].checked == true)
        val = 1;
    notepadList[index] = { content: $("#notepad_content").val(), view: val };
    /***새오브젝트 추가 및 수정***/
}
function OnAudioApply() {

    var index = objName.substr(7);
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
                //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                setTimeout(function () {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="width:150px; height:50px; position:absolute">';
                    element += '<audio style="width:100%; height:100%; background-color:#000" controls><source src="' + data + '"></audio>';
                    //패널 추가
                    element += "<div class='panel'>";
                    element += "<a class='delete-btn'>Delete</a>";
                    element += "<a class='edit-btn'>Edit</a>";
                    element += "</div>";

                    element += "</div>";
                    jQuery(element).appendTo("#editframe");
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": counter + 1 });
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
                    disable_applybtn();

                    //디비에 등록
                    var type = 0;
                    var run_opt = 0;
                    if ($("#audiobtn_rd2")[0].checked == true)
                        type = 1;
                    else if ($("#audiobtn_rd3")[0].checked == true)
                        type = 2;
                    if ($("#audiorun_rd2")[0].checked == true)
                        run_opt = 1;
                    audioList[index] = { url: server_url + data, type: type, run_opt: run_opt , objsize:size};

                    //패널사건추가
                    add_DoubleClickEvent();
                    //setMarkerImg(data);

                }, 3000);

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
        if (isFileChange) {
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
                    //빈오브젝트를 비디오 오브젝트로 바구어 주어야 한다.
                    setTimeout(function () {
                        HideProgress();
                        var pos = $(objName).position();
                        var element = '<div id="temp" style="width: 150px; height: 50px; position:absolute">';
                        element += '<audio style="width:100%; height:100%; background-color:#000" controls><source src="' + data + '"></audio>';
                        //패널 추가
                        element += "<div class='panel'>";
                        element += "<a class='delete-btn'>Delete</a>";
                        element += "<a class='edit-btn'>Edit</a>";
                        element += "</div>";

                        element += "</div>";
                        jQuery(element).appendTo("#editframe");
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                        $("#temp").css({ "left": pos.left, "top": pos.top });
                        $("#temp").css({ "z-index": counter + 1 });
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
                        disable_applybtn();

                        //디비에 등록
                        var type = 0;
                        var run_opt = 0;
                        if ($("#audiobtn_rd2")[0].checked == true)
                            type = 1;
                        else if ($("#audiobtn_rd3")[0].checked == true)
                            type = 2;
                        if ($("#audiorun_rd2")[0].checked == true)
                            run_opt = 1;
                        audioList[index] = { url: server_url + data, type: type, run_opt: run_opt, objsize:size };

                        //패널사건추가
                        add_DoubleClickEvent();
                        //setMarkerImg(data);

                    }, 3000);

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

            var type = 0;
            var run_opt = 0;
            if ($("#audiobtn_rd2")[0].checked == true)
                type = 1;
            else if ($("#audiobtn_rd3")[0].checked == true)
                type = 2;
            if ($("#audiorun_rd2")[0].checked == true)
                run_opt = 1;
            audioList[index] = { url: audioList[index].url, type: type, run_opt: run_opt, objsize: audioList[index].objsize };
            disable_applybtn();
            HideProgress();
        }
    }
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
                setTimeout(function () {
                    HideProgress();
                    var pos = $(objName).position();
                    var element = '<div id="temp" style="width:150px; height:auto; position:absolute">';
                    element += '<video style="width:100%; height:auto" controls><source src="' + data + '"></video>';
                    //패널 추가
                    element += "<div class='panel'>";
                    element += "<a class='delete-btn'>Delete</a>";
                    element += "<a class='edit-btn'>Edit</a>";
                    element += "</div>";

                    element += "</div>";
                    jQuery(element).appendTo("#editframe");
                    $("#temp").css({ "left": pos.left, "top": pos.top });
                    $("#temp").css({ "z-index": counter + 1 });
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
                    disable_applybtn();

                    //디비에 등록
                    var type = 0;
                    var run_opt = 0;
                    if ($("#chromakeyview_rd2")[0].checked == true)
                        type = 1;
                    if ($("#chromakeyrun_rd2")[0].checked == true)
                        run_opt = 1;
                    chromakeyList[index] = { url: server_url + data, type: type, run_opt: run_opt, objsize:size  };

                    //패널사건추가
                    add_DoubleClickEvent();
                    //setMarkerImg(data);

                }, 3000);

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
                    setTimeout(function () {
                        HideProgress();
                        var pos = $(objName).position();
                        var element = '<div id="temp" style="width: 150px; height: auto; position:absolute">';
                        element += '<video style="width:100%; height:auto" controls><source src="' + data + '"></video>';
                        //패널 추가
                        element += "<div class='panel'>";
                        element += "<a class='delete-btn'>Delete</a>";
                        element += "<a class='edit-btn'>Edit</a>";
                        element += "</div>";

                        element += "</div>";
                        jQuery(element).appendTo("#editframe");
                        $("#temp").css({ "width": $(objName).width(), "height": $(objName).height() });
                        $("#temp").css({ "left": pos.left, "top": pos.top });
                        $("#temp").css({ "z-index": counter + 1 });
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
                        disable_applybtn();

                        //디비에 등록
                        var type = 0;
                        var run_opt = 0;
                        if ($("#chromakeyview_rd2")[0].checked == true)
                            type = 1;
                        if ($("#chromakeyrun_rd2")[0].checked == true)
                            run_opt = 1;
                        chromakeyList[index] = { url: server_url + data, type: type, run_opt: run_opt, objsize:size };

                        //패널사건추가
                        add_DoubleClickEvent();
                        //setMarkerImg(data);

                    }, 3000);

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
            chromakeyList[index] = { url: chromakeyList[index].url, type: type, run_opt: run_opt, objsize:chromakeyList[index].objsize };

            disable_applybtn();
            HideProgress();
        }
    }
}
/***적용하기 버튼을 누를때 처리부***/

/*세부옵션의 활성화 비활성화 절환설정하는 부분*/
        //여기서 objectid는 0:비디오 1:웹 2:이미지 3:캡쳐 4:.....
function select_option(objectid) {
    $("#video_opt").css("display", "none");
    $("#web_opt").css("display", "none");
    $("#img_opt").css("display", "none");
    $("#tel_opt").css("display", "none");
    $("#three_opt").css("display", "none");
    $("#capture_opt").css("display", "none");
    $("#googlemap_opt").css("display", "none");
    $("#notepad_opt").css("display", "none");
    $("#audio_opt").css("display", "none");
    $("#chromakey_opt").css("display", "none");
    if (objectid == 0) {
        $("#video_opt").css("display", "block");
    }
    else if (objectid == 1) {
        $("#web_opt").css("display", "block");
    }
    else if (objectid == 2) {
        $("#img_opt").css("display", "block");
    }
    else if (objectid == 3) {
        $("#capture_opt").css("display", "block");
    }
    else if (objectid == 4) {
        $("#three_opt").css("display", "block");
    }
    else if (objectid == 5) {
        $("#tel_opt").css("display", "block");
    }
    else if (objectid == 6) {
        $("#googlemap_opt").css("display", "block");
    }
    else if (objectid == 7) {
        $("#notepad_opt").css("display", "block");
    }
    else if (objectid == 8) {
        $("#audio_opt").css("display", "block");
    }
    else {
        $("#chromakey_opt").css("display", "block");
    }
}
function disable_applybtn() {
    $("#detail_opt").addClass("disabledbutton");
    $("#video_opt *").attr("disabled", "disabled").off('click');
    $("#web_opt *").attr("disabled", "disabled");
    $("#img_opt *").attr("disabled", "disabled").off('click');
    $("#capture_opt *").attr("disabled", "disabled");
    $("#three_opt *").attr("disabled", "disabled").off('click');
    $("#tel_opt *").attr("disabled", "disabled").off('click');
    $("#googlemap_opt *").attr("disabled", "disabled").off('click');
    $("#notepad_opt *").attr("disabled", "disabled").off('click');
    $("#audio_opt *").attr("disabled", "disabled").off('click');
    $("#chromakey_opt *").attr("disabled", "disabled").off('click');


}
function enable_applybtn() {
    $("#detail_opt").removeClass("disabledbutton");
    $("#video_opt *").removeAttr("disabled", "disabled").on('click');
    $("#web_opt *").removeAttr("disabled", "disabled").on('click');
    $("#img_opt *").removeAttr("disabled", "disabled").on('click');
    $("#capture_opt *").removeAttr("disabled", "disabled").on('click');
    $("#three_opt *").removeAttr("disabled", "disabled").on('click');
    $("#tel_opt *").removeAttr("disabled", "disabled").on('click');
    $("#googlemap_opt *").removeAttr("disabled", "disabled").on('click');
    $("#notepad_opt *").removeAttr("disabled", "disabled").on('click');
    $("#audio_opt *").removeAttr("disabled", "disabled").on('click');
    $("#chromakey_opt *").removeAttr("disabled", "disabled").on('click');

}
/**세부옵션의 활성화 비활성화 절환설정하는 부분**/

/*이미지 추가하는 부분*/
function OnAddPrevImg() {
    if (addIndex == 9) {
        alert("최대 9개의 이미지를 등록하실수 있습니다.");
        return;
    }
    $("#image_file").click();


}
/***이미지 추가하는 부분***/


/*이미지슬라이드 세부옵션의 이미지 편집 처리부*/
function On_delPrev_img(previmg_id) {
    if ($("#imgPrev" + previmg_id).attr("src").indexOf("no_image") == -1) {
        var popupdiv =
                '<div id="delpopup" class="clspopup" style="left:' + (event.clientX - 180) + 'px; top:' + (event.clientY - 150) + 'px; width:180px; height:150px; z-index:3000; ">' +
                '<h1>' + 'Delete Object' + '</h1>' +
                '   <p class="question">' + '정말 삭제하시겠습니까?' + '</p>' +
                '   <div class="buttons">' +
                '       <input type="button" onclick="delPrevImg(\'' + previmg_id + '\')" value="확인"/>' +
                '       <input type="button" onclick="removePopup()" value="취소"/>' +
                '   </div>' +
                '</div>';

        jQuery(popupdiv).appendTo(".page");

        $("#delpopup").fadeIn("slow");
        $("#popBack").css({
            "opacity": "0.7"
        });
        $("#popBack").fadeIn("slow");
    }

}
function delPrevImg(previmg_id) {
    $("#prev_div" + previmg_id).remove();
    addIndex--;
    closeConfirmPopup();
}

/*캡쳐이미지 추가하는 부분*/
function OnAddCapPrevImg() {
    if (capCount == 3) {
        alert("최대 3개의 이미지를 등록하실수 있습니다.");
        return;
    }
    $("#capture_file").click();
}
/***캡쳐이미지 추가하는 부분***/


/*캡쳐이미지 세부옵션의 이미지 편집 처리부*/
function OnRemoveCapPrev(previmg_id) {
    var popupdiv =
            '<div id="delpopup" class="clspopup" style="left:' + (event.clientX - 180) + 'px; top:' + (event.clientY - 150) + 'px; width:180px; height:150px; z-index:3000; ">' +
            '<h1>' + 'Delete Object' + '</h1>' +
            '   <p class="question">' + '정말 삭제하시겠습니까?' + '</p>' +
            '   <div class="buttons">' +
            '       <input type="button" onclick="delCapPrevImg(\'' + previmg_id + '\')" value="확인"/>' +
            '       <input type="button" onclick="removePopup()" value="취소"/>' +
            '   </div>' +
            '</div>';

    jQuery(popupdiv).appendTo(".page");

    $("#delpopup").fadeIn("slow");
    $("#popBack").css({
        "opacity": "0.7"
    });
    $("#popBack").fadeIn("slow");

}
function delCapPrevImg(previmg_id) {

    if ($("#capprev_div" + previmg_id + " img").attr("src") == $("#controlcapprev1 img").attr("src")) {
        $("#controlcapprev1").remove();
    }
    if ($("#capprev_div" + previmg_id + " img").attr("src") == $("#controlcapprev2 img").attr("src")) {
        $("#controlcapprev2").remove();
    }
    if ($("#capprev_div" + previmg_id + " img").attr("src") == $("#controlcapprev3 img").attr("src")) {
        $("#controlcapprev3").remove();
    }
    $("#capprev_div" + previmg_id).remove();
    if (capCount > 0)
        capCount--;
    if (n_setteddprevs > 0)
        n_setteddprevs--;
    closeConfirmPopup();
}

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