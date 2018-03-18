<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 13/03/2018
 * Time: 23:00
 */

namespace api\modules\v1\models;


use api\controllers\ApiException;
use api\models\Passport;
use yii\db\ActiveRecord;

class CommonLogin extends ActiveRecord
{

    public $email;
    public $password;

    private $_passport;


    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            // username and password are both required
            [['email', 'password'], 'required'],
            ['email', 'email'],
            ['email', 'string', 'min' => 2, 'max' => 64],
            ['password', 'string', 'min' => 6, 'max' => 32],
            // password is validated by validatePassword()
            ['password', 'validatePassword'],
        ];
    }


    /**
     * Validates the password.
     * This method serves as the inline validation for password.
     *
     * @param string $attribute the attribute currently being validated
     * @param array $params the additional name-value pairs given in the rule
     */
    public function validatePassword($attribute, $params)
    {
        $passport = $this->getPassport();
        if(!$passport) {
            throw new ApiException(10009);
        }
        if (!$passport->validatePassword($this->password)) {
            throw new ApiException(10010);
        }
        return true;
    }


    /**
     * Logs in a user using the provided username and password.
     *
     * @return boolean whether the user is logged in successfully
     */
    public function login()
    {
        if ($this->validate()) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * Finds passport by [[email]]
     *
     * @return User|null
     */
    protected function getPassport()
    {
        if ($this->_passport === null) {
            $this->_passport = Passport::findOne(['type' => 1, 'email' => $this->email]);
        }
        return $this->_passport;
    }

}