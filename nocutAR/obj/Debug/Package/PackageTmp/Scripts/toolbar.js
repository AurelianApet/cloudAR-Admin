$(function () {
    var dropflag = 0;
    $(".clsImagechange").draggable({
        containment: ".page",
        helper: "clone",
        revert: "invalid",
        start: function (ui) { // 드래그 시작했을 때 한 번 호출
            dropflag = 0;
        },
        stop: function (ev, ui) { // 드래그 끝났을 때 한 번 호출
            if (dropflag != 1)
                return;

            $(objName).css({ "left": ui.position.left - $("#editframe").offset().left, "top": ui.position.top - $("#editframe").offset().top });
            $(objName).removeClass("clsImagechange").addClass("dragged_object");   //클론되지 않게 해주는 코드이다.

            $(objName).draggable({
                containment: "parent"
            });
        }

    });
    $(".markdiv").droppable({
        accept: ".clsImagechange",
        activeClass: "ui-state-default",
        hoverClass: "ui-state-hover",
        drop: function (event, ui) {						// event : drop, , ui.draggable : 지금 .drop-box 에 drop된 .drag-box를 가리킨다 
            dropflag = 1;
            if (ui.helper.context.id == "imgEditMenu1") {
                onSelItem(1);
            }
            else if (ui.helper.context.id == "imgEditMenu2") {
                onSelItem(2);
            }
            else if (ui.helper.context.id == "imgEditMenu3") {
                onSelItem(3);
            }
            else if (ui.helper.context.id == "imgEditMenu4") {
                onSelItem(4);
            }
            else if (ui.helper.context.id == "imgEditMenu5") {
                onSelItem(5);
            }
            else if (ui.helper.context.id == "imgEditMenu6") {
                onSelItem(6);
            }
            else if (ui.helper.context.id == "imgEditMenu7") {
                onSelItem(7);
            }
            else if (ui.helper.context.id == "imgEditMenu8") {
                onSelItem(8);
            }
            else if (ui.helper.context.id == "imgEditMenu9") {
                onSelItem(9);
            }
            else if (ui.helper.context.id == "imgEditMenu10") {
                onSelItem(10);
            }
            else if (ui.helper.context.id == "imgEditMenu11") {
                onSelItem(11);
            }
            //$(".tempclass").attr("id", "clonediv" + counter);
            //$("#clonediv" + counter).removeClass("tempclass").addClass("dragged_object");

            //$(this).append($(ui.draggable).clone());

            //$(this).removeClass("over").addClass("drop");

            //ui.draggable.clone().addClass("drop"); // drop된 .drag-box에 클래스 지정
        }
    });
});