<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
use api\modules\v1\models\CacheAR;
use api\modules\v1\models\UserInfo;
use yii\caching\TagDependency;
use yii\log\Logger;

class Follow extends CacheAR
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
        return '{{%follow}}';
    }

    //发起用户
    public function getuserinfo(){
        return $this->hasOne(UserInfo::className(), ['id' => 'uid']);
    }

    //被关注用户
    public function getfuserinfo(){
        return $this->hasOne(UserInfo::className(), ['id' => 'uuid']);
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
            [['uid','uuid'],
                'required','message' => '字段不能为空'],
            ['uid', 'integer'],
            ['uuid', 'integer'],
        ];
    }


    public function fields()
    {
        $controller_id = Yii::$app->controller->id;
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();
        if($action_id=="my"|| $action_id=="index"){
            $fields += ['userinfo','fuserinfo'];
        }else{

        }

        return $fields;
    }

}