<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use api\modules\v1\models\Itemdetail;
use api\modules\v1\models\Itemimg;
use yii\behaviors\TimestampBehavior;

class Item extends ActiveRecord
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
        return '{{%item}}';
    }

    public function getItemdetail(){
        return $this->hasOne(Itemdetail::className(), ['itemid' => 'id']);
    }

    public function getItemimg(){
        return $this->hasMany(Itemimg::className(), ['itemid' => 'id']);
    }


    public function scenarios()
    {
        return [
            'index'=>$this->fields()+['itemdetail','itemimg'],
            'update'=>['teacher_id', 'name', 'price', 'address', 'class_time', 'limit_num', 'description', 'update_time'],
        ];
    }


    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            ['uid','required','message' => '用户名不能为空'],
            ['cid', 'in', 'range' => array(0, 1)],
            ['uid', 'numerical', 'integerOnly'=>true],
        ];
    }

    public function fields()
    {
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();
        if($action_id=="index"||$action_id=="info"){
            $fields += ['itemdetail','itemimg'];
        }

        // 删除一些包含敏感信息的字段
        //unset($fields['auth_key'], $fields['password_hash'], $fields['password_reset_token']);
        //$fields += ['itemdetail','itemimg'];
        return $fields;
    }

    /**
     * 设置关联字段
     * @param $fields
     */
    public function setRelationFields($fields){
        $this->relation_fields = $fields;
    }

    public function extraFields()
    {
        return ['itemdetail','itemimg'];
    }

}