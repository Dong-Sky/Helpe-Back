<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 03/03/2018
 * Time: 19:09
 */

namespace api\modules\v1\controllers;

use api\controllers\ApiException;
use api\controllers\BaseActiveController;
use api\helpers\ResponseStatus;
use Yii;

class SiteController extends BaseActiveController {

    public function actionError() {
        var_dump('xxx'); exit;
        $excpetion = Yii::$app->errorHandler->exception;
        $code = 0;
        if($excpetion instanceof ApiException) {
            $code = $excpetion->getCode();
        } else {
            // unknown error
            $code = 9999;
        }
        return ['code' => $code, 'message' => ResponseStatus::getMessage($code), 'data' => []];
    }

}