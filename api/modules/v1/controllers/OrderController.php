<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 00:02
 */

namespace api\modules\v1\controllers;

use api\modules\v1\models\Orderinfo;
use Yii;
use api\models\ApiResponse;
use yii\rest\ActiveController;
use api\models\Passport;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Item;
use api\modules\v1\models\Itemdetail;
use api\modules\v1\models\Address;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class OrderController extends BaseActiveController {

    public $modelClass = 'api\modules\v1\models\Item';

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

}