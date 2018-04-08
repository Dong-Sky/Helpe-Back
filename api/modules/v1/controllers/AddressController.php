<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Address;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class AddressController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Address';

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
     * 添加地址
     */
    public function actionAdd() {

        if (Yii::$app->request->isPost) {

            //$phone = \Yii::$app->request->post("phone","");
            $info = \Yii::$app->request->post("info","");
            $aid = \Yii::$app->request->post("province",0);
            $lat = \Yii::$app->request->post("lat",0);
            $lng = \Yii::$app->request->post("lng",0);
            $uid = $this->userId;

            $data = [
                'Address' => [
                    //'phone' => $phone,
                    'info'=> $info,
                    'aid' => $aid,
                    'lat' => $lat,
                    'lng' => $lng,
                    'uid' => $uid,
                ]
            ];
            $saveSuccess = false;
            $insert_id = null;
            try {
                $addr = new Address();
                $addr->load($data);
                if ($data && $addr->validate()) {
                    $saved = $addr->save();
                    $saveSuccess = true;
                    $insert_id = $addr->id;
                } else {
                    //var_dump($item->errors);
                    throw new ApiException(9998,$addr->errors);
                }
            } catch (\Exception $e) {
                $insert_id = null;
                //exit;
                throw new ApiException(20002,$e->getMessage());
            }

            Address::updateCache('ow',$insert_id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }


    /**
    修改地址
     */
    public function actionUpdate() {
        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);
            $uid = $this->userId;

            //$phone = \Yii::$app->request->post("phone","");
            $info = \Yii::$app->request->post("info","");
            $aid = \Yii::$app->request->post("province",0);
            $lat = \Yii::$app->request->post("lat",0);
            $lng = \Yii::$app->request->post("lng",0);

            $saveSuccess = false;
            try{

                $addr = Address::find()->where('id=:id and uid=:uid', [':id' => $id,':uid' => $uid])->one();
                if(empty($addr)){
                    throw new ApiException(70001);
                }

                $addr->info = $info;
                $addr->aid = $aid;
                $addr->lat = $lat;
                $addr->lng = $lng;

                if($addr->save()){

                    $saveSuccess = true;


                }else{
                    //var_dump($item->errors);
                    throw new ApiException(9998,$addr->errors);
                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(20002,$e->getMessage());
            }

            Address::updateCache('ow',$id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }

    /**
     * 删除address
     * @return ApiResponse
     * @throws ApiException
     * @throws \Exception
     */
    public function actionDel(){

        if (Yii::$app->request->isPost) {

            $id = \Yii::$app->request->post("id",0);

            $delSuccess = false;
            try{

                $addr = Address::find()->where('id=:id and uid=:uid ', [':id' => $id,':uid' => $this->userId])->one();
                if($addr && $addr->delete()){

                    $delSuccess = true;


                }else{
                    //var_dump($item->errors);
                    throw new ApiException(9998,$addr->errors);
                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(20002,$e->getMessage());
            }

            Address::updateCache("ow",$id);

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }



    /**
     * 地址列表
     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionIndex() {
        $uid = $this->userId;
        $condition[] = ['=', 'uid', $uid];

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Address::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }
}