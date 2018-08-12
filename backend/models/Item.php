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
            'default' => ['flag'],
            'update' => ['flag']
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
            'appid' => 'APP',
            'price' => '价格',
            'img' => '总览图',
            'flag' => '状态',
            'uid' => '用户ID',
            'cid' => '商品类型ID',
            'tag' => '标签',
            'type' => '类型',
            'aid' => '我的地址ID',
            'aaid' => '日本地区ID',
            'lat' => '经度',
            'lng' => '纬度',
            'pt' => '发布时间',
            'payty' => '支付类型',
            'contact' => '联系方式',
            'deadline' => '最后期限',
            'unit' => '单位',
            'pet' => '发布过期时间',
            'ct' => '创建时间',
            'ut' => '修改时间',
        ];
    }

}