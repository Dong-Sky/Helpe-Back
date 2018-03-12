<?php
namespace api\modules\v1\models;

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

    protected $data_field = [];
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


//    public function scenarios()
//    {
//        return [
//            'create'=>['teacher_id', 'name', 'price', 'address', 'class_time', 'limit_num', 'description', 'create_time', 'update_time'],
//            'update'=>['teacher_id', 'name', 'price', 'address', 'class_time', 'limit_num', 'description', 'update_time'],
//        ];
//    }


    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            ['username','required','message' => '用户名不能为空'],
            ['password','required','message' => '密码不能为空']
        ];
    }

    public function fields()
    {
        if($this->data_field){
            $fields = parent::fields();

            //$fields += ['itemdetail','itemimg'];
        }else{
            $fields = parent::fields();
        }

        // 删除一些包含敏感信息的字段
        //unset($fields['auth_key'], $fields['password_hash'], $fields['password_reset_token']);

        return $fields;
    }

    public function setFields($fields){
        $this->data_field = $fields;
    }

    public function extraFields()
    {
        return ['itemdetail','itemimg'];
    }

}