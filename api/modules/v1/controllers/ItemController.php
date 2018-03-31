<?php
namespace api\modules\v1\controllers;

use api\modules\v1\models\Itemimg;
use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Item;
use api\modules\v1\models\Itemdetail;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\web\UploadedFile;
use yii\log\Logger;
use common\helpers\AliyunOss;

class ItemController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Item';

    /**
     * @return array
     * 设置过滤方法
     */
    public function behaviors() {
        return ArrayHelper::merge(parent::behaviors(), [
            'authenticator' => [
                'optional' => [
                    'index',
                    'info',
                ],
            ]
        ]);
    }



    public $serializer = [
        'class'=>'api\rests\Serializer',
        'collectionEnvelope' => 'data',
    ];


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

            $uid = $this->userId;
            $aid = \Yii::$app->request->post("aid",0);
            $name = \Yii::$app->request->post("name");
            $type = \Yii::$app->request->post("type",0);
            $cid = \Yii::$app->request->post("cid",0);
            $price = \Yii::$app->request->post("price",0);
            $mark= \Yii::$app->request->post("mark",0);
            $paytp = \Yii::$app->request->post("paytp",0);
            $conact =  \Yii::$app->request->post("contact");
            $unit =  \Yii::$app->request->post("unit","");
            $deadline =  \Yii::$app->request->post("deadline","");
            $pet =  \Yii::$app->request->post("pet",0);

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
                    //'img' =>"/sstetttt.jpg",
                    'flag' =>1,
                    'tag'=>"133333",
                    'aaid'=>1,
                    //todo 获取地理位置
                    'lat'=>1,
                    'lng'=>1,
                    'aaid'=>0,
                    'paytp'=>0,
                    'salenum'=>0,
                    'unit'=>$unit,
                    'deadline'=>$deadline,
                    'pt'=>time(),
                    'pet'=>$pet,
                ]
            ];
            //$data_detail = ['itemdetail' => ["mark"=>$mark]];
            // 开始事务查询
            $transaction = Yii::$app->db->beginTransaction();
            $saveSuccess = false;
            $insert_id = null;
            try {
                $item = new Item();
                $item->load($data);
                if ($data && $item->validate()) {
                    $saved = $item->save();


                    if($saved){
                        //更新商品详情
                        $itmedetail = new Itemdetail();
                        $itmedetail->mark = $mark;
                        $itmedetail->itemid = $item->id;

                        if ($itmedetail->validate()) {
                            $itmedetail->save();
                            //$item->link('itemdetail', $itmedetail);
                        } else {
                            //var_dump($itmedetail->errors);exit;
                            throw new ApiException(9998,$itmedetail->errors);
                        }

                        $imgModel = new Itemimg();
                        $aliyunOss = new AliyunOss();

                        $imgFiles = UploadedFile::getInstancesByName( 'itemfile');
                        foreach ($imgFiles as $file){
                            $_imgModel = clone $imgModel;
                            if($imgModel->upload($file)){
                                $_imgModel->url = $imgModel->imageUrl;
                                $_imgModel->itemid = $item->id;
                                $_imgModel->uid = $uid;
                                $imagePath = $imgModel->imagePath;
                                $imageUrl = $imgModel->imageUrl;
                                if($_imgModel->save()){
                                    $ossFile = trim($imageUrl, '/');
                                    $aliyunOss->uploadFile("helpe-avatar", $ossFile, $imagePath);
                                }else{
                                    //var_dump($itmedetail->errors);exit;
                                    throw new ApiException(9998,$imgModel->errors);
                                }
                            }

                        }
                    }
                    $transaction->commit();
                    $saveSuccess = true;
                    $insert_id = $item->id;
                } else {
                    //var_dump($item->errors);
                    throw new ApiException(9998,$item->errors);
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
                throw new ApiException(20002,$e->getMessage());
            }

            Item::updateCache('ow',$insert_id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, $item);
    }


    /**
     * 上架

    -m online
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    -id  商品ID
     */
    public function actionOnline() {
        if (Yii::$app->request->isPost) {
            //todo 文件处理

            $uid = \Yii::$app->request->post("uid",0);
            $id = \Yii::$app->request->post("id",0);


            $saveSuccess = false;
            try{

                $item = Item::find()->where('id=:id and uid=:uid ', [':id' => $id,':uid' => $uid])->one();

                $item->flag = 1;
                if ($item['type']==0){
                    $item['pet'] = time()+3*30*86400;
                }else{
                    $item['pet'] = time()+30*86400;
                }

                if($item->save()){

                    $saveSuccess = true;


                }else{
                    //var_dump($item->errors);
                    throw new ApiException(9998,$item->errors);
                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(20002,$e->getMessage());
            }

            Item::updateCache('ow',$id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, $item);
    }


    /**
     * 设置封面
    - token  登陆后服务器给的token
    -id  商品ID
    - pid  图片id
     */
    public function actionDimg() {
        if (Yii::$app->request->isPost) {
            $pid = \Yii::$app->request->post("pid",0);
            $id = \Yii::$app->request->post("id",0);


            $item = Item::find()->where('id=:id', [':id' => $id])->one();

            if (empty($item) || $item['uid'] !=$this->userId){
                throw new ApiException(20001);
            }
            $img = ItemImg::find()->where('id=:id', [':id' => $pid])->one();
            if (empty($img) || $img['uid'] !=$this->userId){
                throw new \Exception(20003);
            }

            $item->img = $img['url'];
            $saveSuccess = false;
            try{

                if($item->save()){
                    $saveSuccess = true;
                }else{
                    //var_dump($item->errors);
                    throw new ApiException(9998,$item->errors);
                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(20002,$e->getMessage());
            }

            Item::updateCache('ow',$id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    /**
     * 设置封面

    -m online
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    -id  商品ID
     */
    public function actionUpdate() {
        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);

            $item = Item::find()->where('id=:id', [':id' => $id])->one();

            if (empty($item)){
                throw new ApiException(20001);
            }

            if ($item['flag']){
                throw new ApiException(20005);
            }

            if ($item['uid'] !=$this->userId){
                throw new ApiException(20004);
            }


            $aid = \Yii::$app->request->post("aid",0);
            if ($aid>0){
                $item['aid'] = $aid;
            }

            $paytp = \Yii::$app->request->post("paytp",0);
            if ($paytp<2){
                $item['paytp'] = $paytp;
            }

            $name = \Yii::$app->request->post("name","");
            if ($name!=""){
                $item['name'] = $name;
            }

            $cid = \Yii::$app->request->post("cid",0);
            if ($cid>0){
                $item['cid'] = $cid;
            }

            $type = \Yii::$app->request->post("type",0);
            if ($type<2){
                $item['type'] = $type;
            }

            $price = \Yii::$app->request->post("price",0);
            if ($price>0){
                $item['price'] = $price;
            }

            $contact = \Yii::$app->request->post("contact","");
            if ($contact!=""){
                $item['contact'] = $contact;
            }

            $unit = \Yii::$app->request->post("unit","");
            if ($unit!=""){
                $item['unit'] = $unit;
            }

            $deadline = \Yii::$app->request->post("deadline","");
            if ($deadline!=""){
                $item['deadline'] = $deadline;
            }


            $saveSuccess = false;
            try{

                if($item->save()){

                    $saveSuccess = true;


                }else{
                    //var_dump($item->errors);
                    throw new ApiException(9998,$item->errors);
                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(20002,$e->getMessage());
            }

            Item::updateCache('ow',$id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    /**
    - a 	值为itempub
    -m unline
    - token  登陆后服务器给的token
    - uid  登陆后服务器给的uid
    -id  商品ID
     */
    public function actionUnline() {
        if (Yii::$app->request->isPost) {
            //todo 文件处理

            $uid = \Yii::$app->request->post("uid",0);
            $id = \Yii::$app->request->post("id",0);


            $saveSuccess = false;
            try{

                $item = Item::find()->where('id=:id and uid=:uid ', [':id' => $id,':uid' => $uid])->one();

                $item->flag = 0;
                if($item->save()){

                    $saveSuccess = true;


                }else{
                    //var_dump($item->errors);
                    throw new ApiException(9998,$item->errors);
                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(20002,$e->getMessage());
            }

            Item::updateCache("ow",$id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, $item);
    }


    /**
     * 获取订单详情
     - token  登陆后服务器给的token
     - uid  登陆后服务器给的uid
     - id  商品id
     */
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

        //var_dump($modelClass::getCacheRule("or",$id));exit;
        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Item::getCacheRule("or",$id)
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
            $condition[] = ['>', 'ct', $st];
            $condition[] = ['<', 'ct', $et];
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

        $query = $modelClass::find()->with('itemdetail')->with('itemimg');;
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Item::getCacheRule("list")
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

        $condition = [];

        //起始时间
        $et = \Yii::$app->request->get("et");
        $st = \Yii::$app->request->get("st");

        if($et && $st){
            $condition[] = ['>', 'ct', $st];
            $condition[] = ['<', 'ct', $et];
        }

        //经纬度范围判断
        $minlat = \Yii::$app->request->get('minlat',0);
        $maxlat = \Yii::$app->request->get('maxlat',0);
        $minlng = \Yii::$app->request->get('minlng',0);
        $maxlng = \Yii::$app->request->get('maxlng',0);
        $fileds = "*,0 as juli";

        if ($minlat!=0 && $maxlat!=0){
            $condition[] = ['>=', 'lat', $minlat];
            $condition[] = ['<=', 'lat', $maxlat];
        }

        if ($minlng!=0 && $maxlng!=0){
            $condition[] = ['>=', 'lng', $minlng];
            $condition[] = ['<=', 'lng', $maxlng];
        }


        //类型判断
        $cid = \Yii::$app->request->get("cid",0);
        if($cid>0){
            $condition[] = ['=', 'cid', $cid];
        }

        //商品所属用户
        $owner = Yii::$app->request->get("owner",0);
        if ($owner>0){
            $condition[] = ['=', 'uid', $owner];
        }

        //服务或者求助
        $type = Yii::$app->request->get("type",-1);
        if ($type!=-1){
            $condition[] = ['=', 'type', $type];
        }

        //标题模糊查询
        $name = Yii::$app->request->get("name","");
        if ($name!=""){
            $condition[] = ['like', 'name', $name];
        }

        //只显示发布
        $condition[] = ['=', 'flag', 1];

        //处理排序
        //0 距离  1时间 2销量 默认为0
        $searchtp = \Yii::$app->request->get("searchtp",0);
        switch($searchtp){
            case 0:
                $orderby =['ct' => SORT_DESC];
                break;
            case 1:
                $orderby =['ct' => SORT_DESC];
                break;
            default:
                $orderby =['salenum' => SORT_DESC];

        }

        if ($owner > 0){
            $orderby = ['ct' => SORT_DESC,'salenum' => SORT_DESC];
        }

        //Yii::$app->request->setQueryParams(array_merge(Yii::$app->request->getQueryParams(),
        //    ['expand' => 'itemdetail,itemimg']));

        $modelClass = $this->modelClass;

        $query = $modelClass::find()->with('itemdetail')->with('itemimg');
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $query->orderby($orderby);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Item::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }
}