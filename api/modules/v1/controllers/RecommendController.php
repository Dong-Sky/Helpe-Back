<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Recommend;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class RecommendController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Recommend';

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
     * 具体订单详情
    -m info
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    -id  商品id

     * @return HelpeDataProvider
     */

    public function actionInfo() {

        $id = \Yii::$app->request->get("id");
        if($id){
            $condition = ['=', 'id', $id];
        }else{
            throw new ApiException(9998);
        }

        $modelClass = $this->modelClass;

        $model = new $this->modelClass();
        $model->setScenario("info");
        $query = $model->find()->where($condition);
        //$query = $modelClass::find()->where($condition);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            //'cache_rule'=>Item::getCacheRule("or",$id)
        ]);

        $this->serializer['collectionEnvelope'] = null;
        return $ActiveDataProvider;
    }


    /**
     * 推荐商品服务，求助列表
     * - a 	值为item
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    - p  页数
    - ps   每页数量
    - st   开始时间
    -et  结束时间
    －cid  分类ID  默认所有类型

     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionIndex() {
        //todo 处理距离
        /*

        $lat = $this->getFloat('lat',0);
        $lng = $this->getFloat('lng',0);

        if ($lat!=0 || $lng!=0){
            $data = model\Item::instance()->getByJuLi($lat,$lng,$where,$limit);
        }else{
            $data= model\Item::instance()->fetchWhere($where,$fileds,$orderby,$limit);
        }

        */

        $has_dis = false;

        $condition = [];

        $lat = \Yii::$app->request->get("lat");
        $lng = \Yii::$app->request->get("lng");

        //起始时间
        $et = \Yii::$app->request->get("et");
        $st = \Yii::$app->request->get("st");

        if($et && $st){
            $condition[] = ['>', 'ct', $st];
            $condition[] = ['<', 'ct', $et];
        }


        //(st_distance (point (lng, lat),point(113.858202,22.583819) ) / 0.0111) AS distance
        $distance = Yii::$app->request->get("distance");
        if($distance){
            $has_dis = true;
            //$condition[] = ['>=', 'distance', $distance];
            //->andHaving(['>=', 'distance', $distance]);
        }

        //类型判断
        $rcid = \Yii::$app->request->get("rcid",0);
        if($rcid>0){
            $condition[] = ['=', 'rcid', $rcid];
        }


        //处理排序
        //0 距离  1时间 2销量 默认为0
        $searchtp = \Yii::$app->request->get("searchtp",0);
        switch($searchtp){
            case 0:
                $has_dis = true;
                $orderby =['distance' => SORT_ASC];
                break;
            case 1:
            default:
                $orderby =['ct' => SORT_DESC];
                break;

        }

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($has_dis){
            $query->select([
                '*', // select all columns
                "(st_distance (point ([[lng]], [[lat]]),point($lng,$lat) ) / 0.0111) AS distance", // 计算距离
            ]);
            if($distance){
                $query ->andHaving(['<=', 'distance', $distance]);
            }

            $query->joinWith('iteminfo');

        }

        $query->with('iteminfo')
            //->with('category')
        ;
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $query->orderby($orderby);

        //var_dump(ArrayHelper::toArray($query->all()));exit;
        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
        ]);

        return $ActiveDataProvider;
    }


}