<?php
// 定义标题和面包屑信息
$this->title = '推荐管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
    <script src="/public/assets/js/jquery.datetimepicker.full.min.js"></script>
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
        },
        searchHtml: "<label>开始日期: <input type='text' name='ct_start' title='订单创建开始时间' id='search-ct_start' /></label><label>结束日期: <input type='text' name='ct_end' title='订单创建结束时间' id='search-ct_end' /></label>",
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


    $(document).ready(function() {
        jQuery("#search-ct_start").datetimepicker({
            timepicker:false,
            format:'Y-m-d',
            formatDate:'Y-m-d',
            onShow: function (ct) {
                this.setOptions({
                    maxDate:jQuery("#search-ct_end").val() ? jQuery("#search-ct_end").val() : false
                })
            }
        });
        jQuery("#search-ct_end").datetimepicker({
            timepicker:false,
            format:'Y-m-d',
            formatDate:'Y-m-d',
            onShow: function (ct) {
                this.setOptions({
                    minDate:jQuery("#search-ct_start").val() ? jQuery("#search-ct_start").val() : false
                })
            }
        });
    });

</script>
<?php $this->endBlock(); ?>