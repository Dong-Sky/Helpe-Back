<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 16/03/2018
 * Time: 22:17
 */

namespace api\controllers;


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
     */
    public function authenticate($user, $request, $response) {
        $accessToken = $request->get($this->tokenParam);
        if (is_string($accessToken)) {
            $key = "access_token_" . $accessToken;
            $identity = Cache::getOrSet($key, function() use ($user, $accessToken) {
                return $user->loginByAccessToken($accessToken);
            }, 600);
            if ($identity !== null && $identity !== false) {
                return $identity;
            }
        }
        if ($accessToken !== null) {
            $this->handleFailure($response);
        }

        return null;
    }


}