<?php

namespace backend\controllers;

/**
 * Class RegisterController register 执行操作控制器
 * @package backend\controllers
 */
class RegisterController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Register';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'email' => 'like',
        ];
    }
}
