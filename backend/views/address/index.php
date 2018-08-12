<?php
// 定义标题和面包屑信息
$this->title = '地址管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var m = meTables({
        title: "地址管理",
        table: {
            "aoColumns": [
                			{"title": "编号", "data": "id", "sName": "id", "bSortable": false},
			{"title": "用户ID", "data": "uid", "sName": "uid", "search": {"type": "text"}, "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "地址编号", "data": "aid", "sName": "aid", "search": {"type": "text"}, "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "详情", "data": "info", "sName": "info", "edit": {"type": "text", "required": true,"rangelength": "[0, 255]"}, "bSortable": false},
			{"title": "经度", "data": "lat", "sName": "lat", "edit": {"type": "text", "required": true}, "bSortable": false}, 
			{"title": "纬度", "data": "lng", "sName": "lng", "edit": {"type": "text", "required": true}, "bSortable": false}, 
			{"title": "创建时间", "data": "ct", "sName": "ct",  "bSortable": false, "createdCell" : mt.dateTimeString},
			{"title": "修改时间", "data": "mt", "sName": "mt",  "bSortable": false, "createdCell" : mt.dateTimeString},

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