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

    public function getItem(){
        return $this->hasOne(Item::className(), ['itemid' => 'id']);
    }

    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            [['uid','name','appid','type','cid','price','paytp','contact','img','flag','tag','aid','aaid','lat','lng',
                'pt','pet'],
                'required','message' => '字段不能为空'],
            ['cid', 'in', 'range' => array(0, 1)],
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