<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use api\modules\v1\models\CacheAR;
use api\modules\v1\models\UserInfo;
use yii\behaviors\TimestampBehavior;

class Orderinfo extends CacheAR
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

    protected $relation_fields = [];

    public static function tableName()
    {
        return '{{%orderinfo}}';
    }

    public function getOrderaddr(){
        return $this->hasOne(Orderaddr::className(), ['id' => 'orderid']);
    }

    public function getIteminfo(){
        return $this->hasOne(Item::className(), ['id' => 'itemid']);
    }

    public function getOwnerinfo(){
        return $this->hasOne(Item::className(), ['owner' => 'id']);
    }

    public function getUserinfo(){
        return $this->hasOne(Userinfo::className(), ['id' => 'uid']);
    }


    public function scenarios()
    {
        $default_scenarios = parent::scenarios();
        return [
            'default'=>$default_scenarios["default"],
            'info'=>$default_scenarios+["default","iteminfo","ownerinfo","userinfo"],
            'update'=>['teacher_id', 'name', 'price', 'address', 'class_time', 'limit_num', 'description', 'update_time'],
        ];
    }


    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            [['uid','owner','num','cash','type','itemid','changeprice','remark','paytp','status'],
                'required','message' => '字段不能为空'],
            ['type', 'in', 'range' => array(0, 1)],
            ['uid', 'integer'],
            //['num', 'integer'],
            ['itemid', 'integer'],
            ['cash', 'double'],
            ['num', 'compare', 'compareValue' => 1, 'operator' => '>='],
            ['remark', 'string', 'length' => [1, 200]],
            ['no', 'default', 'value' => 0],
            ['ordertp', 'default', 'value' => 0],
            ['pt', 'default', 'value' => 0],
        ];
    }

    public function fields()
    {
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();
        if($action_id=="index"||$action_id=="info"){
            $fields += ['iteminfo','userinfo'];
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