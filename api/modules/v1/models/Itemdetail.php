<?php
namespace api\modules\v1\models;

use yii\db\ActiveRecord;

class Itemdetail extends ActiveRecord
{
    public static function tableName()
    {
        return '{{%itemdetail}}';
    }

}