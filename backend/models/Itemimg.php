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

class Itemimg extends AdminModel {


    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%itemimg}}';
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'itemid' => '商品ID',
            'url' => '图片地址',
            'uid' => '用户ID',
            'ct' => '创建时间',
        ];
    }

}