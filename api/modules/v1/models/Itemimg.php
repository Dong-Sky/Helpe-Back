<?php
namespace api\modules\v1\models;

use yii\db\ActiveRecord;

class Itemimg extends ActiveRecord
{
    public static function tableName()
    {
        return '{{%itemimg}}';
    }

}