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
use api\models\UserAvatar;
use api\modules\v1\models\UserInfo;
use common\helpers\AliyunOss;
use common\models\User;
use Yii;
use common\helpers\Mailer;
use api\controllers\BaseActiveController;
use api\models\ApiResponse;
use yii\helpers\ArrayHelper;

class UserController extends BaseActiveController {

    /**
     * @return array
     * 设置过滤方法
     */
    public function behaviors() {
        return ArrayHelper::merge(parent::behaviors(), [
            'authenticator' => [
                'optional' => [
                    'forget-password',
                    'forget-password-reset',
                    'get-info-by-id',           // 可能会引起风险, 但是需求需要
                ],
            ]
        ]);
    }

    /**
     * 获取用户信息
     * @return ApiResponse
     */
    public function actionInfo() {
        $ret = $this->user->attributes;
        unset($ret['access_token']);
        unset($ret['password_reset_token']);
        return new ApiResponse(0, $ret);
    }

    /**
     * 可以在登录和非登录状态可以获取到用会信息, 可能会引起数据丢失
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionGetInfoById() {
        $id = intval($this->get["id"]);
        $ret = User::findIdentity($id)->attributes;
        if(!$ret) {
            throw new ApiException(10011);
        }
        // 只传给客户端必要数据
        $filter = ['type', 'username', 'face', 'gender', 'birthday', 'city', 'tel', 'info'];
        foreach(array_keys($ret) as $item) {
            if(!in_array($item, $filter, true)) {
                unset($ret[$item]);
            }
        }
        return new ApiResponse(0, $ret);
    }


    /**
     * 更新用户信息字段, username, gender, career, birthday, city, tel, info
     * 更新完成之后, 删除缓存的key
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionUpdate() {

        $userInfo = UserInfo::findOne(['access_token' => $this->user->access_token]); //var_dump($userInfo);

        if (isset($this->post['birthday'])) {
            if (!preg_match("/^\\d{4}-\\d{2}-\\d{2}$/", $this->post['birthday'])) {
                throw new ApiException(9998);
            }
        }
        if (isset($this->post['gender'])) {
            if (!in_array($this->post['gender'], array("1", "2", "3"))) {
                throw new ApiException(9998);
            }
        }

        $userInfo->load($this->post, '');
        //var_dump($this->post); //exit;
        //var_dump($userInfo);
        if($userInfo->validate()) {
            if($userInfo->save()) {
                Yii::$app->cache->delete(GlobalPre::CACHE_PRE_ACCESS_TOKEN . $this->user->access_token);
            } else {
                throw new ApiException(10007);
            }
        } else {
            throw new ApiException(9998);
        }
        return new ApiResponse(0, []);

    }

    /**
     * 更新用户名, 密码功能, 校验老密码
     * old_password
     * new_password
     */
    public function actionResetPassword() {
        $oldPassword = $this->get['old_password'];
        $newPassword = $this->get['new_password'];
        if(!empty($oldPassword) && !empty($newPassword)
            && strlen($newPassword) >= 6 && strlen($newPassword) <= 32) {
            if($this->user->type === 1) {
                $passport = Passport::findOne(['type' => 1, 'email' => $this->user->email]);
                if($passport->validatePassword($oldPassword)) {
                    $passport->password = Yii::$app->security->generatePasswordHash($newPassword);
                    $passport->save();
                } else {
                    throw new ApiException(9995);
                }
            } else {
                throw new ApiException(10015);
            }
        } else {
            throw new ApiException(9998);
        }
        return new ApiResponse(0, []);
    }


    /**
     * 忘记密码发邮件, 不要登录验证信息
     * email 地址
     */
    public function actionForgetPassword() {
        $email = trim($this->get['email']);
        $pattern = "/^([a-zA-Z0-9])+([.a-zA-Z0-9_-])*@([.a-zA-Z0-9_-])+([.a-zA-Z0-9_-]+)+([.a-zA-Z0-9_-])$/";
        if(preg_match($pattern, $email)) {
            $user = User::findIdentityByEmail(1, $email);
            if($user) {
                $passwordResetToken = substr(str_replace(['-', '_', '0', 'o', 'O', 'l', 'L', '1'], '', Yii::$app->security->generateRandomString(50)),0, 18);
                $user->password_reset_token = $passwordResetToken;
                $user->save();
                // 发送邮件, 重试3次
                $sendStatus = false;
                for($i = 0; $i <= 3; $i ++) {
                    $ret = Mailer::forgetPassword($email, $passwordResetToken);
                    if($ret) {
                        $sendStatus = true;
                        break;
                    }
                }
                if(!$sendStatus) {
                    throw new ApiException(10004);
                }
            } else {
                throw new ApiException(10009);
            }
        } else {
            throw new ApiException(10001);
        }
        return new ApiResponse(0, []);
    }

    /**
     * 忘记密码重置, 需要验证, 电子邮件名称, 邮件的token和新的密码
     */
    public function actionForgetPasswordReset() {
        $email = $this->getData('email');
        $authToken = $this->getData('auth_token');
        $password = $this->getData('password');
        $pattern = "/^([a-zA-Z0-9])+([.a-zA-Z0-9_-])*@([.a-zA-Z0-9_-])+([.a-zA-Z0-9_-]+)+([.a-zA-Z0-9_-])$/";
        if(preg_match($pattern, $email)) {
            $user = User::findIdentityByEmail(1, $email);
            if($user) {
                if($user->password_reset_token === $authToken) {

                    $transaction = Yii::$app->db->beginTransaction();
                    $saveSuccess = false;

                    try {

                        $userInfo = User::findIdentityByEmail(1, $email);
                        $userInfo->password_reset_token = "";
                        $userInfo->save();

                        $passport = Passport::findOne(['type' => 1, 'email' => $email]);
                        $passport->password = Yii::$app->security->generatePasswordHash($password);
                        $passport->save();

                        $transaction->commit();
                        $saveSuccess = true;
                    } catch (\Exception $e) {
                        $transaction->rollBack();
                    }

                    if(!$saveSuccess) {
                        throw new ApiException(10007);
                    }
                } else {
                    throw new ApiException(10016);
                }
            } else {
                throw new ApiException(10009);
            }
        } else {
            throw new ApiException(10001);
        }
        return new ApiResponse(0, []);
    }

    /**
     * 更新用户头像
     */
    public function actionAvatar() {
        $userAvatar = new UserAvatar();
        $aliyunOss = new AliyunOss();
        $imagePath = "";
        $imageUrl = "";
        try {

            if($userAvatar->validate() && $userAvatar->upload('face')) {
                $imagePath = $userAvatar->imagePath;
                $imageUrl = $userAvatar->imageUrl;
            } else {
                throw new ApiException(10018);
            }
        } catch (\Exception $e) {
            Yii::warning("upload image error, " . $e->getMessage(), 'api');
            throw new ApiException(10018);
        }
        $ossFile = trim($imageUrl, '/');
        $aliyunOss->uploadFile("helpe-avatar", $ossFile, $imagePath);

        $user = User::findIdentity($this->userId);
        $user->face = $imageUrl;
        $user->save();
        // 更新用户新的缓存
        Yii::$app->cache->delete(GlobalPre::CACHE_PRE_ACCESS_TOKEN . $this->user->access_token);
        return new ApiResponse(0, []);
    }

}