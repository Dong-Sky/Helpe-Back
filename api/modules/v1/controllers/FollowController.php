<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Follow;
use api\modules\v1\models\UserInfo;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class FollowController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Follow';

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
     * 添加关注
     */
    public function actionSave() {

        if (Yii::$app->request->isPost) {
            $userid = \Yii::$app->request->post("uid");
            $userinfo = UserInfo::find()->where("id=:id",[':id' => $userid])->one();
            if(empty($userinfo) || $userinfo['id']==$this->userId){
                throw new ApiException(10009);
            }

            $follow = Follow::find()->where("uuid=:uuid",[':uuid' => $userid])->one();
            if (!empty($follow)){
                throw new ApiException(80001);
            }


            $data = [
                'Follow' => [
                    'uid'=> $this->userId,
                    'uuid' => $userid, //关注用户
                ]
            ];

            $saveSuccess = false;
            $insert_id = null;
            try {
                $model = new Follow();
                $model->load($data);
                if ($data && $model->validate()) {
                    $saved = $model->save();
                    $saveSuccess = true;
                    $insert_id = $model->id;
                } else {
                    //var_dump($item->errors);
                    throw new ApiException(9998,$model->errors);
                }
            } catch (\Exception $e) {
                $insert_id = null;
                //exit;
                throw new ApiException(20002,$e->getMessage());
            }

            Follow::updateCache('ow',$insert_id);

            $this->addMlog($userid,9,array("username"=>$userinfo['username']));

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }

    /**
     * 删除follow
     * @return ApiResponse
     * @throws ApiException
     * @throws \Exception
     */
    public function actionDel(){

        if (Yii::$app->request->isPost) {
            $id = \Yii::$app->request->post("id",0);

            $delSuccess = false;
            try{

                $follow = Follow::find()->where('id=:id and uid=:uid ', [':id' => $id,':uid' => $this->userId])->one();
                if($follow && $follow->delete()){

                    $delSuccess = true;


                }else{
                    //var_dump($item->errors);
                    if(empty($follow->errors)){
                        throw new ApiException(9998);
                    }else{
                        throw new ApiException(9998,$follow->errors);
                    }

                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(20002,$e->getMessage());
            }

            Follow::updateCache("ow",$id);

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
            'cache_rule'=>Follow::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }


    /**
     * 关于我的关注
     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionMy() {
        $uid = $this->userId;
        $condition[] = ['=', 'uuid', $uid];

        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
            'cache_rule'=>Follow::getCacheRule("list")
        ]);

        return $ActiveDataProvider;
    }
}