<?php

namespace backend\controllers;
use backend\models\Orderaddr;



use common\helpers\Helper;
use common\strategy\Substance;
use yii\db\Query;
/**
 * Class OrderController 订单详情管理 执行操作控制器
 * @package backend\controllers
 */
class OrderinfoController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Orderinfo';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'no' => '=',
            'uid' => '=',
            'status' => '=',
            'itemid' => '=',
        ];
    }

    /**
     * 处理原始数据字段, 处理在查询时转换临时表的逻辑
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
        $search['field'] = $search['field'] ? $search['field'] : $this->sort;
        $search['orderBy'] = [$search['field'] => $search['sort'] == 'asc' ? SORT_ASC : SORT_DESC];

        //var_dump($search);
        // 处理where 条件, where param中的字段和 search param 中的字段都加上 fo 字段

        $newWhere = [];
        foreach($this->where([]) as $itemKey => $itemValue) {
            if (isset($search['params'][$itemKey])) {
                $search['params']['fo.'.$itemKey] = $search['params'][$itemKey];
                unset($search['params'][$itemKey]);
            }
            $newWhere['fo.'.$itemKey] = $itemValue;
        }


        $search['where'] = Helper::handleWhere($search['params'], $newWhere);

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
        /* @var $model \yii\db\ActiveRecord */
        $model = $this->modelClass;
        return (new Query())->select("fo.*, oa.info as address_info")->from($model::tableName() . " as fo")->leftJoin(Orderaddr::tableName() . " as oa", 'fo.id = oa.orderid')->where($where);
    }

}
