<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 03/03/2018
 * Time: 19:45
 */
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\web\IdentityInterface;

class Admin extends ActiveRecord implements IdentityInterface {

    public static function findIdentityByAccessToken($token, $type = null) {
        // TODO: Implement findIdentityByAccessToken() method.
        return static::findOne([
            'access_token' => $token,
        ]);
    }


    public function getId() {
        return $this->id;
    }

    public function getAuthKey() {
        // TODO: Implement getAuthKey() method.
        return $this->authKey;
    }

    public function validateAuthKey($authKey) {
        // TODO: Implement validateAuthKey() method.
        return $this->authKey === $authKey;
    }

    public static function findIdentity($id) {
        // TODO: Implement findIdentity() method.
        return static::findOne($id);
    }

    public static function tableName() {
        return '{{%admin}}';
    }


}