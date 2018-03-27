<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
use api\modules\v1\models\CacheAR;
use yii\caching\TagDependency;
use yii\log\Logger;

class Address extends CacheAR
{
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

    public static function tableName()
    {
        return '{{%address}}';
    }


    public function scenarios()
    {
        $default_scenarios = parent::scenarios();
        return [
            'default'=>$default_scenarios["default"],
            'online'=>[''],
            'update'=>['teacher_id', 'name', 'price', 'address', 'class_time', 'limit_num', 'description', 'update_time'],
        ];
    }

    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            [['uid','info','aid','lat','lng','uid'],
                'required','message' => '字段不能为空'],
            ['uid', 'integer'],
        ];
    }

    public function fields()
    {
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();
        return $fields;
    }

}