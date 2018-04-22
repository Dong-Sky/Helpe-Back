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

class MarketLog extends AdminModel {

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
        return '{{%market_log}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['uid', 'tpid', 'data', 'ct']
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
            'tpid' => '交易信息类型编号',
            'data' => '内容',
            'ct' => '创建时间',
        ];
    }


}