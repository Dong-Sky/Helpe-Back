<?php
// 定义标题和面包屑信息
$this->title = '服务求助管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var aStatus = {"0":"上架","1":"下架"},
        aStatusColor = {"0":"label-success","1":"label-danger"};
    var aItemType = {"0":"服务","1":"求助"},
        aItemTypeColor = {"0":"label-success","1":"label-warning"};
    var m = meTables({
        title: "服务求助管理",
        table: {
            "aoColumns": [
                {"title": "编号", "data": "id", "sName": "id", "edit": {"type": "hidden", "required": true,"number": true}, "search": {"type": "text"}, "bSortable": false},
			{"title": "名称", "data": "name", "sName": "name", "search": {"type": "text"}, "bSortable": false},
			// {"title": "APP", "data": "appid", "sName": "appid", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "价格", "data": "price", "sName": "price"},
			// {"title": "图片", "data": "img", "sName": "img", "edit": {"type": "text", "required": true,"rangelength": "[2, 50]"}, "bSortable": false},
			{"title": "状态", "data": "flag", "sName": "flag", "value": aStatus, "search": {"type": "select"}, "edit": {"type": "radio", "required": true,"number": true}, "bSortable": false, "createdCell":function(td, data) {
                    $(td).html(mt.valuesString(aStatus, aStatusColor, data));
                }},

			{"title": "用户ID", "data": "uid", "sName": "uid", "search": {"type": "text"}, "bSortable": false},
			{"title": "商品类型ID", "data": "cid", "sName": "cid", "search": {"type": "text"},  "bSortable": false},
			{"title": "标签", "data": "tag", "sName": "tag", "search": {"type": "text"},  "bSortable": false},
			{"title": "类型", "data": "type", "sName": "type", "search": {"type": "select"}, "value": aItemType, "bSortable": false, "createdCell":function(td, data) {
                    $(td).html(mt.valuesString(aItemType, aItemTypeColor, data));
                }},
			{"title": "地址编号", "data": "aid", "sName": "aid", "bSortable": false},
			// {"title": "日本地址编号", "data": "aaid", "sName": "aaid", "bSortable": false},
			{"title": "经度", "data": "lat", "sName": "lat", "bSortable": false},
			{"title": "纬度", "data": "lng", "sName": "lng",  "bSortable": false},
			{"title": "发布时间", "data": "pt", "sName": "pt", "createdCell" : mt.dateTimeString},
			// {"title": "支付方式", "data": "paytp", "sName": "paytp", "bSortable": false},
			{"title": "联系方式", "data": "contact", "sName": "contact", "bSortable": false},
			{"title": "过期时间描述", "data": "deadline", "sName": "deadline",  "bSortable": false},
			{"title": "单位", "data": "unit", "sName": "unit", "bSortable": false},
			{"title": "发布过期时间", "data": "pet", "sName": "pet",  "createdCell" : mt.dateTimeString},
                {"title": "创建时间", "data": "ct", "sName": "ct", "createdCell" : mt.dateTimeString},
                {"title": "修改时间", "data": "mt", "sName": "mt", "createdCell" : mt.dateTimeString},
            ]       
        },
        operations: {
            buttons: {
                "see": {"className": "btn-success", "cClass":"me-table-detail", "click-param-url":"/item/iteminfo?itemid=", "click-param-index":"1", "click-param-barid":"iteminfo-id-", "click-param-barname":"服务求助详情-id-",  "icon":"fa-search-plus",  "sClass":"blue"},
                "update": {"className": "btn-info", "cClass":"me-table-update", "icon":"fa-pencil-square-o",  "sClass":"green"},
                "delete": {"className": "btn-danger", "cClass":"me-table-delete", "icon":"fa-trash-o",  "sClass":"red"}
            }
        },
        buttons:{
            create: {
                bShow: false
            },
            updateAll: {
                bShow: false
            }
        },
    });
    
    /**
    meTables.fn.extend({
        // 显示的前置和后置操作
        beforeShow: function(data, child) {
            return true;
        },
        afterShow: function(data, child) {
            return true;
        },
        
        // 编辑的前置和后置操作
        beforeSave: function(data, child) {
            return true;
        },
        afterSave: function(data, child) {
            return true;
        }
    });
    */

     $(function(){
         m.init();
     });


    var $windowDiv = $("#me-window", window.parent.document),
        $divContent = $("#page-content", window.parent.document),
        intSize = <?=Yii::$app->params['iframeNumberSize']?>;

    function addDiv(strId, strTitle) {
        $windowDiv.find("div.active").removeClass("active");
        if ($windowDiv.find("div:not(div.hide)").size() >= intSize) {
            $windowDiv.find("div:not(div.hide):first").addClass("hide");
            $("#window-prev").removeClass("hide");
        }
        var html = '<div class="me-div active" data-id="' + strId + '"><span>' + strTitle + '</span><a href="javascript:;" class="me-window-close"><i class="ace-icon fa fa-times me-i-close"></i></a></div>';
        $windowDiv.append(html);
    }

    function addIframeItem(strId, strUrl, strTitle) {
        strId = "iframe-" + strId;
        $divContent.find("iframe.active").removeClass("active").addClass("hide");
        $windowDiv.find("div.active").removeClass("active");
        if ($divContent.find("#" + strId).size() > 0) {
            $divContent.find("#" + strId).addClass("active").removeClass("hide");
            $windowDiv.find("div[data-id=" + strId + "]").addClass("active");
        } else {
            var strIframe = '<iframe id="' + strId + '" name="' + strId + '" ' + 'width="100%" class="active iframe" height="100%" src="' + strUrl + '" frameborder="0"></iframe>';
            addDiv(strId, $.trim(strTitle));
            $("#page-content", window.parent.document).append(strIframe);
        }
    }

</script>
<?php $this->endBlock(); ?>