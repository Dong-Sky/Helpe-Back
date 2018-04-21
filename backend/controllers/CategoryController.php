<?php

namespace backend\controllers;

/**
 * Class CategoryController 分类管理 执行操作控制器
 * @package backend\controllers
 */
class CategoryController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Category';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            			'flag' => '=', 
			'ct' => '=', 

        ];
    }
}
