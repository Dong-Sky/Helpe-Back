<?php

namespace backend\controllers;



use Yii;
use common\helpers\Helper;
use backend\models\AdminLog;

/**
 * Class FeedbackController 评论后台管理 执行操作控制器
 * @package backend\controllers
 */
class FeedbackController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Feedback';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
			'content' => 'like',
			'itemid' => '=', 
			'flag' => '=', 
			'orderid' => '=', 
			'uid' => '=',
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
        if (!$model->load(['flag' => 1, 'id' => $data["id"]], '')) {
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

}
