<?php
// 定义标题和面包屑信息
$this->title = '订单详情管理';
?>
<?=\backend\widgets\MeTable::widget()?>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var aStatus = {"0":"初始状态","10":"订单接受", "20":"订单到达", "30":"订单付款", "40":"订单结束", "50":"订单拒绝", "60":"订单取消"},
        aStatusColor = {"0":"label-success","10":"label-success","20":"label-success","30":"label-success","40":"label-success","50":"label-warning","60":"label-warning"};
    var m = meTables({
        title: "订单详情管理",
        table: {
            "aoColumns": [
            {"title": "ID", "data": "id", "sName": "id", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "订单号", "data": "no", "sName": "no",  "search": {"type": "text"}, "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "用户ID", "data": "uid", "sName": "uid", "search": {"type": "text"}, "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "状态", "data": "status", "sName": "status", "value": aStatus, "search": {"type": "select"}, "edit": {"type": "radio", "default": 10, "required":true,"number":true}, "bSortable": false, "createdCell":function(td, data) {
                    $(td).html(mt.valuesString(aStatus, aStatusColor, data));
                }},
			{"title": "订单类型", "data": "ordertp", "sName": "ordertp", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "价格", "data": "cash", "sName": "cash", "edit": {"type": "text", "required": true}, "bSortable": false},
			{"title": "item发布时间", "data": "pt", "sName": "pt", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false, "createdCell" : meTables.dateTimeString},
			{"title": "商品id", "data": "itemid", "sName": "itemid", "search": {"type": "text"}, "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
			{"title": "数量", "data": "num", "sName": "num", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "商品类型", "data": "type", "sName": "type", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "商品所有者", "data": "owner", "sName": "owner", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false}, 
			{"title": "差价", "data": "changeprice", "sName": "changeprice", "edit": {"type": "text", "required": true}, "bSortable": false},
                {"title": "订单地址", "data": "address_info", "sName": "address_info", "bSortable": false},
                {"title": "支付类型", "data": "paytp", "sName": "paytp", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false},
                {"title": "备注", "data": "remark", "sName": "remark", "edit": {"type": "text", "required": true,"rangelength": "[2, 200]"}, "bSortable": false},
			{"title": "是否评论", "data": "fd", "sName": "fd", "edit": {"type": "text", "number": true}, "bSortable": false},
                {"title": "创建时间", "data": "ct", "sName": "ct", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false, "createdCell" : meTables.dateTimeString},
                {"title": "修改时间", "data": "mt", "sName": "mt", "edit": {"type": "text", "required": true,"number": true}, "bSortable": false, "createdCell" : meTables.dateTimeString},

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