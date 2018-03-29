<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
use api\modules\v1\models\Item;
use api\modules\v1\models\CacheAR;
use yii\caching\TagDependency;
use yii\log\Logger;

class Fav extends CacheAR
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
        return '{{%fav}}';
    }


    public function scenarios()
    {
        $default_scenarios = parent::scenarios();
        return [
            'default'=>$default_scenarios["default"],
             ];
    }

    public function getIteminfo(){
        return $this->hasOne(Item::className(), ['id' => 'itemid']);
    }

    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            [['uid','itemid'],
                'required','message' => '字段不能为空'],
            ['uid', 'integer'],
            ['itemid', 'integer'],

        ];
    }

    public function fields()
    {
        $controller_id = Yii::$app->controller->id;
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();


        if($controller_id=="fav" && $action_id=="index"){
            $fields += ['iteminfo'];
        }elseif($controller_id=="fav" && $action_id=="info"){
            //$fields += ['itemdetail','itemimg','isfav','favnum','userInfo'];
        }

        return $fields;
    }

}