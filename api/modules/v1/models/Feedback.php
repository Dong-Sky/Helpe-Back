<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
use api\modules\v1\models\CacheAR;
use api\modules\v1\models\Orderinfo;
use yii\caching\TagDependency;
use yii\log\Logger;

class Feedback extends CacheAR
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
        return '{{%feedback}}';
    }

    public function getOrderinfo(){
        return $this->hasOne(Orderinfo::className(), ['id' => 'orderid']);
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
            [['content','score','uid','owner','itemid','oid'],
                'required','message' => '字段不能为空'],
            //['score', 'in', 'range' => array(0, 100)],
            ['score', 'compare', 'compareValue' => 0, 'operator' => '>='],
            ['score', 'compare', 'compareValue' => 100, 'operator' => '<='],
            ['uid', 'integer'],
            ['flag', 'default', 'value' => 0],
        ];
    }

    public function fields()
    {
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();
        if($action_id=="index"||$action_id=="my"||$action_id=="info"){
            $fields += ['orderinfo'];
        }

        // 删除一些包含敏感信息的字段
        //unset($fields['auth_key'], $fields['password_hash'], $fields['password_reset_token']);
        //$fields += ['itemdetail','itemimg'];
        return $fields;
    }

}