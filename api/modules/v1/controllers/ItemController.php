<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use yii\web\Response;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;

class ItemController extends ActiveController
{
    public $modelClass = 'api\modules\v1\models\Item';

    public function behaviors() {
        $behaviors = parent::behaviors();
//        $behaviors['authenticator'] = [
//            'class' => CompositeAuth::className(),
//            'authMethods' => [
//                //3.请求参数: access token 当作API URL请求参数发送，这种方式应主要用于JSONP请求，因为它不能使用HTTP头来发送access token
//                //http://localhost/user/index/index?access-token=123
//                QueryParamAuth::className(),
//            ],
//        ];
        $behaviors['contentNegotiator']['formats']['text/html'] = Response::FORMAT_JSON;
        return $behaviors;
    }

    public function actions()
    {
        $actions = parent::actions();

        //使用自己写action类
        //$actions['index']['class'] = 'api\modules\v1\rests\item\IndexAction';

        //使用inline function来调用自己的实现，不使用ation类
        unset($actions['index']);
        return $actions;
    }


    public $serializer = [
        'class'=>'api\rests\Serializer',
        'collectionEnvelope' => 'data',
    ];


    public function getCacheKey(){
        //todo
        return "item_list_1";
    }

    public function actionIndex() {
        $session = \Yii::$app->session;

        $cache = \Yii::$app->cache;
        $key = "item";
        Yii::$app->request->setQueryParams(array_merge(Yii::$app->request->getQueryParams(),
            ['expand' => 'itemdetail,itemimg']));
        $modelClass = $this->modelClass;
        //$query = $modelClass::find();
        //return $query;
        //$query->where(["id" => 1]);

        $query = $modelClass::find();

//        $ActiveDataProvider =  new ActiveDataProvider([
//            'query' => $query
//        ]);
//        return $ActiveDataProvider;


        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>['key'=>$key,"cache_depend"=>new TagDependency(['tags' => 'item_list'])]
        ]);

        return $ActiveDataProvider;

//        $adp = $cache->getOrSet($key, function () use ($modelClass) {
//             $query = $modelClass::find();
//            $ActiveDataProvider =  new HelpeDataProvider([
//                'query' => $query
//            ]);
//            $ActiveDataProvider->prepare();
//            return $ActiveDataProvider;
//        },300);
//        return $adp;
    }
}