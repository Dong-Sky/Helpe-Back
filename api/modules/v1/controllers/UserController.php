<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 00:02
 */

namespace api\modules\v1\controllers;

use Yii;
use api\controllers\BaseActiveController;
use api\models\Response;

class UserController extends BaseActiveController {



    public function actionIndex() {

        return new Response(0, [], "");
    }

    public function actionLogin() {
        return new Response(0, ['code' => 'dw'], "");
    }

    public function actionAct() {
        var_dump(Yii::$app->user);
        var_dump('actionAct');
    }

}