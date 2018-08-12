<?php
// 定义标题和面包屑信息
$this->title = '评论后台管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var aStatus = {"1":"正常","0":"删除"},
        aStatusColor = {"1":"label-success","0":"label-danger"};
    var m = meTables({
        title: "评论后台管理",
        table: {
            "aoColumns": [
            {"title": "编号", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "内容", "data": "content", "sName": "content", "edit": {"type": "text", }, "search": {"type": "text"}, "bSortable": false}, 
			{"title": "商品编号", "data": "itemid", "sName": "itemid", "edit": {"type": "text", "number": true}, "search": {"type": "text"}, "bSortable": false}, 
			{"title": "状态", "data": "flag", "sName": "flag",  "value": aStatus, "edit": {"type": "radio", "default": 10, "required":true,"number":true}, "search": {"type": "select"}, "bSortable": false, "createdCell":function(td, data) {
                    $(td).html(mt.valuesString(aStatus, aStatusColor, data));
                }},
			{"title": "得分", "data": "score", "sName": "score", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "订单编号", "data": "orderid", "sName": "orderid", "edit": {"type": "text", "number": true}, "search": {"type": "text"}, "bSortable": false}, 
			{"title": "评论用户", "data": "uid", "sName": "uid", "edit": {"type": "text", "number": true}, "search": {"type": "text"}, "bSortable": false}, 
			{"title": "所有者", "data": "owner", "sName": "owner", "edit": {"type": "text", "number": true}, "bSortable": false}, 
			{"title": "创建时间", "data": "ct", "sName": "ct", "bSortable": false, "createdCell" : meTables.dateTimeString}, 
			{"title": "修改时间", "data": "mt", "sName": "mt", "bSortable": false, "createdCell" : meTables.dateTimeString}, 

            ]       
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
</script>
<?php $this->endBlock(); ?>