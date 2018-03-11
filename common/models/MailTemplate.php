<?php

namespace common\models;

use common\behaviors\TimestampBehavior;

/**
 * This is the model class for table "{{%china}}".
 *
 * @property integer $Id
 * @property string $Name
 * @property integer $Pid
 *
 * @property China $p
 * @property China[] $chinas
 */
class MailTemplate extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%mail_template}}';
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
}
