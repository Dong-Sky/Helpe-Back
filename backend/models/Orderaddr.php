<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/4/7
 * Time: 15:37
 */

namespace backend\models;


use common\models\AdminModel;

class Orderaddr extends AdminModel {


    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%orderaddr}}';
    }


}