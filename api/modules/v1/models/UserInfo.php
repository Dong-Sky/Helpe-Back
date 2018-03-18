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
            ['username','required','message'=> ResponseStatus::getMessage(10014)]
        ];
    }

}