<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/4/7
 * Time: 15:37
 */

namespace backend\models;


use common\models\AdminModel;
use common\behaviors\TimestampBehavior;



class Report extends AdminModel {

    /**
     * @return array
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%report}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['item_type', 'item_value', 'reason', 'info', 'status', 'user_id'],
            'update' => ['item_type', 'item_value', 'reason', 'info', 'status', 'user_id'],
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
            'item_type' => '商品类型',
            'item_value' => '商品编号',
            'reason' => '理由',
            'info' => '详情',
            'status' => '状态',
            'user_id' => '用户ID',
            'created_at' => '创建时间',
            'updated_at' => '修改时间',
        ];
    }



}