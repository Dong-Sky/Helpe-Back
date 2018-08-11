<?php
// 定义标题和面包屑信息
$this->title = '登录信息表';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    function substringItem(td, data) {
        if(data.length > 0) {
            $(td).html(data.substr(0, 20) + '...');
        }
    }
</script>
<script type="text/javascript">
    var aStatus = {"1":"系统","2":"facebook"},
        aStatusColor = {"1":"label-success","2":"label-warning"};
    var m = meTables({
        title: "登录信息表",
        table: {
            "aoColumns": [
                {"title": "编号", "data": "id", "sName": "id", "bSortable": true},
			    {"title": "用户类型", "data": "type", "sName": "type", "value": aStatus, "search": {"type": "text"}, "bSortable": false,      "createdCell":function(td, data) {
                        $(td).html(mt.valuesString(aStatus, aStatusColor, data));
                    }},
			    {"title": "邮箱", "data": "email", "sName": "email", "search": {"type": "text"}, "edit": {"type": "text"}, "bSortable": false},
			    {"title": "密码", "data": "password", "sName": "password", "bSortable": false, "edit": {"type": "text", "rangelength": "[0, 64]"}},
			    {"title": "第三方token", "data": "token", "sName": "token", "bSortable": false, "edit": {"type": "text", "rangelength": "[0, 512]"}},
			    {"title": "创建时间", "data": "created_at", "sName": "created_at", "bSortable": false, "createdCell" : meTables.dateTimeString},
			    {"title": "更新时间", "data": "updated_at", "sName": "updated_at", "bSortable": false, "createdCell" : meTables.dateTimeString}

            ]       
        },
        buttons:{
            create: {
                bShow: false
            },
            updateAll: {
                bShow: false
            }
        }
        // table: {
        //     //"bAutoWidth": true
        // }
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
</script>
<?php $this->endBlock(); ?>