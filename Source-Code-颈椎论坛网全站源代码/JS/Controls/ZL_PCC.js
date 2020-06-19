/*
*功能:省市县三级联动,默认值:值
*<script src="http://code.zoomla.cn/Area.js"></script>
*/
function ZL_PCC(pid, cityid, countyid) {
    this.$province = $("#" + pid);
    this.$city = $("#" + cityid);
    this.$county = $("#" + countyid);
    this.kvtype = 1;
    this.defProvince = "", this.defCity = "", this.defCounty = "";
}
ZL_PCC.prototype = {
    ProvinceInit: function () {
        var ref = this;
        for (var i = 0; i < AreaMod.length; i++) {
                switch (ref.kvtype)
                {
                    case 1:
                        ref.$province.append("<option data-id='" + AreaMod[i].ID + "'  value='" + AreaMod[i].Name + "'>" + AreaMod[i].Name + "</option>");
                        break;
                    case 2:
                        ref.$province.append("<option data-id='" + AreaMod[i].ID + "'  value='" + AreaMod[i].ID + "'>" + AreaMod[i].Name + "</option>");
                        break;
                }
        }
        var def = (ref.defProvince && ref.defProvince != "") ? ref.defProvince : ref.$province[0].options[0].value;
        ref.$province.val(def);
        ref.CityInit();
        ref.$province.change(function () { ref.CityInit(); });
    },
    CityInit: function () {
        var ref = this;
        ref.$city.html("");
        var arr = AreaMod.GetByID(ref.$province.find(":checked").data("id")).CityList;
        for (var i = 0; i < arr.length; i++) {
            switch (ref.kvtype) {
                case 1:
                    ref.$city.append("<option data-id='" + arr[i].ID + "' value='" + arr[i].Name + "'>" + arr[i].Name + "</option>");
                    break;
                case 2:
                    ref.$city.append("<option data-id='" + arr[i].ID + "' value='" + arr[i].ID + "'>" + arr[i].Name + "</option>");
                    break;
            }
        }
        var def = (ref.defCity && ref.defCity != "") ? ref.defCity : ref.$city[0].options[0].value;
        ref.$city.val(def);
        ref.CountyInit();
        ref.$city.change(function () { ref.CountyInit(); });
    },
    CountyInit: function () {
        var ref = this;
        ref.$county.html("");
        var arr = AreaMod.GetByID(ref.$province.find(":checked").data("id")).CityList.GetByID(ref.$city.find(":checked").data("id")).CountyList;
        for (var i = 0; i < arr.length; i++) {
            switch (ref.kvtype) {
                case 1:
                    ref.$county.append("<option data-id='" + arr[i].ID + "' value='" + arr[i].Name + "'>" + arr[i].Name + "</option>");
                    break;
                case 2:
                    ref.$county.append("<option data-id='" + arr[i].ID + "' value='" + arr[i].ID + "'>" + arr[i].Name + "</option>");
                    break;
            }
        }
        if (ref.$county[0].options.length > 0) {
            var def = (ref.defCounty && ref.defCounty != "") ? ref.defCounty : ref.$county[0].options[0].value;
            ref.$county.val(def);
        }
    },
    SetDef: function () {
        this.defProvince = arguments[0];
        this.defCity = arguments[1];
        this.defCounty = arguments[2];
    }
}
Array.prototype.GetByID = function (v) {
    for (var i = 0; i < this.length; i++) {
        if (this[i].ID == v) return this[i];
    }
    return null;
}