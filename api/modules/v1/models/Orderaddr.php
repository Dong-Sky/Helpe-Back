<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
use api\modules\v1\models\CacheAR;
use yii\caching\TagDependency;
use yii\log\Logger;

class Orderaddr extends CacheAR
{
    public function behaviors()
    {
        return [
            'timestamp'=>[
                'class'=>TimestampBehavior::className(),
                'attributes'=>[
                    ActiveRecord::EVENT_BEFORE_INSERT => ['ct'],
                ]
            ]
        ];
    }

    public static function tableName()
    {
        return '{{%orderaddr}}';
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
            [['uid','aid','info','orderid','lat','lng'],
                'required','message' => '字段不能为空'],

            ['uid', 'integer'],
        ];
    }

    public function fields()
    {
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();

        // 删除一些包含敏感信息的字段
        //unset($fields['auth_key'], $fields['password_hash'], $fields['password_reset_token']);
        //$fields += ['itemdetail','itemimg'];
        return $fields;
    }

}