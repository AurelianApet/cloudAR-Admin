$(document).ready(function () {

    $("#popBack").click(function () {
        /*if (document.location.toString().indexOf("ProjectList.aspx") != "-1" || document.location.toString().indexOf("/Manager/") != "-1" || document.location.toString().indexOf("/Notice.aspx") != "-1")
            hidePopup();
        else*/
            closePopup();
            
    });
});

function hidePopup() {
    $(".clspopup").fadeOut("slow");
    $("#popBack").fadeOut("slow");
}

function closePopup() {
    hidePopup();
}

function closeConfirmPopup() {
    $("#dvDelSlideItem").fadeOut("slow");
}
/*프로그래스바 현시*/
function ShowProgress() {
    closePopup();
    showPopup("progress_div");
    /*$("#progress_div").css("display", "block");
    $("#popBack").css({
        "opacity": "0.7"
    });
    $("#popBack").fadeIn("slow");*/
}
function ShowProgress2() {
    showPopup("progress_div");
}
function HideProgress() {
    $("#progress_div").css("display", "none");
    $("#popBack").fadeOut("slow");
}
function HideProgress2() {
    $("#progress_div").css("display", "none");
}
/***프로그래스바 현시***/

/*오브젝트 삭제함수*/
function delObject1() {
    closePopup();
    $("#" + $("#del_objectid").val()).remove();
    $("#delpopup2").fadeOut("slow");
    $("#popBack").fadeOut("slow");
    $("#del_objectid").val("");
}
/***오브젝트 삭제함수***/


function showPopup(pid) {
    var topPos = $(window).scrollTop() + (document.body.clientHeight - $("#" + pid).height()) / 2;
    var leftPos = $(window).scrollLeft() + (document.body.clientWidth - $("#" + pid).width()) / 2;

    $("#" + pid).fadeIn("fast");
    $("#" + pid).css({
        "left": leftPos,
        "top": topPos
    });
    $("#popBack").css({
        "opacity": "0.7"
    });
    $("#popBack").fadeIn("fast");
}

function checkDateTime(dtObj, bEmpty) {
    if (!isValidDate(dtObj.value)) {
        if (bEmpty == true) {
            dtObj.value = "";
        } else {
            dtObj.value = getDateStrFromDateObject(new Date());
        }
    }
}
function getDateStrFromDateObject(dateObject) {
    var str = null;

    var month = dateObject.getMonth() + 1;
    var day = dateObject.getDate();

    if (month < 10)
        month = '0' + month;
    if (day < 10)
        day = '0' + day;

    str = dateObject.getFullYear() + '-' + month + '-' + day;
    return str;
}
/*
* 날짜가 유효한지 검사
*/
function isValidDate(d) {
    // 포맷에 안맞으면 false리턴
    if (!isDateFormat(d)) {
        return false;
    }

    var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    var dateToken = d.split('-');
    var year = Number(dateToken[0]);
    var month = Number(dateToken[1]);
    var day = Number(dateToken[2]);

    // 날짜가 0이면 false
    if (day == 0) {
        return false;
    }

    var isValid = false;

    // 윤년일때
    if (isLeaf(year)) {
        if (month == 2) {
            if (day <= month_day[month - 1] + 1) {
                isValid = true;
            }
        } else {
            if (day <= month_day[month - 1]) {
                isValid = true;
            }
        }
    } else {
        if (day <= month_day[month - 1]) {
            isValid = true;
        }
    }

    return isValid;
}
/*
* 날짜포맷에 맞는지 검사
*/
function isDateFormat(d) {
    var df = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
    return d.match(df);
}

/*
* 윤년여부 검사
*/
function isLeaf(year) {
    var leaf = false;

    if (year % 4 == 0) {
        leaf = true;

        if (year % 100 == 0) {
            leaf = false;
        }

        if (year % 400 == 0) {
            leaf = true;
        }
    }

    return leaf;
}

function closeDivPop() {
    $('.clspopup', window.parent.document).fadeOut();
    $('#popBack', window.parent.document).fadeOut();
}
