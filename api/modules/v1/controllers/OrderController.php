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
use api\modules\v1\models\Item;
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

            $uid = $this->userId;
            $aid = \Yii::$app->request->post("aid",0);
            $num = \Yii::$app->request->post("num",1);
            $id = \Yii::$app->request->post("id",0);
            $cprice = \Yii::$app->request->post("changeprice",0);

            $remark = \Yii::$app->request->post("remark","");
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

            $data = ['Orderinfo' => array(
                'uid'=>$uid,
                'owner'=>$item['uid'],//
                'num'=>$num,
                'cash'=>$item['price']*$num,
                'type'=>$item['type'],
                'itemid'=>$item['id'],
                'changeprice'=>$cprice,
                'remark'=>$remark,
                "paytp"=>$paytp,
                'status'=>0,
                'pt'=>$item['pt'],
            )];


            $addr = null;
            if($aid>0){
                $addr = Address::findOne($aid);
                if (empty($addr)){
                    throw new ApiException(40001);
                }
            }else{
                throw new ApiException(40001);
            }

            //item类型 0 服务 1 求助
            if ($data['Orderinfo']['type']==0){
                $data['Orderinfo']['aid'] = $aid;

            }else{
                $data['Orderinfo']['aid'] = $item['aid'];
            }

            // 开始事务查询
            $transaction = Yii::$app->db->beginTransaction();
            $saveSuccess = false;
            $insert_id = null;
            try {
                $orderinfo = new Orderinfo();
                $orderinfo->load($data);

                if ($orderinfo->validate()) {
                    $saved = $orderinfo->save();

                    if($saved){
                        $orderaddr = new Orderaddr();
                        $adr_data = ['Orderaddr'=>$addr->toArray()];
                        unset($adr_data['Orderaddr']['id']);

                        $adr_data['Orderaddr']['orderid'] = $orderinfo->id;

                        $orderaddr->load($adr_data);
                        if ($orderaddr->validate()) {
                            $orderaddr->save();
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

            Orderinfo::updateCache('ow',$orderinfo->id);
            Orderaddr::updateCache('ow',$orderaddr->id);

            //如果下单成功就不管消息是否发送成功
            //item类型 0 服务 1 求助
            if ($data['Orderinfo']['type']==0){
                $this->addMlog($item['uid'],1,array("username"=>$this->user["username"],"itemname"=>$item["name"]));

            }else{
                $this->addMlog($item['uid'],1,array("username"=>$this->user["username"],"itemname"=>$item["name"]));
            }

            return new ApiResponse(0, []);
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

        $uid = $this->userId;
        $condition[] = ['=', 'uid', $uid];

        //订单的商品类型 服务还是求助
        $type = Yii::$app->request->get('type');

        if ($type>-1){
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

        $query = $modelClass::find()->with('iteminfo')->with('userinfo');
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

        $condition = [];

        $uid = $this->userId;

        $condition[] = ['=', 'owner', $uid];

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

        $modelClass = $this->modelClass;

        $query = $modelClass::find()->with('iteminfo')->with('userinfo');
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


    /**
    接受订单
     */
    public function actionAccept() {
        $change_status = 10;
        $prev_status = 0;
        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            $order = Orderinfo::find()->where('id=:id', [':id' => $id])->one();

            if (empty($order)) {
                throw new ApiException(40002);
            }

            if ($order['owner'] != $this->userId) {
                throw new ApiException(40003);
            }

            if ($order['status'] != $prev_status ) {
                throw new ApiException(40004);
            }

            $this->updateOrderStatus($id,$change_status,$prev_status);

            //如果下单成功就不管消息是否发送成功
            //item类型 0 服务 1 求助
            if ($order['type']==0){
                $this->addMlog($order['uid'],3,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));

            }else{
                $this->addMlog($order['uid'],4,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));
            }


        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    /**
    拒绝订单
     */
    public function actionRefuse() {
        $change_status = 50;
        $prev_status = 0;
        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            $order = Orderinfo::find()->where('id=:id', [':id' => $id])->one();

            if (empty($order)) {
                throw new ApiException(40002);
            }

            if ($order['owner'] != $this->userId) {
                throw new ApiException(40003);
            }

            if ($order['status'] != $prev_status ) {
                throw new ApiException(40004);
            }

            $this->updateOrderStatus($id,$change_status,$prev_status);


            //如果下单成功就不管消息是否发送成功
            //item类型 0 服务 1 求助
            if ($order['type']==0){
                $this->addMlog($order['owner'],11,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],12,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));


            }else{
                $this->addMlog($order['owner'],13,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],14,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));

            }


        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    /**
    到达订单
     */
    public function actionArrival() {
        $change_status = 20;
        $prev_status = 10;

        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            $order = Orderinfo::find()->where('id=:id', [':id' => $id])->one();

            if (empty($order)||$order['paytp']!=0) {
                throw new ApiException(40002);
            }

            if ($order['type']==1){ //求助  要求是求助者本人
                if ($order['owner']!=$this->userId){
                    throw new ApiException(40005);
                }
            }else{//服务 要求就是下单用户
                if ($order['uid']!=$this->userId){
                    throw new ApiException(40006);
                }
            }

            if ($order['status'] != $prev_status ) {
                throw new ApiException(40004);
            }

            $this->updateOrderStatus($id,$change_status,$prev_status);


            //如果下单成功就不管消息是否发送成功
            //item类型 0 服务 1 求助
            if ($order['type']==0){
                $this->addMlog($order['owner'],5,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],7,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));


            }else{
                $this->addMlog($order['owner'],6,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],8,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));

            }

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    /**
    付钱订单
     */
    public function actionMoney() {
        $change_status = 30;
        $prev_status = 20;

        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            $order = Orderinfo::find()->where('id=:id', [':id' => $id])->one();

            if (empty($order)||$order['paytp']!=0) {
                throw new ApiException(40002);
            }

            if ($order['type']==1){ //求助  要求是求助者本人
                if ($order['owner']!=$this->userId){
                    throw new ApiException(40005);
                }
            }else{//服务 要求就是下单用户
                if ($order['uid']!=$this->userId){
                    throw new ApiException(40006);
                }
            }

            if ($order['status'] != $prev_status ) {
                throw new ApiException(40004);
            }

            $this->updateOrderStatus($id,$change_status,$prev_status);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }

    /**
    拿钱订单
     */
    public function actionGetmoney() {
        $change_status = 40;
        $prev_status = 30;

        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            $order = Orderinfo::find()->where('id=:id', [':id' => $id])->one();

            if (empty($order)||$order['paytp']!=0) {
                throw new ApiException(40002);
            }

            if ($order['type']==1){//求助  要求提供服务的人确认
                if ($order['uid']!=$this->userId){
                    throw new ApiException(40006);
                }
            }else{//服务 服务所有者确认
                if ($order['owner']!=$this->userId){
                    throw new ApiException(40005);
                }
            }


            if ($order['status'] != $prev_status ) {
                throw new ApiException(40004);
            }

            $this->updateOrderStatus($id,$change_status,$prev_status);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    public function  actionCancel()
    {

        $change_status = 60;
        $prev_status = array(0,10,20,30);

        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            $order = Orderinfo::find()->where('id=:id', [':id' => $id])->one();

            if (empty($order)) {
                throw new ApiException(40002);
            }

            //判断是否是2种身份中的一个
            if ($order['owner']!=$this->userId && $order['uid']!=$this->userId){
                throw new ApiException(40005);
            }


            if (!in_array($order['status'],array(0,10,20,30))) {
                throw new ApiException(40004);
            }

            $this->updateOrderStatus($id,$change_status,$prev_status);



            //如果下单成功就不管消息是否发送成功
            //item类型 0 服务 1 求助
            if ($order['type']==0){
                $this->addMlog($order['owner'],15,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],16,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));


            }else{
                $this->addMlog($order['owner'],17,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],18,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));

            }

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    public function actionFinish()
    {
        $change_status = 40;
        $prev_status = array(10);

        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            $order = Orderinfo::find()->where('id=:id', [':id' => $id])->one();

            if (empty($order) || $order['paytp']!=1) {
                throw new ApiException(40002);
            }

            if ($order['type']==1){ //求助  要求是求助者本人
                if ($order['owner']!=$this->userId){
                    throw new ApiException(40005);
                }
            }else{//服务 要求就是下单用户
                if ($order['uid']!=$this->userId){
                    throw new ApiException(40006);
                }
            }


            if (!in_array($order['status'],array(10))) {
                throw new ApiException(40004);
            }

            $this->updateOrderStatus($id,$change_status,$prev_status);


            //如果下单成功就不管消息是否发送成功
            //item类型 0 服务 1 求助
            if ($order['type']==0){
                $this->addMlog($order['owner'],5,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],7,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));


            }else{
                $this->addMlog($order['owner'],7,array("username"=>$order['ownerinfo']['username'],"itemname"=>$order['iteminfo']["name"]));
                $this->addMlog($order['uid'],8,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"]));

            }

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }

    protected function updateOrderStatus($id, $status, $p_status)
    {
        $saveSuccess = false;
        try {

            if(!is_array($p_status)){
                $result = \Yii::$app->db->createCommand()
                    ->update('{{%orderinfo}}', ['status' => $status], "status=$p_status and id=$id")
                    ->execute();
            }else{
                $result = \Yii::$app->db->createCommand()
                    ->update('{{%orderinfo}}', ['status' => $status], "status in (".implode(",",$p_status).") and id=$id")
                    ->execute();
            }


            if ($result) {
                $saveSuccess = true;
            } else {
                //var_dump($item->errors);
                throw new ApiException(9998);
            }
        }catch (ApiException $e) {
                throw $e;
        } catch (\Exception $e) {
            //var_dump($e->getMessage());
            throw new ApiException(9996, $e->getMessage());
        }


        //更新item表订单计数
        Orderinfo::updateCache("ow", $id);

        return $saveSuccess;
    }

}