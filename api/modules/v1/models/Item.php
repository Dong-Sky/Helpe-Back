<?php
namespace api\modules\v1\models;

use yii\db\ActiveRecord;
use api\modules\v1\models\Itemdetail;
use api\modules\v1\models\Itemimg;

class Item extends ActiveRecord
{
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