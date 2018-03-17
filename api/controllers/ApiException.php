<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 13/03/2018
 * Time: 00:05
 */

namespace api\controllers;


/*
 * todo
 * 不知道如何序列化
 */



class ApiException extends \Exception {

    public function __construct($code = 0,$debug=null)
    {
        $message = serialize($debug);

        parent::__construct($message, $code);
    }

    public function getName()
    {
        return 'ApiException';
    }


}