<?php
// 定义标题和面包屑信息
$this->title = '推送信息查看';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var m = meTables({
        title: "推送信息查看",
        table: {
            "aoColumns": [
                {"title": "编号", "data": "id", "sName": "id", "bSortable": false},
			{"title": "用户ID", "data": "uid", "sName": "uid", "search": {"type": "text"}, "bSortable": false}, 
			{"title": "交易信息类型id", "data": "tpid", "sName": "tpid", "search": {"type": "text"}, "bSortable": false}, 
			{"title": "内容", "data": "data", "sName": "data", "bSortable": false}, 
			{"title": "创建时间", "data": "ct", "sName": "ct", "bSortable": false, "createdCell" : meTables.dateTimeString},

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