<?php

namespace api\models;

use Yii;
use yii\db\ActiveQuery;
use yii\log\Logger;

/**
 * CachedActiveRecord is the ActiveRecord class with cache
 */
trait CachedActiveRecord
{
    /**
     * @inheritdoc
     * @return CachedActiveQuery the newly created [[CachedActiveQuery]] instance.
     */
    public static function find($useCache=true)
    {
        if ($useCache){
            return Yii::createObject([
                'class'      => CachedActiveQuery::className(),
                'duration'   => 300,
                'dependency' => null
            ], [get_called_class()]);
        }else{
            Yii::getLogger()->log("no use cache find", Logger::LEVEL_INFO);
            return Yii::createObject([
                'class'      => ActiveQuery::className(),
            ], [get_called_class()]);
        }

    }
}