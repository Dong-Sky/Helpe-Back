<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use yii\web\Response;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Item;
use api\modules\v1\models\Itemdetail;

class ItemController extends BaseController
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

        //模拟数据，数组的一维必须是相关模型名
        //手动封盖值用于测试
        $data = [
            'Test' => [
                'username' => 'hello',
                'password' => '123321'
            ]
        ];

        $model = new Item();
        $model->load($data);
        if($data && $model->validate()){
            echo 'ok';
            $model->save();
        }else{
            var_dump($model->errors);
        }
    }


    /**
    - a 	值为itempub
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    - aid  选择的地址名称
    -name  商品求助名称
    -tp   0 商品 1 求助
    -cid  分类ID
    -price 价格
    -mark  描述
    -paytp 支付类型 0 线上支付  1 线下支付 2  线上支付  线下支付
    -contact  联系方式  100字节以内

    图片 请把客户端模拟的form里面file 的那么设为itemfile  支持多个图片上传
     */
    public function actionPub() {

        if (Yii::$app->request->isPost) {
            //todo 文件处理

            $uid = \Yii::$app->request->post("uid",0);
            $aid = \Yii::$app->request->post("aid",0);
            $name = \Yii::$app->request->post("name");
            $type = \Yii::$app->request->post("type",0);
            $cid = \Yii::$app->request->post("cid",0);
            $price = \Yii::$app->request->post("price",0);
            $mark= \Yii::$app->request->post("mark",0);
            $paytp = \Yii::$app->request->post("paytp",0);
            $conact =  \Yii::$app->request->post("contact");

            /*
             public $id;             //用户id
    public $name;
    public $appid=0;
    public $cid=1;
    public $img="";
    public $tp=1;
    public $t=NOW_TIME;
    public $mt=NOW_TIME;
    public $pt = NOW_TIME;

    public $price;
    public $flag = 0;
    public $uid=0;
    public $tag=0;


    public $aid;
    public $pet=0;
    public $lat;
    public $lng;
    public $aaid=0;
    public $paytp=0;
    public $contact="";
    public $salenum=0;
    public $u="";
    public $deadline="";
             */
            $data = [
                'Item' => [
                    'uid' => $uid,
                    'aid' => $aid,
                    'appid'=> 0,
                    'name' => $name,
                    'type' => $type,
                    'cid' => $cid,
                    'price' => $price,
                    'paytp' => $paytp,
                    'contact' => $conact,
                    'img' =>"/sstetttt.jpg",
                    'flag' =>1,
                    'tag'=>"133333",
                    'aaid'=>1,
                    //todo 获取地理位置
                    'lat'=>1,
                    'lng'=>1,
                    'aaid'=>0,
                    'paytp'=>0,
                    'salenum'=>0,
                    'unit'=>"",
                    //'deadline'=>"",
                    'pt'=>time(),
                    'pet'=>0,
                ]
            ];
            //$data_detail = ['itemdetail' => ["mark"=>$mark]];
            // 开始事务查询
            $transaction = Yii::$app->db->beginTransaction();
            $saveSuccess = false;
            try{
                //var_dump($data);exit;
                $item = new Item();
                $item->load($data);
                var_dump($data);
                if($data && $item->validate()){
                    echo 'ok';
                    $item->save();

                    $itmedetail = new Itemdetail();
                    $itmedetail->mark = $mark;
                    //$itmedetail->itemid = $item->id;

                    if($itmedetail->validate()){
                        echo 'ok2';
                        //$itmedetail->save();
                        $item->link('itemdetail', $itmedetail);
                    }else{
                        var_dump($itmedetail->errors);
                    }

                    $transaction->commit();
                    $saveSuccess = true;


                }else{
                    var_dump($item->errors);
                }
            } catch (\Exception $e) {
                var_dump($e->getMessage());
                $transaction->rollBack();
                exit;
            }

            TagDependency::invalidate(Yii::$app->cache, 'num');
        }else{
            echo 2222;
        }



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

        //$model = new $this->modelClass();
        //$query = $model->setScenario("index")->find()->where($condition);
        $query = $modelClass::find()->where($condition);

        //var_dump($this->getCacheRule());exit;
        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>$this->getCacheRule()
        ]);

        $this->serializer['collectionEnvelope'] = null;
        return $ActiveDataProvider;
    }



    /**
    - a 	值为user
    -m item
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    - p  页数
    - ps   每页数量
    - st   开始时间
    -et  结束时间
    －tp   类型 0 我的商品   1 我的账求助

     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionMyitem() {

        $condition = [];
        $et = \Yii::$app->request->get("et");
        $st = \Yii::$app->request->get("st");

        if($et && $st){
            $condition[] = ['>', 'pt', $st];
            $condition[] = ['<', 'pt', $et];
        }

        $uid = \Yii::$app->request->get("uid",0);
        if($uid){
            $condition[] = ['=', 'uid', $uid];
        }

        $type = \Yii::$app->request->get("type");
        if($type!==NULL && in_array($type,[0,1])){
            $condition[] = ['=', 'type', $type];
        }

        //var_dump($condition);exit;
        //Yii::$app->request->setQueryParams(array_merge(Yii::$app->request->getQueryParams(),
        //    ['expand' => 'itemdetail,itemimg']));

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>$this->getCacheRule()
        ]);

        return $ActiveDataProvider;
    }


    /**
     * 商品服务，求助列表
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

        $condition = [];
        $et = \Yii::$app->request->get("et");
        $st = \Yii::$app->request->get("st");

        if($et && $st){
            $condition[] = ['>', 'pt', $st];
            $condition[] = ['<', 'pt', $et];
        }

        $cid = \Yii::$app->request->get("cid",0);
        if($cid){
            $condition[] = ['=', 'cid', $cid];
        }

        //Yii::$app->request->setQueryParams(array_merge(Yii::$app->request->getQueryParams(),
        //    ['expand' => 'itemdetail,itemimg']));

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

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
        //Yii::$app->request->setQueryParams(array_merge(Yii::$app->request->getQueryParams(),
        //    ['expand' => 'itemdetail,itemimg']));
        $modelClass = $this->modelClass;
        //$query = $modelClass::find();
        //return $query;
        //$query->where(["id" => 1]);

        $query = $modelClass::find()->setRelationFields(['itemdetail','itemimg']);

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