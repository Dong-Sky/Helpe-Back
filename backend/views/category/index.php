<?php
// 定义标题和面包屑信息
$this->title = '分类管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var m = meTables({
        title: "分类管理",
        table: {
            "aoColumns": [
                {"title": "编号", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			    {"title": "日本名称", "data": "jp_name", "sName": "jp_name", "edit": {"type": "text", "required": true,"rangelength": "[2, 50]"}, "bSortable": false},
			    {"title": "中文名称", "data": "cn_name", "sName": "cn_name", "edit": {"type": "text", "rangelength": "[2, 50]"}, "bSortable": false},
			    {"title": "父类ID", "data": "pid", "sName": "pid", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			    {"title": "排序", "data": "sort", "sName": "sort", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			    {"title": "状态", "data": "flag", "sName": "flag", "edit": {"type": "text", "required": true,"number": true}, "search": {"type": "text"}, "bSortable": false},
			    {"title": "创建时间", "data": "ct", "sName": "ct", "edit": {"type": "text", "required": true,"number": true}, "search": {"type": "text"}, "bSortable": false},
			    {"title": "修改时间", "data": "mt", "sName": "mt", "edit": {"type": "text", "number": true}, "bSortable": false}

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