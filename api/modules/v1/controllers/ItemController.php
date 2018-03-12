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

        // 注销系统自带的实现方法
        unset($actions['index'], $actions['update'], $actions['create'], $actions['delete'], $actions['view']);
        return $actions;
    }



    public $serializer = [
        'class'=>'api\rests\Serializer',
        'collectionEnvelope' => 'data',
    ];


    public function getCacheRule(){
        //$vaid_query_key = ["expand",""]
        //todo
        $key = $modify_tag = $cache_depend = null;
        $action_id = Yii::$app->controller->action->id;
        $qs = \Yii::$app->request->queryParams;

        if($action_id=="info"){
            $key = "item_info_".$qs["id"];
            $modify_tag = "item_list";
        }elseif($action_id=="index"){
            sort($qs);
            $condition = implode(",",array_values($qs));
            $key = "item_info_".$condition;
            $cache_depend = "item_list";
        }

        $rule = [];
        $rule["key"] = $key;
        if($modify_tag){
            $rule["modify_tag"] = new TagDependency(['tags' => $modify_tag]);
        }else{
            $rule["modify_tag"] = $modify_tag;
        }
        if($cache_depend){
            $rule["cache_depend"] =  new TagDependency(['tags' => $cache_depend]);
        }else{
            $rule["cache_depend"] = $cache_depend;
        }

        return $rule;
    }

    public function actionUpdate() {

//        //模拟数据，数组的一维必须是相关模型名
//        //手动封盖值用于测试
//        $data = [
//            'Test' => [
//                'username' => 'hello',
//                'password' => '123321'
//            ]
//        ];
//
//        $test = new \app\models\Test();
//        $test->load($data);
//        if($data && $test->validate()){
//            echo 'ok';
//        }else{
//            var_dump($test->errors);
//        }
    }

    public function actionInfo() {

        $id = \Yii::$app->request->get("id");


        if($id){
            $condition = ['=', 'id', $id];
        }

        //Yii::$app->request->setQueryParams(array_merge(Yii::$app->request->getQueryParams(),
        //    ['expand' => 'itemdetail,itemimg']));

        //var_dump($this->getCacheKey());
        //var_dump(\Yii::$app->request->queryParams);
        $modelClass = $this->modelClass;


        $query = $modelClass::find()->where($condition);

        //var_dump($this->getCacheRule());exit;
        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>$this->getCacheRule(),
        ]);

        $this->serializer['collectionEnvelope'] = null;
        return $ActiveDataProvider;
    }

    public function actionIndex() {

        $condition = [];
        $et = \Yii::$app->request->get("et");
        $st = \Yii::$app->request->get("st");

        if($et && $st){
            $condition[] = ['>', 'pt', $st];
            $condition[] = ['<', 'pt', $et];
        }

        $session = \Yii::$app->session;

        //Yii::$app->request->setQueryParams(array_merge(Yii::$app->request->getQueryParams(),
        //    ['expand' => 'itemdetail,itemimg']));

        //var_dump($this->getCacheKey());
        //var_dump(\Yii::$app->request->queryParams);
        $modelClass = $this->modelClass;


        $query = $modelClass::find()
            ->where($condition);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>$this->getCacheRule()
        ]);

        return $ActiveDataProvider;
    }


    public function actionIndex1() {
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