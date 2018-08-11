<?php

namespace backend\controllers;

use backend\models\User;
use Yii;
use common\helpers\Helper;
use backend\models\AdminLog;

/**
 * Class UserController 用户信息
 * @package backend\controllers
 */
class UserController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\User';

    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'username' => 'like',
            'email' => 'like',
            'status' => '=',
            'id' => '=',
        ];
    }

    /**
     * 首页显示
     * @return string
     */
    public function actionIndex()
    {
        return $this->render('index', [
            'status' => User::getArrayStatus(),
            'statusColor' => User::getStatusColor(),
        ]);
    }

    /**
     * 处理导出数据显示的问题
     * @return array
     */
    public function getExportHandleParams()
    {
        $array['created_at'] = $array['updated_at'] = function ($value) {
            return date('Y-m-d H:i:s', $value);
        };

        return $array;
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

    public function actionUserinfo() {
        $request = Yii::$app->request;
        $uid = $request->get('uid');

        if (empty($uid)) {
            return $this->error(201);
        }

        $model = $this->modelClass;
        $model = $model::findOne($uid);
        //var_dump($model);
        if (!$model) {
            return $this->error(220, "用户没找到");
        }

        return $this->render('userinfo', ['user' => $model->attributes]);
    }
}
