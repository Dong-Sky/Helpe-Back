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
use api\modules\v1\models\CacheAR;


class UserInfo extends CacheAR {


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
            ['username', 'default', 'value' => null],
            ['gender', 'default', 'value' => null],
            ['birthday', 'default', 'value' => null],
            ['city', 'default', 'value' => null],
            ['cityinfo', 'default', 'value' => null],
            ['tel', 'default', 'value' => null],
            ['info', 'default', 'value' => null],
            ['career', 'default', 'value' => null],
        ];
    }

    public function scenarios()
    {
        $default_scenarios = parent::scenarios();
        return [
            'default'=>$default_scenarios["default"],
            'update'=>['username', 'gender', 'birthday', 'city', 'cityinfo', 'tel', 'info', 'career']
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