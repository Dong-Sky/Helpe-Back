<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Category;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class CategoryController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Category';

    /**
     * @return array
     * 设置过滤方法
     */
    public function behaviors() {
        return ArrayHelper::merge(parent::behaviors(), [
            'authenticator' => [
                'optional' => [
                    'check-email',
                    'register',
                    'login',
                ],
            ]
        ]);
    }



    public $serializer = [
        'class'=>'api\rests\Serializer',
        'collectionEnvelope' => 'data',
    ];


    /**
     * 获取分类信息
    - a 	值为category
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    - pid  父分类id   默认获取所有分类  当然也可以 获取 各个大分类下的小分类
     * @return HelpeDataProvider
     */
    public function actionIndex() {

        $fileds = "id,name,parent";

        $condition = [];

        $pid = Yii::$app->request->get("pid",0);

        if($pid>0){
            $condition[] = ['=', 'pid', $pid];
        }

        $condition[] = ['=', 'flag', 1];

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $orderby =["sort"=>SORT_DESC];
        $query->orderby($orderby);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Category::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }
}