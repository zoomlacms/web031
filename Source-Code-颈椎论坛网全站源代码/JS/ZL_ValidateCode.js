//1,页面上指定codeok,codeno两个样式
//2,$("#TxtValidateCode").ValidateCode();
(function ($) {
    $.fn.extend({
        ValidateCode: function (options, callback) {
            var opts = $.extend({}, $.fn.ValidateCode.defaults, options);
            var obj = this;
            if (!obj || obj == null || !obj.attr("id")) return;
            var objimg = $("#" + obj[0].id + "_img");
            var objhid = $("#" + obj[0].id + "_hid");
            objhid.val(Math.random());//Key
            objimg.attr("src", "/Common/ValidateCode.aspx?key="+ objhid.val()+"&t=" + Math.random());
            //----事件
            objimg.click(function () {
                var url = "/Common/ValidateCode.aspx?key=" + objhid.val() + "&t=" + Math.random();
                $(this).attr("src", url); obj.val(""); obj.keyup(); obj.focus();
            });
            $(obj).keyup(function () {
                a = "checkcode";
                v = $(obj).val();
                if (v.length < opts.num) { $(obj).removeClass(opts.okcss).removeClass(opts.nocss); return; }
                $.ajax({
                    type: "Post",
                    url: "/Common/ValidateCode.aspx",
                    data: { action: a, key: objhid.val(), value: v },
                    success: function (data) {
                        if (data == 0) {
                            $(obj).removeClass(opts.okcss).addClass(opts.nocss);
                        }
                        else if (data == 1) {
                            $(obj).removeClass(opts.nocss).addClass(opts.okcss);
                        }
                    }
                });
            });//keyup end;
        }
    })//fn end;
    $.fn.ValidateCode.defaults = { okcss: "codeok", nocss: "codeno", num: 6 };//参数赋值
})(jQuery)