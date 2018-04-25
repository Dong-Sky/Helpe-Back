<?php
namespace api\modules\v1\controllers;

use Yii;
use yii\rest\ActiveController;
use api\models\Passport;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use api\modules\v1\models\Fav;
use api\modules\v1\models\Item;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class FavController extends BaseActiveController
{
    public $modelClass = 'api\modules\v1\models\Fav';

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
     * 添加收藏
     */
    public function actionSave() {

        if (Yii::$app->request->isPost) {

            $id = \Yii::$app->request->post("id",0);

            $item = Item::find()->where("id=:id",[':id' => $id])->one();

            if (empty($item) || $item['uid'] == $this->userId){
                throw new ApiException(20001);
            }

            $fav = Fav::find()->where("id=:id and uid=:uid",[':id' => $id,':uid' => $this->userId])->one();

            if (empty($item) || $item['uid'] == $this->userId){
                throw new ApiException(50001);
            }

            $data = [
                'Fav' => [
                    'uid'=>$this->userId,
                    'itemid'=>$id,
                ]
            ];
            $saveSuccess = false;
            $insert_id = null;
            try {
                $fav = new Fav();
                $fav->load($data);
                if ($data && $fav->validate()) {
                    $saved = $fav->save();
                    $saveSuccess = true;
                    $insert_id = $fav->id;
                } else {
                    //var_dump($item->errors);
                    throw new ApiException(9998,$fav->errors);
                }



            }catch (ApiException $e) {
                //var_dump($e->getMessage());exit;
                //exit;
                throw $e;
            } catch (\Exception $e) {
                $insert_id = null;
                //exit;
                throw new ApiException(9996,$e->getMessage());
            }

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
            //todo 文件处理

            $uid = $this->userId;
            $id = \Yii::$app->request->post("id",0);


            $delSuccess = false;
            try{

                $fav = Fav::find()->where('id=:id and uid=:uid ', [':id' => $id,':uid' => $uid])->one();
                $itemid = $fav->itemid;
                if($fav && $fav->delete()){

                    $delSuccess = true;


                }else{
                    //var_dump($item->errors);
                    throw new ApiException(9998,$fav->errors);
                }
            } catch (\Exception $e) {
                //var_dump($e->getMessage());
                throw new ApiException(9996,$e->getMessage());
            }

        }else{
            //echo 2222;
            throw new ApiException(9997);
        }

        return new ApiResponse(0, []);
    }



    /**
     * 收藏列表
     * @return HelpeDataProvider|ActiveDataProvider
     */
    public function actionIndex() {

        $uid = $this->userId;
        $condition[] = ['=', 'uid', $uid];

        $modelClass = $this->modelClass;

        $query = $modelClass::find()->with('iteminfo');
        if($condition){
            foreach ($condition as $cond){
                $query->andWhere($cond);

            }
        }

        $ActiveDataProvider =  new HelpeDataProvider([
            'query' => $query,
        ]);

        return $ActiveDataProvider;
    }
}