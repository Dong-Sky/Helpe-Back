<?php

namespace backend\controllers;



use backend\models\Item;
use backend\models\User;
use common\strategy\Substance;
use common\helpers\Helper;
use yii\db\Query;

/**
 * Class FavController 用户收藏管理 执行操作控制器
 * @package backend\controllers
 */
class FavController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Fav';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'fav.uid' => '=',
        ];
    }

    /**
     * 处理查询数据
     * @return mixed|string
     * @see where()
     * @see getQuery()
     * @see afterSearch()
     */
    public function actionSearch()
    {
        // 实例化数据显示类
        /* @var $strategy \common\strategy\Strategy */
        $strategy = Substance::getInstance($this->strategy);

        // 获取查询参数
        $search = $strategy->getRequest(); // 处理查询参数
        // var_dump($search['params']);
        // var_dump($this->where($search['params']));
        $search['field'] = $search['field'] ? $search['field'] : $this->sort;
        $search['orderBy'] = [$search['field'] => $search['sort'] == 'asc' ? SORT_ASC : SORT_DESC];
        $search['where'] = Helper::handleWhere($search['params'], $this->where($search['params']));

        // 查询数据
        $query = $this->getQuery($search['where']);
        if (YII_DEBUG) $this->arrJson['other'] = $query->createCommand()->getRawSql();

        // 查询数据条数
        $total = $query->count();
        if ($total) {
            $array = $query->offset($search['offset'])->limit($search['limit'])->orderBy($search['orderBy'])->all();
            if ($array) $this->afterSearch($array);
        } else {
            $array = [];
        }

        return $this->success($strategy->handleResponse($array, $total));
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
        // 处理联表查询的 where 条件
        /* @var $model \yii\db\ActiveRecord */
        $model = $this->modelClass;
        return (new Query())->select("fav.id as id, fav.uid as uid,  fav.itemid as itemid, fav.ct as ct, fav.mt as mt, user.username as username, item.name as itemname")->from($model::tableName() . " as fav")->leftJoin(User::tableName() . " as user", 'fav.uid = user.id')->leftJoin(Item::tableName() . " as item", 'fav.itemid = item.id')->where($where);
    }
}
