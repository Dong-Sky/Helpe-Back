<?php

namespace backend\controllers;


use backend\models\User;
use yii\db\Query;


/**
 * Class FollowController follow 执行操作控制器
 * @package backend\controllers
 */
class FollowController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Follow';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'fo.uuid' => '=',
        ];
    }

    /**
     * 获取查询对象(查询结果一定要为数组)
     *
     * @param mixed|array $where 查询条件
     * @return \yii\db\Query 返回查询对象
     * @see actionSearch()
     * @see actionExport()
     */
    protected function getQuery($where)
    {
        /* @var $model \yii\db\ActiveRecord */
        $model = $this->modelClass;
        return (new Query())->select("fo.id as id, fo.uuid as uuid, fo.uid as uid, fo.ct as ct, fo.mt as mt, uu.username as uuusername, u.username as uusername")->from($model::tableName() . " as fo")->leftJoin(User::tableName() . " as uu", 'fo.uuid = uu.id')->leftJoin(User::tableName() . " as u", 'fo.uid = u.id')->where($where);
    }
}
