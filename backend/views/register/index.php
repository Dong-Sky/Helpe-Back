<?php
// 定义标题和面包屑信息
$this->title = '注册信息表';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var m = meTables({
        title: "注册信息表",
        table: {
            "aoColumns": [
                {"title": "编号", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}},
			    {"title": "电子邮件", "data": "email", "sName": "email", "edit": {"type": "text", "required": true,"rangelength": "[2, 64]"}, "search": {"type": "text"}, "bSortable": false},
			    {"title": "邮件校验key", "data": "auth_token", "sName": "auth_token", "edit": {"type": "text", "required": true,"rangelength": "[2, 12]"}, "bSortable": false},
			    {"title": "创建时间", "data": "created_at", "sName": "created_at", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false, "createdCell" : meTables.dateTimeString},
			    {"title": "最后更新时间", "data": "updated_at", "sName": "updated_at", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false, "createdCell" : meTables.dateTimeString}
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
        operations: {

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