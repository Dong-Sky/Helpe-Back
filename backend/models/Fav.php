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

class Fav extends AdminModel {

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
        return '{{%fav}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['uid', 'itemid', 'ct', 'ut'],
            'update' => ['uid', 'itemid', 'ct', 'ut']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => '编号',
            'uid' => '用户编号',
            'itemid' => '商品编号',
            'ct' => '创建时间',
            'ut' => '修改时间',
        ];
    }

}