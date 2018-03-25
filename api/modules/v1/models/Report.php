<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 25/03/2018
 * Time: 22:17
 */

namespace api\modules\v1\models;


use yii\db\ActiveRecord;
use common\behaviors\TimestampBehavior;

class Report extends ActiveRecord {

    public static function tableName()
    {
        return '{{%report}}';
    }

    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }


    public function rules()
    {
        return [
            [['item_type', 'item_value', 'reason'], 'required'],
            ['info', 'default', 'value' => ''],
        ];
    }

    public function scenarios() {
        $scenarios = parent::scenarios();
        //var_dump($scenarios);
        return $scenarios;
    }

}