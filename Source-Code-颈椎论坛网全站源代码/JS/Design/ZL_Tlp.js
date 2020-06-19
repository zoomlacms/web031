function InitDrag() {
    //$("div").draggable({
    //    addClasses: false,
    //    axis: false,
    //    cursor: 'crosshair',
    //    disabled: false
    //});
}
function StopDrag() {
    //$("div").draggable({ disabled: true });
}
//function InitEdit() {//旧开启编辑
//    StopDrag();
//    $(document).bind("contextmenu", function (e) {
//        return false;
//    });
//    $("div").mousedown(function () {
//        if (event.button == 2) {
//            $(this).attr("contenteditable", true);
//            parent.EditA(this);
//        }
//    });
//}
//function StopEdit() {
//    $(document).unbind("contextmenu");
//    $("div").unbind("mousedown");
//}
//右键菜单
function InitContextMenu() {
    $("div").contextMenu('rmenu',
      {
          bindings:
          {
              'edit': function (t) {
                  StopDrag();
                  $("div[contenteditable=true]").removeAttr("contenteditable");
                  $(t).attr("contenteditable", true);
                  $(t).focus();
                  parent.EditA(t);
              },
              'drag': function (t) {
                  InitDrag();
              },
              'enddrag': function (t)
              {
                  StopDrag();
              }
          }
      });
}
//为保存做准备
function BeginSave() {
    $("#editor_div").remove();
    $("#jqContextMenu").remove();
    $("div").each(function () { $(this).removeAttr("contenteditable"); });
}
$(function () {
    //InitDrag();
    //InitEdit();
    InitContextMenu();
    $("a").each(function () { $(this).click(function () { window.event.returnValue = false; }); });//禁止所有的超链接点击
})