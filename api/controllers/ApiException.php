<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 13/03/2018
 * Time: 00:05
 */

namespace api\controllers;



use Throwable;

class ApiException extends \Exception {

    public function __construct($code = 0)
    {
        parent::__construct("", $code);
    }

}