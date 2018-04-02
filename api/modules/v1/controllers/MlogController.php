<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Mlog;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class MlogController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Mlog';

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
     * 地址列表
     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionIndex() {
        $uid = $this->userId;
        $condition[] = ['=', 'uid', $uid];

        $st = Yii::$app->request->get('st',0);
        $et = Yii::$app->request->get('et',0);

        //日志创建时间
        if ($st>0 && $et>0){
            $condition[] = ['>', 'ct', $st];
            $condition[] = ['<', 'ct', $et];
        }


        $orderby =['ct' => SORT_DESC];

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $query->orderby($orderby);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Address::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }
}