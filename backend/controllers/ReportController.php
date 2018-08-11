<?php

namespace backend\controllers;


use backend\models\User;
use yii\db\Query;

use Yii;
use common\helpers\Helper;
use backend\models\AdminLog;
use common\strategy\Substance;

/**
 * Class ReportController 举报信息管理 执行操作控制器
 * @package backend\controllers
 */
class ReportController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Report';

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
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'item_type' => '=',
			'item_value' => '=',
			'reason' => '=',
			'status' => '=',
        ];
    }


    public function actionDelete()
    {
        // 接收参数判断
        $data = Yii::$app->request->post();
        $model = $this->findOne();
        if (!$model) {
            return $this->returnJson();
        }


        // 判断是否存在指定的验证场景，有则使用，没有默认
        $arrScenarios = $model->scenarios();
        if (isset($arrScenarios['delete'])) {
            $model->scenario = 'delete';
        }


        // 对model对象各个字段进行赋值
        if (!$model->load(['status' => 0, 'id' => $data["id"]], '')) {
            return $this->error(205);
        }
        //var_dump('<pre>', $data);
        // 修改数据成功
        if ($model->save()) {
            AdminLog::create(AdminLog::TYPE_UPDATE, $data, $this->pk . '=' . $data[$this->pk]);
            return $this->success($model);
        } else {
            return $this->error(1004, Helper::arrayToString($model->getErrors()));
        }
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
        return (new Query())->select("fo.id as id, fo.item_type as item_type, fo.item_value as item_value, fo.reason as reason, fo.info as info, fo.status as status, fo.user_id as user_id, fo.created_at as created_at, fo.updated_at as updated_at, u.username as username")->from($model::tableName() . " as fo")->leftJoin(User::tableName() . " as u", 'fo.user_id = u.id')->where($where);
    }
}
