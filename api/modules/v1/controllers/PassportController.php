<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 00:02
 */

namespace api\modules\v1\controllers;

use api\models\Passport;
use api\models\Register;
use Yii;
use api\controllers\BaseActiveController;
use api\models\Response;
use yii\helpers\ArrayHelper;

class PassportController extends BaseActiveController {

    /**
     * @return array
     * 设置过滤方法
     */
    public function behaviors() {
         return ArrayHelper::merge(
             parent::behaviors(),
             [
                 'authenticator' => [
                     'optional' => [
                         'check-email',
                         'register',
                         'login',
                     ],
                 ]
             ]
         );
    }


    /**
     * @return Response
     * 检查电子邮件是否有效
     */
    public function actionCheckEmail() {
        $email = trim($this->get['email']);
        $pattern = "/^([a-zA-Z0-9])+([.a-zA-Z0-9_-])*@([.a-zA-Z0-9_-])+([.a-zA-Z0-9_-]+)+([.a-zA-Z0-9_-])$/";
        $status = 0;

        if(preg_match($pattern, $email)) {
            $emailInfo = Passport::getDb()->cache(function ($db) use ($email) {
                return Passport::find(['type' => 1, 'email' => $email])->one();
            }, 24 * 3600);
            if($emailInfo) {
                $status = 10003;
            } else {
                $result = Register::getDb()->cache(function ($db) use ($email) {
                    $recentTime = time() - 2 * 3600;
                    return Register::find(['email' => $email])->where("'update_at' >= $recentTime")->orderBy('update_at DESC')->one();
                }, 2 * 3600);
                if($result && (time() - $result['create_at'] < Yii::$app->params['passportSendMailMinTime']) ) {
                    $status = 10002;
                } else {
                    //再次发送验证码, 并保存到数据库中, 验证码保存不区分大小写
                    $authToken = Yii::$app->security->generateRandomString(6);

                    // 保存到数据库中

                    // 发送邮件
                    $sendStatus = Mailer::registerCheckDigit();
            
                }
            }
        } else {
            $status = 10001;
        }
        return new Response($status, []);
    }

    /**
     * 用户注册方法
     * @return Response
     *
     */
    public function actionRegister() {
        return new Response(0, ['code' => 'dw']);
    }

    /**
     * 用户登录
     * @return Response
     */
    public function actionLogin() {
        return new Response(0, ['code' => 'dddw']);
    }

}