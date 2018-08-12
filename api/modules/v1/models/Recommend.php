<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use api\modules\v1\models\Itemdetail;
use api\modules\v1\models\Itemimg;
use api\modules\v1\models\Fav;
use api\modules\v1\models\Orderinfo;
use api\modules\v1\models\Category;
use api\modules\v1\models\CacheAR;
use yii\behaviors\TimestampBehavior;
use yii\caching\TagDependency;
use yii\log\Logger;

class Recommend extends CacheAR
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


    public $distance;

    public static function tableName()
    {
        return '{{%recommend}}';
    }

    public function getIteminfo(){
        return $this->hasOne(Item::className(), ['id' => 'itemid']);
    }

    public function getRcategory(){
        return $this->hasOne(Rcategory::className(), ['id' => 'rcid']);
    }

    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            [['uid','name','appid','type','cid','price','paytp','contact','flag','tag','aid','aaid','lat','lng',
                'pt','pet'],
                'required','message' => '字段不能为空'],
            ['type', 'in', 'range' => array(0, 1)],
            ['uid', 'integer'],
            ['img', 'default', 'value' => ""],
            ['unit', 'default', 'value' => ""]
        ];
    }

    public function fields()
    {
        $controller_id = Yii::$app->controller->id;
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();
        if($controller_id=="recommend" && $action_id=="index"){
            $fields[] = 'iteminfo';
            //$fields[] = 'category';
        }elseif($controller_id=="recommend" && $action_id=="info"){
            $fields[] = 'iteminfo';
            $fields[] = 'rcategory';

        }

        if(intval(\Yii::$app->request->get("searchtp",-1))===0||
            (!empty( \Yii::$app->request->get("distance")))
        ){
            $fields[] = 'distance';
        }

        // 删除一些包含敏感信息的字段
        //unset($fields['auth_key'], $fields['password_hash'], $fields['password_reset_token']);
        //$fields += ['itemdetail','itemimg'];
        return $fields;
    }

    public function extraFields()
    {
        return ['itemdetail','itemimg'];
    }

}