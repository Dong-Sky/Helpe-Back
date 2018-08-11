<?php
// 定义标题和面包屑信息
$this->title = '用户信息';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var aGender = {"0":"男","1":"女"},
        aGenderColor = {"0":"label-success","1":"label-warning"};
    var aStatus = <?=\yii\helpers\Json::encode($status)?>,
        aStatusColor = <?=\yii\helpers\Json::encode($statusColor)?>,
        m = meTables({
            title: "<?=$this->title?>",
            table: {
                "aoColumns":[
                    {"title": "用户ID", "data": "id", "sName": "id", "edit": {"type": "hidden"}, "search": {"type": "text"}, "defaultOrder": "desc"},
                    {"title": "用户账号", "data": "username", "sName": "username", "edit": {"type": "text", "required":true,"rangelength":"[2, 255]"}, "search": {"type": "text"}, "bSortable": false},
                    // {"title": "密码", "data": "password", "sName": "password", "isHide": true, "edit": {"type": "password", "rangelength":"[2, 20]"}, "bSortable": false, "defaultContent":"", "bViews":false},
                    // {"title": "确认密码", "data": "repassword", "sName": "repassword", "isHide": true, "edit": {"type": "password", "rangelength":"[2, 20]", "equalTo":"input[name=password]:first"}, "bSortable": false, "defaultContent":"", "bViews":false},
                    {"title": "邮箱", "data": "email", "sName": "email", "edit": {"type": "text", "required":true,"rangelength":"[2, 255]", "email": true}, "search": {"type": "text"}, "bSortable": false},
                    {"title": "登录token", "data": "access_token", "sName": "access_token", "edit": {"type": "text", "rangelength": "[0, 255]"}, "bSortable": false, "search": {"type": "text"}},
                    {"title": "重置密码token", "data": "password_reset_token", "sName": "password_reset_token", "edit": {"type": "text", "rangelength": "[0, 255]"}, "bSortable": false},
                    {"title": "登录IP", "data": "ip", "sName": "ip", "edit": {"type": "text", "rangelength": "[0, 32]"}, "bSortable": false},

                    {"title": "性别", "data": "gender", "sName": "gender", "value": aGender, "edit": {"type": "radio", "default": 10, "required":true,"number":true}, "bSortable": false, "createdCell":function(td, data) {
                            $(td).html(mt.valuesString(aGender, aGenderColor, data));
                        }},
                    {"title": "生日", "data": "birthday", "sName": "birthday", "edit": {"type": "text", }, "bSortable": false},
                    {"title": "职业", "data": "career", "sName": "career", "edit": {"type": "text", "rangelength": "[0, 255]"}, "bSortable": false},
                    {"title": "城市", "data": "cityinfo", "sName": "cityinfo", "edit": {"type": "text", "rangelength": "[0, 120]"}, "bSortable": false},
                    {"title": "电话", "data": "tel", "sName": "tel", "edit": {"type": "text", "rangelength": "[0, 32]"}, "bSortable": false},
                    {"title": "状态", "data": "status", "sName": "status", "value": aStatus,
                        "edit": {"type": "radio", "default": 10, "required":true,"number":true},
                        "bSortable": false,
                        "search": {"type": "select"},
                        "createdCell":function(td, data) {
                            $(td).html(mt.valuesString(aStatus, aStatusColor, data));
                        }
                    },
                    {"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell" : meTables.dateTimeString},
                    {"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell" : mt.dateTimeString},
                ]
            },
            operations: {
                buttons: {
                    "see": {"className": "btn-success", "cClass":"me-table-detail", "click-param-url":"/user/userinfo?uid=", "click-param-index":"1", "click-param-barid":"userinfo-id-", "click-param-barname":"用户详情-id-",  "icon":"fa-search-plus",  "sClass":"blue"},
                    "update": {"className": "btn-info", "cClass":"me-table-update", "icon":"fa-pencil-square-o",  "sClass":"green"},
                    "delete": {"className": "btn-danger", "cClass":"me-table-delete", "icon":"fa-trash-o",  "sClass":"red"}
                }
            }
        });

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
