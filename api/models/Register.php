<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 15:32
 */

namespace api\models;


use yii\db\ActiveRecord;
use common\behaviors\TimestampBehavior;

class Register extends ActiveRecord {

    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }

}