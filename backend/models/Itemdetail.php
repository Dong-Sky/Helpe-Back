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

class Itemdetail extends AdminModel {


    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%itemdetail}}';
    }


    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'itemid' => '服务求助编号',
            'mark' => '描述',
            'ct' => '创建时间',
            'ut' => '修改时间',
        ];
    }

}