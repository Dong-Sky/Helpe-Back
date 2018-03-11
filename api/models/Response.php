<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 01:03
 */

namespace api\models;

use api\helpers\ResponseStatus;

class Response {

    /**
     * @var int
     * 接口的状态值,
     */
    public $status = 0;

    /**
     * @var array
     * 返回的数据结果
     */
    public $data = [];

    /**
     * @var string
     * 错误内容
     */
    public $err = null;

    public function __construct($status, $data, $err = null) {
        $this->status = $status;
        $this->data = $data;
        if(empty($err)) {
            $this->err = ResponseStatus::getMessage($status);
        } else {
            $this->err = $err;
        }
    }

    public function getStatus() {
        return $this->status;
    }

    public function setStatus($status) {
        $this->status = $status;
    }

    public function getData() {
        return $this->data;
    }

    public function setData($data) {
        $this->data = $data;
    }

    public function getErr() {
        return $this->err;
    }

    public function setErr($err) {
        $this->err = $err;
    }

}