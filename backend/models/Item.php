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

class Item extends AdminModel {

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
        return '{{%item}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['jp_name', 'cn_name', 'pid', 'sort', 'flag'],
            'update' => ['jp_name', 'cn_name', 'pid', 'sort', 'flag']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => '名称',
            'appid' => '编号',
            'price' => '价格',
            'img' => '图像',
            'flag' => '状态',
            'uid' => '用户ID',
            'cid' => '创建ID',
            'tag' => '标签',
            'type' => '类型',
            'aid' => 'aid',
            'aaid' => 'aaid',
            'ct' => '创建时间',
            'ut' => '修改时间',
        ];
    }

}