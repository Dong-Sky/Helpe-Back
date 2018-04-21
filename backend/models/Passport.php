<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/4/6
 * Time: 21:01
 */

namespace backend\models;


use common\models\AdminModel;
use common\behaviors\TimestampBehavior;

class Passport extends AdminModel
{

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
        return '{{%passport}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['email', 'token'],
            'update' => ['email', 'token']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'type' => '账号类型',
            'email' => '电子邮件',
            'token' => '第三方token',
            'created_at' => '创建时间',
            'updated_at' => '修改时间',
        ];
    }


}