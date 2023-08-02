function OnBrowse(file_input_id) {
    $("#" + file_input_id).click();
}

//var isFileChange = 0;
//var isFileChange1 = 0;
//var isFileChange2 = 0;
//var isFileChange3 = 0;
//function OnRegFileBind(index) {
//    $("#" + index).bind("change", function () {       
//        if (!checkImgExtention($("#" + index), "img")) {
//            return false;
//        }
//        var file = document.getElementById(index);
//        var size = file.files[0].size / 1053317.6;
//        /*용량제한*/
//        if (size > 2) {
//            alert("2MB 이하의 파일만 업로드가능합니다.");
//            return;
//        }
//        /***용량제한***/
//        switch (index) {
//            case "marker1_filein":
//                isFileChange1 = 1;
//                break;
//            case "marker2_filein":
//                isFileChange2 = 1;
//                break;
//            case "marker3_filein":
//                isFileChange3 = 1;
//                break;
//            default:
//                isFileChange = 1;
//                break;
//        }
//    });
//}
/*확장자체크*/
function checkImgExtention(fileObj, type) {
    if (type == "img") {
        var _validFileExtensions = [".jpg", ".png"];
        var blnValid = false;
        var sFileName = $("#" + fileObj).val();
        for (var j = 0; j < _validFileExtensions.length; j++) {
            var sCurExtension = _validFileExtensions[j];
            if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                blnValid = true;
                break;
            }
        }
        if (!blnValid) {
//            alert("파일형식이 잘못되었습니다.");
            return false;
        }        
    }
    else if (type == "video") {
        var _validFileExtensions = [".mp4", ".wmv", ".avi"];
        var blnValid = false;
        var sFileName = $("#" + fileObj).val();
        for (var j = 0; j < _validFileExtensions.length; j++) {
            var sCurExtension = _validFileExtensions[j];
            if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                blnValid = true;
                break;
            }
        }
        if (!blnValid) {            
            return false;
        }
    }
    return true;
}
/***확장자체크***/

/*용량체크 MB */
function checkFileSize(fileinputID, fileSize) {    
    var file = document.getElementById(index);
    var size = file.files[0].size / 1053317.6;    
    if (size > fileSize) {
        alert(fileSize + "MB 이하의 파일만 업로드가능합니다.");
        return false;
    }    
    return true;    
}
/***용량체크***/