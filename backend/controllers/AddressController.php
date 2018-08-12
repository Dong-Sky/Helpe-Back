<?php

namespace backend\controllers;

/**
 * Class AddressController 地址管理 执行操作控制器
 * @package backend\controllers
 */
class AddressController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Address';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'uid' => '=',
            'aid' => '=',
        ];
    }
}
