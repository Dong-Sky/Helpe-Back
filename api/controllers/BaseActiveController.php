<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 10/03/2018
 * Time: 23:24
 */

namespace api\controllers;

use api\modules\v1\models\Mlog;
use Yii;
use yii\helpers\ArrayHelper;
use yii\web\Response;
use yii\rest\Controller;
use api\helpers\UmengNotification;
use yii\log\Logger;

class BaseActiveController extends Controller {

    public $modelClass = 'common\models\user';

    public $post = null;
    public $get = null;
    public $user = null;
    public $userId = null;

    public function init() {
        parent::init(); // TODO: Change the autogenerated stub
        Yii::$app->language = 'ja-JP';
    }


//    public $serializer = [
//        'class' => 'yii\rest\Serializer',
//        'collectionEnvelope' => 'items',
//    ];

    public function behaviors() {
        return ArrayHelper::merge(
            parent::behaviors(),
            ['contentNegotiator' => [
                'formats' => [
                    'text/html' => Response::FORMAT_JSON,
                ]
            ], 'authenticator' => [
                'class' => ApiAuth::className(),
                'tokenParam' => 't',
            ]]
        );
    }

    public function beforeAction($action)
    {
        parent::beforeAction($action); // TODO: Change the autogenerated stub
        $this->post = yii::$app->request->post();
        $this->get = yii::$app->request->get();
        $this->user = yii::$app->user->identity;
        $this->userId = yii::$app->user->id;
        return $action;
    }

    public function getData($key, $default = null) {
        return $this->getItemData($this->get, $key, $default);
    }

    public function postData($key, $default = null) {
        return $this->getItemData($this->post, $key, $default);
    }

    public function getItemData($data, $key, $default) {
        if(isset($data[$key]) && strlen(trim($data[$key])) > 0 ) {
            return trim($data[$key]);
        } else {
            if($default) {
                return $default;
            } else {
                throw new ApiException(9998);
            }
        }
    }

    /**
     * @param $uid
     * @param int $tp //类型id
     * @param array $data ['username'=>"",'itemname'=>""]
     * @return mixed
     */
    public function addMlog($uid,$tp=1,$data=array()){
        $db_data = [ 'Mlog'=>[
            'uid'=>$uid,
            'tpid'=>$tp,
            'data'=>json_encode($data),
                ],
        ];

        try {
            $log = new Mlog();
            $log->load($db_data);
            if ($db_data && $log->validate()) {
                $saved = $log->save();
                $saveSuccess = true;
                $insert_id = $log->id;
            } else {
                //var_dump($item->errors);
                throw new ApiException(9998,$log->errors);
            }
        } catch (\Exception $e) {
            $insert_id = null;
            //exit;
            throw new ApiException(20002,$e->getMessage());
        }

        //Mlog::updateCache('ow',$insert_id);

        $userinfo = $this->user;

        try{
            $umeng = new UmengNotification(Yii::$app->params['umengAppKey'], Yii::$app->params['umengAppMasterSecret']);
            $umeng->sendIosNotification($uid,$tp,$data);
        }catch (\Exception $e) {
            $insert_id = null;
            //exit;
            //throw new ApiException(20002,$e->getMessage());
            Yii::getLogger()->log("sendIOSCustomizedcast Sent fail ".$e->getMessage(), Logger::LEVEL_INFO);
//            print("Sent SUCCESS\r\n");
        }


        return $saved;

    }
}