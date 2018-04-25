<?php
namespace api\modules\v1\models;

use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;

class Itemdetail extends CacheAR
{
    public static function tableName()
    {
        return '{{%itemdetail}}';
    }

    public function behaviors()
    {
        return [
            'timestamp'=>[
                'class'=>TimestampBehavior::className(),
                'attributes'=>[
                    ActiveRecord::EVENT_BEFORE_INSERT => ['ct', 'mt'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['mt']
                ]
            ]
        ];
    }

    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            [['itemid','mark'],
                'required','message' => '字段不能为空'],
            ['itemid', 'integer'],
            ['mark', 'string', 'length' => [1, 400]]
        ];
    }

}