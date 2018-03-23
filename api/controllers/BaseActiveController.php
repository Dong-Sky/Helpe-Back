<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 10/03/2018
 * Time: 23:24
 */

namespace api\controllers;

use Yii;
use yii\helpers\ArrayHelper;
use yii\web\Response;
use yii\rest\Controller;

class BaseActiveController extends Controller {

    public $modelClass = 'common\models\user';

    public $post = null;
    public $get = null;
    public $user = null;
    public $userId = null;

    public function init() {
        parent::init(); // TODO: Change the autogenerated stub
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
}