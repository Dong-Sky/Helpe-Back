<?php

namespace backend\controllers;


use Yii;
use backend\models\AdminLog;
use common\helpers\Helper;

/**
 * Class PassportController 登录信息表 执行操作控制器
 * @package backend\controllers
 */
class PassportController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Passport';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'type' => '=',
			'email' => 'like',

        ];
    }


}
