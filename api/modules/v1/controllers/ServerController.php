<?php
namespace api\modules\v1\controllers;

use Yii;
use api\models\ApiResponse;
use yii\data\ActiveDataProvider;
use api\rests\HelpeDataProvider;
use yii\caching\TagDependency;
use yii\helpers\ArrayHelper;
use api\controllers\BaseActiveController;
use api\controllers\ApiException;
use yii\log\Logger;

class ServerController extends BaseActiveController
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
                    'info',
                    //'imauth',
                ],
            ]
        ]);
    }



    public $serializer = [
        'class'=>'api\rests\Serializer',
        'collectionEnvelope' => 'data',
    ];


    /**
     * 获得服务器信息
     */
    public function actionInfo(){
        $data = ['f&qUrl'=>Yii::$app->params['f&qUrl'],
            'staticUrl'=>Yii::$app->params['staticUrl'],
            'version'=>Yii::$app->params['version']];
        return new ApiResponse(0, $data);
    }

    public function actionImsign(){
        $client_id = $id = \Yii::$app->request->get('client_id');
        $app_id = Yii::$app->params['leancloudAppID'];
        // $app_key = System::getConfig('leancloud_app_key');
        $timestamp = time();
        $nonce = $this->generateRandomString(5);
        $str = $app_id . ':' . $client_id . '::' . $timestamp . ':' . $nonce;
        $signature = hash_hmac('sha1', Yii::$app->params['leancloudMasterKey'], $str);
        $data =  [
            'str'=>$str,
            //'master'=>System::getConfig('leancloud_master_key'),
            //'result'=>'success',
            'signature'=>$signature,
            'timestamp'=>$timestamp,
            'nonce'=>$nonce
        ];
        return new ApiResponse(0, $data);
    }

    /**
     * PHP生成随机字符串
     * @param	Int	$length	字符串长度
     * @return string
     */
    protected function  generateRandomString($length = 10) {
		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[rand(0, strlen($characters) - 1)];
		}
    return $randomString;
}


}