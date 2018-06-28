<?php
namespace api\modules\v1\controllers;

use api\modules\v1\models\Orderinfo;
use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Feedback;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class FeedbackController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Feedback';

    /**
     * @return array
     * 设置过滤方法
     */
    public function behaviors() {
        return ArrayHelper::merge(parent::behaviors(), [
            'authenticator' => [
                'optional' => [
                    'index'
                ],
            ]
        ]);
    }



    public $serializer = [
        'class'=>'api\rests\Serializer',
        'collectionEnvelope' => 'data',
    ];


    /**

     */
    public function actionSave() {
        if (Yii::$app->request->isPost) {
            //todo 文件处理

            $orderid = \Yii::$app->request->post("orderid",0);
            $content = \Yii::$app->request->post("content","");
            $score = \Yii::$app->request->post("score",0);


            $order = Orderinfo::find()->where("id=:id",[':id' => $orderid])->one();

            if (empty($order)){
                throw new ApiException(40002);
            }


            if ($order['fd']!=0){
                throw new ApiException(60001);
            }


            if ($order['type']==0){
                //服务 下订单的用户必须是当前用户
                if ($order['uid']!=$this->userId){
                    throw new ApiException(60002);
                }

                $owner = $order['owner'];
            }else{
                //求助 发布者必须是当前用户
                if ($order['owner']!=$this->userId){
                    throw new ApiException(60002);
                }

                $owner = $order['uid'];
            }

            $data = [
                'Feedback' => [
                        'content'=>$content,
                        'score'=>$score,
                        'uid'=>$this->userId,
                        'owner'=>$owner,
                        'itemid'=>$order['itemid'],
                        'orderid'=>$orderid,
                ]
            ];

            $transaction = Yii::$app->db->beginTransaction();
            $saveSuccess = false;
            $insert_id = null;
            try {

                $order->fd = 1;

                $saved = $order->save();

                if($saved){
                    $fd = new Feedback();

                    $fd->load($data);
                    //var_dump($data);exit;
                    if ($fd->validate()) {
                        $fd->save();
                    } else {
                        //var_dump($itmedetail->errors);exit;
                        throw new ApiException(9998,$fd->errors);
                    }
                }
                $transaction->commit();
                $saveSuccess = true;
                $insert_id = $fd->id;

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

            $this->addMlog($order["uid"],10,array("username"=>$this->user["username"],"itemname"=>$order['iteminfo']["name"],"score"=>$data['score']));

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        Orderinfo::updateCache(false,$orderid);

        return new ApiResponse(0, []);
    }


    /**

     */
    public function actionUpdate() {
        if (Yii::$app->request->isPost) {

            $id = \Yii::$app->request->post("id",0);
            $content = \Yii::$app->request->post("content","");
            $score = \Yii::$app->request->post("score",0);


            $feedback = Feedback::find()->where("id=:id",[':id' => $id])->one();

            if (empty($feedback)){
                throw new ApiException(60003);
            }

            if ($feedback->uid!=$this->userId){
                throw new ApiException(60002);
            }

            $saveSuccess = false;
            try {
                $feedback->content=$content;
                $feedback->score=$score;
                if($feedback->save()){
                    $saveSuccess = true;
                } else {
                    //var_dump($itmedetail->errors);exit;
                    throw new ApiException(9998,$feedback->errors);
                }

            }catch (ApiException $e) {
                //var_dump($e->getMessage());exit;
                $insert_id = null;
                //exit;
                throw $e;
            } catch (\Exception $e) {
                //var_dump($e->getMessage());exit;
                $insert_id = null;
                //exit;
                throw new ApiException(20002,$e->getMessage());
            }

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        //Orderinfo::updateCache(false,$orderid);

        return new ApiResponse(0, []);
    }


    /**
    我发布的商品评论

     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionMy() {

        $condition = [];

        $uid = $this->userId;
        if($uid){
            $condition[] = ['=', 'uid', $uid];
        }


        $orderby = ['ct' => SORT_DESC];

        $modelClass = $this->modelClass;

        $query = $modelClass::find()->with('orderinfo');
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $query->orderby($orderby);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
        ]);

        return $ActiveDataProvider;
    }


    /**
    关于我商品的评论

     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionAboutme() {

        $condition = [];

        $uid = $this->userId;
        if($uid){
            $condition[] = ['=', 'owner', $uid];
        }


        $orderby = ['ct' => SORT_DESC];

        $modelClass = $this->modelClass;

        $query = $modelClass::find()->with('orderinfo');
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $query->orderby($orderby);

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
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

        $orderid = \Yii::$app->request->get("orderid",0);
        if($orderid>0){
            $condition[] = ['=', 'orderid', $orderid];
        }else{
            $itemid = \Yii::$app->request->get("itemid",0);
            if($itemid>0){
                $condition[] = ['=', 'itemid', $itemid];
            }

        }

        $minscore = \Yii::$app->request->get('minscore',0);
        $maxscore = \Yii::$app->request->get('maxscore',0);

        if ($minscore!=0 && $maxscore!=0){
            $condition[] = ['>=', 'score', $minscore];
            $condition[] = ['<=', 'score', $maxscore];
        }


        $orderby = ['ct' => SORT_DESC];


        $modelClass = $this->modelClass;

        $query = $modelClass::find()->with('orderinfo');
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $query->orderby($orderby);


        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
        ]);

        return $ActiveDataProvider;
    }
}