<?php
// 定义标题和面包屑信息
$this->title = '推荐管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var m = meTables({
        title: "推荐管理",
        fileSelector: ["#file"],
        table: {
            "aoColumns": [
            {"title": "编号", "data": "id", "sName": "id", "edit": {"type": "hidden"}, "bSortable": false},
			{"title": "标题", "data": "title", "sName": "title", "edit": {"type": "text", "required": true,"rangelength": "[2, 255]"}, "bSortable": false}, 
			{"title": "宣传图链接", "data": "img", "sName": "img", "isHide": true, "edit": {
                    "type": "file",
                    options: {
                        "id": "file",
                        "name": "uploadimg",
                        "input-name": "img",
                        "input-type": "img_file",
                        "file-name": "img"
                    }
                }, "bSortable": false},
			{"title": "发布类型", "data": "rcid", "sName": "rcid", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "详情", "data": "mark", "sName": "mark", "edit": {"type": "textarea", "required": true}, "bSortable": false},
			{"title": "官网地址", "data": "url", "sName": "url", "edit": {"type": "text", "required": true,"rangelength": "[2, 255]"}, "bSortable": false}, 
			{"title": "商品id", "data": "itemid", "sName": "itemid", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "发布人名字", "data": "pub_username", "sName": "pub_username", "edit": {"type": "text", "required": true,"rangelength": "[2, 255]"}, "bSortable": false}, 
			{"title": "创建时间", "data": "ct", "sName": "ct", "bSortable": false, "createdCell" : meTables.dateTimeString},
			{"title": "修改时间", "data": "mt", "sName": "mt", "bSortable": false, "createdCell" : meTables.dateTimeString},

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
     var $file = null;
     $(function(){
         m.init();
         $file = $("#file");
     });
</script>
<?php $this->endBlock(); ?>