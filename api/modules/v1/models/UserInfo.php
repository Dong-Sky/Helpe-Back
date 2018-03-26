<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 18/03/2018
 * Time: 15:30
 */

namespace api\modules\v1\models;


use api\helpers\ResponseStatus;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;


class UserInfo extends ActiveRecord {

    public $username;
    public $gender;
    public $birthday;
    public $city;
    public $tel;
    public $info;
    public $career;

    public static function tableName() {
        return '{{%user}}';
    }

    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }

    public function rules() {
        return [
            ['username','required','message'=> ResponseStatus::getMessage(10014)],
            ['gender', 'in', 'range' => [1, 2, 3]],
            ['birthday', 'date', 'format' => 'yyyy-MM-dd'],
            ['city', 'string'],
            ['tel', 'string'],
            ['info', 'string'],
            ['career', 'string'],
        ];
    }


    public function fields()
    {
        $fields = parent::fields();

        // 删除一些包含敏感信息的字段
        unset($fields['access_token'], $fields['password_reset_token']);
        return $fields;
    }

}