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
use api\modules\v1\models\UserInfo;
use Yii;
use api\controllers\BaseActiveController;
use api\models\ApiResponse;

class UserController extends BaseActiveController {


    /**
     * 获取用户信息
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionInfo() {

        $ret = $this->user->attributes;
        return new ApiResponse(0, $ret);

    }


    /**
     * 更新用户信息字段, username, gender, career, birthday, city, tel, info
     * 更新完成之后, 删除缓存的key
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionUpdate() {

        $userInfo = UserInfo::findOne(['access_token' => $this->user->access_token]);
        //$userInfo->load($this->post, '');
        $userInfo->username = $this->post['username'];
        $userInfo->gender = $this->post['gender'];
        $userInfo->birthday = $this->post['birthday'];
        $userInfo->city = $this->post['city'];
        $userInfo->career = $this->post['career'];
        $userInfo->tel = $this->post['tel'];
        $userInfo->info = $this->post['info'];
        $userInfo->validate();
        $userInfo->save();
        if($userInfo->validate() && $userInfo->save()) {
            Yii::$app->cache->delete(GlobalPre::REDIS_CACHE_PRE_ACCESS_TOKEN . $this->user->access_token);
        } else {
            throw new ApiException(10007);
        }
        return new ApiResponse(0, []);

    }

    public function actionResetPassword() {
        var_dump(Yii::$app->user);
        var_dump('actionAct');
    }

}