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

class Feedback extends AdminModel {

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
        return '{{%feedback}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['content', 'itemid', 'flag', 'score', 'orderid', 'uid', 'owner'],
            'update' => ['content', 'itemid', 'flag', 'score', 'orderid', 'uid', 'owner'],
            'delete' => ['flag']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'content' => '内容',
            'itemid' => '商品编号',
            'flag' => '状态',
            'score' => '得分',
            'orderid' => '订单编号',
            'uid' => '评论用户',
            'owner' => '所有者',
            'ct' => '创建时间',
            'ut' => '修改时间',
        ];
    }

}