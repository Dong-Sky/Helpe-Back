<?php

namespace api\models;

use Yii;

/**
 * CachedActiveRecord is the ActiveRecord class with cache
 */
trait CachedActiveRecord
{
    /**
     * @inheritdoc
     * @return CachedActiveQuery the newly created [[CachedActiveQuery]] instance.
     */
    public static function find()
    {
        return Yii::createObject([
            'class'      => CachedActiveQuery::className(),
            'duration'   => 300,
            'dependency' => null
        ], [get_called_class()]);
    }
}