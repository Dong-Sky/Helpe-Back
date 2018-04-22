<?php
// 定义标题和面包屑信息
$this->title = '用户关注管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var m = meTables({
        title: "用户关注管理",
        table: {
            "aoColumns": [
                {"title": "id", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "被关注用户编号", "data": "uuid", "sName": "fo.uuid", "search": {"type": "text"}, "bSortable": false},
                {"title": "被关注用户名称", "data": "uuusername", "sName": "uuusername", "bSortable": false},
			{"title": "用户编号", "data": "uid", "sName": "uid", "edit": {"type": "text", "required": true,"number": true}},
                {"title": "用户名称", "data": "uusername", "sName": "uusername", "edit": {"type": "text", "required": true,"number": true}},
                {"title": "创建时间", "data": "ct", "sName": "ct", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "修改时间", "data": "mt", "sName": "mt", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 

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
            isOpen: true,
            width: "120px",
            // title: meTables.fn.getLanguage("sOperation"),
            defaultContent: "",
            buttons: {
                "see": {"className": "btn-success", "cClass":"me-table-detail",  "icon":"fa-search-plus",  "sClass":"blue"},
                "update": {"bShow": false},
                "delete": {"className": "btn-danger", "cClass":"me-table-delete", "icon":"fa-trash-o",  "sClass":"red"}
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