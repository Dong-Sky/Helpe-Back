<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/4/6
 * Time: 12:03
 */

namespace backend\models;


use common\models\AdminModel;
use yii\behaviors\TimestampBehavior;

class Register extends AdminModel {

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
        return '{{%register}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['email', 'auth_token', 'create_at', 'updated_at'],
            'update' => ['email', 'auth_token', 'create_at', 'updated_at']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'email' => '电子邮件',
            'auth_token' => '排序字段',
            'created_at' => '创建时间',
            'updated_at' => '修改时间',
        ];
    }

}