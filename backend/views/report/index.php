<?php
// 定义标题和面包屑信息
$this->title = '举报信息管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var aStatus = {"0":"删除","1":"系统提交","2":"人工处理"},
        aStatusColor = {"0":"label-danger", "1":"label-success","2":"label-warning"};
    var m = meTables({
        title: "举报信息管理",
        table: {
            "aoColumns": [
                {"title": "编号", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "商品类型", "data": "item_type", "sName": "item_type", "edit": {"type": "text", "required": true,"number": true}, "search": {"type": "text"}, "bSortable": false},
			{"title": "商品编号", "data": "item_value", "sName": "item_value", "edit": {"type": "text", "required": true,"number": true}, "search": {"type": "text"}, "bSortable": false},
			{"title": "举报原因", "data": "reason", "sName": "reason", "edit": {"type": "text", "required": true,"number": true}, "search": {"type": "text"}, "bSortable": false},
			{"title": "举报详细", "data": "info", "sName": "info", "edit": {"type": "text", }, "bSortable": false}, 
			{"title": "状态", "data": "status", "sName": "status", "value": aStatus, "edit": {"type": "radio", "required": true,"number": true}, "search": {"type": "select"}, "bSortable": false, "createdCell":function(td, data) {
                    $(td).html(mt.valuesString(aStatus, aStatusColor, data));
                }},
			{"title": "举报用户编号", "data": "user_id", "sName": "user_id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
            {"title": "举报用户名称", "data": "username", "sName": "username", "bSortable": false},
			{"title": "创建时间", "data": "created_at", "sName": "created_at", "bSortable": false, "createdCell" : meTables.dateTimeString}, 
			{"title": "最后更新时间", "data": "updated_at", "sName": "updated_at", "bSortable": false, "createdCell" : meTables.dateTimeString}, 

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