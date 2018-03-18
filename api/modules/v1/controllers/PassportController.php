<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 00:02
 */

namespace api\modules\v1\controllers;

use api\controllers\ApiException;
use api\helpers\GlobalPre;
use api\models\Passport;
use api\models\Register;
use api\modules\v1\models\CommonLogin;
use common\models\User;
use Yii;
use api\controllers\BaseActiveController;
use api\models\ApiResponse;
use yii\db\Exception;
use yii\helpers\ArrayHelper;
use common\helpers\Mailer;
use common\helpers\Cache;

class PassportController extends BaseActiveController {

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


    /**
     * @return ApiResponse
     * @throws ApiException
     * 检查电子邮件是否有效
     */
    public function actionCheckEmail() {

        $email = trim($this->get['email']);
        $pattern = "/^([a-zA-Z0-9])+([.a-zA-Z0-9_-])*@([.a-zA-Z0-9_-])+([.a-zA-Z0-9_-]+)+([.a-zA-Z0-9_-])$/";
        $status = 0;
        if(preg_match($pattern, $email)) {

            $passportInfo = Cache::getOrSet("dd", function () use ($email) {
                return Passport::find()->where(['type' => 1, 'email' => $email])->one();
            }, 24 * 3600);
            if($passportInfo) {
                throw new ApiException(10003);
            } else {
                $recentTime = time() - 2 * 3600;
                $registerInfo = Register::find()
                    ->andWhere(['and', ['=', 'email', $email], ['>', 'updated_at', $recentTime]])
                    ->orderBy('updated_at DESC')->one();

                if($registerInfo && (time() - $registerInfo['created_at'] < Yii::$app->params['passportSendMailMinTime']) ) {
                    throw new ApiException(10002);
                } else {
                    //再次发送验证码, 并保存到数据库中, 验证码保存不区分大小写
                    $authToken = substr(str_replace(['-', '_', '0', 'o', 'O', 'l', 'L', '1'], '', Yii::$app->security->generateRandomString(50)),0, 6);
                    // 保存到数据库中
                    $register = new Register();
                    $register->email = $email;
                    $register->auth_token = $authToken;
                    $register->save();
                    // 发送邮件, 重试3次
                    $sendStatus = false;
                    for($i = 0; $i <= 3; $i ++) {
                        $ret = Mailer::registerCheckDigit($email, $authToken);
                        if($ret) {
                            $sendStatus = true;
                            break;
                        }
                    }
                    if(!$sendStatus) {
                        throw new ApiException(10004);
                    }
                }
            }
        } else {
            throw new ApiException(10001);
        }
        return new ApiResponse(0, []);

    }

    /**
     * 用户注册方法, 注册邮件根据客户端上报的key
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionRegister() {

        $email = trim($this->get['email']);
        $username = trim($this->get['username']);
        $password = trim($this->get['password']);
        if(strlen($password) < 6 || strlen($password) > 32) {
            throw new ApiException(9995);
        }
        $authToken = trim($this->get['auth_token']);

        $recentTime = time() - 2 * 3600;
        $registerInfo = Register::find()
            ->andWhere(['and', ['=', 'email', $email], ['>', 'updated_at', $recentTime]])
            ->orderBy('updated_at DESC')->one();

        if($registerInfo) {

            $passportInfo = Cache::getOrSet("passport_check_email_".$email, function () use ($email) {
                return Passport::find()->where(['type' => 1, 'email' => $email])->one();
            }, 24 * 3600);
            if($passportInfo) {
                throw new ApiException(10003);
            } else {
                if($registerInfo['auth_token'] === $authToken) {

                    // 开始事务查询
                    $transaction = Yii::$app->db->beginTransaction();
                    $saveSuccess = false;

                    try {
                        $passport = new Passport();
                        $passport->type = 1;
                        $passport->email = $email;
                        $passport->password = Yii::$app->security->generatePasswordHash($password);

                        // 用户信息表
                        $user = new User();
                        $user->type = 1;
                        $user->email = $email;
                        $user->username = $username;
                        $user->status = 1;

                        $passport->save();
                        $user->save();
                        $transaction->commit();
                        $saveSuccess = true;

                    } catch (\Exception $e) {
                        $transaction->rollBack();
                    }

                    if(!$saveSuccess) {
                        throw new ApiException(10007);
                    }
                } else {
                    throw new ApiException(10005);
                }
            }
        } else {
            throw new ApiException(10006);
        }

        return new ApiResponse(0, []);


    }

    /**
     * 用户登录分2部分, 第三方登录和默认登录, 根据类型判断 type 判断
     * 1 是默认登录
     * 2 是 facebook 登录
     *
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionLogin() {
        $type = (int) trim($this->get['type']);
        $ret = [];
        switch ($type) {
            case 1:
                $commonLogin = new CommonLogin();
                if($commonLogin->load($this->get,'') && $commonLogin->login()) {
                    // 处理 user token
                    $transaction = Yii::$app->db->beginTransaction();
                    $success = false;
                    try {
                        $user = User::findIdentityByEmail(1, $commonLogin->email);
                        if(!$user) {
                            throw new ApiException(10011);
                        } else {
                            Yii::$app->cache->delete(GlobalPre::REDIS_CACHE_PRE_ACCESS_TOKEN . $user->access_token);
                            $user->access_token = substr(str_replace(['-', '_', '0', 'o', 'O', 'l', 'L', '1'], '', Yii::$app->security->generateRandomString(70)),0, 40);;
                            $user->ip = Yii::$app->request->getUserIP();
                            $user->save();
                        }
                        $transaction->commit();
                        $success = true;
                        $ret = $user->attributes;
                    } catch (\Exception $e) {
                        $transaction->rollBack();
                    }
                    if(!$success) {
                        throw new ApiException(10012);
                    }
                } else {
                    throw new ApiException(9998);
                }
                break;
            case 2:

                break;
            default:
                throw new ApiException(10008);
        }
        return new ApiResponse(0, $ret);

    }

    /**
     * 用户登出使用 access token, 如果当前用户存在, 则清空用户信息表和redis里的token
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionLogout() {

        $accessToken = $this->user->access_token;
        try {
            Yii::$app->cache->delete(GlobalPre::REDIS_CACHE_PRE_ACCESS_TOKEN . $accessToken);
            $this->user->access_token = "";
            $this->user->save();
        } catch (\Exception $e) {
            throw new ApiException(9999);
        }
        return new ApiResponse(0, []);

    }


}