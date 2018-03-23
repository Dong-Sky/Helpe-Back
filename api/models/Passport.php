<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 10:07
 */

namespace api\models;


use yii\db\ActiveRecord;
use common\behaviors\TimestampBehavior;
use Yii;
use yii\db\Exception;

class Passport extends ActiveRecord {


    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }

    public function validatePassword($password) {
        try {
            return Yii::$app->security->validatePassword($password, $this->password);
        } catch (\Exception $e) {}
        return false;
    }

}