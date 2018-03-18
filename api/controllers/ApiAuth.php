<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 16/03/2018
 * Time: 22:17
 */

namespace api\controllers;


use api\helpers\GlobalPre;
use common\helpers\Cache;
use yii\filters\auth\QueryParamAuth;

class ApiAuth extends QueryParamAuth {


    public $tokenParam = 't';


    /**
     * 具体的校验逻辑
     * @param \yii\web\User $user
     * @param \yii\web\Request $request
     * @param \yii\web\Response $response
     * @return null|\yii\web\IdentityInterface
     * @throws ApiException
     */
    public function authenticate($user, $request, $response) {
        $accessToken = $request->get($this->tokenParam);
        if (is_string($accessToken)) {
            $key = GlobalPre::REDIS_CACHE_PRE_ACCESS_TOKEN . $accessToken;
            $identity = Cache::getOrSet($key, function() use ($user, $accessToken) {
                return $user->loginByAccessToken($accessToken);
            }, 600);
            if ($identity !== null && $identity !== false) {
                // 确认再次登录,保证用户信息的登录状态
                $user->login($identity);
                return $identity;
            } else {
                throw new ApiException(10000);
            }
        }
        if ($accessToken !== null) {
            $this->handleFailure($response);
        }

        return null;
    }


}