<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/4/7
 * Time: 15:37
 */

namespace backend\models;


use common\models\AdminModel;
use common\behaviors\TimestampMtBehavior;

class Orderinfo extends AdminModel {

    /**
     * @return array
     */
    public function behaviors()
    {
        return [
            TimestampMtBehavior::className(),
        ];
    }

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%orderinfo}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['status'],
            'update' => ['status'],
            'delete' => ['status']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'no' => '订单号',
            'uid' => '用户ID',
            'status' => '订单状态',
            'ordertp' => '订单类型',
            'cash' => '价格',
            'ct' => '创建时间',
            'pt' => '商品发布时间',
            'mt' => '修改时间',
            'itemid' => '商品ID',
            'num' => '数量',
            'type' => '商品类型',
            'owner' => '商品所有者ID',
            'changeprice' => '差价',
            'remark' => '备注',
            'paytp' => '支付类型',
            'fd' => '是否评论',
        ];
    }

}