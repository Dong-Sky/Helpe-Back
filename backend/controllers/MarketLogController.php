<?php

namespace backend\controllers;

use yii\db\Query;
use backend\models\User;

/**
 * Class MarketLogController 推送信息查看 执行操作控制器
 * @package backend\controllers
 */
class MarketLogController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\MarketLog';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'uid' => '=',
			'tpid' => '=', 

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
        return (new Query())->select("ml.id as id, ml.uid as uid, ml.tpid as tpid, ml.ct as ct, ml.data as data, u.username as uusername")->from($model::tableName() . " as ml")->leftJoin(User::tableName() . " as u", 'ml.uid = u.id')->where($where);
    }
}
