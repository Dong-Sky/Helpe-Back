<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 00:02
 */

namespace api\modules\v1\controllers;
use Yii;
use api\models\ApiResponse;
use yii\rest\ActiveController;
use api\models\Passport;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Orderinfo;
use api\modules\v1\models\Orderaddr;
use api\modules\v1\models\Address;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class OrderController extends BaseActiveController {

    public $modelClass = 'api\modules\v1\models\Orderinfo';

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
    - a 	值为buy
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    - aid  选择的地址ID  （当是购买商品时候 需要选择地址ID  求助不需要 会记录求助者的信息）
    -id  商品id
    -num   数量
    -cprice 差价
     * @return ApiResponse
     */
    public function actionBuy() {
        if (Yii::$app->request->isPost) {
            //todo 文件处理

            $uid = \Yii::$app->request->post("uid",0);
            $aid = \Yii::$app->request->post("aid",0);
            $num = \Yii::$app->request->post("num",1);
            $id = \Yii::$app->request->post("id",0);
            $cprice = \Yii::$app->request->post("changeprice",0);

            $remark = \Yii::$app->request->post("mark","");
            $paytp = \Yii::$app->request->post('paytp',1);

            /**
             * todo
             */
            //$cache_config = Item::getCacheConfig($id);
            //var_dump($cache_config);exit;

            $item = Item::find()->where("id=:id",[':id' => $id])->one();

            if (empty($item) || $item['uid'] == $uid){
                throw new ApiException(30001);
            }

            $data = ['order' => array(
                'uid'=>$uid,
                'owner'=>$item['uid'],
                'num'=>$num,
                'cash'=>$item['price']*$num,
                'type'=>$item['type'],
                'itemid'=>$item['id'],
                'changeprice'=>$cprice,
                'remark'=>$remark,
                "paytp"=>$paytp,
            )];


            /**
             *todo
             */
            $check_user = true;
            if($check_user){

            }


            //item类型 0 服务 1 求助
            if ($data['order']['type']==0){
                $data['order']['aid'] = $aid;


                //model\Log::instance()->addLog($item['uid'],1,array("username"=>$my['name'],"itemname"=>$item["name"]));
            }else{
                $data['order']['aid'] = $item['aid'];
                //model\Log::instance()->addLog($item['uid'],2,array("username"=>$my['name'],"itemname"=>$item["name"]));

            }

            $addr = Address::findOne(["id=:id",[":id"=>$aid]]);
            if (empty($addr)){
                throw new ApiException(40001);
            }

            // 开始事务查询
            $transaction = Yii::$app->db->beginTransaction();
            $saveSuccess = false;
            $insert_id = null;
            try {
                $orderinfo = new Orderinfo();
                $orderinfo->load($data);
                if ($data && $orderinfo->validate()) {
                    $saved = $orderinfo->save();

                    if($saved){
                        $orderaddr = new Orderaddr();
                        $adr_data = ['Orderaddr'=>$addr];
                        unset($adr_data['Orderaddr']['id']);
                        $adr_data['Orderaddr']['id'] = $orderinfo->id;

                        $orderaddr->load($adr_data);
                        if ($orderaddr->validate()) {
                            $orderaddr->save();
                            //$item->link('itemdetail', $itmedetail);
                        } else {
                            //var_dump($itmedetail->errors);exit;
                            throw new ApiException(9998,$orderaddr->errors);
                        }
                    }
                    $transaction->commit();
                    $saveSuccess = true;
                    $insert_id = $orderinfo->id;
                } else {
                    //var_dump($item->errors);
                    throw new ApiException(9998,$orderinfo->errors);
                }

            }catch (ApiException $e) {
                //var_dump($e->getMessage());exit;
                $transaction->rollBack();
                $insert_id = null;
                //exit;
                throw $e;
            } catch (\Exception $e) {
                //var_dump($e->getMessage());exit;
                $transaction->rollBack();
                $insert_id = null;
                //exit;
                throw new ApiException(9996,$e->getMessage());
            }

            $this->updateCache($insert_id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }
    }

    /**
    * 我的下单列表
    - a 	值为order
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    -   选择的地址ID  （当是购买商品时候 需要选择地址ID  求助不需要 会记录求助者的信息）
    -tp  0 商品  1 求助

     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionIndex() {


        $fileds = " o.id AS oid,o.paytp as opayty,o.remark AS oremark,o.*,u.*,i.*";


        $condition = [];

        //$uid = Yii::$app->request->get("uid",0);
        $check_user = true;

        $uid = 1;//todo
        if($check_user){
            $condition[] = ['=', 'uid', $uid];
        }

        //订单的商品类型 服务还是求助
        $type = Yii::$app->request->get('type');

        if ($type>-1||$type===null){
            $condition[] = ['=', 'type', $type];
        }

        $st = Yii::$app->request->get('st',0);
        $et = Yii::$app->request->get('et',0);

        //订单创建时间
        if ($st>0 && $et>0){
            $condition[] = ['>', 'ct', $st];
            $condition[] = ['<', 'ct', $et];
        }

        $status = Yii::$app->request->get('status',"");

        //如果1,2,3 或者 1
        if ($status!=""){
            if(strpos($status,",")!==false){
                $condition[] = ['in', 'status', explode(",",$status)];
            }else{
                $condition[] = ['=', 'status', $status];
            }
        }

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $orderby =["ct"=>SORT_DESC];
        $query->orderby($orderby);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Orderinfo::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }

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
        }

        $modelClass = $this->modelClass;

        $model = new $this->modelClass();
        $query = $model->setScenario("info")->find()->where($condition);
        //$query = $modelClass::find()->where($condition);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Item::getCacheRule("or",$id)
        ]);

        $this->serializer['collectionEnvelope'] = null;
        return $ActiveDataProvider;
    }


    /**
     *用户出售的 订单列表
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    -   选择的地址ID  （当是购买商品时候 需要选择地址ID  求助不需要 会记录求助者的信息）
    -tp  0 商品  1 求助
     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionSale() {
        $fileds = "o.id AS oid,o.paytp as opayty,o.remark AS oremark,o.*,u.*,i.* ";


        $check_user = true;


        $uid = 1;//todo
        if($check_user){
            $condition[] = ['=', 'owner', $uid];
        }

        //订单的商品类型 服务还是求助
        $type = Yii::$app->request->get('type');

        if ($type>-1||$type===null){
            $condition[] = ['=', 'type', $type];
        }

        $condition = [];
        $et = \Yii::$app->request->get("et");
        $st = \Yii::$app->request->get("st");

        if($et && $st){
            $condition[] = ['>', 'ct', $st];
            $condition[] = ['<', 'ct', $et];
        }

        $status = Yii::$app->request->get('status',"");

        //如果1,2,3 或者 1
        if ($status!=""){
            if(strpos($status,",")!==false){
                $condition[] = ['in', 'status', explode(",",$status)];
            }else{
                $condition[] = ['=', 'status', $status];
            }
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

        $orderby =["ct"=>SORT_DESC];
        $query->orderby($orderby);

        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Orderinfo::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }

}