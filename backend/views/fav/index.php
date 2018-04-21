<?php
// 定义标题和面包屑信息
$this->title = '用户收藏管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var m = meTables({
        title: "用户收藏管理",
        table: {
            "aoColumns": [
                			{"title": "id", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "用户编号", "data": "uid", "sName": "uid", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "商品编号", "data": "itemid", "sName": "itemid", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "创建时间", "data": "ct", "sName": "ct", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false, "createdCell" : meTables.dateTimeString},
			{"title": "最后修改时间", "data": "mt", "sName": "mt", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false, "createdCell" : meTables.dateTimeString}

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