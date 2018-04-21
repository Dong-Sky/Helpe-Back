<?php

namespace backend\controllers;

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
            
        ];
    }
}
