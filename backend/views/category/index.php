<?php
// 定义标题和面包屑信息
$this->title = '分类管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var aStatus = {"1":"启用","0":"禁用"},
        aStatusColor = {"1":"label-success","0":"label-danger"};
    var m = meTables({
        title: "分类管理",
        table: {
            "aoColumns": [
                {"title": "编号", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			    {"title": "日本名称", "data": "jp_name", "sName": "jp_name", "edit": {"type": "text", "required": true,"rangelength": "[2, 50]"}, "bSortable": false},
			    {"title": "中文名称", "data": "cn_name", "sName": "cn_name", "edit": {"type": "text", "rangelength": "[2, 50]"}, "bSortable": false},
			    {"title": "父类ID", "data": "pid", "sName": "pid", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			    {"title": "排序", "data": "sort", "sName": "sort", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
                {"title": "状态", "data": "flag", "sName": "flag", "value": aStatus,
                    "edit": {"type": "radio", "default": 10, "required":true,"number":true},
                    "bSortable": false,
                    "search": {"type": "select"},
                    "createdCell":function(td, data) {
                        $(td).html(mt.valuesString(aStatus, aStatusColor, data));
                    }
                },
			    {"title": "创建时间", "data": "ct", "sName": "ct", "bSortable": false, "createdCell" : meTables.dateTimeString},
			    {"title": "修改时间", "data": "mt", "sName": "mt", "bSortable": false, "createdCell" : meTables.dateTimeString}

            ]       
        }
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